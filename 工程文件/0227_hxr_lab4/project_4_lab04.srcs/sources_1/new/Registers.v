`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 11:16:36
// Design Name: 
// Module Name: Registers
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


module Registers(
    input clk,
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output reg [31:0] readData1,
    output reg [31:0] readData2
    );
    
    reg [31:0] regSets[31:0];
  
    always @ (readReg1 or readReg2 or writeReg)
        begin
            readData1 = regSets[readReg1];
            readData2 = regSets[readReg2];
        end
        
     always @ (negedge clk)
        begin
            if(regWrite==1)
                regSets[writeReg] = writeData;
        end
endmodule
