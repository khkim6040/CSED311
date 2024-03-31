module TempRegister (input [31:0] in
                    input able,
                    output reg [31:0] out);
                    
    reg [31:0] temp = 32`b0;


    always (posedge able) begin
        temp <= in;
    end

    assign out = temp;

endmodule
