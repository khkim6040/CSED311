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
                    output [1:0] ALUOp,
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
        ALUOp = 0;
        
        if (part_of_inst == `ECALL)
            is_ecall = 1;
        else
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
                if (part_of_inst == `BRANCH) begin
                    PCWriteCond = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 0;
                    PCSource = 1;
                    ALUOp = `ALU_CTRL_SUB;
                end
                else begin
                    PCWrite = 0;
                end
            end
            `EX_2: begin
                if (part_of_inst == `ARITHMETIC) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 0;
                    ALUOp = `ALU_CTRL_ARITH;
                end
                else if (part_of_inst == `ARITHMETIC_IMM) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_IMME;
                end
                else if (part_of_inst == `LOAD | part_of_inst == `STORE) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_ADD;
                end
                else if (part_of_inst == `JAL) begin
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_ADD;
                end
                else if (part_of_inst == `JALR) begin
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_ADD;
                end
                else if (part_of_inst == `BRANCH) begin
                    PCWrite = 1;
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_SUB;
                end
            end
            `MEM_4: begin
                IorD = 1;
                if (part_of_inst == `LOAD) begin
                    MemRead = 1;
                    MDRWrite = 1;
                end
                else begin
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                    MemWrite = 1;
                    PCWrite = 1;
                end
            end
            `WB: begin
                PCWrite = 1;
                ALUOp = `ALU_CTRL_ADD;
                if (part_of_inst == `ARITHMETIC | part_of_inst == `ARITHMETIC_IMM) begin begin
                    MemtoReg = 0;
                    RegWrite = 1;
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                end
                else if (part_of_inst == `LOAD) begin
                    MemtoReg = 1;
                    RegWrite = 1;
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                end
                else if (part_of_inst == `JAL) begin
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                end
                else if (part_of_inst == `JALR) begin
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                end
                else begin
                    PCWrite = 1;
                end
            end
            default: begin
                PCWrite = 0;
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
            `EX_1: next_state = (opcodes == `BRANCH & bcond == 0) ? `IF_1 : `EX_2; // 주의) 레지스터 답은 똑같은데 사이클 수만 다르면 여기를 체크
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
            default: next_state = `IF_1;
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