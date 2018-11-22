module cronometro(reset, enable, clk, s0, s1, m0, m1, h); //Modulo que se encarga de instanciar a los contadores
    
    input wire reset, enable, clk;
    output [3:0] s0, s1, m0, m1, h;

    wire cs0, cs1, csm0, cm1, ch;

    upcountto9 upcountto9_s0(reset,clk,enable,s0,cs0);
    upcountto6 upcountto6_s1(reset,cs0,enable,s1,cs1);
    upcountto9 upcountto9_m0(reset,cs1,enable,m0,cm0);
    upcountto6 upcountto6_m1(reset,cm0,enable,m1,cm1);
    upcountto9 upcountto6_h(reset,cm1,enable,h,ch);

endmodule

module upcountto9(Reset, Clock, Enable, Salida, carry);// Contador desde 0 hasta 9

    input Reset, Clock, Enable;
    output reg [3:0] Salida;
    output reg carry;

    initial
    begin
        Salida <= 4'b0000;
        carry <= 0;
    end 

    always @(posedge Reset or posedge Clock) 
        if(Reset)
            Salida <= 4'b0000; //Si Reset es 1 pongo un 0 en binario de 4 bits
            else if (Enable && Salida < 4'b1001) //Si no llegue al 9, sigo contando
                begin
					Salida <= Salida + 1;
					carry<=0;
                end
					else if (Enable && (Salida == 4'b1001)) //Si llegue al 9, reinicio
                    begin 
						    Salida <= 4'b0000;
							carry<=1;
							end
endmodule

module upcountto6(Reset, Clock, Enable, Salida, carry); // Contador desde 0 hasta 6

    input Reset, Clock, Enable;
    output reg [3:0] Salida;
    output reg carry;

    initial
    begin
        Salida <= 4'b0000;
        carry <= 0;
    end 

    always @(posedge Reset or posedge Clock) 
        if(Reset)
            Salida <= 4'b0000; //Si Reset es 1 pongo un 0 en binario de 4 bits
            else if (Enable && Salida < 4'b0101) //Si no llegue al 5, sigo contando
                begin
					Salida <= Salida + 1;
					carry<=0;
                end
					else if (Enable && (Salida == 4'b0101)) //Si llegue al 5, reinicio
                    begin 
						    Salida <= 4'b0000;
							carry<=1;
							end
endmodule