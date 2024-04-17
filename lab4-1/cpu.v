// Submit this file with other files you created.
// Do not touch port declarations of the module 'CPU'.

// Guidelines
// 1. It is highly recommened to `define opcodes and something useful.
// 2. You can modify modules (except InstMemory, DataMemory, and RegisterFile)
// (e.g., port declarations, remove modules, define new modules, ...)
// 3. You might need to describe combinational logics to drive them into the module (e.g., mux, and, or, ...)
// 4. `include files if required

module cpu(input reset,       // positive reset signal
           input clk,         // clock signal
           output is_halted, // Whehther to finish simulation
           output [31:0]print_reg[0:31]); // Whehther to finish simulation


  /***** Wire declarations *****/
  // IF stage wires
  wire[31:0] IF_current_pc;
  wire[31:0] IF_imem_out;
  wire[31:0] IF_pc_4_adder_out;

  // ID stage wires
  wire[31:0] ID_rs1_dout;
  wire[31:0] ID_rs2_dout;
  wire[31:0] ID_imm_gen_out;
  wire[31:0] ID_reg_rs1_mux_out;
  // Output of control unit in ID stage
  wire ID_is_ecall;
  wire ID_halt_cpu;
  wire ID_reg_write;
  wire ID_mem_to_reg;
  wire ID_mem_read;
  wire ID_mem_write;
  wire[1:0] ID_alu_op;
  wire ID_alu_src;
  // Assingable wires in ID stage
  wire[31:0] ID_full_inst;
  wire[6:0] ID_opcode;
  wire[2:0] ID_funct3;
  wire ID_funct7;
  wire[4:0] ID_reg_rs1;
  wire[4:0] ID_reg_rs2;
  wire[4:0] ID_reg_rd;

  // EX stage wires 
  wire[3:0] EX_alu_ctrl_out;
  wire[31:0] EX_alu_src2_mux_out;
  wire[31:0] EX_rs1_data;
  wire[31:0] EX_rs2_data;
  wire[31:0] EX_alu_result;
  wire[31:0] EX_imm_gen_out;
  wire EX_mem_read;
  wire EX_mem_to_reg;
  wire EX_mem_write;
  wire EX_alu_src;
  wire EX_reg_write;
  wire EX_halt_cpu;
  wire EX_funct7;
  wire EX_funct3;
  wire EX_reg_rd;
  wire[1:0] EX_alu_op;
  
  // MEM stage wires
  wire[31:0] MEM_alu_out;
  wire[31:0] MEM_dmem_din;
  wire[31:0] MEM_rd;
  wire[31:0] MEM_dmem_dout;
  wire MEM_mem_write;
  wire MEM_mem_read;
  wire MEM_is_branch;
  wire MEM_mem_to_reg;
  wire MEM_reg_write;
  wire MEM_halt_cpu;

  // WB stage wires
  wire[31:0] WB_mem_to_reg_src_1;
  wire[31:0] WB_mem_to_reg_src_2;
  wire[31:0] WB_reg_write_mux_out;
  wire WB_mem_to_reg;
  wire WB_reg_write;
  wire WB_halt_cpu; // Will set is_halted(output of this module)


  /***** Register declarations *****/
  // You need to modify the width of registers
  // In addition, 
  // 1. You might need other pipeline registers that are not described below
  // 2. You might not need registers described below
  /***** IF/ID pipeline registers *****/
  reg [31:0] reg_IF_ID_inst;           // Full instruction
  /***** ID/EX pipeline registers *****/
  // From the control unit
  reg[1:0] reg_ID_EX_alu_op;         // will be used in EX stage
  reg reg_ID_EX_alu_src;        // will be used in EX stage
  reg reg_ID_EX_mem_write;      // will be used in MEM stage
  reg reg_ID_EX_mem_read;       // will be used in MEM stage
  reg reg_ID_EX_mem_to_reg;     // will be used in WB stage
  reg reg_ID_EX_reg_write;      // will be used in WB stage
  reg reg_ID_EX_halt_cpu;       // will be used in WB stage
  // From others
  reg[31:0] reg_ID_EX_rs1_data;
  reg[31:0] reg_ID_EX_rs2_data;
  reg[31:0] reg_ID_EX_imm;
  reg[3:0] reg_ID_EX_ALU_ctrl_unit_input; // ID_funct7, funct3
  reg[4:0] reg_ID_EX_rd;

  /***** EX/MEM pipeline registers *****/
  // From the control unit
  reg reg_EX_MEM_mem_write;     // will be used in MEM stage
  reg reg_EX_MEM_mem_read;      // will be used in MEM stage
  // reg reg_EX_MEM_is_branch;     // will be used in MEM stage, seems not used in this lab
  reg reg_EX_MEM_mem_to_reg;    // will be used in WB stage
  reg reg_EX_MEM_reg_write;     // will be used in WB stage
  reg reg_EX_MEM_halt_cpu;      // will be used in WB stage
  // From others
  reg[31:0] reg_EX_MEM_alu_out;
  reg[31:0] reg_EX_MEM_dmem_din;
  reg[4:0] reg_EX_MEM_rd;

  /***** MEM/WB pipeline registers *****/
  // From the control unit
  reg reg_MEM_WB_mem_to_reg;    // will be used in WB stage
  reg reg_MEM_WB_reg_write;     // will be used in WB stage
  reg reg_MEM_WB_halt_cpu;      // will be used in WB stage
  // From others
  reg[31:0] reg_MEM_WB_mem_to_reg_src_1;
  reg[31:0] reg_MEM_WB_mem_to_reg_src_2;

  /***** Wire Instantiation *****/
  assign ID_full_inst = reg_IF_ID_inst;
  assign ID_opcode = reg_IF_ID_inst[6:0];
  assign ID_funct3 = reg_IF_ID_inst[14:12];
  assign ID_funct7 = reg_IF_ID_inst[30];
  assign ID_reg_rs1 = reg_IF_ID_inst[19:15];
  assign ID_reg_rs2 = reg_IF_ID_inst[24:20];
  assign ID_reg_rd = reg_IF_ID_inst[11:7];
  assign ID_halt_cpu = ID_is_ecall && ID_rs1_dout == 10;

