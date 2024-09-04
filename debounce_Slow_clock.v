`timescale 1ns / 1ps

module Slow_clock(
    input clk_in,
    output clk_out; //4Hz slow clock 
);
reg [25:0] count = 0;
reg clk_out;

always @(posedge clk_in)
begin 
count <= count+1;
if (count == 6250000) //Este dato es igual a 50Mhz/8
begin 
    count <=0;
    clk_out = ~ clk_out; // Niega el reloj de salida 
end
end

endmodule