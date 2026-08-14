module immediate_gen(
    input [6:0]opcode,
    input [31:0]instruction,
    output reg [31:0]imm_ext
);
always@(*)begin
    case (opcode)
        7'b0000011: imm_ext = {{20{instruction[31]}},instruction[31:20]}; //LW
        7'b0010011: imm_ext = {{20{instruction[31]}},instruction[31:20]};  //ADDI
        7'b0100011: imm_ext = {{20{instruction[31]}},instruction[31:25],instruction[11:7]} ; //SW
        7'b1100011: imm_ext = {{19{instruction[31]}},instruction[31],instruction[7],instruction[30:25],instruction[11:8],1'b0}; //BEQ
        default : imm_ext = 32'b0;
    endcase
end
endmodule