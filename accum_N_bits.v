module accum_N_bits(
	input [N-1:0] A,
	input clk, aclr,
	output reg [N-1:0] S,
	output reg carry, 
	output reg overflow);
	
	parameter N = 8;
	
	always @(posedge clk) begin
		if (aclr)
			S = {N{1'b0}};
		else begin
			{carry, S} <= A + S;
			overflow <= carry ^ S[N-1];
		end	
	end

endmodule
	