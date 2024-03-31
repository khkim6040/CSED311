module PC(
    input reset,
    input clk,
    input [31:0] next_pc,
    output reg [31:0] current_pc
);

    always @(posedge clk) begin
        if (reset) begin
            _pc <= 32'b0;
        end
        else begin
            current_pc <= next_pc;
        end
    end



endmodule
