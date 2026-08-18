module mux(
    input [31:0]a,b,
    input sel,
    output [31:0]mux_out
);

assign mux_out = (sel) ? b : a ;

endmodule