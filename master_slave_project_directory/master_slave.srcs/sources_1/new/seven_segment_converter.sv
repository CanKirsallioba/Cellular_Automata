`timescale 1ns / 1ps


module seven_segment_converter(clk,regdisplay,a, b, c, d, e, f, g, dp, an );
    input clk;

    output a;
    output b;
    output c;
    output d;
    output e;
    output f;
    output g;
    output dp;
    output [3:0] an;
    
    input [15:0] regdisplay;
    wire a;
    wire b;
    wire c;
    wire d;
    wire e;
    wire f;
    wire g;
    wire dp;
    wire  [3:0] an;    

    wire [15:0] regdisplay;
    
SevSeg_4digit SevSeg_4digit_instance(clk,regdisplay[3:0],regdisplay[7:4],regdisplay[11:8],regdisplay[15:12],a, b, c, d, e, f, g, dp, an );   
       

    
endmodule
