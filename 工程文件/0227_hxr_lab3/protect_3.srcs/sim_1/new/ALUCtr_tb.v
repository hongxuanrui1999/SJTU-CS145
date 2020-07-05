`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 09:48:53
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALUCtr_tb(

    );
    wire [3:0] aluCtrOut;
    
    reg [1:0] ALUOp;
    reg [5:0] Funct;
    
    
    ALUCtr aluctr(
        .aluOp(ALUOp),
        .funct(Funct),
        .aluCtrOut(aluCtrOut)
    );
   
    
initial begin
    {ALUOp,Funct} = 8'b00000000;
    
    #100;
    
    #100
        {ALUOp,Funct} = 8'b00xxxxxx;
    #100
        {ALUOp,Funct} = 8'bx1xxxxxx;
    #100
        {ALUOp,Funct} = 8'b10xx0000;
    #100
        {ALUOp,Funct} = 8'b10xx0010;
    #100
        {ALUOp,Funct} = 8'b10xx0100;
    #100
        {ALUOp,Funct} = 8'b10xx0101;
    #100
        {ALUOp,Funct} = 8'b10xx1010;
end
endmodule
