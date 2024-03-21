`include "opcodes.v"

module alu (input [10:0] alu_op,
            input [31:0] alu_in_1,
            input [31:0] alu_in_2,
            output reg [31:0] alu_result,
            output reg alu_bcond);

    wire funct7part;
    wire [2:0] funct3part;
    wire [6:0] opcode;

    assign funct7part = alu_op[10];
    assign funct3part = alu_op[9:7];
    assign opcode = alu_op[6:0];

    // 어차피 다 reg로 해야 값을 저장하는 게 가능해서, output을 reg로 다 바꾸고 assign을 다 뺐음. 
    always @(*) begin
        case (opcode) // 수정함. 기존 코드 --> alu_op
            `ARITHMETIC: begin
                if (funct7part == 0) begin
                    case(funct3part)
                        `FUNCT3_ADD: alu_result = alu_in_1 + alu_in_2; // 오버플로우 검출 안 해도 된다고 하심.
                        `FUNCT3_SLL: alu_result = alu_in_1 << alu_in_2[4:0];
                        `FUNCT3_XOR: alu_result = alu_in_1 ^ alu_in_2;
                        `FUNCT3_OR: alu_result = alu_in_1 | alu_in_2;
                        `FUNCT3_AND: alu_result = alu_in_1 & alu_in_2;
                        `FUNCT3_SRL: alu_result = alu_in_1 >> alu_in_2[4:0];
                        default: alu_result = 0;
                    endcase
                end
                else begin        
                    case(funct3part)
                        `FUNCT3_SUB: alu_result = alu_in_1 - alu_in_2;
                        default: alu_result = 0;
                    endcase
                end
                alu_bcond = 0;
            end
            `ARITHMETIC_IMM: begin
                if (funct7part == 0) begin
                    case(funct3part)
                        `FUNCT3_ADD: alu_result = alu_in_1 + alu_in_2; // 오버플로우 검출 안 해도 된다고 하심.
                        `FUNCT3_SLL: alu_result = alu_in_1 << alu_in_2[4:0];
                        `FUNCT3_XOR: alu_result = alu_in_1 ^ alu_in_2;
                        `FUNCT3_OR: alu_result = alu_in_1 | alu_in_2;
                        `FUNCT3_AND: alu_result = alu_in_1 & alu_in_2;
                        `FUNCT3_SRL: alu_result = alu_in_1 >> alu_in_2[4:0];
                        default: alu_result = 0;
                    endcase
                end
                else begin 
                    alu_result = 0;
                end
                alu_bcond = 0;
            end
            `LOAD: begin
                if (funct3part == `FUNCT3_LW) begin
                    alu_result = alu_in_1 + alu_in_2;
                end
                else begin        
                    alu_result = 0;
                end
                alu_bcond = 0;
            end
            `STORE: begin
                if (funct3part == `FUNCT3_SW) begin
                    alu_result = alu_in_1 + alu_in_2;
                end
                else begin        
                    alu_result = 0;
                end
                alu_bcond = 0;
            end
            `BRANCH: begin
                if (funct7part == 0) begin
                    case(funct3part)
                        `FUNCT3_BEQ: alu_bcond = alu_in_1 == alu_in_2;
                        `FUNCT3_BNE: alu_bcond = alu_in_1 != alu_in_2;
                        `FUNCT3_BLT: alu_bcond = alu_in_1 < alu_in_2;
                        `FUNCT3_BGE: alu_bcond = alu_in_1 >= alu_in_2;
                        default: alu_bcond = 0;
                    endcase
                end
                else begin        
                    alu_bcond = 0;
                end
                alu_result = 0;
            end
            `JALR: begin
                alu_result = alu_in_1 + alu_in_2;
                alu_bcond = 0;
            end
            `JAL: begin
                alu_result = 0;
                alu_bcond = 0;
            end
            default: begin
                alu_result = 0;
                alu_bcond = 0;
            end
        endcase
    end

endmodule
