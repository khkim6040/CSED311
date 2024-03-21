`include "opcodes.v"


module alu_control_unit (input [31:0] part_of_inst,  // 명령어의 32비트 전부 다 온다고 정함
                        output reg [10:0] alu_op); 

    reg funct7;
    reg [2:0] funct3;
    reg [6:0] opcode;

    wire _unused_ok = &{1'b0,
                part_of_inst[31],
                part_of_inst[29:15],
                part_of_inst[11:7],
                1'b0}; // 각 1비트 사이사이로 &를 적용한 연산결과. 1비트 결과이다. 이건 무조건 0.

    always @(*) begin
        assign funct7 = part_of_inst[30];
        assign funct3 = part_of_inst[14:12];
        assign opcode = part_of_inst[6:0];
        case (opcode)
            `ARITHMETIC : alu_op = {funct7, funct3, opcode};
            `ARITHMETIC_IMM : alu_op = {1'b0, funct3, opcode};
            `LOAD : alu_op = {1'b0, `FUNCT3_LW, opcode};
            `STORE : alu_op = {1'b0, `FUNCT3_SW, opcode};
            `JALR : alu_op = {1'b0, `FUNCT3_ADD, opcode};
            `BRANCH : alu_op = {1'b0, funct3, opcode};
            default : alu_op = 0;
        endcase
    end


    
endmodule
