module tpf(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    //input wire RST_BTN,         // reset button
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [4:0] VGA_R,    // 5-bit VGA red output
    output wire [4:0] VGA_G,    // 5-bit VGA green output
    output wire [4:0] VGA_B     // 5-bit VGA blue output
    );

    //wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
    // wire rst = RST_BTN;  // reset is active high on Basys3 (BTNC)

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
	 parameter init_offset_x=56, init_offset_y=208, number_offset_x=32, block_offset=8;
    always @(posedge CLK)
        {pix_stb, cnt} <= cnt + 16'h8000;  // divide by 2: (2^16)/2 = 0x8000

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );

    // Four overlapping squares
    wire sq_a, sq_b, sq_c, sq_d;


    assign VGA_R[3] = sq_b;         // square b is red
    assign VGA_G[3] = sq_a | sq_d;  // squares a and d are green
    assign VGA_B[3] = sq_c;         // square c is blue
endmodule