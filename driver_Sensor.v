`timescale 1ns / 1ps
`include "Proyecto/FSM_Drivers/Register_states.v"

module Buttons_driver(
    input rst,
    input test,
    input clk,
    input sensor_light,
    input sensor_trig,
);

    // variables internas
    reg [2:0] state = 0,
    reg up = 0,
    reg down  = 0,
    reg clk  = 0,
    reg rst  = 0,
    reg test_mode = 0;
    reg light_signal = 0;
    reg trig_signal = 0;

    // variables tiempo
    reg [6:0] sec_count = 0,

// se llama a registro_states para aumentar o disminuir niveles
Registro_states registro_states(.state(state), .UpState(up), .DownState(down), .clk(clk), .rst(rst));

// Se llama al contador de segundos
divisor_freq seconds(.clk(clk), .sec_count(sec_count));

// se llama al antirebote
debounce antirreboteTest(.pb(test),.clk(clk),.out_signal(test_signal));
debounce antirreboteFood(.pb(button_food),.clk(clk),.out_signal(food_signal));
debounce antirreboteHeal(.pb(button_heal),.clk(clk),.out_signal(heal_signal));


// ¿Como evitar que se mantega la señal en alto mucho tiempo?
always @(*) begin //

    state = 5;
    up = 0;
    down  = 0;
    value  = 0;
    rst  = 0;

    if (test_signal == 1)begin
    
    end

    if (food_signal == 1)begin // tiempo de recuperacion como?
        up = 1;
        state = 0; //PREGUNTAR POR ESTO
    end
    if (heal_signal == 1)begin
        up = 1;
        state = 4;
    end


end
endmodule