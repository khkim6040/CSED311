module PC(
    input reset,
    input clk,
    input [31:0] next_pc,
    output reg [31:0] current_pc
);
    reg [31:0] _pc;

    always @(posedge clk) begin
        if (reset) begin
            _pc <= 32'b0;
        end
        else begin
            _pc <= next_pc;
        end
    end

    assign current_pc = _pc;

endmodule
