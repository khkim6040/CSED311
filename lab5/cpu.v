`include "opcodes.v"

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
  // Register update signals
  wire PC_write; // output of HazardDetector module, for PC module
  wire IF_ID_write; // output of HazardDetector module, for IF/ID pipeline register
  wire ID_EX_write; // output of HazardDetector module, for ID/EX pipeline register
  wire EX_MEM_write; // output of HazardDetector module, for EX/MEM pipeline register
  wire IF_ID_nop_signal; // output of HazardDetector module. Flush IF/ID pipeline register
  wire ID_EX_nop_signal; // output of HazardDetector module. Flush ID/EX pipeline register

  // IF stage wires
  wire [31:0] IF_PC; // output of PC module
  wire [31:0] IF_imem_out; // output of InstMemory module
  wire [31:0] IF_pc_4_adder_out; // output of Adder module
  wire [31:0] IF_next_pc_mux_out; // output of Mux_2_to_1 module
  wire [31:0] IF_GShare_out; // output of GShare module

  // ID stage wires
  wire [31:0] ID_rs1_dout; // output of RegisterFile module
  wire [31:0] ID_rs2_dout; // output of RegisterFile module
  wire [31:0] ID_imm_gen_out; // output of ImmediateGenerator module
  wire ID_is_ecall; // output of ControlUnit module
  wire ID_is_halted; // output of HaltDetector module
  wire ID_reg_write; // output of ControlUnit module
  wire [1:0] ID_mem_to_reg; // output of ControlUnit module
  wire ID_mem_read; // output of ControlUnit module
  wire ID_mem_write; // output of ControlUnit module
  wire [1:0] ID_alu_op; // output of ControlUnit module
  wire ID_alu_src; // output of ControlUnit module
  wire [31:0] ID_full_inst; // input ID stage modules
  wire [6:0] ID_opcode; // input ID stage modules
  wire [2:0] ID_funct3; // input ID stage modules
  wire ID_funct7; // input ID stage modules
  wire [4:0] ID_reg_rs1; // input ID stage modules
  wire [4:0] ID_reg_rs2; // input ID stage modules
  wire [4:0] ID_reg_rd; // input ID stage modules
  wire [4:0] ID_reg_rs1_mux_out; // Output of Mux_2_to_1 module
  wire [31:0] ID_PC; // input of HazardDetector module
  wire [1:0] ID_jump_signal; // output of ControlUnit module
  // Input Wires Initialization
  assign ID_full_inst = reg_IF_ID_inst;
  assign ID_opcode = reg_IF_ID_inst[6:0];
  assign ID_funct3 = reg_IF_ID_inst[14:12];
  assign ID_funct7 = reg_IF_ID_inst[30];
  assign ID_reg_rs1 = reg_IF_ID_inst[19:15];
  assign ID_reg_rs2 = reg_IF_ID_inst[24:20];
  assign ID_reg_rd = reg_IF_ID_inst[11:7];
  assign ID_PC = reg_IF_ID_PC;

  // EX stage wires 
  wire [3:0] EX_alu_ctrl_out; // output of ALUControlUnit module
  wire [31:0] EX_alu_src2_mux_out; // output of Mux_2_to_1 module
  wire [31:0] EX_alu_result; // output of ALU module
  wire [1:0] forwardA; // input of forwarding_src1_mux
  wire [1:0] forwardB; // input of forwarding_src2_mux
  wire [1:0] forwardC; // input of dmem_din_mux
  wire [31:0] forwardA_mux_out; // input of ALU A src
  wire [31:0] forwardB_mux_out; // input of ALU B src
  wire [31:0] dmem_din_mux_out; // input of DataMemory module
  wire [31:0] EX_imm; // input of Mux_2_to_1 module
  wire [31:0] EX_rs1_data; // input of ALU module
  wire [31:0] EX_rs2_data; // input of Mux_2_to_1 module
  wire EX_alu_src; // input of ALU module
  wire [1:0] EX_alu_op; // input of ALUControlUnit module
  wire EX_funct7; // input of ALUControlUnit module
  wire [2:0] EX_funct3; // input of ALUControlUnit module
  wire EX_mem_read; // input of EX_MEM pipeline register
  wire [1:0] EX_mem_to_reg; // input of EX_MEM pipeline register
  wire EX_mem_write; // input of EX_MEM pipeline register
  wire [4:0] EX_reg_rd; // input of EX_MEM pipeline register
  wire EX_is_halted; // input of EX_MEM pipeline register
  wire EX_reg_write; // input of EX_MEM pipeline register
  wire [4:0] EX_rs1_index; // input of forwarding unit
  wire [4:0] EX_rs2_index; // input of forwarding unit
  wire [1:0] EX_bcond; // input of hazard detector
  wire [31:0] EX_PC; // input of hazard detector
  wire [31:0] EX_correct_next_pc; // output of hazard detector
  wire EX_PCSrc; // output of hazard detector
  wire [31:0] EX_target_pc_adder_out; // output of target address Adder module
  wire [1:0] EX_jump_signal; // output of ControlUnit module
  wire [31:0] EX_target_pc_x0_mux_out; // output of Mux_2_to_1 module
  // Input Wires Initialization
  assign EX_imm = reg_ID_EX_imm;
  assign EX_rs1_data = reg_ID_EX_rs1_data;
  assign EX_rs2_data = reg_ID_EX_rs2_data;
  assign EX_alu_src = reg_ID_EX_alu_src;
  assign EX_alu_op = reg_ID_EX_alu_op;
  assign EX_funct7 = reg_ID_EX_funct7;
  assign EX_funct3 = reg_ID_EX_funct3;
  assign EX_mem_read = reg_ID_EX_mem_read;
  assign EX_mem_to_reg = reg_ID_EX_mem_to_reg;
  assign EX_mem_write = reg_ID_EX_mem_write;
  assign EX_reg_rd = reg_ID_EX_rd;
  assign EX_is_halted = reg_ID_EX_is_halted;
  assign EX_reg_write = reg_ID_EX_reg_write;
  assign EX_rs1_index = reg_ID_EX_rs1_index;
  assign EX_rs2_index = reg_ID_EX_rs2_index;
  assign EX_PC = reg_ID_EX_PC;
  assign EX_jump_signal = reg_ID_EX_jump_signal;


  // MEM stage wires
  wire [31:0] MEM_dmem_dout; // output of DataMemory module
  wire [31:0] MEM_alu_out; // input of DataMemory module
  wire [31:0] MEM_dmem_din; // input of DataMemory module
  wire MEM_mem_write; // input of DataMemory module
  wire MEM_mem_read; // input of DataMemory module
  wire [1:0] MEM_mem_to_reg; // input of MEM_WB pipeline register
  wire MEM_reg_write; // input of MEM_WB pipeline register
  wire MEM_is_halted; // input of MEM_WB pipeline register
  wire [4:0] MEM_reg_rd; // input of MEM_WB pipeline register
  wire [31:0] MEM_PC; 
  wire MEM_is_ready; // output of dcache module
  wire MEM_is_output_valid; // output of dcache module
  wire MEM_is_hit; // output of dcache module
  // Input Wires Initialization
  assign MEM_alu_out = reg_EX_MEM_alu_out;
  assign MEM_dmem_din = reg_EX_MEM_dmem_din;
  assign MEM_mem_write = reg_EX_MEM_mem_write;
  assign MEM_mem_read = reg_EX_MEM_mem_read;
  assign MEM_mem_to_reg = reg_EX_MEM_mem_to_reg;
  assign MEM_reg_write = reg_EX_MEM_reg_write;
  assign MEM_is_halted = reg_EX_MEM_is_halted;
  assign MEM_reg_rd = reg_EX_MEM_rd;
  assign MEM_PC = reg_EX_MEM_PC;

  // WB stage wires
  wire [31:0] WB_reg_write_mux_out; // output of Mux_2_to_1 module
  wire [31:0] WB_mem_to_reg_src_1; // input of Mux_2_to_1 module
  wire [31:0] WB_mem_to_reg_src_2; // input of Mux_2_to_1 module
  wire [1:0] WB_mem_to_reg; // input of Mux_2_to_1 module
  wire WB_reg_write; // input of MEM_WB pipeline register
  wire [4:0] WB_reg_rd;
  wire [31:0] WB_PC; 
  // Input Wires Initialization
  assign WB_mem_to_reg_src_1 = reg_MEM_WB_mem_to_reg_src_1;
  assign WB_mem_to_reg_src_2 = reg_MEM_WB_mem_to_reg_src_2;
  assign WB_mem_to_reg = reg_MEM_WB_mem_to_reg;
  assign WB_reg_write = reg_MEM_WB_reg_write;
  assign WB_reg_rd = reg_MEM_WB_rd;
  assign WB_PC = reg_MEM_WB_PC;

  /***** Register declarations *****/
  // You need to modify the width of registers
  // In addition, 
  // 1. You might need other pipeline registers that are not described below
  // 2. You might not need registers described below
  /***** IF/ID pipeline registers *****/
  reg [31:0] reg_IF_ID_inst;           // Full instruction
  reg [31:0] reg_IF_ID_PC;
  /***** ID/EX pipeline registers *****/
  // From the control unit
  reg [1:0] reg_ID_EX_alu_op;         // will be used in EX stage
  reg reg_ID_EX_alu_src;        // will be used in EX stage
  reg reg_ID_EX_mem_write;      // will be used in MEM stage
  reg reg_ID_EX_mem_read;       // will be used in MEM stage
  reg [1:0] reg_ID_EX_mem_to_reg;     // will be used in WB stage
  reg reg_ID_EX_reg_write;      // will be used in WB stage
  reg reg_ID_EX_is_halted;       // will be used in WB stage
  reg [1:0] reg_ID_EX_jump_signal;     // will be used in EX stage
  // From others
  reg [31:0] reg_ID_EX_rs1_data;
  reg [31:0] reg_ID_EX_rs2_data;
  reg [31:0] reg_ID_EX_imm;
  reg [4:0] reg_ID_EX_rd;
  reg reg_ID_EX_funct7;
  reg [2:0] reg_ID_EX_funct3;
  reg [4:0] reg_ID_EX_rs1_index;
  reg [4:0] reg_ID_EX_rs2_index;
  reg [31:0] reg_ID_EX_PC; 

  /***** EX/MEM pipeline registers *****/
  // From the control unit
  reg reg_EX_MEM_mem_write;     // will be used in MEM stage
  reg reg_EX_MEM_mem_read;      // will be used in MEM stage
  reg [1:0] reg_EX_MEM_mem_to_reg;    // will be used in WB stage
  reg reg_EX_MEM_reg_write;     // will be used in WB stage
  reg reg_EX_MEM_is_halted;      // will be used in WB stage
  // From others
  reg [31:0] reg_EX_MEM_alu_out;
  reg [31:0] reg_EX_MEM_dmem_din;
  reg [4:0] reg_EX_MEM_rd;
  reg [31:0] reg_EX_MEM_PC;

  /***** MEM/WB pipeline registers *****/
  // From the control unit
  reg [1:0] reg_MEM_WB_mem_to_reg;    // will be used in WB stage
  reg reg_MEM_WB_reg_write;     // will be used in WB stage
  reg reg_MEM_WB_is_halted;      // will be used in WB stage
  // From others
  reg [31:0] reg_MEM_WB_mem_to_reg_src_1;
  reg [31:0] reg_MEM_WB_mem_to_reg_src_2;
  reg [4:0] reg_MEM_WB_rd;
  reg [31:0] reg_MEM_WB_PC;



// ------------------- IF stage -------------------
  Mux_2_to_1 next_pc_mux(
    .x0(IF_GShare_out),  // input
    .x1(EX_correct_next_pc),  // input
    .swch(EX_PCSrc),  // input
    .out(IF_next_pc_mux_out)  // output
  );
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(IF_next_pc_mux_out),     // input
    .pc_write_signal(PC_write),     // input
    .current_pc(IF_PC)   // output
  );

  Adder pc_4_adder(
    .x0(IF_PC),  // input
    .x1(4),  // input
    .sum(IF_pc_4_adder_out) // output
  );

  GShare GShare(
    .clk(clk),
    .reset(reset),
    .pc(IF_PC),
    .bcond(EX_bcond), // 확인 필요
    .EX_correct_next_pc(EX_correct_next_pc), // 확인 필요
    .EX_pc(EX_PC), // input
    .next_pc(IF_GShare_out) // output
  );

  InstMemory imem(
    .reset(reset),   // input
    .clk(clk),     // input
    .addr(IF_PC),    // input
    .dout(IF_imem_out)     // output
  );

  // Update IF/ID pipeline registers here
  always @(posedge clk) begin
    if (reset || IF_ID_nop_signal) begin
      reg_IF_ID_inst <= 32'b0; 
      reg_IF_ID_PC <= 32'b0;
    end
    else begin
      if(IF_ID_write) begin
        reg_IF_ID_inst <= IF_imem_out;
        reg_IF_ID_PC <= IF_PC; 
      end
    end
  end

// ------------------- ID stage -------------------

  Mux_2_to_1 #(.WIDTH(5)) reg_rs1_mux(
    .x0(ID_reg_rs1),
    .x1(17),
    .swch(ID_is_ecall),
    .out(ID_reg_rs1_mux_out)
  );

  RegisterFile reg_file (
    .reset (reset),        // input
    .clk (clk),          // input
    .rs1 (ID_reg_rs1_mux_out),          // input
    .rs2 (ID_reg_rs2),          // input
    .rd (WB_reg_rd),           // input
    .rd_din (WB_reg_write_mux_out),       // input
    .write_enable (WB_reg_write),    // input
    .rs1_dout (ID_rs1_dout),     // output
    .rs2_dout (ID_rs2_dout),      // output
    .print_reg(print_reg)
  );

  ControlUnit ctrl_unit (
    .part_of_inst(ID_opcode), // input
    .mem_read(ID_mem_read),      // output
    .mem_to_reg(ID_mem_to_reg),    // output
    .mem_write(ID_mem_write),     // output
    .alu_src(ID_alu_src),       // output
    .reg_write(ID_reg_write),  // output
    .alu_op(ID_alu_op),        // output
    .is_ecall(ID_is_ecall),       // output (ecall inst)
    .jump_signal(ID_jump_signal)  // output
  );

  ImmediateGenerator imm_gen(
    .part_of_inst(ID_full_inst),  // input
    .imm_gen_out(ID_imm_gen_out)    // output
  );

  HaltDetector halt_detector(
    .is_ecall(ID_is_ecall),    // input
    .rs1_data(ID_rs1_dout),    // input
    .is_halted(ID_is_halted)      // output
  );  

  HazardDetector hazard_detector(
    .clk(clk),  // input
    .reset(reset),  // input
    .instruction(ID_full_inst),  // input
    .rs1(ID_reg_rs1_mux_out),  // input
    .EX_rd(EX_reg_rd),   // input
    .MEM_rd(MEM_reg_rd),  // input
    .mem_read(EX_mem_read),  // input
    .is_ecall(ID_is_ecall),  // input
    .bcond(EX_bcond), // input
    .EX_PC(EX_PC),  // input
    .ID_PC(ID_PC),  // input
    .target_pc(EX_target_pc_adder_out),  // input
    .MEM_is_ready(MEM_is_ready),  // input
    .MEM_is_output_valid(MEM_is_output_valid),  // input
    .MEM_is_hit(MEM_is_hit),  // input
    .MEM_mem_read(MEM_mem_read),  // input
    .MEM_mem_write(MEM_mem_write),  // input
    .PC_write(PC_write),  // output
    .IF_ID_write(IF_ID_write),  // output
    .ID_EX_write(ID_EX_write),  // output
    .EX_MEM_write(EX_MEM_write),  // output
    .IF_ID_nop_signal(IF_ID_nop_signal),  // output
    .ID_EX_nop_signal(ID_EX_nop_signal),  // output
    .EX_correct_next_pc(EX_correct_next_pc),  // output
    .EX_PCSrc(EX_PCSrc)  // output
  );

  // Update ID/EX pipeline registers here
  always @(posedge clk) begin
    // no-op due to Data Hazard is performed here
    if (reset || ID_EX_nop_signal) begin
      reg_ID_EX_alu_op <= 2'b0;
      reg_ID_EX_alu_src <= 1'b0;
      reg_ID_EX_mem_write <= 1'b0;
      reg_ID_EX_mem_read <= 1'b0;
      reg_ID_EX_mem_to_reg <= 2'b0;
      reg_ID_EX_reg_write <= 1'b0;
      reg_ID_EX_is_halted <= 1'b0;
      reg_ID_EX_rs1_data <= 32'b0;
      reg_ID_EX_rs2_data <= 32'b0;
      reg_ID_EX_imm <= 32'b0;
      reg_ID_EX_rd <= 5'b0;
      reg_ID_EX_funct7 <= 1'b0;
      reg_ID_EX_funct3 <= 3'b0;
      reg_ID_EX_rs1_index <= 5'b0;
      reg_ID_EX_rs2_index <= 5'b0;
      reg_ID_EX_PC <= 32'b0;
      reg_ID_EX_jump_signal <= `JUMP_DEFAULT;
    end
    else begin
      if(ID_EX_write) begin
        reg_ID_EX_alu_op <= ID_alu_op;
        reg_ID_EX_alu_src <= ID_alu_src;
        reg_ID_EX_mem_write <= ID_mem_write;
        reg_ID_EX_mem_read <= ID_mem_read;
        reg_ID_EX_mem_to_reg <= ID_mem_to_reg;
        reg_ID_EX_reg_write <= ID_reg_write;
        reg_ID_EX_is_halted <= ID_is_halted;
        reg_ID_EX_rs1_data <= ID_rs1_dout;
        reg_ID_EX_rs2_data <= ID_rs2_dout;
        reg_ID_EX_imm <= ID_imm_gen_out;
        reg_ID_EX_rd <= ID_reg_rd;
        reg_ID_EX_funct7 <= ID_funct7;
        reg_ID_EX_funct3 <= ID_funct3;
        reg_ID_EX_rs1_index <= ID_reg_rs1_mux_out;
        reg_ID_EX_rs2_index <= ID_reg_rs2;
        reg_ID_EX_PC <= ID_PC;
        reg_ID_EX_jump_signal <= ID_jump_signal;
      end
    end
  end

