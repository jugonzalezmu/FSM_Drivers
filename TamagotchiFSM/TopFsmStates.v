`timescale 1ns / 1ps

module TopFsmStates(
    input Clk,
    input Rst,
	 input boton,
	 output [0:6] sseg7,
	 output [2:0] an_1,
	 output [2:0] an1_1,
	 output Led
    );

	 wire [2:0] foodValueF;
	 wire [2:0] sleepValueF;
	 wire [2:0] funValueF;
	 wire [2:0] happyValueF;
	 wire [2:0] healthValueF;
	 wire [2:0] xdValue;
	  
display displayOut(
	 .clk(Clk), 
	 .rst(Rst), 
	 .boton(boton),
	 .sseg(sseg7), 
	 .an(an_1), 
	 .an1(an1_1), 
	 .led(Led),
	 .foodValue(foodValueF),
	 .sleepValue(sleepValueF),
	 .funValue(funValueF),
	 .happyValue(happyValueF),
	 .healthValue(healthValueF),
	 .xdValue(xdValue)
	 );

fsm_states states(
	.clk(Clk), 
	.Reset(rst),
	.boton(boton),
	.foodValue(foodValueF),
    .sleepValue(sleepValueF),
    .funValue(funValueF),
    .happyValue(happyValueF),
    .healthValue(healthValueF),
	 .xdvalue(xdValue)
	);
endmodule