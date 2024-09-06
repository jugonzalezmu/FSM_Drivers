`timescale 1ns / 1ps
`include "/home/juandavidgm/github-classroom/unal-edigital1-lab/FSM_Drivers/fsm_states.v"

module fsm_states_tb;
    // Inputs
    reg clk;
    reg rst;

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
		.foodValue(foodValue),
		.sleepValue(sleepValue),
		.funValue(funValue),
		.happyValue(happyValue),
		.healthValue(healthValue)
	);

	initial begin
		//Initialize Inputs
		clk = 0;
		rst = 0;
		//#10000 es un segundo
		#100;// Wait 100 ns for global reset to finish
		rst = 1;
		#100
		$display("Comida =  %d ", foodValue) ;
		$display("Salud  =  %d ", sleepValue) ;
		$display("Sueño  =  %d ", funValue) ;
		$display("Animo  =  %d ", happyValue) ;
		$display("Salud  =  %d ", healthValue) ;

	end

	always #1 clk = ~clk;

	initial begin: TEST_CASE
	    $dumpfile("fsm_states.vcd");
		$dumpvars(-1, uut);
		#10000 $finish;
	end
	   
endmodule