// ------------------- EX stage -------------------

  ForwardingUnit ForwardingUnit(
    .EX_rs1_index(EX_rs1_index),
    .EX_rs2_index(EX_rs2_index),
    .MEM_reg_rd(MEM_reg_rd),
    .WB_reg_rd(WB_reg_rd),
    .MEM_reg_write(MEM_reg_write),
    .WB_reg_write(WB_reg_write),
    .alu_src(EX_alu_src),
    .forwardA(forwardA),
    .forwardB(forwardB),
    .forwardC(forwardC)
  );

  Mux_4_to_1 forwarding_src1_mux(
    .x0(EX_rs1_data),
    .x1(WB_reg_write_mux_out),
    .x2(MEM_alu_out),
    .x3(0),
    .swch(forwardA),
    .out(forwardA_mux_out)
  );

  Mux_4_to_1 forwarding_src2_mux(
    .x0(EX_rs2_data),
    .x1(WB_reg_write_mux_out),
    .x2(MEM_alu_out),
    .x3(EX_imm),
    .swch(forwardB),
    .out(forwardB_mux_out)
  );

  Mux_4_to_1 dmem_din_mux(
    .x0(EX_rs2_data),
    .x1(MEM_alu_out),
    .x2(WB_reg_write_mux_out),
    .x3(0),
    .swch(forwardC),
    .out(dmem_din_mux_out)
  );

  ALUControlUnit alu_ctrl_unit (
    .funct7(EX_funct7),  // input
    .funct3(EX_funct3), // input
    .alu_op(EX_alu_op), // input
    .alu_ctrl_out(EX_alu_ctrl_out)         // output
  );

  ALU alu (
    .alu_ctrl_out(EX_alu_ctrl_out),      // input
    .alu_in_1(forwardA_mux_out),    // input  
    .alu_in_2(forwardB_mux_out),    // input
    .jump_signal(EX_jump_signal),  // input
    .alu_result(EX_alu_result),  // output
    .alu_bcond(EX_bcond)     // output
  );

  Mux_2_to_1 target_pc_x0_mux(
    .x0(EX_PC),  // input
    .x1(EX_rs1_data),  // input
    .swch(EX_jump_signal[0]),  // input
    .out(EX_target_pc_x0_mux_out)  // output
  );

  Adder tartget_pc_adder(
    .x0(EX_target_pc_x0_mux_out),  // input
    .x1(EX_imm),  // input
    .sum(EX_target_pc_adder_out) // output
  );

  // Update EX/MEM pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      reg_EX_MEM_mem_write <= 1'b0;
      reg_EX_MEM_mem_read <= 1'b0;
      reg_EX_MEM_mem_to_reg <= 2'b0;
      reg_EX_MEM_reg_write <= 1'b0;
      reg_EX_MEM_is_halted <= 1'b0;
      reg_EX_MEM_alu_out <= 32'b0;
      reg_EX_MEM_dmem_din <= 32'b0;
      reg_EX_MEM_rd <= 5'b0;
      reg_EX_MEM_PC <= 32'b0;
    end
    else begin
      if(EX_MEM_write) begin
        reg_EX_MEM_mem_write <= EX_mem_write;
        reg_EX_MEM_mem_read <= EX_mem_read;
        reg_EX_MEM_mem_to_reg <= EX_mem_to_reg;
        reg_EX_MEM_reg_write <= EX_reg_write;
        reg_EX_MEM_is_halted <= EX_is_halted;
        reg_EX_MEM_alu_out <= EX_alu_result;
        reg_EX_MEM_dmem_din <= dmem_din_mux_out;
        reg_EX_MEM_rd <= EX_reg_rd;
        reg_EX_MEM_PC <= EX_PC;
      end
    end
  end

