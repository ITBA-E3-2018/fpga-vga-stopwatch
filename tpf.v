module tpf( //Entradas y salidas asignadas a pines físicos en la FPGA.
    input wire CLK,             // Clock de la FPGA: 50Mhz para Altera De0-Nano EP4CE22F17C6N
    input wire RST_BTN,			  // Botón físico en la placa.
	 input wire startstopbtn,	  // Botón físico en la placa.
    output wire VGA_HS_O,       // Output de sincronización horizontal.
    output wire VGA_VS_O,       // Output de sincronización vertical.
	 output wire [4:0] VGA_Ro,   // Output de 5 bits por canal para   
	 output wire [4:0] VGA_Go,   // salida de color RGB por los pines  
	 output wire [4:0] VGA_Bo    // a un DAC: conversor digital-analógico.  
	 );

   
	 
   
 
	 // MANEJO DE CLOCKS
	 
	 wire vga_clk;			// Declaración de los clocks a ser utilizados para el manejo del cronómetro y
	 wire second_clk;		// de la pantalla.

	 //Asignación de los clocks mediante divisores de clock:
	 
	 clockdivider vga_clockinst(  
	 .boardCLK(CLK),
	 .divider(2),
	 .clk_out(vga_clk)
	 );
	 
	 
	 clockdivider meter_clockinst(
	 .boardCLK(CLK),
	 .divider(25000000),
	 .clk_out(second_clk)
	 );

	 
	
	 // MANEJO DE VGA

	 wire [9:0] x;  // Posición actual en pantalla activa: coordenada x.
    wire [8:0] y;  // Posición actual en pantalla activa: coordenada y.
    
	 // Se define una instancia del módulo de control de VGA, dándole valores a las coordenadas actuales:
	 
	 vga_display displayinst(
        .board_clk(CLK),
        .my_clk(vga_clk),
        .rst(0),
        .hs(VGA_HS_O), 
        .vs(VGA_VS_O), 
        .currentX(x), 
        .currentY(y)
    );

	
	 // MANEJO DE BOTONES FÍSICOS DE START/STOP Y RESET: Máquina de estados finitos.
	
	 // La máquina de estados para botones genera un pulso en el flanco ascendente de ambos botones
	 // y devuelve, en estos cables, los pulsos:
	 wire startstop; 
	 wire reset;
		
	 // La máquina de estados de enable devuelve una señal que togglea con un botón, 
	 // según la cual el cronómetro cuenta o no (Active High):
	 wire enable;
	
	 // Se definen instancias de los módulos correspondientes estas FSMs para el manejo de los botones:
	 fsm_boton inst8(
	 .clk(CLK),
	 .btn(RST_BTN),
	 .signal(reset)
	 );
	 
	 fsm_boton inst7(
	 .clk(CLK),
	 .btn(startstopbtn),
	 .signal(startstop)
	 );
	 
	 
	 fsm_enable inst6(
	 .clk(CLK),
	 .signal(startstop),
	 .enable_count(enable)
	 );
	 
	 // MANEJO DEL CRONÓMETRO
	 
	 // Se define la instancia del cronómetro, que devolverá por estos cables...
	
	 wire [6:0] hoursd;   // En formato binario: Horas
	 wire [6:0] mindecd;  // En formato binario: Décadas de minutos
	 wire [6:0] mind;     // En formato binario: Minutos
	 wire [6:0] secdecd;  // En formato binario: Décadas de segundos
	 wire [6:0] secd; 	 // En formato binario: Segundos
	
	 // ...cinco valores correspondientes a H:MM:SS:
	 
	 cronometro inst0(
	 .reset(reset),
	 .enable(enable),
	 .clk(second_clk),
	 .s0(secd),
	 .s1(secdecd),
	 .m0(mind),
	 .m1(mindecd),
	 .h(hoursd)
	 );
	 
	 // MANEJO DEL DIBUJO EN DISPLAY
	 
	 // Parámetros fijos para centrar el cronómetro y definir sus anchos:
	 parameter init_offset_x=188, init_offset_y=236, number_blocks_x=4, block_offset=8; // Offsets iniciales, del 7 segmentos en bloques y ancho del bloque en píxeles.
	 
	 // Definicion de instancias de módulos para convertir valores del cronómetro
	 // de binario a formato estándar de siete segmentos:
	 
	 wire [6:0] hours;    // En formato de 7 segmentos: Horas
	 wire [6:0] mindec;   // En formato de 7 segmentos: Décadas de minutos
	 wire [6:0] min;    	 // En formato de 7 segmentos: Minutos
	 wire [6:0] secdec;   // En formato de 7 segmentos: Décadas de segundos
	 wire [6:0] sec; 		 // En formato de 7 segmentos: Segundos
	
 	 bin_to_segments inst1(
	 .segments(sec),
	 .digit(secd)
	 );
	 
	 bin_to_segments inst2(
	 .segments(secdec),
	 .digit(secdecd)
	 );
	 
	 bin_to_segments inst3(
	 .segments(min),
	 .digit(mind)
	 );
	 
	 bin_to_segments inst4(
	 .segments(mindec),
	 .digit(mindecd)
	 );
	 
	 bin_to_segments inst5(
	 .segments(hours),
	 .digit(hoursd)
	 );
	 
	 // Definición de cables para pintado de segmentos:
	 
	 wire [6:0]	hoursSegments;
	 wire [6:0]	mindecSegments;
	 wire [6:0]	minSegments;
	 wire [6:0] secdecSegments;
	 wire [6:0] secSegments; 
    wire dot1, dot2, dot3, dot4;
	
	 // Se definen instancias del módulo "de asignación" para cada dígito de 7 segmentos.
	 // Este módulo devuelve un bus de 7 bits, cada uno de los cuales está asignado a un segmento
	 // y está en estado HIGH cuando las coordenadas de x e y se encuentran dentro de éste, en el caso 
	 // de que deba estar encendido. De no estar encendido el segmento o no corresponder las coordenadas,
	 // devuelve LOW.
	 
	 segmentAssignment hoursinst(
	 .x(x),
	 .y(y),
	 .position(3'b001),
	 .sevenSegmentNumber(hours),
	 .segBits(hoursSegments),
	 .init_offset_x(init_offset_x),
	 .init_offset_y(init_offset_y),
	 .number_blocks_x(number_blocks_x),
	 .block_offset(block_offset),
	 );
	 
	 segmentAssignment minutesdecinst(
	 .x(x),
	 .y(y),
	 .position(3'b011),
	 .sevenSegmentNumber(mindec),
	 .segBits(mindecSegments),
	 .init_offset_x(init_offset_x),
	 .init_offset_y(init_offset_y),
	 .number_blocks_x(number_blocks_x),
	 .block_offset(block_offset),
	 
	 );
	 
	 segmentAssignment minutesinst(
	 .x(x),
	 .y(y),
	 .position(3'b100),
	 .sevenSegmentNumber(min),
	 .segBits(minSegments),
	 .init_offset_x(init_offset_x),
	 .init_offset_y(init_offset_y),
	 .number_blocks_x(number_blocks_x),
	 .block_offset(block_offset),
	 
	 );
	 
	 segmentAssignment secondsdecinst(
	 .x(x),
	 .y(y),
	 .position(3'b110),
	 .sevenSegmentNumber(secdec),
	 .segBits(secdecSegments),
	 .init_offset_x(init_offset_x),
	 .init_offset_y(init_offset_y),
	 .number_blocks_x(number_blocks_x),
	 .block_offset(block_offset),
	 
	 );
	 
	 segmentAssignment secondsinst(
	 .x(x),
	 .y(y),
	 .position(3'b111),
	 .sevenSegmentNumber(sec),
	 .segBits(secSegments),
	 .init_offset_x(init_offset_x),
	 .init_offset_y(init_offset_y),
	 .number_blocks_x(number_blocks_x),
	 .block_offset(block_offset),
	 
	 );
		 
	 
	 // Se asignan los cables que informan el estado de los píxeles para los puntos de separación:
	 wire [15:0] number_offset_x= block_offset*number_blocks_x;
	  //Parámetros de centro del w
	 assign dot1 = ((x > init_offset_x+number_offset_x*2+block_offset) & (y >  init_offset_y+block_offset*2) & (x < init_offset_x+number_offset_x*2+block_offset*2) & (y < init_offset_y+block_offset*3)) ? 1 : 0;
	 assign dot2 = ((x > init_offset_x+number_offset_x*2+block_offset) & (y >  init_offset_y+block_offset*4) & (x < init_offset_x+number_offset_x*2+block_offset*2) & (y < init_offset_y+block_offset*5)) ? 1 : 0;
	 assign dot3 = ((x > init_offset_x+number_offset_x*5+block_offset) & (y >  init_offset_y+block_offset*2) & (x < init_offset_x+number_offset_x*5+block_offset*2) & (y < init_offset_y+block_offset*3)) ? 1 : 0;
	 assign dot4 = ((x > init_offset_x+number_offset_x*5+block_offset) & (y >  init_offset_y+block_offset*4) & (x < init_offset_x+number_offset_x*5+block_offset*2) & (y < init_offset_y+block_offset*5)) ? 1 : 0;
	 
	 // Se asigna a los buses de 5 bits por canal RGB para los distintos colores a la salida de los cables que
	 // la función de asignación genera: de este modo, cuando las coordenadas del píxel están sobre algo que debe ser mostrado
	 // en pantalla, las salidas de control de voltaje de los buses RGB estarán en HIGH, dándole color al píxel en cuestión.
	 
	 assign VGA_Ro[2] =  |hoursSegments | |mindecSegments | |minSegments | |secdecSegments | |secSegments; // Se hace un OR
	 assign VGA_Go[3] =  |hoursSegments | |mindecSegments | |minSegments | |secdecSegments | |secSegments; // lógico entre los
	 assign VGA_Bo[4] =  |hoursSegments | |mindecSegments | |minSegments | |secdecSegments | |secSegments; // bits de cada bus,
																																			 // y luego otro OR de los
																																			 // resultados.
	 assign VGA_Ro[4]= dot1 | dot2 | dot3 | dot4 ;
	 assign VGA_Go[4]= dot1 | dot2 | dot3 | dot4 ; 
		 
endmodule
