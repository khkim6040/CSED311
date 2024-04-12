module Mux_2_to_1 (input [31:0] x0,
        input [31:0] x1,
        input swch, 
        output reg [31:0] out);

    always @(*) begin
        if (swch == 1'b0) begin
            out = x0;
        end
        else begin
            out = x1;
        end
    end

endmodule
