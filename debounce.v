`timescale 1ns / 1ps
`include "Proyecto/FSM_Drivers/debounce_Slow_clock.v"
`include "Proyecto/FSM_Drivers/debounce_DD_FF.v"

module debounce(  
    input pb,
    input clk,
    output out_signal,
);

wire clk_out;
wire Q1, Q2, Q2_bar;

Slow_clock U1(clk, clk_out);
DD_FF d1(clk_out, pb, Q1);
DD_FF d2(clk_out, Q1, Q2);

assign Q2_bar = ~Q2;
assign out_signal = Q1 & Q2_bar;

endmodule