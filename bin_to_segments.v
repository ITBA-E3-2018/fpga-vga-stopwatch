module bin_to_segments(segments, digit); // Convertidor de binario a siete segmentos.

    
    input [3:0] digit;
    output reg [6:0] segments;

    parameter   CERO = 7'b1111110, UNO = 7'b0110000, DOS = 7'b1101101, TRES = 7'b1111001, CUATRO = 7'b0110011, 
                CINCO = 7'b1011011, SEIS = 7'b1011111, SIETE = 7'b1110000, OCHO = 7'b1111111, NUEVE = 7'b1111011;

    always @ (*)
    begin
        
            case(digit)
                4'b0000: segments <= CERO;
                4'b0001: segments <= UNO;
                4'b0010: segments <= DOS;
                4'b0011: segments <= TRES;
                4'b0100: segments <= CUATRO;
                4'b0101: segments <= CINCO;
                4'b0110: segments <= SEIS;
                4'b0111: segments <= SIETE;
                4'b1000: segments <= OCHO;
                4'b1001: segments <= NUEVE;
            endcase
        
    end

endmodule
