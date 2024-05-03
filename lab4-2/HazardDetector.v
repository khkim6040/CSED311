`include "opcodes.v"

module HazardDetector (input clk,
                       input reset,
                       input [31:0] instruction,
                       input [4:0] rs1,
                       input [4:0] EX_rd,
                       input [4:0] MEM_rd,
                       input mem_read,
                       input is_ecall,
                       input bcond,
                       input [31:0] ID_PC,
                       input [31:0] EX_PC,
                       input [31:0] branch_target,
                       output reg PC_write,
                       output reg IF_ID_write,
                       output reg ID_nop_signal,
                       output reg EX_correct_next_pc,
                       output reg EX_PCSrc);

    reg [4:0] rs2;
    reg [6:0] opcode;
    assign opcode = instruction[6:0];
    // assign rs1 = instruction[19:15];
    assign rs2 = instruction[24:20];
    // Arithmetic uses both rs1, rs2
    // Immediate uses only rs1    
    // Load uses only rs1
    // Store uses both rs1, rs2, even though rs2 is not used in the ALU
    // Branch uses both rs1, rs2
    // Jump uses only rs1
    wire is_rs1_used, is_rs2_used;
    assign is_rs1_used = rs1 != 0 && (opcode == `ARITHMETIC || opcode == `ARITHMETIC_IMM || opcode == `LOAD || opcode == `STORE || opcode == `BRANCH || opcode == `JAL || opcode == `ECALL);
    assign is_rs2_used = rs2 != 0 && (opcode == `ARITHMETIC || opcode == `STORE || opcode == `BRANCH);

    // inspect the hazard
    always @(*) begin
        // Load-use hazard
        if(mem_read && ((is_rs1_used && rs1 == EX_rd) || (is_rs2_used && rs2 == EX_rd))) begin
            PC_write = 0;
            IF_ID_write = 0;
            ID_nop_signal = 1;
        end
        // Ecall hazard because ecall comparison executes in ID stage
        else if(is_ecall && (((is_rs1_used && rs1 == EX_rd) || (is_rs2_used && rs2 == EX_rd)) || ((is_rs1_used && rs1 == MEM_rd) || (is_rs2_used && rs2 == MEM_rd)))) begin
            // When hazard distance is 1
            PC_write = 0;
            IF_ID_write = 0;
            ID_nop_signal = 1;
        end
        else begin
            PC_write = 1;
            IF_ID_write = 1;
            ID_nop_signal = 0;
        end
    end

endmodule
