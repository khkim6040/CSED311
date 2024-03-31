`include "opcodes.v"

module ALUControlUnit (
    input[6:0] funct7,
    input[2:0] funct3,
    input[1:0] ALUOp,
    output reg [3:0] alu_ctrl_out
);

    always @(*) begin 
        case(ALUOp) 
            `ALU_CTRL_ADD: begin
                alu_ctrl_out = `ALU_ADD;
            end
            `ALU_CTRL_SUB: begin
                alu_ctrl_out = `ALU_SUB;
            end
            `ALU_CTRL_ARITH: begin
               case(funct3)
                    `FUNCT3_ADD: begin 
                        if(funct7 == `FUNCT7_SUB) begin
                            alu_ctrl_out = `ALU_SUB;
                        end
                        else begin
                            alu_ctrl_out = `ALU_ADD;
                        end
                    end
                    `FUNCT3_SLL: begin
                        alu_ctrl_out = `ALU_SLL;
                    end
                    `FUNCT3_XOR: begin
                        alu_ctrl_out = `ALU_XOR;
                    end
                    `FUNCT3_SRL: begin
                        alu_ctrl_out = `ALU_SRL;
                    end
                    `FUNCT3_OR: begin
                        alu_ctrl_out = `ALU_OR;
                    end
                    `FUNCT3_AND: begin
                        alu_ctrl_out = `ALU_AND;
                    end
                    default begin
                        alu_ctrl_out = 4'b0; // Undefined
                    end
               endcase 
            end
            `ALU_CTRL_IMME: begin
                case(funct3)
                    `FUNCT3_ADD: begin
                        alu_ctrl_out = `ALU_ADD;
                    end
                    `FUNCT3_XOR: begin
                        alu_ctrl_out = `ALU_XOR;
                    end
                    `FUNCT3_OR: begin
                        alu_ctrl_out = `ALU_OR;
                    end
                    `FUNCT3_AND: begin
                        alu_ctrl_out = `ALU_AND;
                    end
                    `FUNCT3_SLL: begin
                        alu_ctrl_out = `ALU_SLL;
                    end
                    `FUNCT3_SRL: begin
                        alu_ctrl_out = `ALU_SRL;
                    end
                    default begin
                        alu_ctrl_out = 4'b0; // Undefined
                    end
                endcase
            end
        endcase
    end

endmodule
