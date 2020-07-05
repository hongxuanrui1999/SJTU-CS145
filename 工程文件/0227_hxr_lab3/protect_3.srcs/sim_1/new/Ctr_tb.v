`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 08:54:26
// Design Name: 
// Module Name: Ctr_tb
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


module Ctr_tb(

    );
    wire [5:0] opCode;
    wire regDst;
    wire aluSrc;
    wire memToReg;
    wire regWrite;
    wire branch;
    wire [1:0] aluOp;
    wire jump;
    
    reg [5:0] OpCode;
    
    Ctr mainCtr(
        .opCode(opCode),
        .regDst(regDst),
        .aluSrc(aluSrc),
        .memToReg(memToReg),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .branch(branch),
        .aluOp(aluOp),
        .jump(jump)
);
    assign opCode = OpCode;
    
initial begin
    //Initialize Inputs
    OpCode = 0;
    
    //Wait 100ns for global reset to finish
    #100;
    
    #100 
        OpCode = 6'b000000;//R-type
    #100 
        OpCode = 6'b100011;//lw
    #100 
        OpCode = 6'b101011;//sw
    #100   
        OpCode = 6'b000100;//beq
    #100 
        OpCode = 6'b000010;//Jump
end

endmodule
