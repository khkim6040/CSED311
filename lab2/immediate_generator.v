`include "opcodes.v"

module immediate_generator (input [31:0] part_of_inst, output reg [31:0] imm_gen_out);
  
  // input [31:0] part_of_inst;
  // output [31:0] imm_gen_out;
  wire [6:0] opcode;
  assign opcode = part_of_inst[6:0];

  // TODO
  // Generate sign-extended immediate value
  // discern the type of instruction

  always @(*) begin
    // R-type
    // do nothing
    if (opcode == `ARITHMETIC) begin
      assign imm_gen_out = 32'b0;
    end
    // I-type 12bits
    // part_of_inst[31:20] = imm_gen_out[11:0]
    else if (opcode == `ARITHMETIC_IMM || opcode == `LOAD || opcode == `JALR) begin
      assign imm_gen_out = {{20{part_of_inst[31]}}, part_of_inst[31:20]};
    end
    // S-type 12bits
    // part_of_inst[31:25] = imm_gen_out[11:5], part_of_inst[11:7] = imm_gen_out[4:0]
    else if (opcode == `STORE) begin
      assign imm_gen_out = {{20{part_of_inst[31]}}, part_of_inst[31:25], part_of_inst[11:7]};
    end
    // SB-type 13bits
    // part_of_inst[31] = imm_gen_out[12], part_of_inst[30:25] = imm_gen_out[10:5], part_of_inst[11:8] = imm_gen_out[4:1], part_of_inst[7] = imm_gen_out[11]
    else if (opcode == `BRANCH) begin
      assign imm_gen_out = {{19{part_of_inst[31]}}, part_of_inst[31], part_of_inst[7], part_of_inst[30:25], part_of_inst[11:8], 1'b0}; // * 수정함. 기존 코드 --> assign imm_gen_out = {{19{part_of_inst[31]}}, part_of_inst[31], part_of_inst[30:25], part_of_inst[11:8], part_of_inst[7]}; 
    end
    // UJ-type 21bits
    // part_of_inst[31] = imm_gen_out[20], part_of_inst[30:21] = imm_gen_out[10:1], part_of_inst[20] = imm_gen_out[11], part_of_inst[19:12] = imm_gen_out[19:12]
    else if (opcode == `JAL) begin
      assign imm_gen_out = {{11{part_of_inst[31]}}, part_of_inst[31], part_of_inst[19:12], part_of_inst[20], part_of_inst[30:21], 1'b0}; // * 수정함. 기존 코드 --> assign imm_gen_out = {{11{part_of_inst[31]}}, part_of_inst[31], part_of_inst[30:21], part_of_inst[20], part_of_inst[19:12]};
    end
    else begin
      assign imm_gen_out = 32'b0;
    end
  end
    
endmodule


