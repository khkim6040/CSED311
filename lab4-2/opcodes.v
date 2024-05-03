// You don't have to use constants below if you want to define yours.
// You can modify and define constants for your convenience

// OPCODE
// R-type instruction opcodes
`define ARITHMETIC      7'b0110011
// I-type instruction opcodes
`define ARITHMETIC_IMM  7'b0010011
`define LOAD            7'b0000011
`define JALR            7'b1100111
// S-type instruction opcodes
`define STORE           7'b0100011
// B-type instruction opcodes
`define BRANCH          7'b1100011
// U-type instruction opcodes
//`define LUI             7'b0110111
//`define AUIPC           7'b0010111
// J-type instruction opcodes
`define JAL             7'b1101111


`define ECALL           7'b1110011

// FUNCT3
`define FUNCT3_BEQ      3'b000
`define FUNCT3_BNE      3'b001
`define FUNCT3_BLT      3'b100
`define FUNCT3_BGE      3'b101

`define FUNCT3_LW       3'b010
`define FUNCT3_SW       3'b010

`define FUNCT3_ADD      3'b000
`define FUNCT3_SUB      3'b000
`define FUNCT3_SLL      3'b001
`define FUNCT3_XOR      3'b100
`define FUNCT3_OR       3'b110
`define FUNCT3_AND      3'b111
`define FUNCT3_SRL      3'b101

// FUNCT7
`define FUNCT7_SUB      1'b1
`define FUNCT7_OTHERS   1'b0


// ALUOp
`define ALU_CTRL_ADD         2'b00 // JAL, JALR, LW, SW, Default value of don't cares
`define ALU_CTRL_SUB         2'b01 // BEQ, BNE, BLT, BGE
 // Divided OTHER case into arith and imme 
 // because of possible conflict between 
 // immediate sub which should not occur and R-type sub
`define ALU_CTRL_ARITH       2'b10 // R-type, I-type, depending on FUNCT3, FUNCT7
`define ALU_CTRL_IMME        2'b11 // I-type, depending on FUNCT3


// ALU control signals
`define ALU_ADD    4'b0001
`define ALU_SUB    4'b0010
`define ALU_SLL    4'b0011
`define ALU_XOR    4'b0100
`define ALU_SRL    4'b0101
`define ALU_OR     4'b0110
`define ALU_AND    4'b0111
`define ALU_BEQ    4'b1000
`define ALU_BNE    4'b1001
`define ALU_BLT    4'b1010
`define ALU_BGE    4'b1011

`define BCOND_DEFAULT   2'b00
`define BCOND_TAKEN     2'b01
`define BCOND_NOT_TAKEN 2'b10
