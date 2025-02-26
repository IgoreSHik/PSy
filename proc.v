module proc(
	input [8:0] dataIn,
	input reset, clk, run,
	output reg done,
	output reg [8:0] bus);

	parameter T0 = 2'b00,
				T1 = 2'b01,
				T2 = 2'b10,
				T3 = 2'b11;
	
	reg [1:0] Tstep_Q, Tstep_D;
	reg [0:7] Rin, Rout;
	reg [8:0] Sum;
	reg IRin, DINout, Ain, Gin, Gout, AddSub;
	
	wire [2:0] I;
	wire [0:7] Xreg, Yreg;
	wire [1:9] IR;
	wire [8:0] R0, R1, R2, R3, R4, R5, R6, R7;
	wire [8:0] A, G;
	
	assign I = IR[1:3];
	dec3to8 decX(IR[4:6], 1'b1, Xreg);
	dec3to8 dexY(IR[7:9], 1'b1, Yreg);
	
	always @(Tstep_Q, run, done)
	begin
		case (Tstep_Q)
			T0:
				if (!run) Tstep_D = T0;
				else Tstep_D = T1;
			T1:
				if (done) Tstep_D = T0;
				else Tstep_D = T2;
			T2:
				Tstep_D = T3;
			T3:
				Tstep_D = T0;
		endcase
	end
	
	parameter mv = 3'b000,
				mvi = 3'b001,
				add = 3'b010,
				sub = 3'b011;
	always @(Tstep_Q or I or Xreg or Yreg)
	begin
		done = 0; Ain = 0; Gin = 0; AddSub = 0; IRin = 0; DINout = 0; Rin = {6{1'b0}}; Rout = {6{1'b0}}; Gout = 0;
		case (Tstep_Q)
			T0: IRin = 1;
			T1:
				case (I)
					mv: begin
						Rout = Yreg;
						Rin = Xreg;
						done = 1;
					end
					mvi: begin
						DINout = 1;
						Rin = Xreg;
						done = 1;
					end
					add, sub: begin
						Rout = Xreg;
						Ain = 1;
					end
				endcase
			T2:
				case (I)
					add: begin
						Rout = Yreg;
						Gin = 1;
					end
					sub: begin
						Rout = Yreg;
						AddSub = 1;
						Gin = 1;
					end
				endcase
			T3:
				case (I)
					add, sub: begin
						Gout = 1;
						Rin = Xreg;
						done = 1;
					end
				endcase
		endcase
	end

	always @(posedge clk, negedge reset)
		if (!reset)
			Tstep_Q <= T0;
		else
			Tstep_Q <= Tstep_D;
			
	regn reg_0 (bus, Rin[0], clk, R0);
	regn reg_1 (bus, Rin[1], clk, R1);
	regn reg_2 (bus, Rin[2], clk, R2);
	regn reg_3 (bus, Rin[3], clk, R3);
	regn reg_4 (bus, Rin[4], clk, R4);
	regn reg_5 (bus, Rin[5], clk, R5);
	regn reg_6 (bus, Rin[6], clk, R6);
	regn reg_7 (bus, Rin[7], clk, R7);
	regn reg_A (bus, Ain, clk, A);
	regn reg_IR (dataIn, IRin, clk, IR);
	 
	always @(AddSub or A or bus)
	begin
		if (!AddSub)
			Sum = A + bus;
		else
			Sum = A - bus;
	end
	
	regn reg_G (Sum, Gin, clk, G);
	wire [0:9] Sel /* synthesis keep */;
	assign Sel = {Rout, Gout, DINout};
	parameter S0 = 10'b1000000000,
				S1 = 10'b0100000000,
				S2 = 10'b0010000000,
				S3 = 10'b0001000000,
				S4 = 10'b0000100000,
				S5 = 10'b0000010000,
				S6 = 10'b0000001000,
				S7 = 10'b0000000100,
				S8 = 10'b0000000010;
	always @(*)
	begin
		case (Sel)
			S0: bus = R0;
			S1: bus = R1;
			S2: bus = R2;
			S3: bus = R3;
			S4: bus = R4;
			S5: bus = R5;
			S6: bus = R6;
			S7: bus = R7;
			S8: bus = G;
			default: bus = dataIn;
		endcase
	end
	
endmodule
