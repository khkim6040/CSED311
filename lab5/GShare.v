`include "opcodes.v"

module GShare(
    input clk,
    input reset,
    input [31:0] pc,
    input [1:0] bcond,
    input [31:0] EX_correct_next_pc,
    input [31:0] EX_pc,
    output reg [31:0] next_pc
    );

    reg [56:0] BTB [31:0];
    reg [4:0] BHSR;
    reg [1:0] PHT [31:0];
    reg temp;

    wire [24:0] tag;
    wire [4:0] index;
    wire [24:0] BTB_tag;
    wire [4:0] EX_index; 
    wire [24:0] EX_tag;
    wire [3:0] unused;
    wire [31:0] predicted_pc;
    wire [4:0] PHT_index;
    wire [4:0] updated_PHT_index;
    wire tag_matched;
    wire PHT_taken;

    assign tag = pc[31:7];
    assign index = pc[6:2];
    assign BTB_tag = BTB[index][56:32];
    assign EX_index = EX_pc[6:2];
    assign EX_tag = EX_pc[31:7];

    assign unused = {pc[1:0], EX_pc[1:0]};
    assign predicted_pc = BTB[index][31:0];
    assign PHT_index = BHSR^index;
    assign updated_PHT_index = BHSR^EX_index;

    assign tag_matched = tag == BTB_tag;
    assign PHT_taken = PHT[PHT_index] > 1;

    integer i;
    // update BTB, BHSR, PHT 
    always @(posedge clk) begin
        temp <= 0;
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                BTB[i] <= 0;
                PHT[i] <= 0;
            end
            BHSR <= 0;
        end
        else if (bcond == `BCOND_TAKEN || bcond == `BCOND_NOT_TAKEN || bcond == `BCOND_JUMP) begin
            if ((bcond == `BCOND_TAKEN || bcond == `BCOND_JUMP) && PHT[updated_PHT_index] < 3)
                PHT[updated_PHT_index] <= (PHT[updated_PHT_index] + 1);
            else if(bcond == `BCOND_NOT_TAKEN && PHT[updated_PHT_index] > 0) 
                PHT[updated_PHT_index] <= (PHT[updated_PHT_index] - 1);
            else
                temp <= 0;
            //update BTB and BHSR
            BTB[EX_index] <= {EX_tag, EX_correct_next_pc};
            if (bcond == `BCOND_TAKEN || bcond == `BCOND_NOT_TAKEN) begin
                BHSR <= {BHSR[3:0], bcond[0]};
            end
        end
        else 
            temp <= 0;
    end

    Mux_2_to_1 predicted_pc_mux(
        .x0(pc+4),
        .x1(predicted_pc),
        // PC = 0으로 뛰는 명령어 없기 때문에 predicted_pc가 0이라면 invalid로 처리
        .swch(tag_matched && PHT_taken && predicted_pc != 0),
        .out(next_pc)
    );

endmodule
