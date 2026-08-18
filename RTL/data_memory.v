module data_memory(
    input clk,rst,
    input [31:0]read_address,write_data,
    input mem_read , mem_write,
    output reg [31:0]memory_out
);

reg [31:0] d_mem [63:0];

integer i;

always@(posedge clk or posedge rst)begin
    if(rst)begin
        for(i=0;i<64;i=i+1)
            d_mem[i] <= 32'b0; 
    end
    else if(mem_write)begin
        d_mem[read_address] <= write_data; 
    end
end
assign memory_out = (mem_read) ? d_mem[read_address] : 32'b0;
endmodule
