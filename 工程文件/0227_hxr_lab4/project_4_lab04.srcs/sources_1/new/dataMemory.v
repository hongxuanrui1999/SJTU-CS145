`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 09:12:28
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output reg [31:0] readData
    );
    
    reg [31:0] memSets[63:0];
   
    always @(address or memRead or clk)
        begin
            if(memRead)
                readData = memSets[address];
        end
     
     always @(negedge clk)
        begin
            if(memWrite)
                memSets[address] = writeData;
        end
        
endmodule
