module alu_control_unit(
    input [1:0]aluop,
    input funct7_5,
    input [2:0]funct3,
    output reg [3:0]control_out
);
always@(*)begin
    case({aluop,funct7_5,funct3})
        6'b00_0_000:control_out = 4'b0010;  //lw & sw
        6'b01_0_000:control_out = 4'b0110;  // beq
        6'b10_0_000:control_out = 4'b0010;  // R(add)
        6'b10_1_000:control_out = 4'b0110;  // R(sub)
        6'b10_0_111:control_out = 4'b0000;  // R(and)
        6'b10_0_110:control_out = 4'b0001;  // R(or)
    endcase
end
endmodule