`include "CLOG2.v"

// Define macros to compute sizes dynamically
`define SET_BITS (`CLOG2(NUM_SETS))
`define WAY_BITS (`CLOG2(NUM_WAYS))
`define LRU_BITS (`CLOG2(NUM_WAYS))
`define BO_BITS 2
`define OFFSET_BITS 2
`define TAG_BITS (32 - `SET_BITS - `BO_BITS - `OFFSET_BITS)
`define DATA_BITS 32


`define TAG_IDX (127+`TAG_BITS)
`define VALID_IDX (`TAG_IDX+1)
`define DIRTY_IDX (`VALID_IDX+1)
`define LRU_IDX (`DIRTY_IDX+`LRU_BITS)

// For input address
`define D_SET_IDX 4
`define D_TAG_IDX (`D_SET_IDX + `SET_BITS)
`define D_BO_IDX 2

`define READ 1'b0
`define WRITE 1'b1
`define LRU_NEW ((1 << `WAY_BITS) - 1)
`define LRU_OLD 0

`define A 3'b000
`define B 3'b001
`define C 3'b010
`define D 3'b011
`define E 3'b100
`define F 3'b101

module Cache #(parameter LINE_SIZE = 16,
               parameter NUM_SETS = 2,
               parameter NUM_WAYS = 8) (
    input reset,
    input clk,

    input is_input_valid,
    input [31:0] addr,
    input mem_rw,
    input [31:0] din,

    output is_ready,
    output is_output_valid,
    output [31:0] dout,
    output is_hit,
    output reg [31:0] miss_count);

  wire is_data_mem_ready;
  wire is_write_hit;
  wire is_read_hit;
  assign is_ready = is_data_mem_ready;
  assign is_output_valid = line_matched[matched_line] && line_valid[matched_line];
  assign dout = cache[D_set][matched_line][D_bo*32 +: 32];
  assign is_read_hit = is_input_valid && line_matched[matched_line] && line_valid[matched_line] && mem_rw == `READ;
  assign is_write_hit = is_input_valid && line_matched[matched_line] && mem_rw == `WRITE;
  assign is_hit = is_write_hit || is_read_hit;

  wire [`TAG_BITS-1:0] D_tag;
  wire [`SET_BITS-1:0] D_set;
  wire [`BO_BITS-1:0] D_bo;
  assign D_tag = addr[31:`D_TAG_IDX];
  assign D_set = addr[`D_TAG_IDX-1:`D_SET_IDX];
  assign D_bo = addr[`D_SET_IDX-1:2];

  reg [NUM_WAYS-1:0] line_matched;
  reg [NUM_WAYS-1:0] line_valid;
  reg [`WAY_BITS-1:0] lru [NUM_WAYS-1:0];

  reg [`WAY_BITS-1:0] matched_line;
  reg [`WAY_BITS-1:0] old_line;

  // Set matched_line, old_line and valid, lru bit information
  always @(*) begin 
    integer i;
    matched_line = 0;
    old_line = 0;

    for (i = 0; i < NUM_WAYS; i = i + 1) begin
      line_valid[i] = cache[D_set][i][`VALID_IDX];
      lru[i] = cache[D_set][i][`LRU_IDX:`LRU_IDX-`LRU_BITS+1];
      line_matched[i] = cache[D_set][i][`TAG_IDX:`TAG_IDX-`TAG_BITS+1] == D_tag;

      if((cache[D_set][i][`LRU_IDX:`LRU_IDX-`LRU_BITS+1] == `LRU_OLD)) begin
        old_line = i[`WAY_BITS-1:0];
      end
      if(cache[D_set][i][`TAG_IDX:`TAG_IDX-`TAG_BITS+1] == D_tag) begin
        matched_line = i[`WAY_BITS-1:0];
      end
    end
  end

  wire is_old_line_dirty;
  assign is_old_line_dirty = cache[D_set][old_line][`DIRTY_IDX];

  reg C_is_input_valid;
  reg C_mem_read;
  reg C_mem_write;
  reg [`DATA_BITS-1:0] C_addr;
  reg [4*`DATA_BITS-1:0] C_din;
  wire M_is_output_valid;
  wire [4*`DATA_BITS-1:0] M_dout;

  // Cache Block Structure
  // | LRU | Dirty | Valid | Tag |   Data  |
  // |  way_bits  |   1   |   1   | 32-set_bits-4  |  32 * 4 |
  // if WAY_BITS == 1, cache block bits == 156
  // if WAY_BITS == 2, cache block bits == 158
  // if WAY_BITS == 3, cache block bits == 160
  // 최대 크기 160으로 hard-coded
  reg [159:0] cache [NUM_SETS-1:0][NUM_WAYS-1:0];
  reg [2:0] state;

  integer i, j;
  always @(posedge clk) begin
    // Initialize Cache
    if(reset) begin
      for (i=0; i<NUM_SETS; i=i+1) begin
        for(j=0; j<NUM_WAYS; j=j+1) begin
          cache[i][j] <= 0;
        end
      end
      state <= `B;
      miss_count <= 0;
    end
    else begin
      // $display("state: %b", state);
      // $display("mem_rw: %b", mem_rw);
      C_is_input_valid <= 0;
      C_mem_read <= 0;
      C_mem_write <= 0;
      C_addr <= 0;
      C_din <= 0;

      // STATE A
      if (state == `A) begin
        if (is_input_valid)
          state <= `B;
        else
          state <= `A;
      end
      // STATE B
      else if (state == `B) begin
        if(is_input_valid) begin
          // Compare Tag
          if (mem_rw == `WRITE) begin
            if (is_write_hit) begin
              // LRU setting
              cache[D_set][matched_line][`LRU_IDX:`LRU_IDX-`LRU_BITS+1] <= `LRU_NEW;
              cache[D_set][matched_line][D_bo*32 +: 32] <= din;
              cache[D_set][matched_line][`DIRTY_IDX] <= 1;
              for(i=0; i<NUM_WAYS; i=i+1) begin
                if((i[`WAY_BITS-1:0] != matched_line) && (lru[i] > `LRU_OLD))
                  cache[D_set][i][`LRU_IDX:`LRU_IDX-`LRU_BITS+1] <= lru[i] - 1;
              end
              state <= `B;
            end
            else if (is_old_line_dirty) begin
              state <= `C;
              miss_count <= miss_count + 1;
            end
            else begin
              state <= `D;
              miss_count <= miss_count + 1;
            end
          end
          else if (mem_rw == `READ) begin
            if (is_read_hit && is_output_valid) begin
              // LRU setting
              cache[D_set][matched_line][`LRU_IDX:`LRU_IDX-`LRU_BITS+1] <= `LRU_NEW;
              for(i=0; i<NUM_WAYS; i=i+1) begin
                if((i[`WAY_BITS-1:0] != matched_line) && (lru[i] > `LRU_OLD))
                  cache[D_set][i][`LRU_IDX:`LRU_IDX-`LRU_BITS+1] <= lru[i] - 1;
              end
              state <= `B;
            end
            else if (is_old_line_dirty) begin
              state <= `C;
              miss_count <= miss_count + 1;
            end
            else begin
              state <= `D;
              miss_count <= miss_count + 1;
            end
          end
        end
        else 
          state <= `B;
      end
      // STATE C
      else if (state == `C) begin
        C_is_input_valid <= 1;
        C_mem_write <= 1;
        C_addr <= {cache[D_set][old_line][`TAG_IDX:`TAG_IDX-`TAG_BITS+1], D_set, 4'b0};
        C_din <= cache[D_set][old_line][4*`DATA_BITS-1:0];
        if (is_data_mem_ready)
          state <= `E;
        else  
          state <= `C;
      end
      // STATE D
      else if (state == `D) begin
        C_is_input_valid <= 1;
        C_mem_read <= 1;
        C_addr <= addr;
        if (is_data_mem_ready)
          state <= `F;
        else
          state <= `D;
      end
      // STATE E
      else if (state == `E) begin
        C_is_input_valid <= 1;
        C_mem_read <= 1;
        if(is_data_mem_ready) begin
          cache[D_set][old_line][`DIRTY_IDX] <= 0;
          state <= `D;
        end
        else
          state <= `E;
      end
      // STATE F
      else if (state == `F) begin
        C_is_input_valid <= 1;
        C_mem_read <= 1;
        if(M_is_output_valid) begin
          cache[D_set][old_line][4*`DATA_BITS-1:0] <= M_dout;
          cache[D_set][old_line][`DIRTY_IDX] <= 0;
          cache[D_set][old_line][`VALID_IDX] <= 1;
          cache[D_set][old_line][`TAG_IDX:`TAG_IDX-`TAG_BITS+1] <= D_tag;
          state <= `B;
        end
        else
          state <= `F;
      end
    end
  end

  // Instantiate data memory
  DataMemory #(.BLOCK_SIZE(LINE_SIZE)) data_mem(
    .reset(reset),
    .clk(clk),

    .is_input_valid(C_is_input_valid),
    // NOTE: address must be shifted by CLOG2(LINE_SIZE)
    .addr(C_addr >> (`CLOG2(LINE_SIZE))),     
    .mem_read(C_mem_read),
    .mem_write(C_mem_write),
    .din(C_din),

    // is output from the data memory valid?
    .is_output_valid(M_is_output_valid),
    .dout(M_dout),
    // is data memory ready to accept request?
    .mem_ready(is_data_mem_ready)
  );

endmodule
