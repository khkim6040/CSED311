module HaltDetector(
    input is_ecall,
    input[31:0] rs1_data,
    output reg is_halted);

    always @(*) begin
        is_halted = is_ecall && (rs1_data == 10);
    end

endmodule