// ------------------- IF stage -------------------
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(IF_pc_4_adder_out),     // input
    .current_pc(IF_current_pc)   // output
  );

  Adder pc_4_adder(
    .x0(IF_current_pc),  // input
    .x1(4),  // input
    .sum(IF_pc_4_adder_out) // output
  );

  InstMemory imem(
    .reset(reset),   // input
    .clk(clk),     // input
    .addr(IF_current_pc),    // input
    .dout(IF_imem_out)     // output
  );

  // Update IF/ID pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      reg_IF_ID_inst <= 32'b0; 
    end
    else begin
      reg_IF_ID_inst <= IF_imem_out;
    end
  end

// ------------------- ID stage -------------------

  Mux_2_to_1 reg_rs1_mux(
    .x0(17)
    .x1(ID_reg_rs1)
    .swch(ID_is_ecall)
    .out(ID_reg_rs1_mux_out)
  );

  RegisterFile reg_file (
    .reset (reset),        // input
    .clk (clk),          // input
    .rs1 (ID_reg_rs1_mux_out),          // input
    .rs2 (ID_reg_rs2),          // input
    .rd (ID_reg_rd),           // input
    .rd_din (WB_reg_write_mux_out),       // input
    .reg_write (reg_MEM_WB_reg_write),    // input
    .rs1_dout (ID_rs1_dout),     // output
    .rs2_dout (ID_rs2_dout),      // output
    .print_reg(print_reg)
  );


  ControlUnit ctrl_unit (
    .part_of_inst(//TODO: how range of inst should be in?),  // input
    .mem_read(ID_mem_read),      // output
    .mem_to_reg(ID_mem_to_reg),    // output
    .mem_write(ID_mem_write),     // output
    .alu_src(ID_alu_src),       // output
    .reg_write(ID_reg_write),  // output
    // .pc_to_reg(),     // output. seems not used in this lab
    .alu_op(ID_alu_op),        // output
    .is_ecall(ID_is_ecall)       // output (ecall inst)
  );

  ImmediateGenerator imm_gen(
    .part_of_inst(ID_full_inst),  // input
    .imm_gen_out(ID_imm_gen_out)    // output
  );

  // Update ID/EX pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
    end
    else begin
    end
  end

// ------------------- EX stage -------------------

  Mux_2_to_1 alu_src2_mux(
    .x0(EX_rs2_data)
    .x1(EX_imm_gen_out)
    .swch(EX_alu_src)
    .out(EX_alu_src2_mux_out)
  );

  ALUControlUnit alu_ctrl_unit (
    .funct7(EX_funct7)  // input
    .funct3(EX_funct3) // input
    .alu_op(EX_alu_op) // input
    .alu_ctrl_out(EX_alu_ctrl_out)         // output
  );

  ALU alu (
    .alu_ctrl_out(EX_alu_ctrl_out),      // input
    .alu_in_1(EX_rs1_data),    // input  
    .alu_in_2(EX_alu_src2_mux_out),    // input
    .alu_result(EX_alu_result),  // output
    // .alu_zero()     // output. seems not used in this lab
  );

  // Update EX/MEM pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
    end
    else begin
    end
  end

// ------------------- MEM stage -------------------

  DataMemory dmem(
    .reset (reset),      // input
    .clk (clk),        // input
    .addr (MEM_alu_out),       // input
    .din (MEM_dmem_din),        // input
    .mem_read (MEM_mem_read),   // input
    .mem_write (MEM_mem_write),  // input
    .dout (MEM_dmem_dout)        // output
  );

  // Update MEM/WB pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
    end
    else begin
    end
  end

// ------------------- WB stage -------------------
  
  Mux_2_to_1 reg_write_mux(
    .x0(WB_mem_to_reg_src_1),        // input
    .x1(WB_mem_to_reg_src_2),        // input
    .swch(WB_mem_to_reg),         // input
    .out(WB_reg_write_mux_out)          // output
  );
  
endmodule
