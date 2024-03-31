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
  wire [31:0] current_pc;
  wire [31:0] next_pc;
  wire [31:0] mem_src_mux_out;
  wire [31:0] alu_src1_mux_out;
  wire [31:0] alu_src2_mux_out;
  wire [31:0] reg_write_mux_out;
  wire [31:0] pc_src_mux_out;
  wire [31:0] mem_dout;
  wire [31:0] imm_gen_out;
  wire [31:0] alu_out;
  wire [31:0] alu_ctrl_out;
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


  /***** Register declarations *****/
  reg [31:0] IR; // instruction register
  reg [31:0] MDR; // memory data register
  reg [31:0] A; // Read 1 data register
  reg [31:0] B; // Read 2 data register
  reg [31:0] ALUOut; // ALU output register


  


  

  2mux mem_src_mux(
    .x1(),        // input
    .x2(),        // input
    .swch(),         // input
    .out()          // output
  );

  2mux alu_src1_mux(
    .x1(),        // input
    .x2(),        // input
    .swch(),         // input
    .out()          // output
  );

  2mux alu_src2_mux(
    .x1(),        // input
    .x2(),        // input
    .swch(),         // input
    .out()          // output
  );

  2mux reg_write_mux(
    .x1(),        // input
    .x2(),        // input
    .swch(),         // input
    .out()          // output
  );

  2mux pc_src_mux(
    .x1(),        // input
    .x2(),        // input
    .swch(),         // input
    .out()          // output
  );

  // ---------- Update program counter ----------
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(),         // input
    .next_pc(),     // input
    .current_pc()   // output
  );

  // ---------- Register File ----------
  RegisterFile reg_file(
    .reset(),        // input
    .clk(),          // input
    .rs1(),          // input
    .rs2(),          // input
    .rd(),           // input
    .rd_din(),       // input
    .write_enable(),    // input
    .rs1_dout(),     // output
    .rs2_dout(),      // output
    .print_reg()     // output (TO PRINT REGISTER VALUES IN TESTBENCH)
  );

  // ---------- Memory ----------
  Memory memory(
    .reset(),        // input
    .clk(),          // input
    .addr(),         // input
    .din(),          // input
    .mem_read(),     // input
    .mem_write(),    // input
    .mem_dout()          // output
  );

  // ---------- Control Unit ----------
  ControlUnit ctrl_unit(
    .part_of_inst(),  // input
    .is_jal(),        // output
    .is_jalr(),       // output
    .branch(),        // output
    .mem_read(),      // output
    .mem_to_reg(),    // output
    .mem_write(),     // output
    .alu_src(),       // output
    .write_enable(),     // output
    .pc_to_reg(),     // output
    .is_ecall()       // output (ecall inst)
  );

  // ---------- Immediate Generator ----------
  ImmediateGenerator imm_gen(
    .part_of_inst(),  // input
    .imm_gen_out()    // output
  );

  // ---------- ALU Control Unit ----------
  ALUControlUnit alu_ctrl_unit(
    .funct7(),  // input
    .funct3(),  // input
    .ALUOp(),   // input
    .alu_ctrl_out()         // output
  );

  // ---------- ALU ----------
  ALU alu(
    .alu_op(),      // input
    .alu_in_1(),    // input  
    .alu_in_2(),    // input
    .alu_out(),  // output
    .alu_bcond()     // output
  );

endmodule
