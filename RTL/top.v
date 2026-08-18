module  top(
      input clk,rst
);

wire [31:0] pc_in_t ,pc_out_t , instruction_t , imm_ext_t , read_data1_t , read_data2_t, mux1out_t , alu_result_t , memory_out_t ,write_back_t , pc_aft4_t , add1_out_t;
wire [1:0]aluop_t;
wire and_out_t ,regwrite_t , alusrc_t ,zero_t , memwrite_t ,memread_t ,memtoreg_t ,branch_t , mux_select_t ;
wire [3:0]alu_ctr_t;


program_counter pc(.clk(clk) , .rst(rst) , .pc_in(pc_in_t) , .pc_out(pc_out_t));

pc_plus_4 pc4(.from_pc(pc_out_t) ,.next_to_pc(pc_aft4_t));

instruction_mem  i_mem(.clk(clk) ,.rst(rst) ,
    .read_address(pc_out) ,
    .instruction_mem_out(instruction_t)
);

register_file reg_file(.clk(clk),
    .rst(rst),
    .regwrite(regwrite_t),
    .rs2(instruction_t[24:20]),
    .rs1(instruction_t[19:15]),
    .rd(instruction_t[11:7]),
    .write_data(write_back_t),
    .read_data1(read_data1_t),
    .read_data2(read_data2_t) 
);

op_control_unit ctrl(.opcode(instruction_t[6:0]),
    .alusrc(alusrc_t) , 
    .memtoreg(memtoreg_t) ,
    .memwrite(memwrite_t) ,
    .memread(memread_t) , 
    .branch(branch_t) , 
    .regwrite(regwrite_t) ,
    .aluop(aluop_t)
);

immediate_gen im_gen(.opcode(instruction_t[6:0]),
    .instruction(instruction_t),
    .imm_ext(imm_ext_t)
);

alu_control_unit alu_cu(.aluop(aluop_t),
    .funct7_5(instruction_t[30]),
    .funct3(instruction_t[14:12]),
    .control_out(alu_ctr_t)
);

mux mux_alu(.a(read_data2_t),
    .b(imm_ext_t),
    .sel(alusrc_t),
    .mux_out(mux1out_t)
);

alu alu1(.a(read_data1_t),
    .b(mux1out_t),
    .control_in(alu_ctr_t),
    .zero(zero_t),
    .alu_result(alu_result_t)
);

data_memory d_mem(.clk(clk),
    .rst(rst),
    .read_address(alu_result_t),
    .write_data(read_data2_t),
    .mem_read(memread_t) , 
    .mem_write(memwrite_t) ,
    .memory_out(memory_out_t)
);

mux mux_mem(.a(alu_result_t),
    .b(memory_out_t),
    .sel(memtoreg_t),
    .mux_out(write_back_t)
);

and_logic and1(.a(branch_t),
    .b(zero_t),
    .out(and_out_t)
);

adder add1(.a(pc_out_t),
    .b(imm_ext_t),
    .sum(add1_out_t)
);

mux mux_pc(.a(pc_aft4_t),
    .b(add1_out_t),
    .sel(and_out_t),
    .mux_out(pc_in_t)
);


endmodule