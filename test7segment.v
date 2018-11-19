\include "segment.v"

module test;

reg A , a ;
a <= 0;

my_segment segment(A,a);
 
// Uses r_VAL_1, r_VAL_2, and r_VAL_3 together to drive a case statement
// This always block is synthesizable
always @(*)
    segment(A,a);
end
 
// *Initial* is never synthesizable.  Test code only!
initial begin
  a <= 1;
  #100;
  a <= 2;
  #100;
  a <= 3;
  #100;
  a <= 4;
  #100;
  a <= 5;
  #100;
  a <= 6;
  #100;
  a <= 7;
  #100;
  a <= 8;
  #100;
  a <= 9;
  #100;
  a <= 0;
  #100;
  #1000000;
  end

  initial 
  begin
  $monitor("A = %b");
  end
endmodule