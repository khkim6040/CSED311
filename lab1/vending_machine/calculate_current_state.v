
`include "vending_machine_def.v"	

module calculate_current_state(i_input_coin,i_select_item,item_price,coin_value,current_total
,current_total_nxt,o_return_coin,o_available_item,o_output_item, time_return, wait_time);
	
	input [`kNumCoins-1:0] i_input_coin,o_return_coin;
	input [`kNumItems-1:0] i_select_item;			
	input [31:0] item_price [`kNumItems-1:0];
	input [31:0] coin_value [`kNumCoins-1:0];	
	input [`kTotalBits-1:0] current_total;
	input [31:0] wait_time;

	output reg [`kNumItems-1:0] o_available_item,o_output_item;
	output reg [`kTotalBits-1:0] current_total_nxt;
	output reg time_return;
	reg [`kTotalBits-1:0] input_total;
	reg [`kTotalBits-1:0] output_total;
	reg [`kTotalBits-1:0] return_total;	
	
	always @(*) begin
		integer i;
		input_total = 0;
		output_total = 0;
		return_total = 0;
		for (i = 0; i < `kNumCoins; i = i + 1) begin
			input_total = input_total + i_input_coin[i] * coin_value[i][31:0];
		end
		for (i = 0; i < `kNumItems; i = i + 1) begin
			if(i_select_item[i] == 1 && current_total >= i_select_item[i] * item_price[i][31:0]) begin
				output_total = output_total + i_select_item[i] * item_price[i][31:0];
				o_output_item[i] = i_select_item[i];
			end
			else begin
				o_output_item[i] = 0;
			end
			// output_total = output_total + i_select_item[i] * item_price[i][31:0];
		end
		// return_total을 총 잔액이 아닌 지금까지 거슬러 준 돈으로 바꿈
		for (i = 0; i < `kNumCoins; i = i + 1) begin
			return_total = return_total + o_return_coin[i] * coin_value[i][31:0];
		end
		current_total_nxt = current_total + input_total - output_total - return_total;
		// return_total = input_total + current_total - output_total;
		// if (return_total > 0 || return_total == 0) begin
		// 	current_total_nxt = return_total;
		// 	o_output_item = i_select_item;
		// end
		// else begin
		// 	current_total_nxt = current_total;
		// 	o_output_item = 0;
		// end
	end
	
	always @(*) begin
		integer i;
		o_available_item = 0;
		for(i = 0; i < `kNumItems; i = i + 1) begin
			if(current_total >= item_price[i][31:0]) begin
				o_available_item[i] = 1;
			end
			else begin
				o_available_item[i] = 0;
			end
		end
	end

	always @(*) begin
		if($signed(wait_time) <= 0) begin
			time_return = 1;
		end
		else begin
			time_return = 0;
		end	
	end

endmodule 
