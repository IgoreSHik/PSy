module my_ram32x4_map(
	input [9:0] SW,
	input [0:0] KEY,
	output [0:6] HEX0,
	output [0:6] HEX2,
	output [0:6] HEX4,
	output [0:6] HEX5);
	
	wire [3:0] q;
	my_ram32x4 ram(SW[8:4], KEY[0], SW[3:0], SW[9], q);
	
	decoder_hex_16 h0(SW[8], HEX5);
	decoder_hex_16 h1(SW[7:4], HEX4);
	
	decoder_hex_16 h2(SW[3:0], HEX2);
	
	decoder_hex_16 h3(q, HEX0);
		
endmodule
