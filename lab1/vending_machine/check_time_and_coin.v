`include "vending_machine_def.v"

module check_time_and_coin(i_trigger_return,coin_value,current_total,o_available_item,
i_input_coin,wait_time,i_select_item,o_return_coin,wait_time_nxt,time_to_return);
    
    input i_trigger_return;
    input [31:0] coin_value [`kNumCoins-1:0];
    input [`kTotalBits-1:0] current_total;
    input [`kNumCoins-1:0] i_input_coin;
    input [`kNumItems-1:0] i_select_item;
    input [31:0] wait_time;
    input [`kNumItems-1:0] o_available_item;
    input time_to_return;

    output reg [`kNumCoins-1:0] o_return_coin;
    output reg [31:0] wait_time_nxt;

    integer tmp; // o_return_coin에 가능한 모든 경우의 수를 계산하기 위해 사용되는 변수
    integer i;
    
    // Initiate values
    initial begin
        wait_time_nxt = `kWaitTime + 1;
    end

    always @(i_trigger_return) begin
        if(i_trigger_return == 1) begin
            wait_time_nxt = `kTriggerWaitCycle;
        end
        // 만약 i_trigger_return을 1로 세팅한 후 3 clock이 지나기 전에 다시 0으로 세팅한다면 wait_time을 초기화 
        else begin
            wait_time_nxt = `kWaitTime + 1;
        end
    end
    
    // wait_time_nxt를 계산하는 combinational circuit
    always @(*) begin
        if(time_to_return == 0) begin
            if(i_input_coin > 0) begin
                // 돈을 넣었다면 wait_time을 초기화하
                wait_time_nxt = `kWaitTime + 1;
            end
            else if(i_select_item > 0) begin
                if((i_select_item & o_available_item) > 0) begin
                    // 물건을 골랐고 뽑을 수 있다면 wait_time을 초기화
                    wait_time_nxt = `kWaitTime + 1;
                end
                else begin
                    // 물건을 골랐지만 돈이 부족하다면 wait_time을 줄임
                    wait_time_nxt = wait_time - 1;
                end
            end
            else begin
                // 돈을 넣지 않았다면 wait_time을 줄임
                wait_time_nxt = wait_time - 1;
            end
        end
        else begin
            if(i_input_coin == 0) begin 
                // 돈을 거슬러 주고 있는데 돈을 더 넣지 않는다면 wait_time을 그대로 0으로 두어 계속 거슬러주게 함
                wait_time_nxt = 0;
            end
            else begin
                // 돈을 거슬러 주고 있는데 돈을 더 넣는다면 wait_time을 초기화하기로 판단
                wait_time_nxt = `kWaitTime + 1;
            end
        end
    end


    // 큰 단위부터 current total에 대해 동전 반환.
    // 1600원 있다하면 1000원짜리 1개, 500원짜리 1개, 100원짜리 1개 반환. => o_return_coin = 3'b111
    always @(*) begin
        o_return_coin = 0;
        tmp = 0;
        if(time_to_return == 1) begin
            for(i = `kNumCoins-1; i >= 0; i = i - 1) begin
                // tmp에 현재까지 반환한 돈의 총액을 저장
                if(current_total >= coin_value[i] + tmp) begin
                    o_return_coin[i] = 1;
                    tmp = tmp + coin_value[i];
                end
            end
        end
    end

endmodule