// ------------------- MEM stage -------------------

  Cache dcache(
    .reset (reset),      // input
    .clk (clk),        // input
    .is_input_valid (MEM_mem_read || MEM_mem_write),     // input 
    .addr (MEM_alu_out),       // input
    .mem_rw (MEM_mem_write),   // input
    .din (MEM_dmem_din),        // input
    .is_ready (MEM_is_ready),        // output
    .is_output_valid (MEM_is_output_valid),      // output
    .dout (MEM_dmem_dout),        // output
    .is_hit (MEM_is_hit)
  );

  // Update MEM/WB pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      reg_MEM_WB_mem_to_reg <= 2'b0;
      reg_MEM_WB_reg_write <= 1'b0;
      reg_MEM_WB_is_halted <= 1'b0;
      reg_MEM_WB_mem_to_reg_src_1 <= 32'b0;
      reg_MEM_WB_mem_to_reg_src_2 <= 32'b0;
      reg_MEM_WB_rd <= 5'b0;
      reg_MEM_WB_PC <= 32'b0;
    end
    else begin
      reg_MEM_WB_mem_to_reg <= MEM_mem_to_reg;
      reg_MEM_WB_reg_write <= MEM_reg_write;
      reg_MEM_WB_is_halted <= MEM_is_halted;
      reg_MEM_WB_mem_to_reg_src_1 <= MEM_alu_out;
      reg_MEM_WB_mem_to_reg_src_2 <= MEM_dmem_dout;
      reg_MEM_WB_rd <= MEM_reg_rd;
      reg_MEM_WB_PC <= MEM_PC;
    end
  end


// ------------------- WB stage -------------------
  
  Mux_4_to_1 reg_write_mux(
    .x0(WB_mem_to_reg_src_1),        // input
    .x1(WB_mem_to_reg_src_2),        // input
    .x2(WB_PC+4),        // input
    .x3(0),        // input
    .swch(WB_mem_to_reg),         // input
    .out(WB_reg_write_mux_out)          // output
  );

  assign is_halted = reg_MEM_WB_is_halted;
  
endmodule
