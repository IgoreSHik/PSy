module adder_BCD_2_digits_b(
	input [3:0] x,
	input [3:0] y,
	input cin,
	output [3:0] s0,
	output [3:0] s1,
	output error);
	
	reg [3:0] tempS0;
	reg c1;
	reg e;
	
	wire [3:0] t0;
	wire cout_void;
	
	adder_4 a0(cin, x, y, t0, cout_void);
	
	always @ (*) begin
		if (x > 9 | y > 9) begin
			e = 1;
		end else begin
			e = 0;
		end
		
		if (t0 > 9) begin
			tempS0 = 10;
			c1 = 1;
		end
		else begin
			tempS0 = 0;
			c1 = 0;
		end
	end
	
	assign s0 = t0 - tempS0;
	assign s1 = {3'b000, c1};
	assign error = e;
	
endmodule
