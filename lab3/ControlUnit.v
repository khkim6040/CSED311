`include "opcodes.v"
`include "states.v"

module ControlUnit (
    input [6:0] part_of_inst,
    output is_jal,
    output is_jalr,
    output branch,
    output mem_read,
    output mem_to_reg,
    output mem_write,
    output alu_src,
    output write_enable,
    output pc_to_reg,
    output is_ecall
);

    reg [3:0] state, next_state;

    // TODO: Microcode for Control Unit
    always @(*) begin 
        
    end

    // TODO: Assign Control signals
    always @(*) begin 
        
    end

    // TODO: Calculate next state
    always @(*) begin 
        
    end

    // TODO: Update state synchronously
    always @(posedge clk) begin 
        state <= next_state;
    end
    
endmodule