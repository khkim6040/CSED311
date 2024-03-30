module 2mux (input [31:0] x1,
        input [31:0] x2,
        input swch, 
        output reg [31:0] out);

    always @(*) begin
        if (swch == 1'b0) begin
            out = x1;
        end
        else begin
            out = x2;
        end
    end

endmodule
