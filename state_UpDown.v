`timescale 1ns / 1ps
`include "FSM_Drivers/Register_states.v"

module state_UpDown(
    input clk,
    input rst,
    input food_button,
    input heal_button,
    input state_button,
    input test_signal,
	input light_signal,
	input echo_signal
);
    reg test_mode = 0;

    reg upFood = 0;
    reg upSleep= 0;
    reg upFun= 0;
    reg upHeal = 0;

    reg [2:0] selected_state = 0;
    wire [2:0] state = 0;
    reg up_state = 0;
    reg down_state = 0;

Registro_states state_register(.state(selected_state), .DownState(down_state), .UpState(up_state), .stateValue(state), .clk(clk), .rst(rst));
Registro_states food_register(.state(3'b000), .UpState(upFood), .clk(clk), .rst(rst));
Registro_states sleep_register(.state(3'b001), .UpState(upSleep), .clk(clk), .rst(rst)); 
Registro_states fun_register(.state(3'b010), .UpState(upFun), .clk(clk), .rst(rst));
Registro_states heal_register(.state(3'b100), .UpState(upHeal), .clk(clk), .rst(rst)); 

    always @(posedge clk) begin
        if (rst) begin
            test_mode <= 0;
            upFood <= 0;
            upSleep <= 0;
            upFun <= 0;
            upHeal <= 0;
            selected_state <= 0;
            up_state <= 0;
            down_state <= 0;
        end

        upFood <= 0;
        upSleep <= 0;
        upFun <= 0;
        upHeal <= 0;
        up_state <= 0;
        down_state <= 0;
        test_mode <= (test_signal == 1) ? ~test_mode : test_mode;

        if (test_mode == 1) begin
            selected_state <= (state_button == 1) ? ((selected_state == 4) ? 0 : selected_state + 1) : selected_state;
            up_state <= (food_button == 1) ? 1: 0;
            down_state <= (heal_button == 1) ? 1: 0;
        end else begin
            upFood <= food_button;
            upSleep <= light_signal;
            upFun <= echo_signal;
            upHeal <= heal_button;
        end
    end

endmodule