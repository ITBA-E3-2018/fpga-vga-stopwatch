`include "src/clock_gen.v"
`include "src/fsm_boton.v" 
`include "src/fsm_enable.v"

module testbench_fsm;
    wire clk, signal, enable;
    reg btn;

    clock_gen clock0(clk);
    fsm_boton fsm_boton0(clk, btn, signal);
    fsm_enable fsm_enable0(clk, signal, enable);

    initial
    begin
        btn = 0;
        #3
        btn = 1;
        #10
        btn = 0;
        #10
        btn = 1;
        #10
        btn = 0;
        #10
        $finish;
    end

    reg[8*64:0] dumpfile_path = "output.vcd";

    initial begin
        $dumpfile(dumpfile_path);
        $dumpvars(0, testbench_fsm);
    end
endmodule