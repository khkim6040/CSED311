// Do not submit this file.
`include "cpu.v"

module top(input reset,
           input clk,
           output reg [31:0] miss_count,
           output is_halted,
           output [31:0] print_reg [0:31]);

  cpu cpu(
    .reset(reset), 
    .clk(clk),
    .miss_count(miss_count),
    .is_halted(is_halted),
    .print_reg(print_reg)
  );

endmodule
