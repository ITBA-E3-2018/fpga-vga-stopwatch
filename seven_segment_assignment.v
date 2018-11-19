module seven_segment_assignment (input wire value[0:6], input wire position_original, input wire x, input wire y);
	parameter init_offset_x=56, init_offset_y=208, number_offset_x=32, block_offset=8;
	reg position;
	always @(value)
	if (position_original>2 && position_original<5) position<=position_original+1; //displacement puntos de separacion
	else if (position_original>4 && position_original<7) position<=position_original+2;
	else if (position_original>7) position<=position_original+3;

	//asignacion y de-asignacion de campos de pixeles por segmento
	assign seg_a_1 = ((x > init_offset_X+number_offset_x*position+8) & (y >  init_offset_y) & (x < init_offset_X+number_offset_x*position+24) & (y < init_offset_y+16)) ? value[0] : 0;
   assign seg_b_1 = ((x > init_offset_X+number_offset_x*position+24) & (y >  init_offset_y+8) & (x < init_offset_X+number_offset_x*position+32) & (y < init_offset_y+24)) ? value[1] : 0;
	assign seg_c_1 = ((x > init_offset_X+number_offset_x*position+24) & (y >  init_offset_y+32) & (x < init_offset_X+number_offset_x*position+32) & (y < init_offset_y+48)) ? value[2] : 0;
	assign seg_d_1 = ((x > init_offset_X+number_offset_x*position+8) & (y >  init_offset_y+48) & (x < init_offset_X+number_offset_x*position+24) & (y < init_offset_y+56)) ? value[3] : 0;
	assign seg_e_1 = ((x > init_offset_X+number_offset_x*position) & (y >  init_offset_y+32) & (x < init_offset_X+number_offset_x*position+8) & (y < init_offset_y+48)) ? value[4] : 0;
	assign seg_f_1 = ((x > init_offset_X+number_offset_x*position) & (y >  init_offset_y+8) & (x < init_offset_X+number_offset_x*position+8) & (y < init_offset_y+24)) ? value[5] : 0;
	assign seg_g_1 = ((x > init_offset_X+number_offset_x*position+8) & (y >  init_offset_y+24) & (x < init_offset_X+number_offset_x*position+24) & (y < init_offset_y+32)) ? value[6] : 0;
	
	endmodule