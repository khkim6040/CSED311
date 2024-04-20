module HazardDetector (input clk,
                       input reset,
                       input rs1[4:0],
                       input rs2[4:0],
                       input rd[4:0],
                       input mem_read,
                       input is_ecall,
                       output reg PC_write,
                       output reg IF_ID_write,
                       output reg ID_nop_signal);

    reg [1:0] stall_cycle_left;

    always @(posedge clk) begin
        if(reset) begin
            stall_cycle_left <= 0;
        end

        if(stall_cycle_left > 0) begin
            stall_cycle_left <= stall_cycle_left - 1;
        end

    end  

    // inspect the hazard
    always @(*) begin
        // Load-use hazard
        if(mem_read && (rs1 == rd || rs2 == rd)) begin
            stall_cycle_left = 1;
        end
        // Ecall hazard because ecall comparison executes in ID stage
        else if(is_ecall && (rs1 == rd || rs2 == rd)) begin
            stall_cycle_left = 2;
        end
    end

    // stall cycle
    always @(*) begin
        if(stall_cycle_left > 0) begin
            PC_write = 0;
            IF_ID_write = 0;
            ID_nop_signal = 1;
        end
        else begin
            PC_write = 1;
            IF_ID_write = 1;
            ID_nop_signal = 0;
        end
    end

endmodule
