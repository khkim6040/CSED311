module Adder(
  input [31:0] x0,
  input [31:0] x1,  
  output reg [31:0] sum
  );

always@(*) begin
  sum = x0 + x1;
end

endmodule
