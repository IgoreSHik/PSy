module FSM_one_hot_map(
	input [1:0] SW,
	input [0:0] KEY,
	output [9:0] LEDR);
	
	FSM_one_hot fsm(SW[1], KEY[0], SW[0], LEDR[9], LEDR[8:0]);
	
endmodule
