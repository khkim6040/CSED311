
`include "vending_machine_def.v"	

module calculate_current_state(i_input_coin,i_select_item,item_price,coin_value,current_total
,current_total_nxt,o_return_coin,o_available_item,o_output_item,time_to_return,wait_time);
	
	input [`kNumCoins-1:0] i_input_coin,o_return_coin;
	input [`kNumItems-1:0] i_select_item;			
	input [31:0] item_price [`kNumItems-1:0];
	input [31:0] coin_value [`kNumCoins-1:0];	
	input [`kTotalBits-1:0] current_total;
	input [31:0] wait_time;

	output reg [`kNumItems-1:0] o_available_item,o_output_item;
	output reg [`kTotalBits-1:0] current_total_nxt;
	output reg time_to_return;
	reg [`kTotalBits-1:0] input_total;
	reg [`kTotalBits-1:0] output_total;
	reg [`kTotalBits-1:0] return_total;	

	// current_total_nxt를 계산하는 combinational circuit	
	always @(*) begin
		integer i;
		input_total = 0; // 현재까지 넣은 돈의 총액
		output_total = 0; // 현재까지 뽑은 물건의 총액
		return_total = 0; // 현재까지 거슬러 준 돈의 총액(i_trigger_return 혹은 time_to_return이 1일 때만 증가)
		// input_total
		for (i = 0; i < `kNumCoins; i = i + 1) begin
			input_total = input_total + i_input_coin[i] * coin_value[i];
		end
		// output_total
		for (i = 0; i < `kNumItems; i = i + 1) begin
			if(i_select_item[i] == 1 && current_total >= (i_select_item[i] * item_price[i])) begin
				// 물건을 뽑을 수 있고 돈이 충분하다면 output_total을 증가시키고 o_output_item 또한 업데이트
				output_total = output_total + i_select_item[i] * item_price[i];
				o_output_item[i] = i_select_item[i];
			end
			else begin
				o_output_item[i] = 0;
			end
		end
		// return_total
		for (i = 0; i < `kNumCoins; i = i + 1) begin
			return_total = return_total + o_return_coin[i] * coin_value[i];
		end
		// current_total_nxt
		current_total_nxt = current_total + input_total - output_total - return_total;
	end
	
	// o_available_item를 계산하는 combinational circuit
	always @(*) begin
		integer i;
		o_available_item = 0;
		for(i = 0; i < `kNumItems; i = i + 1) begin
			if(current_total >= item_price[i]) begin
				o_available_item[i] = 1;
			end
			else begin
				o_available_item[i] = 0;
			end
		end
	end

	// wait_time이 0이 되었을 때 1이 되어 돈을 거슬러주기 시작하는 신호
	always @(*) begin
		if($signed(wait_time) <= 0) begin
			time_to_return = 1;
		end
		else begin
			time_to_return = 0;
		end	
	end

endmodule 
