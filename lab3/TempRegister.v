module TempRegister (input [31:0] in
                    input able,
                    output reg [31:0] out);
                    
    reg [31:0] temp = 32`b0;

    always (*) begin
        if (able == 1)
            out = in;
        else
            out = temp; 
    end

    always (posedge able) begin
        temp <= out;
    end


endmodule