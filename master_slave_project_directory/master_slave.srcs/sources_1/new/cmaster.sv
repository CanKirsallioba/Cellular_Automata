`timescale 1ns / 1ps


module cmaster(
    en_cmaster,master_case,clk, led,none_case_led_override,slave_case,master_previous_case,slave_previous_case,regmaster,pushbutton_reset
    );
    input pushbutton_reset;
    input slave_case;
    input slave_previous_case;
    input master_previous_case;
    input none_case_led_override;
    input master_case;
    input en_cmaster;
    input clk;
    reg [9:0] count=10'b0000000000;
    output reg led=0;
    output reg [15:0] regmaster= 16'b0000000000000000;
    
    
   
    always_ff @ (posedge clk)
        begin
            if (master_case != master_previous_case || slave_case != slave_previous_case)  //detect state change
            begin
                  regmaster <= 16'b0000000000000000; //reset regmaster if master/slave case changes
            end    
            
            if (pushbutton_reset ==1)  //detect pushbutton
            begin
                  regmaster <= 16'b0000000000000000; ////reset regmaster if pushbutton pressed
            end
        
            if (en_cmaster)     //check if counting enabled
            begin
                count <= count +1;       //counter increment
                
                if (master_case ==1)    //check if master case selected to blink leds
                begin
                    if (count < 10'b0000110010  )    //0-1 ms preiod 
                    begin
                            led <= 1'b1;               //led on
                    end
                    else if (count == 10'b0000110010) //1-2 ms period
                    begin
                    led <= 1'b0;                    //led off
                    end
                end
                    
                if (count == 10'b0001100011)    //reset counter @2ms
                begin
                    count <= 10'b0000000000;    //reset cmaster counter
                        
                    regmaster <= regmaster+1;  // increment regmaster
                end
            end
        end
    
endmodule