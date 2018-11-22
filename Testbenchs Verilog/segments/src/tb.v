`include "src/bin_to_segments.v"

module tb;

    wire [6:0] segments;
    reg [3:0] digit;
    reg enable;
    bin_to_segments bin_to_segments0(segments, digit, enable);

    initial
    begin
        enable = 0;
        #1
        enable = 1;
        #1
        digit = 0;
        #1
        digit = 1;
        #1
        digit = 2;
        #1
        digit = 3;
        #1
        digit = 4;
        #1
        digit = 5;
        #1
        digit = 6;
        #1
        digit = 7;
        #1
        digit = 8;
        #1
        digit = 9;
        #1
        $finish;
    end

    reg[8*64:0] dumpfile_path = "output.vcd";

    initial begin
        $dumpfile(dumpfile_path);
        $dumpvars(0, tb);
    end

endmodule