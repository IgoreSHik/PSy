module diode_delay_map(
	input CLOCK2_50,
	output [7:0] LEDR);

	wire d0, d1;
	diode_delay(CLOCK2_50, d0, d1);
	
	assign LEDR[3:0] = {4{d0}};
	assign LEDR[7:4] = {4{d1}};
	
endmodule
