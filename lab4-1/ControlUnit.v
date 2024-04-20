`include "opcodes.v"

module ControlUnit (input part_of_inst[6:0],
                    output mem_read,
                    output mem_to_reg,
                    output mem_write,
                    output alu_src,
                    output reg_write,
                    output reg [1:0] alu_op,
                    output reg is_ecall);


    always @(*) begin
        mem_read = 0;
        mem_to_reg = 0;
        mem_write = 0;
        alu_src = 0;
        reg_write = 0;
        alu_op = `ALU_CTRL_ADD; // Default value
        is_ecall = 0;
        case(part_of_inst)
            `ARITHMETIC: begin
                reg_write = 1;
                alu_op = `ALU_CTRL_ADD;
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
                // NOTE: will be implemented further in the next lab
                alu_op = `ALU_CTRL_SUB;
            end
            `JAL: begin
                // NOTE: will be implemented further in the next lab
                alu_src = 1;
                reg_write = 1;
                alu_op = `ALU_CTRL_ADD;
            end
            `JALR: begin
                // NOTE: will be implemented further in the next lab
                alu_src = 1;
                reg_write = 1;
                alu_op = `ALU_CTRL_ADD;
            end
            `ECALL: begin
                is_ecall = 1;
            end
            default: begin
            end
        endcase
    end
    
endmodule
