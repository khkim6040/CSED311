`include "vending_machine_def.v"


module change_state(clk,reset_n,wait_time_nxt,current_total_nxt,wait_time,current_total);

	input clk;
	input reset_n;
	input [31:0] wait_time_nxt;
	input [`kTotalBits-1:0] current_total_nxt;
	output reg [31:0] wait_time;
	output reg [`kTotalBits-1:0] current_total;
	
	// Sequential circuit to reset or update the states
	always @(posedge clk ) begin
		if (!reset_n) begin
			current_total <= 0;
			wait_time <= `kWaitTime;
		end
		else begin
			current_total <= current_total_nxt;
			wait_time <= wait_time_nxt;
			// TODO: update all states.
		end
	end
endmodule 
