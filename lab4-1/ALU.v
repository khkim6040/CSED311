`include "opcodes.v"

module ALU (
    input [3:0] alu_ctrl_out,
    input [31:0] alu_in_1,
    input [31:0] alu_in_2,
    output reg [31:0] alu_result,
    output reg alu_bcond
);

    always @(*) begin
        alu_result = 32'b0;
        alu_bcond = 1'b0;
        case(alu_ctrl_out)
            `ALU_ADD: begin
                alu_result = alu_in_1 + alu_in_2;
            end
            `ALU_SUB: begin
                alu_result = alu_in_1 - alu_in_2;
            end
            `ALU_SLL: begin
                alu_result = alu_in_1 << alu_in_2;
            end
            `ALU_XOR: begin
                alu_result = alu_in_1 ^ alu_in_2;
            end
            `ALU_SRL: begin
                alu_result = alu_in_1 >> alu_in_2;
            end
            `ALU_OR: begin
                alu_result = alu_in_1 | alu_in_2;
            end
            `ALU_AND: begin
                alu_result = alu_in_1 & alu_in_2;
            end
            `ALU_BEQ: begin
                if (alu_in_1 == alu_in_2) begin
                    alu_bcond = 1'b1;
                end
                else begin
                    alu_bcond = 1'b0;
                end
            end
            `ALU_BNE: begin
                if (alu_in_1 != alu_in_2) begin
                    alu_bcond = 1'b1;
                end
                else begin
                    alu_bcond = 1'b0;
                end
            end
            `ALU_BLT: begin
                if (alu_in_1 < alu_in_2) begin
                    alu_bcond = 1'b1;
                end
                else begin
                    alu_bcond = 1'b0;
                end
            end
            `ALU_BGE: begin
                if (alu_in_1 >= alu_in_2) begin
                    alu_bcond = 1'b1;
                end
                else begin
                    alu_bcond = 1'b0;
                end
            end
            default begin
                alu_result = 32'b0;
                alu_bcond = 1'b0;
            end
        endcase   
    end

endmodule
