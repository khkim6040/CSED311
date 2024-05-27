`include "CLOG2.v"
// For cache
`define LRU_IDX 155
`define DIRTY_IDX 154
`define VALID_IDX 153
`define TAG_IDX 152
`define DATA3_IDX 127
`define DATA2_IDX 95
`define DATA1_IDX 63
`define DATA0_IDX 31

`define TAG_SIZE 25
`define SET_SIZE 3
`define BO_SIZE 2
`define DATA_SIZE 32

// For input address
`define D_SET_IDX 4
`define D_TAG_IDX 7
`define D_BO_IDX 2

`define READ 1'b0
`define WRITE 1'b1
`define LRU_NEW 1'b0
`define LRU_OLD 1'b1

`define A 3'b000
`define B 3'b001
`define C 3'b010
`define D 3'b011
`define E 3'b100
`define F 3'b101

module Cache #(parameter LINE_SIZE = 16,
               parameter NUM_SETS = 8,
               parameter NUM_WAYS = 2) (
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
  reg is_write_hit;
  wire is_read_hit;
  reg matched_line;
  assign is_ready = is_data_mem_ready || is_hit;
  assign is_output_valid = is_input_valid && ((line0_matched && line0_is_valid) || (line1_matched && line1_is_valid));
  //assign matched_line = line1_matched; // line1 is not matched, line0 can be matched or not. if line0 matched, 0 is correct. if line0 is also not matched, don't care.  
  assign dout = cache[D_set][matched_line][D_bo*32 +: 32];
  //assign is_write_hit = is_output_valid && mem_rw == `WRITE;
  assign is_read_hit = is_output_valid && mem_rw == `READ;
  assign is_hit = is_write_hit || is_read_hit;

  wire [`TAG_SIZE-1:0] D_tag;
  wire [`SET_SIZE-1:0] D_set;
  wire [`BO_SIZE-1:0] D_bo;
  assign D_tag = addr[31:`D_TAG_IDX];
  assign D_set = addr[`D_TAG_IDX-1:`D_SET_IDX];
  assign D_bo = addr[`D_SET_IDX-1:2];

  wire line0_matched;
  wire line1_matched;
  wire line0_is_valid;
  wire line1_is_valid;
  assign line0_matched = cache[D_set][0][`TAG_IDX:`TAG_IDX-24] == D_tag;
  assign line1_matched = cache[D_set][1][`TAG_IDX:`TAG_IDX-24] == D_tag;
  assign line0_is_valid = cache[D_set][0][`VALID_IDX];
  assign line1_is_valid = cache[D_set][1][`VALID_IDX];

  reg old_line;
  wire is_old_line_dirty;
  //assign old_line = cache[D_set][0][`LRU_IDX] == `LRU_OLD ? 0 : 1;
  assign is_old_line_dirty = cache[D_set][old_line][`DIRTY_IDX];

  reg C_is_input_valid;
  reg C_mem_read;
  reg C_mem_write;
  reg [31:0] C_addr;
  reg [127:0] C_din;
  wire M_is_output_valid;
  wire [LINE_SIZE*8-1:0] M_dout;

  // Cache Block Structure
  // | LRU | Dirty | Valid | Tag |   Data  |
  // |  1  |   1   |   1   | 25  |  32 * 4 |
  reg [155:0] cache [NUM_SETS-1:0][NUM_WAYS-1:0];

  reg [2:0] state;

  integer i;

    // HIT case: index > tag matched > valid > hit and return data > set LRU to 0(younger) > set other LRU to 1(older)
    // MISS case: index > tag not matched > retrieve data from memory > put data into cache > first, put data into cache line where valid = 0, second put data into cache line where LRU = 1
    //            > set LRU to 0(younger) > set other LRU to 1(older)


  always @(posedge clk) begin
    // Initialize Cache
    if(reset) begin
      for (i=0; i<NUM_SETS; i=i+1) begin
        cache[i][0] <= {`LRU_NEW, 1'b0, 1'b0, 25'b0, 128'b0};
        cache[i][1] <= {`LRU_OLD, 1'b0, 1'b0, 25'b0, 128'b0};
      end
      state <= `B;
      miss_count <= 0;
    end

    is_write_hit <= 0;
    C_is_input_valid <= 0;
    C_mem_read <= 0;
    C_mem_write <= 0;
    C_addr <= 0;
    C_din <= 0;

    // $display("state: %b", state);
    //$display("mem_rw: %b", mem_rw);

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
          if(line0_matched) begin
            is_write_hit <= 1;
            cache[D_set][0][D_bo*32 +: 32] <= din;
            cache[D_set][0][`DIRTY_IDX] <= 1;
            state <= `A;
          end
          else if(line1_matched) begin
            is_write_hit <= 1;
            cache[D_set][1][D_bo*32 +: 32] <= din;
            cache[D_set][1][`DIRTY_IDX] <= 1;
            state <= `A;
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
          if (is_output_valid) 
            state <= `A;
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
      C_addr <= {cache[D_set][old_line][`TAG_IDX:`TAG_IDX-24], D_set, 4'b0};
      C_din <= cache[D_set][old_line][127:0];
      if (is_data_mem_ready) begin
        state <= `E;
      end
      else  
        state <= `C;
    end
    // STATE D
    else if (state == `D) begin
      C_is_input_valid <= 1;
      C_mem_read <= 1;
      C_addr <= addr;
      if (is_data_mem_ready) begin
        state <= `F;
      end
      else
        state <= `D;
    end
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
    else if (state == `F) begin
      C_is_input_valid <= 1;
      C_mem_read <= 1;
      if(M_is_output_valid) begin
        cache[D_set][old_line][127:0] <= M_dout;
        cache[D_set][old_line][`DIRTY_IDX] <= 0;
        cache[D_set][old_line][`VALID_IDX] <= 1;
        cache[D_set][old_line][`TAG_IDX:`TAG_IDX-24] <= D_tag;
        state <= `B;
      end
      else
        state <= `F;
    end

    if(is_input_valid && line0_is_valid && is_hit) begin
      cache[D_set][0][`LRU_IDX] <= `LRU_NEW;
      cache[D_set][1][`LRU_IDX] <= `LRU_OLD;
    end
    else if(is_input_valid && line1_is_valid && is_hit) begin
      cache[D_set][1][`LRU_IDX] <= `LRU_NEW;
      cache[D_set][0][`LRU_IDX] <= `LRU_OLD;
    end
  end

  always @(*) begin
    if (cache[D_set][0][`LRU_IDX] == `LRU_OLD) begin
      old_line = 0;
    end
    else begin
      old_line = 1;
    end

    if(is_input_valid && line0_is_valid && line0_matched) begin
      matched_line = 0;
    end
    else if(is_input_valid && line1_is_valid && line1_matched) begin
      matched_line = 1;
    end
    else begin
      matched_line = 0;
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
