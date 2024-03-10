`include "alu_func.v"

module alu #(parameter data_width = 16) (
   input [data_width - 1 : 0] A, 
   input [data_width - 1 : 0] B, 
   input [3 : 0] FuncCode,
   output reg [data_width - 1: 0] C,
   output reg OverflowFlag
);

initial begin
   C = 0;
   OverflowFlag = 0;
end      

reg signed [data_width - 1: 0] result; // Modify result variable to match data_width

always @(*) begin
    case (FuncCode)
        `FUNC_ADD: result = A + B;
        `FUNC_SUB: result = A - B;
        `FUNC_ID: result = A; 
        `FUNC_NOT: result = ~A;
        `FUNC_AND: result = A & B;
        `FUNC_OR: result = A | B;
        `FUNC_NAND: result = ~(A & B);
        `FUNC_NOR: result = ~(A | B);
        `FUNC_XOR: result = A ^ B;
        `FUNC_XNOR: result = ~(A ^ B);
        `FUNC_LLS: result = A << 1; // Logical Left Shift
        `FUNC_LRS: result = A >> 1; // Logical Right Shift
        `FUNC_ALS: result = $signed(A) <<< 1; // Arithmetic Left Shift
        `FUNC_ARS: result = $signed(A) >>> 1; // Arithmetic Right Shift
        `FUNC_TCP: result = ~A + 1;
        `FUNC_ZERO: result = 0; // Zero output
        default: result = 0; // Default case
    endcase
end

// Assigning outputs
assign C = result;
always @(*) begin
    if (FuncCode == `FUNC_ADD) begin
        if ((A[data_width-1] & B[data_width-1] & ~result[data_width-1]) || (~A[data_width-1] & ~B[data_width-1] & result[data_width-1]))
            OverflowFlag = 1;
        else
            OverflowFlag = 0;
    end
    else if(FuncCode == `FUNC_SUB) begin
        if ((A[data_width-1] & ~B[data_width-1] & ~result[data_width-1]) || (~A[data_width-1] & B[data_width-1] & result[data_width-1]))
            OverflowFlag = 1;
        else
            OverflowFlag = 0;
    end
    else begin
        OverflowFlag = 0; // Or any appropriate value
    end
end

endmodule
