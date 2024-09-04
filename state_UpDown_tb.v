`timescale 1ns / 1ps
`include "/home/juandavidgm/github-classroom/unal-edigital1-lab/FSM_Drivers/state_UpDown.v"

module state_UpDown_tb;
    // Inputs
    reg clk;
    reg rst;
    reg food_button;
	reg light_signal;
	reg echo_signal;
	reg test_button;
    reg heal_button;

	// Instantiate the Unit Under Test (UUT)

	state_UpDown uut (
		.clk(clk),
		.rst(rst),
		.food_button(food_button),
		.light_signal(light_signal),
		.echo_signal(echo_signal),
		.test_button(test_button),
		.heal_button(heal_button)
	);

	initial begin
		//Initialize Inputs
		test_button = 0;
		clk = 0;
		rst = 0;
		food_button = 0;
		light_signal = 0;
		echo_signal = 0;
		heal_button = 0;
		//#10000 es un segundo
		#100;// Wait 100 ns for global reset to finish
		rst = 1;
		#100;// Wait 100 ns for global reset to finish
		rst = 0;

		#100
		food_button = 1;
		light_signal = 0;
		echo_signal = 0;
		heal_button = 0;
		#100
		food_button = 0;
		light_signal = 1;
		echo_signal = 0;
		heal_button = 0;
		#100
		food_button = 0;
		light_signal = 0;
		echo_signal = 1;
		heal_button = 0;
		#100
		food_button = 0;
		light_signal = 0;
		echo_signal = 0;
		heal_button = 1;
		#100
		food_button = 0;
		light_signal = 0;
		echo_signal = 0;
		heal_button = 0;

		#100
		test_button = 1;

		#100
		food_button = 1;
		light_signal = 0;
		echo_signal = 0;
		heal_button = 0;
		#100
		food_button = 0;
		light_signal = 1;
		echo_signal = 0;
		heal_button = 0;
		#100
		food_button = 0;
		light_signal = 0;
		echo_signal = 1;
		heal_button = 0;
		#100
		food_button = 0;
		light_signal = 0;
		echo_signal = 0;
		heal_button = 1;
		#100
		food_button = 0;
		light_signal = 0;
		echo_signal = 0;
		heal_button = 0;


	end

	always #1 clk = ~clk;

	initial begin: TEST_CASE
	    $dumpfile("state_UpDown.vcd");
		$dumpvars(-1, uut);
		#10000 $finish;
	end
	   
endmodule

