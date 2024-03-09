`include "vending_machine_def.v"

module check_time_and_coin(i_trigger_return,coin_value,current_total,
i_input_coin,wait_time,i_select_item,o_return_coin,wait_time_nxt, time_return);
    
    input i_trigger_return;
    input [31:0] coin_value [`kNumCoins-1:0];
    input [`kTotalBits-1:0] current_total;
    input [`kNumCoins-1:0] i_input_coin;
    input [`kNumItems-1:0] i_select_item;
    input [31:0] wait_time;
    // input [`kNumItems-1:0] o_available_item;
    input time_return;

    output reg [`kNumCoins-1:0] o_return_coin;
    output reg [31:0] wait_time_nxt;
    // reg time_return;

    integer _tmp; 
    integer i;
    // Initiate values
    initial begin
        wait_time_nxt = `kWaitTime;
    end

    always @(i_input_coin, i_select_item) begin
        wait_time_nxt = `kWaitTime;
    end


    always @(*) begin
		if(current_total > 0 && i_input_coin == 0 && i_select_item == 0) begin
            wait_time_nxt = wait_time - 1;
		end
		else begin
			wait_time_nxt = `kWaitTime;
		end
	end

    // 이거 time_return wire 사용해서 calcualte_current_state로 옮김
	// always @(*) begin
	// 	if(wait_time == 0) begin
	// 		time_return = 1;
	// 	end
	// 	else begin
	// 		time_return = 0;
	// 	end
	// end


    // 큰 단위부터 current total에 대해 동전 반환.
    // 1600원 있다하면 1000원짜리 1개, 500원짜리 1개, 100원짜리 1개 반환. => o_return_coin = 3'b111
    always @(*) begin
        o_return_coin = 0;
        _tmp = 0;
        if(time_return == 1 || i_trigger_return == 1) begin
            for(i = `kNumCoins-1; i >= 0; i = i - 1) begin
                if(current_total >= coin_value[i] + _tmp) begin
                    o_return_coin[i] = 1;
                    _tmp = _tmp + coin_value[i];
                end
            end
        end
    end

endmodule
