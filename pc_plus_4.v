module pc_plus_4(
    input [31:0]from_pc,
    output reg [31:0]next_to_pc
);
always@(*)begin
    next_to_pc = from_pc + 4;
end
endmodule