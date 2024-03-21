// Submit this file with other files you created.
// Do not touch port declarations of the module 'cpu'.

// Guidelines
// 1. It is highly recommened to `define opcodes and something useful.
// 2. You can modify the module.
// (e.g., port declarations, remove modules, define new modules, ...)
// 3. You might need to describe combinational logics to drive them into the module (e.g., mux, and, or, ...)
// 4. `include files if required

module cpu(input reset,                     // positive reset signal
           input clk,                       // clock signal
           output is_halted,                // Whehther to finish simulation
           output [31:0] print_reg [0:31]); // TO PRINT REGISTER VALUES IN TESTBENCH (YOU SHOULD NOT USE THIS)
  /***** Wire declarations *****/
  wire [31:0] next_pc;

  reg [10:0] alu_op;
  reg [31:0] dout;

  wire is_jal;
  wire is_jalr;
  wire branch;
  wire mem_read;
  wire mem_to_reg;
  wire mem_write;
  wire alu_src;
  wire write_enable;
  wire pc_to_reg;
  wire is_ecall;
  wire [31:0] PCSrc1_out;
  reg alu_bcond;

  wire [4:0] rs1;
  wire [4:0] rs2;
  wire [4:0] rd;
  assign rs1 = dout[19:15]; // assign은 wire에만 쓸 수 있고, dout이 바뀔 때 자동으로 rs1,2,rd 의 값이 같이 바뀌게 된다.
  assign rs2 = dout[24:20];
  assign rd = dout[11:7];

  reg [31:0] rs1_dout;
  reg [31:0] rs2_dout;  
  reg [31:0] imm_gen_out;
  reg [31:0] pc_4_output;
  reg [31:0] pc_jump_output;
  reg [31:0] alu_result;
  wire [31:0] PCtoReg_out;
  wire [31:0] memtoReg_out;
  wire [31:0] ALUSrc_out;
  reg [31:0] dmem_dout;


  reg [6:0] opcode;
  assign opcode = dout[6:0];



  /***** Register declarations *****/
  reg [31:0] current_pc; // 전부 wire로 하면 다른 모듈에서 여기에 값을 넣을 때 오류를 일으킴. 값을 넣을 변수는 wire가 아니라 reg로 선언해야 함.

  // ---------- Update program counter ----------
  // PC must be updated on the rising edge (positive edge) of the clock.
  pc pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(next_pc),     // input
    .current_pc(current_pc)   // output
  );
  
  adder pc_4(
    .sc1(current_pc),    // input
    .sc2(32'b100),      // input, 그냥 4로 하는 게 낫지 않나 32'b000...100 으로 해야 되지 않음?
    .result(pc_4_output)    // output
  ); // 이런 식으로 adder, mux 모듈을 하나씩 만들어서 여기에 넣으면 됨

  adder pc_jump(
    .sc1(current_pc),    // input
    .sc2(imm_gen_out),   // input
    .result(pc_jump_output)    // output
  );

  mux PCSrc1(
    .x1(pc_4_output),    // input
    .x2(pc_jump_output),  // input
    .swch((branch&alu_bcond)|is_jal),
    .out(PCSrc1_out)    // output
  );

  mux PCSrc2(
    .x1(PCSrc1_out),    // input
    .x2(alu_result),    // input
    .swch(is_jalr),      // input
    .out(next_pc)     // output
  );

  // ---------- Instruction Memory ----------
  instruction_memory imem(
    .reset(reset),   // input
    .clk(clk),     // input
    .addr(current_pc),    // input
    .dout(dout)     // output
  );

  mux PCtoReg(
    .x1(memtoReg_out),  // input
    .x2(pc_4_output),    // input
    .swch(pc_to_reg),    // input
    .out(PCtoReg_out)      // output
  );

  // ---------- Register File ----------
  register_file reg_file (
    .reset (reset),        // input
    .clk (clk),          // input
    .rs1 (rs1),          // input
    .rs2 (rs2),          // input
    .rd (rd),           // input
    .rd_din (PCtoReg_out),       // input
    .write_enable (write_enable), // input
    .is_ecall(is_ecall),      // input, E_CALL 계산 위해 RF에 추가.
    .rs1_dout (rs1_dout),     // output
    .rs2_dout (rs2_dout),     // output
    .print_reg (print_reg),  //DO NOT TOUCH THIS
    .is_halted(is_halted)   // output, is_halted 계산한 값 빼주기
  );


  // ---------- Control Unit ---------- // 나
  control_unit ctrl_unit (
    .part_of_inst(opcode),  // input
    .is_jal(is_jal),        // output
    .is_jalr(is_jalr),       // output
    .branch(branch),        // output
    .mem_read(mem_read),      // output
    .mem_to_reg(mem_to_reg),    // output
    .mem_write(mem_write),     // output
    .alu_src(alu_src),       // output
    .write_enable(write_enable),  // output
    .pc_to_reg(pc_to_reg),     // output
    .is_ecall(is_ecall)       // output (ecall inst)
  );

  // ---------- Immediate Generator ---------- // 재형
  immediate_generator imm_gen(
    .part_of_inst(dout),  // input
    .imm_gen_out(imm_gen_out)    // output
  );

  mux ALUSrc(
    .x1(rs2_dout),    // input
    .x2(imm_gen_out),  // input
    .swch(alu_src),      // input
    .out(ALUSrc_out)     // output
  );

  // ---------- ALU Control Unit ---------- // 나
  alu_control_unit alu_ctrl_unit (
    .part_of_inst(dout),  // input
    .alu_op(alu_op)         // output
  );

  // ---------- ALU ---------- // 재형
  alu alu (
    .alu_op(alu_op),      // input
    .alu_in_1(rs1_dout),    // input  
    .alu_in_2(ALUSrc_out),    // input, * 수정함. 기존 코드 --> rs2_dout
    .alu_result(alu_result),  // output
    .alu_bcond(alu_bcond)    // output
  );

  // ---------- Data Memory ---------- // 재형
  data_memory dmem(
    .reset (reset),      // input
    .clk (clk),        // input
    .addr (alu_result),       // input * 수정함. 기존 코드 --> ALUSrc_out
    .din (rs2_dout),        // input
    .mem_read (mem_read),   // input
    .mem_write (mem_write),  // input
    .dout (dmem_dout)        // output
  );

  mux MemetoReg(
    .x1(alu_result),  // input
    .x2(dmem_dout),    // input
    .swch(mem_to_reg),  // input
    .out(memtoReg_out)     // output
  );

endmodule
