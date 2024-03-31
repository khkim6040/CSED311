`include "opcodes.v"
`include "states.v"

module ControlUnit (input reset,
                    input clk,
                    input [6:0] part_of_inst,
                    input bcond,
                    output ALUSrcA,
                    output [1:0] ALUSrcB,
                    output IorD,
                    output IRWrite,
                    output PCSource,
                    output PCWrite,
                    output PCWriteCond,
                    output RegWrite,
                    output MemRead,
                    output MemWrite,
                    output MemtoReg,
                    output MDRWrite,
                    output ALUSrcAWrite,
                    output ALUSrcBWrite,
                    output ALUOutWrite,
                    output [2:0] ALUOp,
                    output is_ecall);


    reg [3:0] state, next_state;

    // TODO: Microcode for Control Unit
    always @(*) begin 
        ALUSrcA = 0;
        ALUSrcB = 1;
        IorD = 0;
        IRWrite = 0;
        PCSource = 0;
        PCWrite = 0;
        PCWriteCond = 0;
        RegWrite = 0;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        MDRWrite = 0;
        ALUSrcAWrite = 0;
        ALUSrcBWrite = 0;
        ALUOutWrite = 0;
        ALUOp = part_of_inst;
        is_ecall = 0;

        case (state) begin
            `IF_4: begin
                MemRead = 1;
                IRWrite = 1;
                ALUOutWrite = 1;
            end
            `ID: begin
                ALUSrcAWrite = 1;
                ALUSrcBWrite = 1;
            end
            `EX_1: begin
                if (opcodes == `BRANCH) begin
                    PCWriteCond = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 0;
                    PCSource = 1;
                end
                else begin
                    PCWrite = 0;
                end
            end
            `EX_2: begin
                if (opcodes == `ARITHMETIC) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 0;
                    ALUOp = `ALU_OTHERS;
                end
                else if (opcodes == `ARITHMETIC_IMM) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_OTHERS;
                end
                else if (opcodes == `LOAD | opcodes == `STORE) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_ADD;
                end
                else if (opcodes == `JAL) begin
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                    ALUOp = ALU_ADD;
                end
                else if (opcodes == `JALR) begin
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = ALU_ADD;
                end
                else if (opcodes == `BRANCH) begin
                    PCWrite = 1;
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                    ALUOp = ALU_SUB;
                end
            end
            `MEM_4: begin
                IorD = 1;
                if (opcodes == `LOAD) begin
                    
                end
                else begin
                end
            end
            `WB: begin
            end
            default: begin
            end
        
        end
        endcase

    end

    // TODO: Calculate next state
    always @(*) begin 
        case (state) begin
            `IF_1: next_state = `IF_2;
            `IF_2: next_state = `IF_3;
            `IF_3: next_state = `IF_4;
            `IF_4: next_state = opcodes == `JAL ? `EX_1 : `ID;
            `ID: next_state = `EX_1;
            `EX_1: next_state = opcodes == `BRANCH & bcond == 0 ? `IF_1 : `EX_2;
            `EX_2: begin
                if (opcodes == `BRANCH) 
                    next_state = `IF_1;
                else if (opcodes == `LOAD | opcodes == `STORE)
                    next_state = `MEM_1;
                else
                    next_state = `WB;
            end
            `MEM_1: next_state = `MEM_2;
            `MEM_2: next_state = `MEM_3;
            `MEM_3: next_state = `MEM_4;
            `MEM_4: next_state = opcodes == `LOAD ? `WB : `IF_1;
            `WB: next_state = `IF_1;
            default: begin
            end
        
        end
        endcase
    end

    // TODO: Update state synchronously
    always @(posedge clk) begin 
        if (reset == 1) begin
            state <= `IF_1;
            next_state = `IF_2;
        end
        else begin
            state <= next_state;
        end
    end
    
endmodule