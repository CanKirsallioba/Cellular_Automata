`timescale 1ns / 1ps


module test_bench();


    reg pushbutton_reset=0;
    reg clk;    
    reg master=1;
    reg slave=0;
    reg en_cmaster=1;
    reg en_cslave=1;
    wire a;
    wire b;
    wire c;
    wire d;
    wire e;
    wire f;
    wire g;
    wire dp;
    wire  [3:0] an;    
    wire led_cmaster;
    wire led_cslave;
    wire led_master;
    wire led_slave;
    
 initial begin
    clk <=1;
 end
 
 
 always #5ns clk <=~clk; //100mhz period clock
 
top_level top_level_instance(clk,
master,slave,en_cmaster,en_cslave,
led_cmaster,led_cslave,led_master,led_slave,
a, b, c, d, e, f, g, dp, an,pushbutton_reset
   );

endmodule

