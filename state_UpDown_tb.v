`timescale 1ns / 1ps
`include "/home/juandavidgm/github-classroom/unal-edigital1-lab/FSM_Drivers/state_UpDown.v"

module state_UpDown_tb;
    // Inputs
    reg clk;
    reg rst;
    reg food_buttonF;
	reg light_signalF;
	reg echo_signalF;
	reg test_buttonF;
    reg heal_buttonF;
	reg state_buttonF;

	// Instantiate the Unit Under Test (UUT)

	state_UpDown uut (
		.clk(clk),
		.rst(rst),
		.food_button(food_buttonF),
		.light_signal(light_signalF),
		.echo_signal(echo_signalF),
		.state_button(state_buttonF),
		.test_signal(test_buttonF),
		.heal_button(heal_buttonF)
	);

	initial begin
		//Initialize Inputs
		clk = 0;
		rst = 0;
		state_buttonF = 0;
		test_buttonF = 0;
		food_buttonF = 0;
		light_signalF = 0;
		echo_signalF = 0;
		heal_buttonF = 0;
		//#10000 es un segundo
		#2;// Wait 100 ns for global reset to finish
		rst = 1;
		#2;// Wait 100 ns for global reset to finish
		rst = 0;

		//probando botones test_mode = 0
		#2
		food_buttonF = 1;
		#2
		food_buttonF = 0;
		light_signalF = 1;
		#2
		light_signalF = 0;
		echo_signalF = 1;
		#2
		echo_signalF = 0;
		heal_buttonF = 1;
		#2
		heal_buttonF = 0;

		#2
		test_buttonF = 1;
		#2
		test_buttonF = 0;
		//probando botones test_mode = 1

		food_buttonF = 0;
		light_signalF = 0;
		echo_signalF = 0;
		heal_buttonF = 0;

		// señales de sensores no dan nada
		#2
		light_signalF = 1;
		#2
		light_signalF = 0;
		echo_signalF = 1;
		#2
		echo_signalF = 0;

		
		#2
		food_buttonF = 1;
		heal_buttonF = 0;
		state_buttonF = 0;
		#2
		food_buttonF = 1;
		heal_buttonF = 0;
		state_buttonF = 0;
		#2
		food_buttonF = 0;
		heal_buttonF = 1;
		state_buttonF = 0;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 1;
		#2
		food_buttonF = 0;
		heal_buttonF = 1;
		state_buttonF = 0;
		#2
		food_buttonF = 1;
		heal_buttonF = 0;
		state_buttonF = 0;
		#2
		food_buttonF = 0;
		heal_buttonF = 0;
		state_buttonF = 0;


		#2
		test_buttonF = 1;
		#2
		test_buttonF = 0;
		#2
		food_buttonF = 1;
		#2
		food_buttonF = 0;
		light_signalF = 1;
		#2
		light_signalF = 0;
		echo_signalF = 1;
		#2
		echo_signalF = 0;
		heal_buttonF = 1;
		#2
		heal_buttonF = 0;

	end

	always #1 clk = ~clk;

	initial begin: TEST_CASE
	    $dumpfile("state_UpDown.vcd");
		$dumpvars(-1, uut);
		#1000 $finish;
	end
	   
endmodule