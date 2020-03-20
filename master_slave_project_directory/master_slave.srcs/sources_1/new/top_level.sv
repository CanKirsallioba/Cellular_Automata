`timescale 1ns / 1ps


module top_level(clk,
master,slave,en_cmaster,en_cslave,
led_cmaster,led_cslave,led_master,led_slave,
a, b, c, d, e, f, g, dp, an,pushbutton_reset
    );
    input clk;
    input master;
    input slave;
    input en_cmaster;
    input en_cslave;
    input pushbutton_reset;
    
    output reg led_cmaster;
    output reg led_cslave;
    output led_master;
    output led_slave;
        
    output a;
    output b;
    output c;
    output d;
    output e;
    output f;
    output g;
    output dp;
    output [3:0] an;
    
   
    reg [15:0] regdisplay= 16'b0000000000000000;
    
    reg none_case_led_override=0;
    reg master_previous_case=0;
    reg slave_previous_case=0;
    reg master_case=0;
    reg slave_case=0;
    wire [15:0] regslave;
    wire [15:0] regmaster;
    
    wire a;
    wire b;
    wire c;
    wire d;
    wire e;
    wire f;
    wire g;
    wire dp;
    wire  [3:0] an;    
    
    wire  [6:0] display_0;
    wire  [6:0] display_1;
    wire  [6:0] display_2;
    wire  [6:0] display_3;
    
    timer20msec timer20msec_instance(clk,clk_20ms);   
       
    cmaster cmaster_instance(en_cmaster,master_case,clk_20ms, led_master,none_case_led_override,slave_case,master_previous_case,slave_previous_case,regmaster,pushbutton_reset);
    cslave cslave_instance(en_cslave,slave_case,clk_20ms, led_slave,none_case_led_override,master_case,master_previous_case,slave_previous_case,regslave,pushbutton_reset);
    
    seven_segment_converter seven_segment_converter_instance(clk,regdisplay,a, b, c, d, e, f, g, dp, an );
    
    
     always_ff @ (posedge clk)
        begin
        
            if ( master == 1'b1 )       //master case
            begin
                master_case <= 1;
                slave_case <=0;
                regdisplay <=regmaster;
                none_case_led_override=0;
            end 
            
            if ( slave == 1'b1 && master == 1'b0)   //slave case
            begin
                master_case <= 0;
                slave_case <=1;
                regdisplay <=regslave;
                none_case_led_override=0;
            end
            
            if ( slave == 1'b0 && master == 1'b0)    //0-0 case
            begin
                if (en_cmaster == 1'b1)      //master case
                begin
                    master_case <= 1;
                    slave_case <=0;
                    regdisplay <=regmaster; 
                    none_case_led_override=0;        
                end
                
                else if (en_cmaster == 1'b0 && en_cslave==1'b1)   //slave case
                begin
                    master_case <= 0;
                    slave_case <=1;
                    regdisplay <=regslave; 
                    none_case_led_override=0;         
                end
                
                else if (en_cmaster == 1'b0 && en_cslave==1'b0)  //"none" case
                    regdisplay <=15'b0000000000000000; 
                     none_case_led_override=1;       
            end
            
        
            master_previous_case <=master_case;
            slave_previous_case <= slave_case;
            
            led_cmaster <= en_cmaster;
            led_cslave <= en_cslave;
        end
    
    
endmodule
