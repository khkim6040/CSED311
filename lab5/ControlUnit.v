`include "opcodes.v"

module ControlUnit (
    input [6:0] part_of_inst,
    output reg mem_read,
    output reg [1:0] mem_to_reg,
    output reg mem_write,
    output reg alu_src,
    output reg reg_write,
    output reg [1:0] alu_op,
    output reg is_ecall,
    output reg [1:0] jump_signal
    );


    always @(*) begin
        mem_read = 0;
        mem_to_reg = 0;
        mem_write = 0;
        alu_src = 0;
        reg_write = 0;
        alu_op = `ALU_CTRL_ADD; // Default value
        is_ecall = 0;
        jump_signal = `JUMP_DEFAULT;
        case(part_of_inst)
            `ARITHMETIC: begin
                reg_write = 1;
                alu_op = `ALU_CTRL_ARITH;
            end
            `ARITHMETIC_IMM: begin
                alu_src = 1;
                reg_write = 1;
                alu_op = `ALU_CTRL_IMME;
            end
            `LOAD: begin
                mem_read = 1;
                mem_to_reg = 1;
                alu_src = 1;
                reg_write = 1;
                alu_op = `ALU_CTRL_ADD;
            end
            `STORE: begin
                mem_write = 1;
                alu_src = 1;
                alu_op = `ALU_CTRL_ADD;
            end
            `BRANCH: begin
                alu_op = `ALU_CTRL_SUB;
            end
            `JAL: begin
                alu_src = 1;
                reg_write = 1;
                alu_op = `ALU_CTRL_ADD;
                mem_to_reg = 2;
                jump_signal = `JUMP_JAL;
            end
            `JALR: begin
                alu_src = 1;
                reg_write = 1;
                alu_op = `ALU_CTRL_ADD;
                mem_to_reg = 2;
                jump_signal = `JUMP_JALR;
            end
            `ECALL: begin
                is_ecall = 1;
            end
            default: begin
            end
        endcase
    end
    
endmodule
