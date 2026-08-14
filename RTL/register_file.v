module register_file(
    input clk,rst,regwrite,
    input [4:0]rs2,rs1,rd,
    input [31:0]write_data,
    output reg [31:0]read_data1,read_data2
);

integer i;

reg [31:0] register[31:0];

always@(posedge clk or posedge rst)begin
    if(rst)begin
        for(i = 0 ; i <= 31 ; i=i+1 )
            register[i] <= 32'b0;
    end
    else if(regwrite)begin
        register[rd] <= write_data;
    end
end

assign read_data1 = register[rs1];
assign read_data2 = register[rs2];

endmodule