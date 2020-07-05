`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 08:59:50
// Design Name: 
// Module Name: ALUCtr
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


module ALUCtr(
    input [1:0] aluOp,
    input [5:0] funct,
    input [5:0] opCode,
    output reg [3:0] aluCtrOut
    );
    
    always @ (aluOp or funct)
    begin
        casex ({aluOp,funct})
            8'b00xxxxxx:
                aluCtrOut = 4'b0010;//addi
            
            8'b01xxxxxx:
                aluCtrOut = 4'b0110;//beq
            
            8'b1xxx0000:
                aluCtrOut = 4'b0010;//add
            
            8'b1xxx0010:
                aluCtrOut = 4'b0110;//sub
            
            8'b1xxx0100:
                aluCtrOut = 4'b0000;//and
            
            8'b1xxx0101:
                aluCtrOut = 4'b0001;//or
            
            8'b1x101010:
                aluCtrOut = 4'b0111;//stl
                
            8'b10000000:
                aluCtrOut = 4'b0011;//◊Û“∆
            
            8'b10000010:
                aluCtrOut = 4'b0100;//”““∆
                
            8'b10100111:
                aluCtrOut = 4'b1100;
                
            8'b11xxxxxx:
            begin
                case(opCode)
                6'b001100:
                    aluCtrOut = 4'b0000;//andi
                6'b001101:
                    aluCtrOut = 4'b0001;//ori
                endcase
            end
        endcase
    end
endmodule
