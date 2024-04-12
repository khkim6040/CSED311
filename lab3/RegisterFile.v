module RegisterFile(input	reset,
                    input clk,
                    input [4:0] rs1,          // source register 1
                    input [4:0] rs2,          // source register 2
                    input [4:0] rd,           // destination register
                    input [31:0] rd_din,      // input data for rd
                    input is_ecall,           // ecall signal
                    input write_enable,       // RegWrite signal
                    output reg is_halted,         // halt signal 
                    output reg [31:0] rs1_dout,   // output reg of rs 1
                    output reg [31:0] rs2_dout,
                    output reg [31:0] print_reg[0:31]);  // output of rs 2
  integer i;
  // Register file
  reg [31:0] rf[0:31];
  assign print_reg = rf;

  always @(posedge clk) begin
    // Initialize register file (do not touch)
    if (reset) begin
      for (i = 0; i < 32; i = i + 1)
        rf[i] <= 32'b0;
      rf[2] <= 32'h2ffc; // stack pointer
    end
    // Synchronously write data to the register
    else begin
      if (write_enable && rd != 0)
        rf[rd] <= rd_din;
    end
  end

  always @(*) begin
    // Asynchronously read register file
    rs1_dout = rf[rs1];
    rs2_dout = rf[rs2];
    if (is_ecall == 1 && rf[17] == 10) begin
      is_halted = 1;
    end
    else begin
      is_halted = 0;
    end
  end

endmodule
