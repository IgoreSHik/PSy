module T_flip_flop(
	input enable, clk, areset,
	output reg Q);

	always @(posedge clk, negedge areset)
		if (!areset) Q <= 1'b0;
		else if (enable) Q <= ~Q;
		else Q <= Q;
	
endmodule
