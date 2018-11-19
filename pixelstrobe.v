reg [15:0] cnt;
reg pix_stb; 
always @(posedge CLK)
    {pix_stb, cnt} <= cnt + 16'h8000;  // divide by 2: (2^16)/2 = 0x8000