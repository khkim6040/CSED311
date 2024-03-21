module mux (input [31:0] x1,
        input [31:0] x2,
        input swch, 
        output reg [31:0] out);

    assign out = ~swch ? x1 : x2;

endmodule
