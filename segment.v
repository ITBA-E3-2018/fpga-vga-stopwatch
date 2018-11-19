module segment(A , B , C , D , E , F , G , in );
//  los valores A,B,C,D,E,F y G son los segmentos para mostrar un numero
//  in es el numero que entra, se esoera que el numero sea un binario de 4 bits

input in;
output reg A , B , C , D , E , F , G;
parameter low = 1'b0 , high = 1'b1 ;

always @ (in)
begin
  case (in)
  4'b0000: 
  begin
    A = high;
    B = high;
    C = high;
    D = high;
    E = high;
    F = high;
    G = low;
  end
  4'b0001: 
  begin
    A = low;
    B = high;
    C = high;
    D = low;
    E = low;
    F = low;
    G = low;    
  end
  4'b0010: 
  begin
    A = high;
    B = high;
    C = low;
    D = high;
    E = high;
    F = low;
    G = high;
    
  end
  4'b0011: 
  begin
    A = high;
    B = high;
    C = high;
    D = high;
    E = low;
    F = low;
    G = high;    
  end
  4'b0100: 
  begin
    A = low;
    B = high;
    C = high;
    D = low;
    E = low;
    F = high;
    G = high;    
  end

  4'b0101: 
  begin
    A = high;
    B = low;
    C = high;
    D = high;
    E = low;
    F = high;
    G = high;    
  end

  4'b0110: 
  begin
    A = high;
    B = low;
    C = high;
    D = high;
    E = high;
    F = high;
    G = high;    
  end

  4'b0111: 
  begin
    A = high;
    B = high;
    C = high;
    D = low;
    E = low;
    F = low;
    G = low;
  end

  4'b1000: 
  begin
    A = high;
    B = high;
    C = high;
    D = high;
    E = high;
    F = high;
    G = high;  
  end

  4'b1001: 
  begin
    A = high;
    B = high;
    C = high;
    D = low;
    E = low;
    F = high;
    G = high;  
  end

  default: 
  begin    
    A = low;
    B = low;
    C = low;
    D = low;
    E = low;
    F = low;
    G = low;
  end

end

endmodule