module adder(input [31:0] sc1,
            input [31:0] sc2,  
            output reg [31:0] result);

always@(*) begin
  result = sc1 + sc2;
end

endmodule
