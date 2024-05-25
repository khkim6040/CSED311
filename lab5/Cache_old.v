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
    output reg [31:0] dout,
    output is_hit);
  // Wire declarations
  assign is_output_valid = is_input_valid && ((line0_matched && line0_is_valid) || (line1_matched && line1_is_valid));
  

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
  reg C_is_input_valid;
  reg C_mem_read;
  reg C_mem_write;
  reg [31:0] C_addr;
  reg [127:0] C_din;
  wire M_is_output_valid;
  reg old_line;
  integer i;
  reg is_write_hit;
  reg is_read_hit;  
  assign is_hit = is_write_hit || is_read_hit;

  wire [LINE_SIZE*8-1:0] M_dout;
  // Reg declarations
  // Cache Block Structure
  // | LRU | Dirty | Valid | Tag |   Data  |
  // |  1  |   1   |   1   | 25  |  32 * 4 |
  reg [155:0] cache [NUM_SETS-1:0][NUM_WAYS-1:0];
  // You might need registers to keep the status.
  wire is_data_mem_ready;
  assign is_ready = is_data_mem_ready;
  
  wire is_old_line_dirty;
  assign is_old_line_dirty = cache[D_set][old_line][`DIRTY_IDX];


    // HIT case: index > tag matched > valid > hit and return data > set LRU to 0(younger) > set other LRU to 1(older)
    // MISS case: index > tag not matched > retrieve data from memory > put data into cache > first, put data into cache line where valid = 0, second put data into cache line where LRU = 1
    //            > set LRU to 0(younger) > set other LRU to 1(older)

  always @(posedge clk) begin
    is_write_hit <= 0;
    if(reset) begin
      for (i=0; i<NUM_SETS; i=i+1) begin
        cache[i][0] <= {`LRU_NEW, 1'b0, 1'b0, 25'b0, 128'b0};
        cache[i][1] <= {`LRU_OLD, 1'b0, 1'b0, 25'b0, 128'b0};
      end
    end
    // Write
    if(M_is_output_valid) begin
      cache[D_set][old_line][127:0] <= M_dout;
      cache[D_set][old_line][`DIRTY_IDX] <= 0;
      cache[D_set][old_line][`VALID_IDX] <= 1;
      cache[D_set][old_line][`TAG_IDX:`TAG_IDX-24] <= D_tag;
    end
    
    if(is_input_valid && mem_rw == `WRITE) begin
      if(line0_matched) begin
        // hit
        is_write_hit <= 1;
        // assume that cache is empty
        cache[D_set][0][D_bo*32 +: 32] <= din;
        cache[D_set][0][`DIRTY_IDX] <= 1;
      end
      else if(line1_matched) begin
        // hit
        is_write_hit <= 1;
        // assume that cache is empty
        cache[D_set][1][D_bo*32 +: 32] <= din;
        cache[D_set][1][`DIRTY_IDX] <= 1;
      end
    end

    if(is_input_valid && mem_rw == `READ) begin
      if(line0_matched) begin
        if(!line0_is_valid && is_data_mem_ready) begin
          C_is_input_valid <= 1;
          C_mem_read <= 1;
          C_addr <= addr;
        end
      end
      else if(line1_matched) begin
        if(!line1_is_valid && is_data_mem_ready) begin
          C_is_input_valid <= 1;
          C_mem_read <= 1;
          C_addr <= addr;
        end
      end
      else begin
        if(is_old_line_dirty && is_data_mem_ready) begin
          C_is_input_valid <= 1;
          C_mem_write <= 1;
          C_addr <= {cache[D_set][old_line][`TAG_IDX:`TAG_IDX-24], D_set, 4'b0};
          C_din <= cache[D_set][old_line][127:0];
          cache[D_set][old_line][`DIRTY_IDX] <= 0;
        end
        else if(is_data_mem_ready) begin
          C_is_input_valid <= 1;
          C_mem_read <= 1;
          C_addr <= addr;
        end
      end
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

    is_read_hit = 0;
    dout = 0;
    
    // Read
    // Calculate set index and tag
    if(is_input_valid) begin
      // Read
      // line0 hit
      if (line0_matched && mem_rw == `READ) begin
        is_read_hit = 1;
        dout = cache[D_set][0][D_bo*32 +: 32];
      end
      // line1 hit
      else if (line1_matched && mem_rw == `READ) begin
        is_read_hit = 1;
        dout = cache[D_set][1][D_bo*32 +: 32];
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
