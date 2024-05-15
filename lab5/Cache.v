`define LRU_IDX 0
`define DIRTY_IDX 1
`define VALID_IDX 2
`define TAG_IDX 3
`define DATA0_IDX 28
`define DATA1_IDX 60
`define DATA2_IDX 92
`define DATA3_IDX 124

module Cache #(parameter LINE_SIZE = 16,
               parameter NUM_SETS = 8,
               parameter NUM_WAYS = 2) (
    input reset,
    input clk,

    input MEM_is_input_valid,
    input [31:0] addr,
    input mem_read,
    input mem_write,
    input [31:0] din,

    output is_ready,
    output is_output_valid,
    output [31:0] dout,
    output is_hit);
  // Wire declarations
  wire is_data_mem_ready;
  wire is_output_valid;
  wire [31:0] dout;
  wire is_hit;
  wire is_input_valid;
  // Reg declarations
  // Cache memory
  // Cache Block Structure
  // | LRU | Dirty | Valid | Tag |   Data  |
  // |  1  |   1   |   1   | 25  |  32 * 4 |
  reg [155:0] cache [NUM_SETS - 1:0][NUM_WAYS - 1:0];
  
  // You might need registers to keep the status.

  assign is_ready = is_data_mem_ready;
  assign is_input_valid = MEM_is_input_valid;

  // Initialize the cache
  always @(posedge clk) begin
    if (reset) begin
      for (int i = 0; i < NUM_SETS; i = i + 1) begin
        cache[i][0] <= {1'b0, 1'b0, 1'b0, 25'b0, 32'b0};
        cache[i][1] <= {1'b1, 1'b0, 1'b0, 25'b0, 32'b0};
      end
    end
  end
  // Read from the cache
  always @(*) begin
    // Extract the tag, set index and block offset
    int tag = addr[31:7];
    int set_index = addr[6:4];
    int block_offset = addr[3:2];
    // Check if the data is present in the cache
    int hit = 0;
    for (int i = 0; i < NUM_WAYS; i = i + 1) begin
      if (cache[set_index][i][`VALID_IDX] == 1 && cache[set_index][i][3] == tag) begin
        hit = 1;
        break;
      end
    end
    is_hit = hit;
    // If the data is present in the cache, read the data
    if (hit) begin
      is_output_valid = 1;
      dout = cache[set_index][i][4 * block_offset +: 32];
    end
    // If the data is not present in the cache, read from the data memory
    else begin
      is_output_valid = 0;
      dout = 0;
      is_input_valid = 1;
    end
  end

  // Write to the cache

  // Instantiate data memory
  DataMemory #(.BLOCK_SIZE(LINE_SIZE)) data_mem(
    .reset(reset),
    .clk(clk),

    .is_input_valid(is_input_valid),
    .addr(),        // NOTE: address must be shifted by CLOG2(LINE_SIZE)
    .mem_read(mem_read_from_cache),
    .mem_write(mem_write),
    .din(din),

    // is output from the data memory valid?
    .is_output_valid(is_output_valid),
    .dout(dout),
    // is data memory ready to accept request?
    .mem_ready(is_data_mem_ready)
  );
endmodule
