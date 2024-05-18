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
`define LRU_NEW 0
`define LRU_OLD 1
// For input address
`define D_SET_IDX 4
`define D_TAG_IDX 7

`define READ 1
`define WRITE 0

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
    output is_hit);
  // Wire declarations
  integer i;
  wire is_data_mem_ready;
  wire is_output_valid;
  wire [31:0] dout;
  wire is_hit;
  

  wire D_tag addr[`TAG_SIZE-1:0];
  wire D_set addr[`SET_SIZE-1:0];
  wire D_bo addr[`BO_SIZE-1:0];
  assign D_tag = addr[31:TAG_IDX];
  assign D_set = addr[TAG_IDX-1:D_SET_IDX];
  assign D_bo = addr[D_SET_IDX-1:2];
  

  wire line0_matched = 0;
  wire line1_matched = 0;
  wire line0_is_valid = 0;
  wire line1_is_valid = 0;
  wire C_is_input_valid = 0;
  wire C_mem_read = 0;
  wire C_mem_write = 0;
  assign line0_matched = cache[D_set][0][`TAG_IDX:`TAG_IDX-24] == D_tag;
  assign line1_matched = cache[D_set][1][`TAG_IDX:`TAG_IDX-24] == D_tag;
  assign line0_is_valid = cache[D_set][0][`VALID_IDX];
  assign line1_is_valid = cache[D_set][1][`VALID_IDX];
  wire M_is_output_valid;
  wire M_dout;
  // Reg declarations
  // Cache Block Structure
  // | LRU | Dirty | Valid | Tag |   Data  |
  // |  1  |   1   |   1   | 25  |  32 * 4 |
  reg [155:0] cache [NUM_SETS-1:0][NUM_WAYS-1:0];
  // You might need registers to keep the status.
  assign is_ready = is_data_mem_ready;



    // HIT case: index > tag matched > valid > hit and return data > set LRU to 0(younger) > set other LRU to 1(older)
    // MISS case: index > tag not matched > retrieve data from memory > put data into cache > first, put data into cache line where valid = 0, second put data into cache line where LRU = 1
    //            > set LRU to 0(younger) > set other LRU to 1(older)

  always @(posedge clk) begin
    if(reset) begin
      for (i=0; i<NUM_SETS; i=i+1) begin
        cache[i][0] <= {`LRU_NEW, 1'b0, 1'b0, 25'b0, 128'b0};
        cache[i][1] <= {`LRU_OLD, 1'b0, 1'b0, 25'b0, 128'b0};
      end
    end
    // Write
    if(M_is_output_valid) begin
      // TODO
      // 메모리에서 가져온 캐시 line을 캐시에 write
    end
    
    if(mem_rw == `WRITE) begin
      if(line0_matched) begin
        // hit
      end
      else if(line1_matched) begin
        // hit
      end
      else begin
        // miss
        if(missed_line_is_dirty) begin
          // evict dirty line
          // write data to memory
          if(is_data_mem_ready) begin
            C_is_input_valid = 1;
            C_mem_write = 1;
            C_addr = // evicted line's address;
            C_din = din;
          end
          // set dirty line to 0
        end
        else begin
          // read data from memory
          if(is_data_mem_ready) begin
            C_is_input_valid = 1;
            C_mem_read = 1;
            C_addr = addr;
          end
        end
      end
    end
  end



  

  always @(*) begin
    // Read
    // 1. Calculate set index and tag
    if (is_input_valid) begin
      if(mem_rw == `READ) begin
        // Read
        
        if (line0_matched) begin
          is_hit = 1;
          dout = cache[D_set][0][32*(D_bo+1)-1: 32*D_bo];
          if(line0_is_valid) begin
            // line 0 hit
            is_output_valid = 1;
            cache[D_set][0][`LRU_IDX] <= `LRU_NEW;
            cache[D_set][1][`LRU_IDX] <= `LRU_OLD;
          end 
        end
        else if (line1_matched) begin
          is_hit = 1;
          dout = cache[D_set][1][32*(D_bo+1)-1: 32*D_bo];
          if(line1_is_valid) begin
            // line 1 hit
            is_output_valid = 1;
            cache[D_set][0][`LRU_IDX] <= `LRU_OLD;
            cache[D_set][1][`LRU_IDX] <= `LRU_NEW;
          end
        end
        else begin
          // miss
          if(missed_line_is_dirty) begin
            // evict dirty line
            // write data to memory
            if(is_data_mem_ready) begin
              C_is_input_valid = 1;
              C_mem_write = 1;
              C_addr = // evicted line's address;
              C_din = din;
            end
            // set dirty line to 0
          end
          else begin
            // read data from memory
            if(is_data_mem_ready) begin
              C_is_input_valid = 1;
              C_mem_read = 1;
              C_addr = addr;
            end
          end
        end
      end
    end
  end



  // Instantiate data memory
  DataMemory #(.BLOCK_SIZE(LINE_SIZE)) data_mem(
    .reset(reset),
    .clk(clk),

    .is_input_valid(C_is_input_valid),
    .addr(C_addr),        // NOTE: address must be shifted by CLOG2(LINE_SIZE)
    .mem_read(C_mem_read),
    .mem_write(C_mem_write),
    .din(din),

    // is output from the data memory valid?
    .is_output_valid(M_is_output_valid),
    .dout(),
    // is data memory ready to accept request?
    .mem_ready(is_data_mem_ready)
  );
endmodule
