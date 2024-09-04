`timescale 1ns / 1ps
`include "/home/juandavidgm/github-classroom/unal-edigital1-lab/FSM_Drivers/Register_states.v"

module Registro_states_tb;

	// Inputs
	reg [2:0] state;
	reg DownState;
	reg UpState;
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] stateValue;

	// Instantiate the Unit Under Test (UUT)

	Registro_states uut (
		.state(state),
		.DownState(DownState),
		.UpState(UpState),
		.stateValue(stateValue),
		.clk(clk),
		.rst(rst)
	);

	initial begin
		//Initialize Inputs
		state = 0;
		DownState = 0;
		UpState = 0;
		clk = 0;
		rst = 0;
		#100;// Wait 100 ns for global reset to finish

		$display("Lectura archivo de carga inicial");

		//rst = 1;
		state = 0;

		for (state = 0; state < 9; state++) begin
			//DownState = 0;
			UpState = 0;
			#4;
			//DownState = 1;
			UpState = 1;
			#1;
			$display("El valor de registro %d =  %d ", state,stateValue) ;
			#1;
		end
			#10;
	end

	always #1 clk = ~clk;

	initial begin: TEST_CASE
	    $dumpfile("Register_states.vcd");
		$dumpvars(-1, uut);
		#500 $finish;
	end
	   
endmodule

