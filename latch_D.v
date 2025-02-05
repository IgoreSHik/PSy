module latch_D (
	input D, Clk,
	output Q);
		
	wire R_g, S_g, Qa, Qb, S, R /* synthesis keep */ ;
	assign S = D;
	assign R = ~D;	
	nand (S_g, S, Clk);
	nand (R_g, ~R, Clk);
	nand (Qa, S_g, Qb);
	nand (Qb, R_g, Qa);
	assign Q = Qa;
	
endmodule
