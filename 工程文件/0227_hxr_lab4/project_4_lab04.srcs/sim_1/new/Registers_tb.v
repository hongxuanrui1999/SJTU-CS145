`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 11:29:13
// Design Name: 
// Module Name: Registers_tb
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


module Registers_tb(
 );
    wire clk;
    wire [25:21] readReg1;
    wire [20:16] readReg2;
    wire [4:0] writeReg;
    wire [31:0] writeData;
    wire regWrite;
    wire [31:0] readData1;
    wire [31:0] readData2;
    
    Registers r0(
        .clk(clk),
        .readReg1(readReg1),
        .readReg2(readReg2), 
        .writeReg(writeReg),
        .writeData(writeData), 
        .regWrite(regWrite), 
        .readData1(readData1), 
        .readData2(readData2)
    );
    parameter PERIOD = 100;
    
    reg [25:21] ReadReg1;
    reg [20:16] ReadReg2;
    reg RegWrite;
    reg [4:0] WriteReg;
    reg [31:0] WriteData;
    reg Clk;
    
    assign readReg1 = ReadReg1;
    assign readReg2 = ReadReg2;
    assign regWrite = RegWrite;
    assign writeReg = WriteReg;
    assign writeData = WriteData;
    assign clk = Clk;
    
    always #(PERIOD) Clk = !Clk;
    
initial begin
    Clk = 1'b0;
    ReadReg1 = 0;
    ReadReg2 = 0;
    WriteReg = 0;
    WriteData = 32'b00000000000000000000000000000000;
    RegWrite = 1'b0;
    
    #200;
    RegWrite = 1'b1;
    WriteReg = 5'b00001;
    WriteData = 32'b11111111111111110000000000000000;
    
    #200;
    RegWrite = 1'b0;
    WriteReg = 5'b00010;
    WriteData = 32'b00000000000000001111111111111111;
    
    #200
     ReadReg1 = 5'b00010;
     ReadReg2 = 5'b00001;
    
    #200;
    RegWrite = 1'b1;
    WriteReg = 5'b00000;
    WriteData = 32'b11111111111111111111111111111111;
    
    #200;
    ReadReg1 = 5'b00001;
    ReadReg2 = 5'b00000;
end
endmodule
