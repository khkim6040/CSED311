module register_file(input	reset,
                     input clk,
                     input [4:0] rs1,          // source register 1
                     input [4:0] rs2,          // source register 2
                     input [4:0] rd,           // destination register
                     input [31:0] rd_din,      // input data for rd
                     input write_enable,          // RegWrite signal
                     input is_ecall,
                     output reg [31:0] rs1_dout,   // output of rs 1
                     output reg [31:0] rs2_dout,   // output of rs 2
                     output [31:0] print_reg [0:31],
                     output is_halted);
  integer i;
  // Register file
  reg [31:0] rf[0:31];
  // Do not touch or use print_reg
  assign print_reg = rf;

  // TODO
  // Asynchronously read register file
  // Synchronously write data to the register file

  // Read_regi1 : 15~19 rs1
  // Read_regi2 : 20~24 rs2
  // Write_regi : 7~11 rd
  always @(posedge clk)begin
    if(write_enable == 1 && reset == 0) begin
      rf[rd] <= rd_din;
    end
    else
      i = 0; // 수정함. 기존 코드 --> rf[rd] <= rf[rd]; <-- cycle 형성되서 컴파일 오류 뜰까봐 그냥 0 넣었음. 근데 0 넣어도 되나? 값을 유지는 하고 있어야 하지 않나? single cycle이라 한 사이클 동안 모든 처리가 완료되서 상관 없을 거 같긴 한데... 생각 좀 더 해보자.
  end

  always @(*) begin
    rs1_dout = rf[rs1];
    rs2_dout = rf[rs2];
    if (is_ecall == 1 && rf[17] == 10) begin
      is_halted = 1;
    end
    else begin
        is_halted = 0;
    end


  end

  // Initialize register file (do not touch)
  always @(posedge clk) begin
    // Reset register file
    if (reset) begin
      for (i = 0; i < 32; i = i + 1)
        // DO NOT TOUCH COMMENT BELOW
        /* verilator lint_off BLKSEQ */
        rf[i] = 32'b0;
        /* verilator lint_on BLKSEQ */
        // DO NOT TOUCH COMMENT ABOVE

      // DO NOT TOUCH COMMENT BELOW
      /* verilator lint_off BLKSEQ */
      rf[2] = 32'h2ffc; // stack pointer
      /* verilator lint_on BLKSEQ */
      // DO NOT TOUCH COMMENT ABOVE
    end 
    else begin
      i = 0;
    end
  end
endmodule
