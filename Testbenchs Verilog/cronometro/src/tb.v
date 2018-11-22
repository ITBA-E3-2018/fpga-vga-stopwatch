`include "src/cronometro_all.v"
`include "src/clock_gen.v"

module tb;
    wire clk;
    wire [3:0] s0, s1, m0, m1, h;
    reg enable, reset;

    clock_gen clock0(clk);
    cronometro cronometro0(reset, enable, clk, s0, s1, m0, m1, h);

    initial
    begin
        enable <= 0;
        reset <=1;
        #1
        reset <= 0;
        enable <= 1;
        #500
        $finish;
    end

    reg[8*64:0] dumpfile_path = "output.vcd";

    initial begin
        $dumpfile(dumpfile_path);
        $dumpvars(0, tb);
    end
endmodule