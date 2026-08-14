module op_control_unit(
    input [6:0]opcode,
    output reg alusrc , memtoreg ,memwrite , memread , branch , regwrite ,
    output reg [1:0]aluop
);

always@(*)begin
    alusrc = 1'b0; 
    memtoreg = 1'b0;
    memwrite = 1'b0;
    memread = 1'b0;
    branch = 1'b0;
    regwrite = 1'b0;
    aluop = 2'b0;
    case (opcode)
        7'b0000011:        //LW
            begin
                alusrc = 1'b1; 
                memtoreg = 1'b1;
                memread = 1'b1;
                regwrite = 1'b1;
            end
        7'b0110011:  //R type
            begin
                regwrite = 1'b1;
                aluop = 2'b10;
            end
        7'b0100011:  //SW
            begin
                alusrc = 1'b1; 
                memwrite = 1'b1;
            end
        7'b1100011:  //beg
            begin
                branch = 1'b1;
                aluop = 2'b01;
            end
    endcase
end
endmodule