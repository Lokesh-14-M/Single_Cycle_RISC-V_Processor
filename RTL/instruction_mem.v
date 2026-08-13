module instruction_mem(
    input clk ,rst ,
    input [31:0]read_address,
    output reg [31:0]instruction_mem_out
);
integer i;
reg [31:0] Imem [63:0];

always@(posedge clk or posedge rst)begin
    if(rst)begin
        for(i=1'b0;i<=63;i=i+1)
            Imem[i] <= 32'b0;
    end
    else 
        instruction_mem_out <= Imem[read_address];
end
endmodule

