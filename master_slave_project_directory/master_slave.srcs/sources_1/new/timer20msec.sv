`timescale 1ms / 1ns

module timer20msec(clk, clk_20msec);
    
    input clk;
    reg [20:0] count =21'b000000000000000000000 ;  //100 Mhz system clock 
    output reg clk_20msec;
    

       
    always_ff @ (posedge clk)
        begin
            count <= count +1;
            if (count < 21'b01110100001001000000) //0-10ms period - 1m clock
            begin
                clk_20msec <= 1'b1;   //clock high
            end
            else if (count == 21'b11110100001001000000) //10-20ms period -2m clock
            begin
                clk_20msec <= 1'b0;//clock low
            end
            if (count == 21'b111101000010001111111) //reset @20ms
            begin
                count <= 21'b000000000000000000000;
            end
        end
    
   
       
endmodule

