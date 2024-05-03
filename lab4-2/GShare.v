module GShare(
    input clk,
    input reset,
    input [31:0] pc,
    input bcond,
    input branch,
    input [31:0] EX_correct_next_pc,
    input [31:0] EX_pc,
    output [31:0] next_pc
);

    reg [56:0] BTB [31:0]
    reg [4:0] BHSR
    reg [1:0] PHT [31:0]
    reg temp;

    wire [24:0] tag;
    wire [4:0] index;
    wire [24:0] EX_tag;
    wire [4:0] EX_index; 
    wire [3:0] unused;
    wire [31:0] predicted_pc;
    wire [4:0] PTH_index;
    wire tag_matched;
    wire PHT_taken;

    assign tag = pc[31:7];
    assign index = pc[6:2];
    assign EX_tag = EX_pc[31:7];
    assign EX_index = EX_index[6:2];
    assign unused = {pc[1:0], EX_pc[1:0]}
    assign predicted_pc = BTB[index][31:0];
    assign PTH_index = BHSR^index;
    assign tag_matched = tag == EX_tag;
    assign PHT_taken = PHT[PTH_index] > 1;

    // update BTB, BHSR, PHT 
    always @(posedge clk) begin
        temp = 0;
        if (reset) begin
            for (i = 0; i < 32; i = i + 1) begin
                BTB[i] = 0
                PHT[i] = 0
            end
            BHSR = 0
        end
        else if (branch == 1) begin
            BTB[EX_index] = {EX_tag, EX_correct_next_pc};
            BHSR << 1;
            BHSR[0] = bcond;
            if (bcond & PHT[PTH_index] < 3)
                PHT[PTH_index] += 1; 
            else if(!bcond & PHT[PTH_index] > 0) 
                PHT[PTH_index] -= 1;
            else
                temp = 0;
        end
        else 
            temp = 0;
    end

    Mux_2_to_1 predicted_pc_mux(
        .x0(pc+4),
        .x1(predicted_pc),
        .swch(tag_matched & PHT_taken),
        .out(next_pc)
    )

endmodule