module choose_from_4_symbols (
	input [9:0] c,
	output [0:6] h);
	
	wire [1:0] m;	
	
	mux_4_1_2_bit mux(c[1:0], c[3:2], c[5:4], c[7:6], c[8], c[9], m);
	decoder_7_seg d7s(m, h);
	
endmodule
