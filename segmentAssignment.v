// Este módulo devuelve un bus de 7 bits, cada uno de los cuales está asignado a un segmento
// y está en estado HIGH cuando las coordenadas de x e y se encuentran dentro de éste, en el caso 
// de que deba estar encendido. De no estar encendido el segmento o no corresponder las coordenadas,
// estará la salida en LOW.
module segmentAssignment (				// Recibe coordenadas actuales				
input wire [9:0] x,  		                 
input wire [8:0] y,               		      
input wire [3:0] position,				// Recibe la posición en la que debe "dibujar" el número (devolver HIGH si corresponde) (HMMSS)			
input wire [6:0] sevenSegmentNumber,// Recibe el número a "dibujar"
output wire [6:0] segBits,				// Devuelve el bus de estado de este dígito de siete segmentos
input wire [15:0] init_offset_x,
input wire [15:0] init_offset_y,
input wire [15:0] number_blocks_x,
input wire [15:0] block_offset

);
	 wire [15:0] number_offset_x= block_offset*number_blocks_x;
	 
	 
	 // Asignación del bus:
	 assign segBits[6] = ((x > init_offset_x+number_offset_x*position+block_offset) 		& (y >  init_offset_y) 						& (x < init_offset_x+number_offset_x*position+block_offset*3) & (y < init_offset_y+8)) 				 ? sevenSegmentNumber[6] : 0;
    assign segBits[5] = ((x > init_offset_x+number_offset_x*position+block_offset*3) 	& (y >  init_offset_y+block_offset) 	& (x < init_offset_x+number_offset_x*position+block_offset*4) & (y < init_offset_y+block_offset*3)) ? sevenSegmentNumber[5] : 0;
    assign segBits[4] = ((x > init_offset_x+number_offset_x*position+block_offset*3) 	& (y >  init_offset_y+block_offset*4) 	& (x < init_offset_x+number_offset_x*position+block_offset*4) & (y < init_offset_y+block_offset*6)) ? sevenSegmentNumber[4] : 0;
    assign segBits[3] = ((x > init_offset_x+number_offset_x*position+block_offset) 		& (y >  init_offset_y+block_offset*6) 	& (x < init_offset_x+number_offset_x*position+block_offset*3) & (y < init_offset_y+block_offset*7)) ? sevenSegmentNumber[3] : 0;
	 assign segBits[2] = ((x > init_offset_x+number_offset_x*position) 						& (y >  init_offset_y+block_offset*4) 	& (x < init_offset_x+number_offset_x*position+block_offset)   & (y < init_offset_y+block_offset*6)) ? sevenSegmentNumber[2] : 0;
    assign segBits[1] = ((x > init_offset_x+number_offset_x*position) 						& (y >  init_offset_y+block_offset) 	& (x < init_offset_x+number_offset_x*position+block_offset)   & (y < init_offset_y+block_offset*3)) ? sevenSegmentNumber[1] : 0;
    assign segBits[0] = ((x > init_offset_x+number_offset_x*position+block_offset) 		& (y >  init_offset_y+block_offset*3) 	& (x < init_offset_x+number_offset_x*position+block_offset*3) & (y < init_offset_y+block_offset*4)) ? sevenSegmentNumber[0] : 0;

endmodule