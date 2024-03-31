`include "opcodes.v"

module ImmediateGenerator (
    input [31:0] part_of_inst,
    output reg [31:0] imm_gen_out
);

    reg [6:0] opcode = part_of_inst[6:0];
    reg [2:0] funct3 = part_of_inst[14:12];
    reg [6:0] funct7 = part_of_inst[31:25];


    // TODO: Generate immediate value depending on the instruction
    always @(*) begin
        // I-type
        if (opcode == `ARITHMETIC_IMM || opcode == `LOAD || opcode == `JALR) begin
            imm_gen_out = {{20{part_of_inst[31]}}, part_of_inst[31:20]};
        end
        // S-type
        else if (opcode == `STORE) begin
            imm_gen_out = {{20{part_of_inst[31]}}, part_of_inst[31:25], part_of_inst[11:7]};
        end
        // B-type
        else if (opcode == `BRANCH) begin
            imm_gen_out = {{19{part_of_inst[31]}}, part_of_inst[31], part_of_inst[7], part_of_inst[30:25], part_of_inst[11:8], 1'b0};
        end
        // J-type
        else if (opcode == `JAL) begin
            imm_gen_out = {{11{part_of_inst[31]}}, part_of_inst[31], part_of_inst[19:12], part_of_inst[20], part_of_inst[30:21], 1'b0};
        end
        else begin
            imm_gen_out = 32'b0; // R-type and unknown
        end
    end

endmodule
