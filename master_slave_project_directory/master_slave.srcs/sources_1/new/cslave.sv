`timescale 1ns / 1ps

module cslave(
    en_cslave,slave_case,clk, led,none_case_led_override,master_case,master_previous_case,slave_previous_case,regslave,pushbutton_reset
    );
    //declarations
    input pushbutton_reset;
    input master_case;
    input master_previous_case;
    input slave_previous_case;
    input none_case_led_override;
    input en_cslave;
    input slave_case;
    input clk;
    reg [9:0] count=10'b0000000000;
    output reg led=0;
    output reg [15:0] regslave = 15'b0000000000000000;
    
   
   
    always_ff @ (posedge clk)
        begin
            if (master_case != master_previous_case || slave_case != slave_previous_case)  //detect state change
            begin
                  regslave <= 15'b0000000000000000;  //reset regslave if state changes                  
            end    
            
            if (pushbutton_reset ==1 )
            begin
                regslave <= 15'b0000000000000000;  //reset regslave if pushbutton pressed    
            end
                    
            if (en_cslave ==1)       //check if counting enabled
            begin
                count <= count +1; //increment
                
                if (none_case_led_override==1)  //if none case, led open
                begin
                    led <= 1'b1;       //led on
                end                    
                
                else if (slave_case == 1)  //check if slave case selected, to control slave led
                begin
                    if (count < 10'b0000011001) //0-500ms period
                    begin
                        led <= 1'b1;       //led on
                    end
                    else if (count == 10'b0000011001) //500-1000ms period
                    begin
                        led <= 1'b0;        //led off
                    end
                end 
              
                if (count == 10'b0000110001)   //1000 ms //counteroverflow
                begin
                    
                    count <= 10'b0000000000;   //reset counter
                    
                    regslave <= regslave +1;

                end
            end
        end
    
endmodule