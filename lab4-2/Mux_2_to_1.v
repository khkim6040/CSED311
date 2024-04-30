module Mux_2_to_1 #(parameter WIDTH = 32) (
    input [WIDTH-1:0] x0,
    input [WIDTH-1:0] x1,
    input swch, 
    output reg [WIDTH-1:0] out);

    always @(*) begin
    if (swch == 1'b0) begin
        out = x0;
    end
    else begin
        out = x1;
    end
    end

endmodule
