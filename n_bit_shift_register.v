module n_bit_shift_register(
	input d, clk, areset,
	output reg [N-1:0] out
);

	parameter N = 4;

	always @(posedge clk, negedge areset) begin
		if (!areset) out <= {N{1'b0}};
		else out <= {out[N-2:0], d};
	end

endmodule
