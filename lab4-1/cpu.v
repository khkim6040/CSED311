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
  wire nop_signal; // output of HazardDetector module, for ControlUnit module

  // IF stage wires
  wire[31:0] IF_current_pc; // output of PC module
  wire[31:0] IF_imem_out; // output of InstMemory module
  wire[31:0] IF_pc_4_adder_out; // output of Adder module

  // ID stage wires
  wire[31:0] ID_rs1_dout; // output of RegisterFile module
  wire[31:0] ID_rs2_dout; // output of RegisterFile module
  wire[31:0] ID_imm_gen_out; // output of ImmediateGenerator module
  wire[31:0] ID_reg_rs1_mux_out; // Output of Mux_2_to_1 module
  wire ID_is_ecall; // output of ControlUnit module
  wire ID_is_halted; // output of HaltDetector module
  wire ID_reg_write; // output of ControlUnit module
  wire ID_mem_to_reg; // output of ControlUnit module
  wire ID_mem_read; // output of ControlUnit module
  wire ID_mem_write; // output of ControlUnit module
  wire[1:0] ID_alu_op; // output of ControlUnit module
  wire ID_alu_src; // output of ControlUnit module
  wire[31:0] ID_full_inst; // input ID stage modules
  wire[6:0] ID_opcode; // input ID stage modules
  wire[2:0] ID_funct3; // input ID stage modules
  wire ID_funct7; // input ID stage modules
  wire[4:0] ID_reg_rs1; // input ID stage modules
  wire[4:0] ID_reg_rs2; // input ID stage modules
  wire[4:0] ID_reg_rd; // input ID stage modules
  // Input Wires Initialization
  assign ID_full_inst = reg_IF_ID_inst;
  assign ID_opcode = reg_IF_ID_inst[6:0];
  assign ID_funct3 = reg_IF_ID_inst[14:12];
  assign ID_funct7 = reg_IF_ID_inst[30];
  assign ID_reg_rs1 = reg_IF_ID_inst[19:15];
  assign ID_reg_rs2 = reg_IF_ID_inst[24:20];
  assign ID_reg_rd = reg_IF_ID_inst[11:7];

  // EX stage wires 
  wire[3:0] EX_alu_ctrl_out; // output of ALUControlUnit module
  wire[31:0] EX_alu_src2_mux_out; // output of Mux_2_to_1 module
  wire[31:0] EX_alu_result; // output of ALU module
  wire[31:0] EX_imm; // input of Mux_2_to_1 module
  wire[31:0] EX_rs1_data; // input of ALU module
  wire[31:0] EX_rs2_data; // input of Mux_2_to_1 module
  wire EX_alu_src; // input of ALU module
  wire[1:0] EX_alu_op; // input of ALUControlUnit module
  wire EX_funct7; // input of ALUControlUnit module
  wire EX_funct3; // input of ALUControlUnit module
  wire EX_mem_read; // input of EX_MEM pipeline register
  wire EX_mem_to_reg; // input of EX_MEM pipeline register
  wire EX_mem_write; // input of EX_MEM pipeline register
  wire EX_reg_rd; // input of EX_MEM pipeline register
  wire EX_is_halted; // input of EX_MEM pipeline register
  wire EX_reg_write; // input of EX_MEM pipeline register
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
  
  // MEM stage wires
  wire[31:0] MEM_dmem_dout; // output of DataMemory module
  wire[31:0] MEM_alu_out; // input of DataMemory module
  wire[31:0] MEM_dmem_din; // input of DataMemory module
  wire MEM_mem_write; // input of DataMemory module
  wire MEM_mem_read; // input of DataMemory module
  // wire MEM_is_branch; // seems not used in this lab
  wire MEM_mem_to_reg; // input of MEM_WB pipeline register
  wire MEM_reg_write; // input of MEM_WB pipeline register
  wire MEM_is_halted; // input of MEM_WB pipeline register
  // Input Wires Initialization
  assign MEM_alu_out = reg_EX_MEM_alu_out;
  assign MEM_dmem_din = reg_EX_MEM_dmem_din;
  assign MEM_mem_write = reg_EX_MEM_mem_write;
  assign MEM_mem_read = reg_EX_MEM_mem_read;
  assign MEM_mem_to_reg = reg_EX_MEM_mem_to_reg;
  assign MEM_reg_write = reg_EX_MEM_reg_write;
  assign MEM_is_halted = reg_EX_MEM_is_halted;

  // WB stage wires
  wire[31:0] WB_reg_write_mux_out; // output of Mux_2_to_1 module
  wire WB_is_halted; // output, will set is_halted(output of this module)
  wire[31:0] WB_mem_to_reg_src_1; // input of Mux_2_to_1 module
  wire[31:0] WB_mem_to_reg_src_2; // input of Mux_2_to_1 module
  wire WB_mem_to_reg; // input of Mux_2_to_1 module
  wire WB_reg_write; // input of MEM_WB pipeline register
  // Input Wires Initialization
  assign WB_mem_to_reg_src_1 = reg_MEM_WB_mem_to_reg_src_1;
  assign WB_mem_to_reg_src_2 = reg_MEM_WB_mem_to_reg_src_2;
  assign WB_mem_to_reg = reg_MEM_WB_mem_to_reg;
  assign WB_reg_write = reg_MEM_WB_reg_write;

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
  reg reg_ID_EX_is_halted;       // will be used in WB stage
  // From others
  reg[31:0] reg_ID_EX_rs1_data;
  reg[31:0] reg_ID_EX_rs2_data;
  reg[31:0] reg_ID_EX_imm;
  reg[4:0] reg_ID_EX_rd;
  reg reg_ID_EX_funct7;
  reg reg_ID_EX_funct3;

  /***** EX/MEM pipeline registers *****/
  // From the control unit
  reg reg_EX_MEM_mem_write;     // will be used in MEM stage
  reg reg_EX_MEM_mem_read;      // will be used in MEM stage
  // reg reg_EX_MEM_is_branch;     // will be used in MEM stage, seems not used in this lab
  reg reg_EX_MEM_mem_to_reg;    // will be used in WB stage
  reg reg_EX_MEM_reg_write;     // will be used in WB stage
  reg reg_EX_MEM_is_halted;      // will be used in WB stage
  // From others
  reg[31:0] reg_EX_MEM_alu_out;
  reg[31:0] reg_EX_MEM_dmem_din;
  reg[4:0] reg_EX_MEM_rd;

  /***** MEM/WB pipeline registers *****/
  // From the control unit
  reg reg_MEM_WB_mem_to_reg;    // will be used in WB stage
  reg reg_MEM_WB_reg_write;     // will be used in WB stage
  reg reg_MEM_WB_is_halted;      // will be used in WB stage
  // From others
  reg[31:0] reg_MEM_WB_mem_to_reg_src_1;
  reg[31:0] reg_MEM_WB_mem_to_reg_src_2;


