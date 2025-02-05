module adder_BCD_2_digits_mapping(
	input [8:0] SW,
	output [0:6] HEX0,
	output [0:6] HEX1,
	output [9:0] LEDR
	);
	
	wire [3:0] s0;
	wire [3:0] s1;
	wire e0, e1;
	
	adder_BCD_2_digits add(SW[7:4], SW[3:0], SW[8], s0, s1, LEDR[9]);
	decoder_hex_10 d0(s0, HEX0, e0);
	decoder_hex_10 d1(s1, HEX1, e1);
	
	assign LEDR[8:0] = SW;
	
	
endmodule
