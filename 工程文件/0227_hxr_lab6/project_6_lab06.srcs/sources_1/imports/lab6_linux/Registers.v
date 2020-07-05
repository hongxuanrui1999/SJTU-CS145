`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 9:10:12
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
    input Clk,
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output reg [31:0] readData1,
    output reg [31:0] readData2,
    input reset
    );
    
    reg [31:0] regFile[31:0];
    reg [5:0] i;
   
   //д�ڴ�
    always @(negedge Clk)
           begin
               if(regWrite)//����д
                   regFile[writeReg] = writeData;
           end
    //���ڴ�
    always @(reset or readReg1 or readReg2 or writeReg)
        begin
            if(reset)//��ʼ��
            begin
                for(i = 0; i < 32; i = i + 1)
                begin
                    regFile[i] = 32'b0;
                end
            end
            readData1 = regFile[readReg1];//�����ڴ�
            readData2 = regFile[readReg2];
        end
endmodule
