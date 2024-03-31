// Submit this file with other files you created.
// Do not touch port declarations of the module 'CPU'.

// Guidelines
// 1. It is highly recommened to `define opcodes and something useful.
// 2. You can modify the module.
// (e.g., port declarations, remove modules, define new modules, ...)
// 3. You might need to describe combinational logics to drive them into the module (e.g., mux, and, or, ...)
// 4. `include files if required

module cpu(input reset,       // positive reset signal
           input clk,         // clock signal
           output is_halted,
           output [31:0]print_reg[0:31]
           ); // Whether to finish simulation
  /***** Wire declarations *****/
  wire [31:0] next_pc;
  wire [31:0] mem_src_mux_out;
  wire [31:0] alu_src1_mux_out;
  wire [31:0] alu_src2_mux_out;
  wire [31:0] reg_write_mux_out;
  wire [31:0] pc_src_mux_out;
  wire [31:0] mem_dout;
  wire [31:0] imm_gen_out;
  wire [31:0] alu_out;
  wire [3:0] alu_ctrl_out;
  wire [31:0] rs1_dout;
  wire [31:0] rs2_dout;


  wire alu_bcond;
 
  wire pc_write_cond;
  wire pc_write;
  wire i_or_d;
  wire mem_read;
  wire mem_write;
  wire mem_to_reg;
  wire IR_write;
  wire pc_source;
  wire [2:0] alu_op;
  wire alu_srcA;
  wire [2:0] alu_srcB;
  wire reg_write;
  wire [6:0] opcode;
  wire [4:0] reg_rs1;
  wire [4:0] reg_rs2;
  wire [4:0] reg_rd;
  wire is_ecall;

  wire [6:0] funct7;
  wire [2:0] funct3;

  wire MDR_write;
  wire A_write;
  wire B_write;
  wire ALUOut_write;

  wire [31:0] PC_out;
  wire [31:0] IR_out;
  wire [31:0] MDR_out;  
  wire [31:0] ALUOut_out;
  wire [31:0] A_out;
  wire [31:0] B_out;
  


  // /***** Register declarations *****/
  // reg [31:0] IR; // instruction register
  // reg [31:0] MDR; // memory data register
  // reg [31:0] A; // Read 1 data register
  // reg [31:0] B; // Read 2 data register
  // // reg [31:0] ALUOut; // ALU output register
  // reg [31:0] PC; // Program counter register
  
  assign reg_rs1 = IR_out[19:15];
  assign reg_rs2 = IR_out[24:20];
  assign reg_rd = IR_out[11:7]; 

  

  2mux mem_src_mux(
    .x0(PC_out),        // input
    .x1(ALUOut_out),        // input
    .swch(i_or_d),         // input
    .out(mem_src_mux_out)          // output
  );

  2mux alu_src1_mux(
    .x0(PC_out),        // input
    .x1(A_out),        // input
    .swch(alu_srcA),         // input
    .out(alu_src1_mux_out)          // output
  );

  4mux alu_src2_mux(
    .x0(B_out),        // input
    .x1(4),        // input
    .x2(imm_gen_out),        // input
    .x3(0),        // input It should not be selected
    .swch(alu_srcB),         // input
    .out(alu_src2_mux_out)          // output
  );

  2mux reg_write_mux(
    .x0(ALUOut_out),        // input
    .x1(MDR_out),        // input
    .swch(mem_to_reg),         // input
    .out(reg_write_mux_out)          // output
  );

  2mux pc_src_mux(
    .x0(alu_out),        // input
    .x1(ALUOut_out),        // input
    .swch(pc_source),         // input
    .out(pc_src_mux_out)          // output
  );

  // ---------- Update program counter ----------
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(next_pc),     // input
    .pc_write_signal(PCWrite || (pc_write_cond && !alu_bcond)),    // input
    .current_pc(PC_out)   // output
  );

  // ---------- Register File ----------
  RegisterFile reg_file(
    .reset(reset),        // input
    .clk(clk),          // input
    .rs1(reg_rs1),          // input
    .rs2(reg_rs2),          // input
    .rd(reg_rd),           // input
    .rd_din(reg_write_mux_out),       // input
    .write_enable(write_enable),    // input
    .is_ecall(is_ecall),      // input
    .is_halted(is_halted),      // output
    .rs1_dout(rs1_dout),     // output
    .rs2_dout(rs2_dout),      // output
    .print_reg(print_reg)     // output (TO PRINT REGISTER VALUES IN TESTBENCH)
  );

  // ---------- Memory ----------
  Memory memory(
    .reset(reset),        // input
    .clk(clk),          // input
    .addr(mem_src_mux_out),         // input
    .din(B_out),          // input
    .mem_read(mem_read),     // input
    .mem_write(mem_write),    // input
    .mem_dout(mem_dout)          // output
  );

  // ---------- Control Unit ----------
  ControlUnit ctrl_unit(
    .reset(reset),        // input
    .clk(clk),          // input
    .part_of_inst(opcode),    // input
    .ALUSrcA(alu_srcA),       // output
    .ALUSrcB(alu_srcB),       // output
    .IorD(i_or_d),        // output
    .IRWrite(IR_write),       // output
    .PCSource(pc_source),      // output
    .PCWrite(pc_write),       // output
    .PCWriteCond(pc_write_cond),   // output
    .RegWrite(reg_write),      // output
    .MemRead(mem_read),       // output
    .MemWrite(mem_write),      // output
    .MemtoReg(mem_to_reg),      // output
    .MDRWrite(MDR_write),      // output
    .ALUSrcAWrite(A_write),     // output
    .ALUSrcBWrite(B_write),     // output
    .ALUOutWrite(ALUOut_write),   // output
    .ALUOp(alu_op),        // output
    .is_ecall(is_ecall)      // output
  );

  // ---------- Immediate Generator ----------
  ImmediateGenerator imm_gen(
    .part_of_inst(IR_out),  // input
    .imm_gen_out(imm_gen_out)    // output
  );

  // ---------- ALU Control Unit ----------
  ALUControlUnit alu_ctrl_unit(
    .funct7(funct7),  // input
    .funct3(funct3),  // input
    .ALUOp(alu_op),   // input
    .alu_ctrl_out(alu_ctrl_out)         // output
  );

  // ---------- ALU ----------
  ALU alu(
    .alu_ctrl_out(alu_ctrl_out),      // input
    .alu_in_1(alu_src1_mux_out),    // input  
    .alu_in_2(alu_src2_mux_out),    // input
    .alu_out(alu_out),  // output
    .alu_bcond(alu_bcond)     // output
  );

  TempRegister IR(
    .in(mem_dout),  // input
    .able(IR_write),  // input
    .out(IR_out)  // output
  );

  TempRegister MDR(
    .in(mem_dout),  // input
    .able(MDR_wire),  // input
    .out(MDR_out)  // output
  );
  
  TempRegister A(
    .in(rs1_dout),  // input
    .able(A_write),  // input
    .out(A_out)  // output
  );
  
  TempRegister B(
    .in(rs2_dout),  // input
    .able(B_write),  // input
    .out(B_out)  // output
  );
  
  TempRegister ALUOut(
    .in(alu_out),  // input
    .able(ALUOut_write),  // input
    .out(ALUOut_out)  // output
  );

endmodule
