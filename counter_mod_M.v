module counter_mod_M (
	input enable, clk, areset,
	output reg [N-1:0] Q);
	
	parameter M = 10;
	
	localparam N = clogb2(M - 1);
	
	function integer clogb2(input [31:0] v);
		for (clogb2 = 0; v > 0; clogb2 = clogb2 +1)
			v = v >> 1;
	endfunction
	
	always @(posedge clk, negedge areset)
		if (!areset) Q <= {N{1'b0}};
		else if (Q == M - 1) Q <= {N{1'b0}};
		else if (enable) Q <= Q + 1;
		else Q <= Q;
	
endmodule