// ------------------- IF stage -------------------
  // PC must be updated on the rising edge (positive edge) of the clock.
  PC pc(
    .reset(reset),       // input (Use reset to initialize PC. Initial value must be 0)
    .clk(clk),         // input
    .next_pc(IF_pc_4_adder_out),     // input
    .pc_write_signal(PC_write),     // input
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
      if(IF_ID_write) begin
        reg_IF_ID_inst <= IF_imem_out;
      end
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
    .nop_signal(nop_signal),  // input
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

  HaltDetector halt_detector(
    .is_ecall(ID_is_ecall),    // input
    .rs1_data(ID_rs1_dout),    // input
    .is_halted(ID_is_halted)      // output
  );  

  HazardDetector hazard_detector(
    .rs1(ID_reg_rs1_mux_out),  // input
    .rs2(ID_reg_rs2),  // input
    .rd(EX_reg_rd),   // input
    .mem_read(EX_mem_read),  // input
    .PC_write(PC_write),  // output
    .IF_ID_write(IF_ID_write),  // output
    .nop_signal(nop_signal)  // output
  );

  // Update ID/EX pipeline registers here
  always @(posedge clk) begin
    if (reset) begin
      reg_ID_EX_alu_op <= 2'b0;
      reg_ID_EX_alu_src <= 1'b0;
      reg_ID_EX_mem_write <= 1'b0;
      reg_ID_EX_mem_read <= 1'b0;
      reg_ID_EX_mem_to_reg <= 1'b0;
      reg_ID_EX_reg_write <= 1'b0;
      reg_ID_EX_is_halted <= 1'b0;
      reg_ID_EX_rs1_data <= 32'b0;
      reg_ID_EX_rs2_data <= 32'b0;
      reg_ID_EX_imm <= 32'b0;
      reg_ID_EX_rd <= 5'b0;
      reg_ID_EX_funct7 <= 1'b0;
      reg_ID_EX_funct3 <= 3'b0;
    end
    else begin
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
    end
  end

// ------------------- EX stage -------------------

  Mux_2_to_1 alu_src2_mux(
    .x0(EX_rs2_data)
    .x1(EX_imm)
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
      reg_EX_MEM_mem_write <= 1'b0;
      reg_EX_MEM_mem_read <= 1'b0;
      reg_EX_MEM_mem_to_reg <= 1'b0;
      reg_EX_MEM_reg_write <= 1'b0;
      reg_EX_MEM_is_halted <= 1'b0;
      reg_EX_MEM_alu_out <= 32'b0;
      reg_EX_MEM_dmem_din <= 32'b0;
      reg_EX_MEM_rd <= 5'b0;
    end
    else begin
      reg_EX_MEM_mem_write <= EX_mem_write;
      reg_EX_MEM_mem_read <= EX_mem_read;
      reg_EX_MEM_mem_to_reg <= EX_mem_to_reg;
      reg_EX_MEM_reg_write <= EX_reg_write;
      reg_EX_MEM_is_halted <= EX_is_halted;
      reg_EX_MEM_alu_out <= EX_alu_result;
      reg_EX_MEM_dmem_din <= EX_rs2_data;
      reg_EX_MEM_rd <= EX_reg_rd;
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
      reg_MEM_WB_mem_to_reg <= 1'b0;
      reg_MEM_WB_reg_write <= 1'b0;
      reg_MEM_WB_is_halted <= 1'b0;
      reg_MEM_WB_mem_to_reg_src_1 <= 32'b0;
      reg_MEM_WB_mem_to_reg_src_2 <= 32'b0;
    end
    else begin
      reg_MEM_WB_mem_to_reg <= MEM_mem_to_reg;
      reg_MEM_WB_reg_write <= MEM_reg_write;
      reg_MEM_WB_is_halted <= MEM_is_halted;
      reg_MEM_WB_mem_to_reg_src_1 <= MEM_dmem_dout;
      reg_MEM_WB_mem_to_reg_src_2 <= MEM_alu_out;
    end
  end


// ------------------- WB stage -------------------
  
  Mux_2_to_1 reg_write_mux(
    .x0(WB_mem_to_reg_src_1),        // input
    .x1(WB_mem_to_reg_src_2),        // input
    .swch(WB_mem_to_reg),         // input
    .out(WB_reg_write_mux_out)          // output
  );

  assign is_halted = reg_MEM_WB_is_halted;
  
endmodule
