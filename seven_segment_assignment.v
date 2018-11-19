module seven_segment_assignment (input wire value[0:6], input wire position, input wire x, input wire y);
	parameter init_offset_x=56, init_offset_y=208, number_offset_x=32, block_offset=8;
	
	always @(position)
	if (position>2 && position<5) position<=position+1; //displacement puntos de separacion
	else if (position>4 && position<7) position<=position+2;
	else if (position>7) position<=position+3;
	
	//asignacion y de-asignacion de campos de pixeles por segmento
	assign seg_a_1 = ((x > init_offset_X+number_offset_x*position+8) & (y >  init_offset_y) & (x < init_offset_X+number_offset_x*position+24) & (y < init_offset_y+16)) ? value[0] : 0;
   assign seg_b_1 = ((x > init_offset_X+number_offset_x*position+24) & (y >  init_offset_y+8) & (x < init_offset_X+number_offset_x*position+32) & (y < init_offset_y+24)) ? value[1] : 0;
	assign seg_c_1 = ((x > init_offset_X+number_offset_x*position+24) & (y >  init_offset_y+32) & (x < init_offset_X+number_offset_x*position+32) & (y < init_offset_y+48)) ? value[2] : 0;
	assign seg_d_1 = ((x > init_offset_X+number_offset_x*position+8) & (y >  init_offset_y+48) & (x < init_offset_X+number_offset_x*position+24) & (y < init_offset_y+56)) ? value[3] : 0;
	assign seg_e_1 = ((x > init_offset_X+number_offset_x*position) & (y >  init_offset_y+32) & (x < init_offset_X+number_offset_x*position+8) & (y < init_offset_y+48)) ? value[4] : 0;
	assign seg_f_1 = ((x > init_offset_X+number_offset_x*position) & (y >  init_offset_y+8) & (x < init_offset_X+number_offset_x*position+8) & (y < init_offset_y+24)) ? value[5] : 0;
	assign seg_g_1 = ((x > init_offset_X+number_offset_x*position+8) & (y >  init_offset_y+24) & (x < init_offset_X+number_offset_x*position+24) & (y < init_offset_y+32)) ? value[6] : 0;
	
	endmodule