module instruction_memory #(parameter MEM_DEPTH = 1024) (input reset,
                                                         input clk,
                                                         input [31:0] addr,   // address of the instruction memory
                                                         output reg [31:0] dout); // instruction at addr
  integer i;
  // Instruction memory
  reg [31:0] mem[0:MEM_DEPTH - 1];
  // Do not touch imem_addr
  wire [9:0] imem_addr;
  assign imem_addr = addr[11:2]; // 메모리 깊이가 총 1024니까 10비트만 필요한 건데 왜 하필 11:2임?
  // Do not touch or use this wire
  wire _unused_ok = &{1'b0,
                  addr[31:12],
                  addr[1:0],
                  1'b0}; // 각 1비트 사이사이로 &를 적용한 연산결과. 1비트 결과이다. 이건 무조건 0.

  // TODO
  // Asynchronously read instruction from the memory 
  // (use imem_addr to access memory)

  always @(*) begin
    dout = mem[imem_addr];
  end

  // Initialize instruction memory (do not touch except path)
  always @(posedge clk) begin
    if (reset) begin
      for (i = 0; i < MEM_DEPTH; i = i + 1)
        // DO NOT TOUCH COMMENT BELOW
        /* verilator lint_off BLKSEQ */
        mem[i] = 32'b0;
        /* verilator lint_on BLKSEQ */
        // DO NOT TOUCH COMMENT ABOVE

      // Provide path of the file including instructions with binary format
      $readmemh("student_tb/non-controlflow_mem.txt", mem); // 텍스트 파일의 경로를 넣어주면 알아서 mem에 값을 넣고 초기화해줌
    end
    else begin
      i  = 0;
    end
  end

endmodule


