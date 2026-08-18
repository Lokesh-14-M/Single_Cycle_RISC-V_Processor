module alu(
    input [31:0]a,b,
    input [3:0]control_in,
    output reg zero,
    output reg [31:0]alu_result
);

always @(*) begin
    case (control_in)
        4'b0000: alu_result = a & b;
        4'b0001: alu_result = a | b;
        4'b0010: alu_result = a + b;
        4'b0110: alu_result = a - b; 
    endcase
    if(alu_result == 0) zero = 1'b1;
    else zero = 1'b0;
end
endmodule