`timescale 1ns / 1ps
`include "TamagotchiFSM/Register_states.v"

module TestBench;

	// Inputs
	reg [2:0] state;
	reg UpState;
	reg DownState;
	reg clk;
	reg rst;

	// Outputs
	wire [2:0] stateValue;

	// Instantiate the Unit Under Test (UUT)
	Registro_states uut (
	    .state(state),
		.UpState(UpState),
		.DownState(DownState),
		.stateValue(stateValue),
		.clk(clk), 
		.Reset(rst)
	);

	initial begin
		//Initialize Inputs
	    state = 0;
	    UpState = 0;
	    DownState = 0;
		clk = 0;
		rst = 0;
		#100;// Wait 100 ns for global reset to finish
		
		$display("Lectura archivo de carga inicial");
        for (state = 0; state < 7; state = state + 1) begin
			#5
			$display("INICIAL El valor de registro %d =  %d", state,stateValue) ;
		end
		#5;
		state = 0;
		#5
		state = 0;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 0;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 0;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 0;
	    UpState = 1;
	    DownState = 0;
		#5
		state = 1;
	    UpState = 1;
	    DownState = 0;
		#5
		state = 1;
	    UpState = 1;
	    DownState = 0;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 2;
	    UpState = 0;
	    DownState = 1;
		#5
		state = 0;
	    UpState = 0;
	    DownState = 0;
		#10;
		//Lectura de la carga
		$display("Lectura archivo de carga inicial");
        for (state = 0; state < 7; state = state + 1) begin
			#5
			$display("CAMBIADA El valor de registro %d =  %d", state,stateValue) ;
		end
		#10;
		//Reset
		rst=1;
		#10;
		rst=0;
		#10;
		$display("Lectura archivo de carga inicial");
        for (state = 0; state < 7; state = state + 1) begin
			#5
			$display("RESET El valor de registro %d =  %d", state,stateValue) ;
		end
		
		#100;
		$stop;
		
	end

	always #1 clk = ~clk;
	   
endmodule

		