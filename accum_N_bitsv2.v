module accum_N_bitsv2(
	input [N-1:0] A,
	input clk, aclr,
	output reg [N-1:0] S,
	output carry, 
	output overflow);
	
	parameter N = 8;
	
	wire [N-1:0] sum;
	assign {carry, sum} = A + S;
	assign overflow = carry ^ S[N-1];
	
endmodule
