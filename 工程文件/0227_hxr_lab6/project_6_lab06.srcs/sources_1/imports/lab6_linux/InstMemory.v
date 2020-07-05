`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 08:09:56
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input [31:0] ReadAddr,
    output reg [31:0] Inst
    );
    reg [31:0] memFile[63:0];
   
    initial
	   begin
		  $readmemb("C:/archlabs/project_6_lab06/project_6_lab06.srcs/mem_inst",memFile,8'h0);
	   end
    always @(ReadAddr)
        begin
            inst <= memFile[ReadAddr >> 2];
        end
endmodule
