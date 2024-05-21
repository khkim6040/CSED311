`include "opcodes.v"

module HazardDetector (
    input clk,
    input reset,
    input [31:0] instruction,
    input [4:0] rs1,
    input [4:0] EX_rd,
    input [4:0] MEM_rd,
    input mem_read,
    input is_ecall,
    input [1:0] bcond,
    input [31:0] ID_PC,
    input [31:0] EX_PC,
    input [31:0] target_pc,
    input [31:0] MEM_is_ready,
    input [31:0] MEM_is_output_valid,
    input [31:0] MEM_is_hit,
    input MEM_mem_read,
    input MEM_mem_write,
    output reg PC_write,
    output reg IF_ID_write,
    output reg ID_EX_write,
    output reg EX_MEM_write,
    output reg ID_EX_nop_signal,
    output reg IF_ID_nop_signal,
    output reg [31:0] EX_correct_next_pc,
    output reg EX_PCSrc
    );

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
    assign is_rs1_used = rs1 != 0 && (opcode == `ARITHMETIC || opcode == `ARITHMETIC_IMM || opcode == `LOAD || 
                                        opcode == `STORE || opcode == `BRANCH || opcode == `JALR || opcode == `ECALL);
    assign is_rs2_used = rs2 != 0 && (opcode == `ARITHMETIC || opcode == `STORE || opcode == `BRANCH);

    // Detect Hazards
    always @(*) begin
        PC_write = 1;
        IF_ID_write = 1;
        ID_EX_write = 1;
        EX_MEM_write = 1;
        ID_EX_nop_signal = 0;
        IF_ID_nop_signal = 0;
        EX_correct_next_pc = EX_PC+4;
        EX_PCSrc = 0; // Update next pc from GShare predictor
        // Data Hazard: Load-use hazard
        if(mem_read && ((is_rs1_used && rs1 == EX_rd) || (is_rs2_used && rs2 == EX_rd))) begin
            PC_write = 0;
            IF_ID_write = 0;
            ID_EX_nop_signal = 1;
        end
        // Data Hazard: Ecall hazard because ecall comparison executes in ID stage
        else if(is_ecall && (((is_rs1_used && rs1 == EX_rd) || (is_rs2_used && rs2 == EX_rd)) || 
                ((is_rs1_used && rs1 == MEM_rd) || (is_rs2_used && rs2 == MEM_rd)))) begin
            // When hazard distance is 1
            PC_write = 0;
            IF_ID_write = 0;
            ID_EX_nop_signal = 1;
        end
        // Control Hazard: Branch hazard
        else if(bcond == `BCOND_TAKEN && ID_PC != target_pc) begin
            IF_ID_nop_signal = 1;
            ID_EX_nop_signal = 1;
            EX_correct_next_pc = target_pc;
            EX_PCSrc = 1;
        end
        // Control Hazard: Branch hazard
        else if(bcond == `BCOND_NOT_TAKEN && ID_PC != EX_PC+4) begin
            IF_ID_nop_signal = 1;
            ID_EX_nop_signal = 1;
            EX_correct_next_pc = EX_PC+4;
            EX_PCSrc = 1;
        end
        // Control Hazard: Jump hazard
        else if(bcond == `BCOND_JUMP && ID_PC != target_pc) begin
            IF_ID_nop_signal = 1;
            ID_EX_nop_signal = 1;
            EX_correct_next_pc = target_pc;
            EX_PCSrc = 1;
        end
        // Cache Miss stall
        else if((MEM_mem_read && !(MEM_is_ready && MEM_is_output_valid && MEM_is_hit)) ||
                    (MEM_mem_write && !(MEM_is_ready && MEM_is_hit))) begin
            PC_write = 0;
            IF_ID_write = 0;
            ID_EX_write = 0;
            EX_MEM_write = 0;
        end
        else begin
            PC_write = 1;
            IF_ID_write = 1;
            ID_EX_write = 1;
            EX_MEM_write = 1;
            ID_EX_nop_signal = 0;
            IF_ID_nop_signal = 0;
            EX_correct_next_pc = EX_PC+4;
            EX_PCSrc = 0;
        end
    end


endmodule
