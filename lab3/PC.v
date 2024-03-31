module PC(
    input reset,
    input clk,
    input [31:0] next_pc,
    input pc_write_signal,
    output reg [31:0] current_pc
);

    // pc를 지우고 current_pc, next_pc로 합칠수도?
    reg [31:0] _pc = 32'b0;

    always @(posedge clk) begin
        if (reset) begin
            current_pc <= 32'b0;
        end
        else begin
            if(pc_write_signal) begin
               current_pc <= _pc; 
            end
            else begin
                _pc <= next_pc;
            end
        end
    end



endmodule
