module counterSecs (
    input clk,
    output reg [6:0] sec_count;
);

parameter freq = 50000000; //50 MHz

reg [25:0] counter; //Contador de 27 bits 

initial begin //Valores iniciales 
counter= 0;
sec_count= 0; 
end 

always @(posedge clk) begin 
    if (counter == freq) begin //En caso de que el contador llegue a su valor maximo 
    sec_count = sec_count+1;
    // Y se reinicia el contador 
    counter = 0;
    end 
    else begin 
        counter <= counter+1;
    end 
    if (sec_count == 91) begin
        sec_count = 1;
    end 
end

endmodule