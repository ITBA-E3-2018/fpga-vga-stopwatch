`include "src/upcountto6.v"
`include "src/upcountto9.v"

module cronometro(reset, enable, clk, s0, s1, m0, m1, h);
    
    input wire reset, enable, clk;
    output [3:0] s0, s1, m0, m1, h;

    wire cs0, cs1, csm0, cm1, ch;

    upcountto9 upcountto9_s0(reset,clk,enable,s0,cs0);
    upcountto6 upcountto6_s1(reset,cs0,enable,s1,cs1);
    upcountto9 upcountto9_m0(reset,cs1,enable,m0,cm0);
    upcountto6 upcountto6_m1(reset,cm0,enable,m1,cm1);
    upcountto9 upcountto6_h(reset,cm1,enable,h,ch);

endmodule
