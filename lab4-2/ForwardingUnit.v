module ForwardingUnit(
    input [4:0] EX_rs1_index,
    input [4:0] EX_rs2_index,
    input [4:0] MEM_reg_rd,
    input [4:0] WB_reg_rd,
    input MEM_reg_write,
    input WB_reg_write,
    input alu_src,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB,
    output reg forwardC);

    always @(*) begin
        if ((EX_rs1_index != 0) && (EX_rs1_index == MEM_reg_rd) && MEM_reg_write) 
            forwardA = 2; // ALU result
        else if ((EX_rs1_index != 0) && (EX_rs1_index == WB_reg_rd) && WB_reg_write) 
            forwardA = 1; // MEM result
        else
            forwardA = 0; // Register value
        
        if (alu_src == 1) 
            forwardB = 3; // Immediate value
        else if ((EX_rs2_index != 0) && (EX_rs2_index == MEM_reg_rd) && MEM_reg_write) 
            forwardB = 2; // ALU result
        else if ((EX_rs2_index != 0) && (EX_rs2_index == WB_reg_rd) && WB_reg_write) 
            forwardB = 1; // MEM result
        else
            forwardB = 0; // Register value

        if (MEM_reg_rd == EX_rs2_index) 
            forwardC = 1;
        else
            forwardC = 0;
    end 

endmodule
