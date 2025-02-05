module counter_T_4_bits(
	input enable, clk, areset,
	output Q);
	
	wire Q0, Q1, Q2;
	wire a0, a1, a2;
	
	T_flip_flop t0(enable, clk, areset, Q0);
	and(a0, Q0, enable);
	
	T_flip_flop t1(a0, clk, areset, Q1);
	and(a1, Q1, a0);
	
	T_flip_flop t2(a1, clk, areset, Q2);
	and(a2, Q2, a1);
	
	T_flip_flop t3(a2, clk, areset, Q);
	
endmodule
