module upcountto9 (Reset, Clock, Enable, Salida)
    input Reset, Clock, Enable;
    output reg [3:0] Salida;

    always@(posedge Reset, posedge Clock)
        if(Reset)
            Salida <= 4'b0; //Si Reset es 1 pongo un 0 en binario de 4 bits
            else if (Enable && Salida < 4'b9) //Si no llegue al 9, sigo contando
                Salida <= Salida + 1;
                else if (Enable && Salida = 4'b9) //Si llegue al 9, reinicio
                    Salida <= 0;
endmodule