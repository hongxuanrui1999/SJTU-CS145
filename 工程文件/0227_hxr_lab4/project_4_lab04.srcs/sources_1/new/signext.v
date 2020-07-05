`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 09:42:13
// Design Name: 
// Module Name: signext
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


module signext(
    input [15:0] init,
    output reg [31:0] data
    );
    
    always @(init)
    begin
    if(init[15]== 1'b0)
        begin
            data = 32'b00000000000000000000000000000000;
            data [15:0] = init;
         end
     else
        begin
            data = 32'b11111111111111111111111111111111;
            data [15:0] = init;
        end
     end
     
endmodule
