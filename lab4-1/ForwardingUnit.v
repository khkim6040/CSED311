module ForwardingUnit(
    input [31:0] EX_rs1_data,
    input [31:0] EX_rs2_data,
    input [4:0] MEM_reg_rd,
    input [4:0] WB_reg_rd,
    input MEM_reg_write,
    input WB_reg_write,
    output forwardA,
    output forwardB);

    always @(*) begin
        if ((EX_rs1_data != 0) && (EX_rs1_data == MEM_reg_rd) && MEM_reg_write) 
            forwardA = 2;
        else if ((EX_rs1_data != 0) && (EX_rs1_data == WB_reg_rd) && WB_reg_write) 
            forwardA = 1;
        else
            forwardA = 0;
        
        if ((EX_rs2_data != 0) && (EX_rs2_data == MEM_reg_rd) && MEM_reg_write) 
            forwardB = 2;
        else if ((EX_rs2_data != 0) && (EX_rs2_data == WB_reg_rd) && WB_reg_write) 
            forwardB = 1;
        else
            forwardB = 0;
    end 


endmodule
