module 4mux (input [31:0] x0,
        input [31:0] x1,
        input [31:0] x2,
        input [31:0] x3,
        input [1:0] swch, 
        output reg [31:0] out);

    always @(*) begin
        case (swch)
            2'b00: out = x0;
            2'b01: out = x1;
            2'b10: out = x2;
            2'b11: out = x3;
        endcase
    end

endmodule
