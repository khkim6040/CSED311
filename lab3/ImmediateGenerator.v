`include "opcodes.v"

module ImmediateGenerator (
    input [31:0] part_of_inst,
    output reg [31:0] imm_gen_out
);

    reg [6:0] opcodes;
    reg [6:0] funct3;
    reg [6:0] funct7;
    // TODO: Generate immediate value depending on the instruction
    always @(*) begin
        
    end

endmodule
