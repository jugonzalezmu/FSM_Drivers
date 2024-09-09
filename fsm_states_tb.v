`timescale 1ns / 1ps
`include "/home/juandavidgm/github-classroom/unal-edigital1-lab/FSM_Drivers/fsm_states.v"

module fsm_states_tb;
    // Inputs
    reg clk;
    reg rst;
	reg feeding;
	reg echo_sig;
	reg light_out;
	reg healing;

    // Outputs
    wire [2:0] foodValue;
	wire [2:0] sleepValue;
	wire [2:0] funValue;
	wire [2:0] happyValue;
	wire [2:0] healthValue;

	// Instantiate the Unit Under Test (UUT)

	fsm_states uut (
		.clk(clk),
		.rst(rst),
		.feeding(feeding),
		.healing(healing),
		.light_out(light_out),
		.echo_sig(echo_sig),
		.foodValue(foodValue),
		.sleepValue(sleepValue),
		.funValue(funValue),
		.happyValue(happyValue),
		.healthValue(healthValue)
	);

	initial begin
		//Initialize Inputs
		clk = 0;
		feeding = 0;
		light_out = 0;
		echo_sig = 0;
		healing = 0;
		rst = 0;
		//#10000 es un segundo
		#100;// Wait 100 ns for global reset to finish
		rst = 1;
		#100
		feeding = 1;
		@(posedge clk);
		@(negedge clk);
		feeding = 0;
		@(posedge clk);
		@(negedge clk);
		healing = 1;
		@(posedge clk);
		@(negedge clk);
		healing = 0;
	end

	always #1 clk = ~clk;

	initial begin: TEST_CASE
	    $dumpfile("fsm_states.vcd");
		$dumpvars(-1, uut);
		#10000 $finish;
	end
	   
endmodule

