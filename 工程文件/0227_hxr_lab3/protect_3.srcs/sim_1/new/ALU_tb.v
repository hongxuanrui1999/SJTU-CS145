`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 10:49:32
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(

    );
    wire zero;
    wire [31:0] aluRes;
 
    
    wire [31:0] input1;
    wire [31:0] input2;
    wire [3:0] aluCtr;
    
    reg [31:0] Input1;
    reg [31:0] Input2;
    reg [31:0] ALUCtr;
    
    assign input1 = Input1;
    assign input2 = Input2;
    assign aluCtr = ALUCtr;
   
    ALU a0(
        .input1(Input1),
        .input2(Input2),
        .aluCtr(ALUCtr),
        .zero(zero),
        .aluRes(aluRes)
    );
    
initial begin
    Input1 = 0;
    Input2 = 0;
    ALUCtr = 4'b0000;
    
    #100;
    
    #100
        Input1 = 4'b1100;
        Input2 = 4'b0100;
        ALUCtr = 4'b0000;//and
    #100
        Input1 = 4'b1100;
        Input2 = 4'b0100;
        ALUCtr = 4'b0001;//or
     #100
       Input1 = 4'b1001;
       Input2 = 4'b0110;
       ALUCtr = 4'b0010;//add
     #100
       Input1 = 4'b1111;
       Input2 = 4'b0011;
       ALUCtr = 4'b0110;//sub
     #100
       Input1 = 4'b0011;
       Input2 = 4'b1100;
       ALUCtr = 4'b0111;//slt;
     #100
       Input1 = 4'b1001;
       Input2 = 4'b0011;
       ALUCtr = 4'b1100;//nor
     
end 
endmodule
