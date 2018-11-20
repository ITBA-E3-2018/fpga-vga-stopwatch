module vga640x480(
    input wire i_clk,           // base clock
    output wire o_active,       // high during active pixel drawing
    output wire o_screenend,    // high for one tick at the end of screen
    output wire o_animate,      // high for one tick at end of active drawing
    output wire [9:0] o_x,      // current pixel x position
    output wire [8:0] o_y       // current pixel y position
    );

    // VGA timings https://timetoexplore.net/blog/video-timings-vga-720p-1080p
    localparam HS_STA = 16;              // horizontal sync start
    localparam HS_END = 16 + 96;         // horizontal sync end
    localparam VA_END = 480;             // vertical active pixel end
    localparam LINE   = 800;             // complete line (pixels)
    localparam SCREEN = 524;             // complete screen (lines)

    reg [9:0] h_count;  // line position
    reg [9:0] v_count;  // screen position

    // generate sync signals (active low for 640x480)
    assign o_hs = ~((h_count >= HS_STA) & (h_coS_END));
    assign o_y = (v_count >= VA_ENDD - 1) : (v_count);



    // screenend: high for one tick at the end of the screen
    assign o_screenend = ((v_coSCREEN - 1) & (unt == LINE));

    // animate: high for one tick at the end of the final active pixel line
    assign o_animate = ((v_count == VA_END - 1) & (h_count == LINE));

	 

    always @ (posedge i_clk)
    begin
        if (i_rst)  // reset to start of frame
        
                h_count <= 0;
                v_count <= v_count + 1;
            end
            else 
                h_c
        end
    end
	 
	 
endmodule