`timescale 1ns / 1ps

module Registro_states #(      		 //   #( Parametros
         parameter BIT_ADDR = 3,  //   BIT_ADDR Número de bit para la dirección
         parameter BIT_DATO = 3  //  BIT_DATO  Número de bit para el dato
	)
	(
       input [BIT_ADDR-1:0] state,
       input UpState,
	   input DownState,

       output [BIT_DATO-1:0] stateValue,

       input clk, 
       input rst
    );

// La cantdiad de registros es igual a: 
localparam NREG = 2 ** BIT_ADDR;
  
//configiración del banco de registro 
reg [BIT_DATO-1: 0] breg [NREG-1:0];

assign stateValue = breg[state];

always @(posedge clk) begin
//Función reset con valores predeterminados
if (rst == 1) begin
      breg[0] <= 5;
	  breg[1] <= 5;
	  breg[2] <= 5;
	  breg[3] <= 5;
	  breg[4] <= 5;
	  breg[5] <= 0;
	  breg[6] <= 0;
	  breg[7] <= 0;
	end
if (breg[4] == 1) begin
      breg[0] <= 0;
	  breg[1] <= 0;
	  breg[2] <= 0;
	  breg[3] <= 0;
	  breg[4] <= 0;
	  breg[5] <= 0;
	  breg[6] <= 0;
	  breg[7] <= 0;
    end
if (UpState == 1) begin
    if (breg[state] == 1 || breg[state] == 2 || breg[state] == 3 || breg[state] == 4) begin 
	      breg[state] <= stateValue+1;
	   end
	end
if (DownState == 1) begin
    if (breg[state] == 2 || breg[state] == 3 || breg[state] == 4 || breg[state] == 5) begin 
	      breg[state] <= stateValue-1;
	   end
	end
end


//La precarga se realiza aqui con la ruta relativa del archivo Reg16.men que se va a leer.
initial 
  $readmemh("/home/juandavidgm/github-classroom/unal-edigital1-lab/FSM_Drivers/Register_States5.men", breg, 0, NREG-1);

endmodule

