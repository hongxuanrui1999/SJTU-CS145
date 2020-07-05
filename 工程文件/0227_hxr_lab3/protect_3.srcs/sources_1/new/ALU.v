`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 10:21:53
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] input1,
    input [31:0] input2,
    input [3:0] aluCtr,
    output reg zero,
    output reg [31:0] aluRes
 );

    always @ (input1 or input2 or aluCtr)
    begin
        case(aluCtr)
        4'b0010://add
        begin
            aluRes = input1 + input2;
            if(aluRes == 0)
                zero = 1;
            else 
                zero = 0;
         end
         
         4'b0110://sub
         begin
            aluRes = input1 - input2;
            if(aluRes == 0)
                zero = 1;
            else
                zero = 0;
          end
          
          4'b0000://and
          begin
            aluRes = input1 & input2;
            if(aluRes == 0)
                zero = 1;
            else
                zero = 0;
           end
                
          4'b0001://or
          begin
            aluRes = input1|input2;
            if(aluRes == 0)
                zero = 1;
             else
                zero = 0;
           end
           
           4'b0111://stl
           begin
             if(input1 < input2)
                begin
                    aluRes = 1;
                    zero = 0;
                 end
             else
                begin
                    aluRes = 0;
                    zero = 1;
                 end
            end
            
            4'b1100://nor
            begin
                aluRes = ~(input1|input2);
                if(aluRes == 0)
                    zero = 1;
                else
                    zero = 0;
            end
        endcase
    end   
endmodule
