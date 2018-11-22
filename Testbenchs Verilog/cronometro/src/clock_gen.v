`timescale 10s / 100ms

module clock_gen(clk);
	parameter PERIOD = 0.1;

	output reg clk;

	always
		begin: CLOCK_DRIVER
			clk <= 1'b0;
			#(PERIOD/2);
			clk <= 1'b1;
			#(PERIOD/2);
		end
endmodule