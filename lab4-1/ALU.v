`include "opcodes.v"

module ALU (
    input [3:0] alu_ctrl_out,
    input [31:0] alu_in_1,
    input [31:0] alu_in_2,
    output reg [31:0] alu_out,
    output reg alu_bcond
);

    // TODO: Implement ALU operations
    always @(*) begin
        // $display("arithmetic: %b", alu_ctrl_out);
        // $display("input A: %b", alu_in_1);
        // $display("input B: %b", alu_in_2);
        alu_out = 32'b0;
        alu_bcond = 1'b0;
        case(alu_ctrl_out)
            `ALU_ADD: begin
                alu_out = alu_in_1 + alu_in_2;
            end
            `ALU_SUB: begin
                alu_out = alu_in_1 - alu_in_2;
            end
            `ALU_SLL: begin
                alu_out = alu_in_1 << alu_in_2;
            end
            `ALU_XOR: begin
                alu_out = alu_in_1 ^ alu_in_2;
            end
            `ALU_SRL: begin
                alu_out = alu_in_1 >> alu_in_2;
            end
            `ALU_OR: begin
                alu_out = alu_in_1 | alu_in_2;
            end
            `ALU_AND: begin
                alu_out = alu_in_1 & alu_in_2;
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
                alu_out = 32'b0;
                alu_bcond = 1'b0;
            end
        endcase   
        // $display("output : %b", alu_out);     
    end

endmodule
