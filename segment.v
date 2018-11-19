module segment(output reg [6:0] segment7 , input wire in );
//  segment7 es la salida que devuelve un numero binario de
//  in es el numero que entra, se esoera que el numero sea un binario de 4 bits



/*parameter low = 1'b0 , high = 1'b1 ; ESTOS VALORES SON PARA HACER EL SEGMENTADO VALOR A VALOR*/

always @ (in)
begin
  case (in)
  4'b0000: segment7 = 7'b1111110 ;

  4'b0001: segment7 = 7'b0110000 ; 

  4'b0010: segment7 = 7'b1101101 ; 

  4'b0011: segment7 = 7'b1111001 ; 

  4'b0100: segment7 = 7'b0110011 ; 

  4'b0101: segment7 = 7'b1011011 ;

  4'b0110: segment7 = 7'b1011111 ;

  4'b0111: segment7 = 7'b1110000 ;

  4'b1000: segment7 = 7'b1111111 ; /* EJEMPLO PARA VALORES DE SEGMENTOS VALOR A VALOR
  begin
    A = high;
    B = high;
    C = high;
    D = high;
    E = high;
    F = high;
    G = high;  
  end */

  4'b1001: segment7 = 7'b1110011 ; 

  default: segment7 = 7'b1111110 ;

endcase
end
endmodule