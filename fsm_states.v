`timescale 1ns / 1ps
`include "FSM_Drivers/Register_states.v"

module fsm_states (
       input clk,
       input rst,
       output [2:0] foodValue,
       output [2:0] sleepValue,
       output [2:0] funValue,
       output [2:0] happyValue,
       output [2:0] healthValue
    );
    reg upHappy = 0;

    reg downFood  = 0;
    reg downSleep  = 0;
    reg downFun  = 0;
    reg downHappy  = 0;
    reg downHeal = 0;

    reg downHeal_food = 0;
    reg downHeal_sleep = 0;
    reg downHeal_fun = 0;
    reg downHeal_happy = 0;

parameter freq = 50; //50 MHz
reg [6:0] sec_count = 0; // segundos hasta 128
reg [25:0] counter = 0; //Contador de 26 bits 

    always @(posedge clk) begin 
        if (counter == freq) begin
            sec_count <= (sec_count == 90) ? 0 : sec_count+1; // se reinician los segundos o aumenta contador segundos
            counter <= 0; // se reinicia el contador 
        end else begin 
            counter <= counter+1;
        end 
    end

Registro_states food_register(.state(3'b000), .DownState(downFood), .stateValue(foodValue), .clk(clk));
Registro_states sleep_register(.state(3'b001), .DownState(downSleep), .stateValue(sleepValue), .clk(clk)); 
Registro_states fun_register(.state(3'b010), .DownState(downFun), .stateValue(funValue), .clk(clk)); 
Registro_states happy_register(.state(3'b011), .DownState(downHappy), .stateValue(happyValue), .UpState(upHappy), .clk(clk)); 
Registro_states health_Register(.state(3'b100), .DownState(downHeal), .stateValue(healthValue), .clk(clk));

parameter IDLEFOOD = 2'b00, HUNGER = 2'b01, FEED = 2'b10, STARVE = 2'b11;
reg [1:0] food_state = IDLEFOOD;
reg [1:0] next_stateFood = 2'b00;

parameter IDLESLEEP = 2'b00, TIRED = 2'b01, REST = 2'b10, INSOMNIA = 2'b11;
reg [1:0] sleep_state = IDLESLEEP;
reg [1:0] next_stateSleep = 2'b00;

parameter IDLEFUN = 2'b00, BOREDOM = 2'b01, PLAY = 2'b10, DEPRESSION = 2'b11;
reg [1:0] fun_state = IDLEFUN;
reg [1:0] next_stateFun = 2'b00;

parameter IDLEHAPPY = 2'b00, SAD = 2'b01, JOLLY = 2'b10, SADNESS = 2'b11;
reg [1:0] happy_state = IDLEHAPPY;
reg [1:0] next_stateHappy = 2'b00;

    always @(posedge clk) begin
        food_state <= (rst == 0) ? IDLEFOOD : next_stateFood;
        sleep_state <= (rst == 0) ? IDLESLEEP : next_stateSleep;
        fun_state <= (rst == 0) ? IDLEFUN : next_stateFun;
        happy_state <= (rst == 0) ? IDLEHAPPY : next_stateHappy;
    end

    always @(*) begin
        downHeal <= (downHeal_happy == 1 || downHeal_fun == 1 || downHeal_sleep == 1 || downHeal_food== 1) ? 1 : 0;
        case(food_state)
            IDLEFOOD: next_stateFood <= HUNGER;
            HUNGER: next_stateFood <= (counter == 0) ? HUNGER : FEED;
            FEED: next_stateFood <= (counter < 4) ? STARVE : HUNGER;
            STARVE: next_stateFood <= IDLEFOOD;
        endcase
        case(sleep_state)
            IDLESLEEP: next_stateSleep <= TIRED;
            TIRED: next_stateSleep <= (counter == 0) ? TIRED : REST;
            REST: next_stateSleep <= (4 < counter && counter < 9) ? INSOMNIA : TIRED;
            INSOMNIA: next_stateSleep <= IDLESLEEP;
        endcase
        case(fun_state)
            IDLEFUN: next_stateFun <= BOREDOM;
            BOREDOM: next_stateFun <= (counter == 0) ? BOREDOM : PLAY;
            PLAY: next_stateFun <= (9 < counter && counter < 14) ? DEPRESSION : BOREDOM;
            DEPRESSION: next_stateFun <= IDLEFUN;
        endcase
        case(happy_state)
            IDLEHAPPY: next_stateHappy <= SAD;
            SAD: next_stateHappy <= (14 < counter && counter < 19) ? SAD : JOLLY;
            JOLLY: next_stateHappy <= (19 < counter && counter < 24) ? SADNESS : SAD;
            SADNESS: next_stateHappy <= IDLEHAPPY;
        endcase
    end

    always @(posedge clk) begin
        if (rst == 0) begin
            downFood  <= 0;
            downHeal_food <= 0;
            downSleep  <= 0;
            downHeal_sleep <= 0;
            downFun  <= 0;
            downHeal_fun <= 0;
            upHappy <= 0;
            downHappy  <= 0;
            downHeal_happy <= 0;
        end else begin
            case(food_state)
                IDLEFOOD: begin
                    downFood <= 0;
                    downHeal_food <= 0;
                end
                HUNGER: begin // se baja nivel comida
                    downFood <= ((sec_count == 30 || sec_count == 60 || sec_count == 90) && counter == 0) ? 1 : 0;
                    downHeal_food <= 0;
                end
                FEED: begin 
                    downFood <= 0;
                    downHeal_food <= 0;
                end
                STARVE: begin //se baja nivel salud si se cumple tiempo
                    downFood <= 0;
                    downHeal_food <= (foodValue < 3 && (sec_count == 20 || sec_count == 55 || sec_count == 85) && counter < 4) ? 1 : 0;
                end 
            endcase
            case(sleep_state)
                IDLESLEEP: begin
                    downSleep <= 0;
                    downHeal_sleep <= 0;
                end
                TIRED: begin
                    downSleep <= ((sec_count == 18 || sec_count == 49 || sec_count == 86) && counter == 0) ? 1 : 0;
                    downHeal_sleep <= 0;
                end
                REST: begin 
                    downSleep <= 0;
                    downHeal_sleep <= 0;
                end
                INSOMNIA: begin
                    downSleep <= 0;
                    downHeal_sleep <= (sleepValue < 3 && (sec_count == 34 || sec_count == 75) && 4< counter && counter < 9) ? 1 : 0;
                end 
            endcase
            case(fun_state)
                IDLEFUN: begin
                    downFun <= 0;
                    downHeal_fun <= 0;
                end
                BOREDOM: begin
                    downFun <= ((sec_count == 25 || sec_count == 50 || sec_count == 73 || sec_count == 89) && counter == 0) ? 1 : 0;
                    downHeal_fun <= 0;
                end
                PLAY: begin 
                    downFun <= 0;
                    downHeal_fun <= 0;
                end
                DEPRESSION: begin
                    downFun <= 0;
                    downHeal_fun <= (funValue < 3 && (sec_count == 33 || sec_count == 77) && 9< counter && counter < 14) ? 1 : 0;
                end 
            endcase
            case(happy_state)
                IDLEHAPPY: begin
                    upHappy <= 0;
                    downHappy <= 0;
                    downHeal_happy <= 0;
                end
                SAD: begin
                    upHappy <= 0;
                    downHappy <= (foodValue < 3 && funValue < 3 && (sec_count == 23 || sec_count == 47 || sec_count == 69 || sec_count == 83) && counter == 0) ? 1 : 0;
                    downHeal_happy <= 0;
                end
                JOLLY: begin 
                    upHappy <= (foodValue > 3 && funValue > 3 && (sec_count == 22 || sec_count == 70) && 14< counter && counter < 19) ? 1: 0;
                    downHappy <= 0;
                    downHeal_happy <= 0;
                end
                SADNESS: begin
                    upHappy <= 0;
                    downHappy <= 0;
                    downHeal_happy <= (happyValue < 3 && (sec_count == 2 || sec_count == 32 || sec_count == 62) && 19 < counter && counter < 24) ? 1 : 0;
                end 
            endcase
        end
    end


endmodule