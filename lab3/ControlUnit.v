`include "opcodes.v"
`include "states.v"

module ControlUnit (input reset,
                    input clk,
                    input [6:0] opcode,
                    input bcond,
                    output reg ALUSrcA,
                    output reg [1:0] ALUSrcB,
                    output reg IorD,
                    output reg IRWrite,
                    output reg PCSource,
                    output reg PCWrite,
                    output reg PCWriteCond,
                    output reg RegWrite,
                    output reg MemRead,
                    output reg MemWrite,
                    output reg MemtoReg,
                    output reg MDRWrite,
                    output reg ALUSrcAWrite,
                    output reg ALUSrcBWrite,
                    output reg ALUOutWrite,
                    output reg [1:0] ALUOp,
                    output reg is_ecall);


    reg [3:0] state, next_state;

    // Calculate next state
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
        
        if (opcode == `ECALL)
            is_ecall = 1;
        else
            is_ecall = 0;

        case (state) 
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
                if (opcode == `BRANCH) begin
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
                if (opcode == `ARITHMETIC) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 0;
                    ALUOp = `ALU_CTRL_ARITH;
                end
                else if (opcode == `ARITHMETIC_IMM) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_IMME;
                end
                else if (opcode == `LOAD | opcode == `STORE) begin
                    ALUOutWrite = 1;
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_ADD;
                end
                else if (opcode == `JAL) begin
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_ADD;
                end
                else if (opcode == `JALR) begin
                    ALUSrcA = 1;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_ADD;
                end
                else if (opcode == `BRANCH) begin
                    PCWrite = 1;
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                    ALUOp = `ALU_CTRL_ADD;
                end
            end
            `MEM_4: begin
                IorD = 1;
                if (opcode == `LOAD) begin
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
                if (opcode == `ARITHMETIC | opcode == `ARITHMETIC_IMM)  begin
                    PCSource = 0;
                    MemtoReg = 0;
                    RegWrite = 1;
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                end
                else if (opcode == `LOAD) begin
                    PCSource = 0;
                    MemtoReg = 1;
                    RegWrite = 1;
                    ALUSrcA = 0;
                    ALUSrcB = 1;
                end
                else if (opcode == `JAL) begin
                    RegWrite = 1;
                    PCSource = 0;
                    ALUSrcA = 0;
                    ALUSrcB = 2;
                end
                else if (opcode == `JALR) begin
                    RegWrite = 1;
                    PCSource = 0;
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
        endcase
        
        case (state) 
            `IF_1: next_state = `IF_2;
            `IF_2: next_state = `IF_3;
            `IF_3: next_state = `IF_4;
            `IF_4: next_state = opcode == `JAL ? `EX_1 : `ID;
            `ID: next_state = `EX_1;
            `EX_1: next_state = (opcode == `BRANCH & bcond == 0) ? `IF_1 : `EX_2; // 주의) 레지스터 답은 똑같은데 사이클 수만 다르면 여기를 체크
            `EX_2: begin
                if (opcode == `BRANCH)
                    next_state = `IF_1;
                else if (opcode == `LOAD | opcode == `STORE)
                    next_state = `MEM_1;
                else
                    next_state = `WB;
            end
            `MEM_1: next_state = `MEM_2;
            `MEM_2: next_state = `MEM_3;
            `MEM_3: next_state = `MEM_4;
            `MEM_4: next_state = opcode == `LOAD ? `WB : `IF_1;
            `WB: next_state = `IF_1;
            default: next_state = `IF_1;
        endcase
    end

    // Update state synchronously
    always @(posedge clk) begin 
        if (reset == 1) begin
            state <= `IF_1;
        end
        else begin
            state <= next_state;
        end
    end
    
endmodule
