`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 11:10:43
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
    input Clk,
    input memWrite,
    input memRead,
    input [31:0] address,
    input [31:0] writeData,
    output reg [31:0] readData
    );
    
    reg [31:0] memFile[63:0];
    
    initial
	   begin
            $readmemh("C:/archlabs/project_6_lab06/project_6_lab06.srcs/mem_data.txt",memFile,10'h0);
	   end
    
    always @(negedge Clk)
            begin
                if(memWrite)
                    memFile[address] = writeData;
            end
    always @(address or memRead or Clk)
        begin
            if(memRead)
                readData = memFile[address];
        end
endmodule
