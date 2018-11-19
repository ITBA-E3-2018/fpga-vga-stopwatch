module upcountto6 (input wire Reset, input wire Clock, input wire Enable, output reg [3:0] Salida);

    always @(posedge Reset or posedge Clock)
        if(Reset)
            Salida <= 4'b0000; //Si Reset es 1 pongo un 0 en binario de 4 bits
            else if (Enable && Salida < 4'b0101) //Si no llegue al 5, sigo contando
                Salida <= Salida + 1;
                else if (Enable && (Salida == 4'b0101)) //Si llegue al 5 en el ciclo anterior, toca reiniciar
                    Salida <= 4'b0000;
endmodule