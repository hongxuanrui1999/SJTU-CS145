`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 09:18:58
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb(

    );
    
    wire clk;
    wire [31:0] address;
    wire [31:0] writeData;
    wire memWrite;
    wire memRead;
    wire [31:0] readData;
    
    dataMemory m0(
        .clk(clk), 
        .address(address), 
        .writeData(writeData), 
        .memWrite(memWrite), 
        .memRead(memRead), 
        .readData(readData)
     );
     
     parameter PERIOD = 100;
     
     reg Clk;
     reg [31:0] Address;
     reg [31:0] WriteData;
     reg MemWrite;
     reg MemRead;
     
     assign clk = Clk;
     assign address = Address;
     assign writeData = WriteData;
     assign memWrite = MemWrite;
     assign memRead = MemRead;
     
     always #(PERIOD) Clk = !Clk;
     
initial begin
    Clk = 1'b0;
    Address = 32'b00000000000000000000000000000000;
    WriteData = 32'b00000000000000000000000000000000;
    MemWrite = 1'b1;
    MemRead = 1'b0;
    
     #100
     MemWrite = 0;//¶Á£¬²»Ð´
     MemRead = 1'b1;
     
    #100;
    MemWrite = 1'b1;//Ð´£¬²»¶Á
    MemRead = 1'b0;
    Address = 32'b00000000000000000000000000000011;
    WriteData = 32'b00000000000000000000000000000011;
    
     #100
     MemWrite = 0;//¶Á£¬²»Ð´
     MemRead = 1'b1;
       
    #100
    MemWrite = 1'b1;//Ð´¡£²»¶Á
    MemRead = 1'b0;
    Address = 32'b00000000000000000000000000000010;
    WriteData = 32'b00000000000000000000000000000010;
   
    #100
    MemWrite = 0;//¶Á£¬²»Ð´
    MemRead = 1'b1;
   
   
end
endmodule
