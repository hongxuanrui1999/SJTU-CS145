`include "ALU.v"
`include "ALUCtr.v"
`include "ctr.v"
`include "dataMemory.v"
`include "InstMemory.v"
`include "Registers.v"
`include "signext.v"
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 08:30:23
// Design Name: 
// Module Name: Top
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


module Top(
    input clk,
    input reset
    );
    //PC
    reg [31:0] PC;

    //for IF to ID
    reg [31:0] IF_ID_PCADD4;//普通类型指令后pc更新的指令地址
    reg [31:0] IF_ID_INST;//指令
    
    //for ID to EX
    reg [31:0] ID_EX_PCADD4;
    reg [31:0] ID_EX_ReadData1;
    reg [31:0] ID_EX_ReadData2;
    reg [31:0] ID_EX_SIGNEXT;
    reg [4:0] ID_EX_INST_HIGH; 
    reg [4:0] ID_EX_INST_LOW; 
    
    //to EX
    reg [1:0] ID_EX_ALUOp;
    reg ID_EX_RegDst;
    reg ID_EX_ALUSrc;
    
    //to MEM
    reg ID_EX_Branch;
    reg ID_EX_MemWrite;
    reg ID_EX_MemRead;
    reg ID_EX_Jump;
    
    //to WB
    reg ID_EX_RegWrite;
    reg ID_EX_MemToReg;

    //for EX to MEM
    reg [31:0] EX_MEM_BranchAddr;
    reg EX_MEM_ZERO;
    reg [31:0] EX_MEM_ALURes;
    reg [31:0] EX_MEM_ReadData2;
    reg [4:0] EX_MEM_INST_HL;
    
    //to MEM
    reg EX_MEM_Branch;
    reg EX_MEM_MemWrite;
    reg EX_MEM_MemRead;

    
    //to WB 
    reg EX_MEM_RegWrite;
    reg EX_MEM_MemToReg;
    

    //for MEM to WB
    reg [31:0] MEM_WB_ReadData;
    reg [31:0] MEM_WB_ALURes;
    reg [4:0] MEM_WB_INST_HL;
    
    //to WB
    reg MEM_WB_RegWrite;
    reg MEM_WB_MemToReg;
    
    //Wires
    //IF
    wire [31:0] PC_Add4;
    wire [31:0] NewPC;
    wire [31:0] IF_INST;

    //ID
    wire [31:0] ID_INST;
    wire ID_MemToReg;
    wire ID_Branch;
    wire ID_MemWrite;
    wire [31:0] ID_ReadData1;
    wire [31:0] ID_ReadData2;
    wire [31:0] ID_SignExt;
    wire ID_MemRead;
    wire ID_Jump;
    wire ID_RegDst;
    wire [1:0] ID_ALUOp;
    wire ID_RegWrite;
    wire ID_ALUSrc;
   

    //EX
    wire [31:0] EX_ALUOperand2;
    wire [3:0] EX_ALUCtr;
    wire [31:0] EX_BranchAddr;
    wire EX_ALUZero;
    wire [31:0] EX_ALURes;
    wire [4:0] EX_INST_HL;

    //MEM
    wire MEM_PCSrc;    
    wire [31:0] MEM_ReadData;

    //WB
    wire [31:0] WB_WriteData;

   
    assign PC_Add4 = PC + 4;
    assign NewPC = MEM_PCSrc ? EX_MEM_BranchAddr : PC_Add4;
    
    //EX
    assign EX_BranchAddr = (ID_EX_SIGNEXT << 2) + PC_Add4;
    assign EX_INST_HL = ID_EX_RegDst ? ID_EX_INST_LOW : ID_EX_INST_HIGH;
    assign EX_ALUOperand2 = ID_EX_ALUSrc ? ID_EX_SIGNEXT : ID_EX_ReadData2;

    //MEM
    assign MEM_PCSrc = EX_MEM_Branch & EX_MEM_ZERO;

    //WB
    assign WB_WriteData = MEM_WB_MemToReg ? MEM_WB_ReadData : MEM_WB_ALURes;
    
    Ctr c0(
        IF_ID_INST[31:26],
        ID_RegDst,
        ID_ALUSrc,
        ID_MemToReg,
        ID_RegWrite,
        ID_MemRead,
        ID_MemWrite,
        ID_Branch,
        ID_ALUOp,
    );
   
    ALU a0(
        ID_EX_ReadData1,
        EX_ALUOperand2,
        EX_ALUCtr,
        ID_EX_SIGNEXT[10:6],
        EX_ALUZero,
        EX_ALURes
    );

    ALUCtr ac0(
        ID_EX_ALUOp,
        ID_EX_SIGNEXT[5:0],
        EX_ALUCtr
    );

    Registers r0(
        clk,
        IF_ID_INST[25:21],
        IF_ID_INST[20:16],
        MEM_WB_INST_HL,
        WB_WriteData,
        MEM_WB_RegWrite,
        ID_ReadData1,
        ID_ReadData2,
        reset
    );

    dataMemory d0(
        clk,
        EX_MEM_MemWrite,
        EX_MEM_MemRead,
        EX_MEM_ALURes,
        EX_MEM_ReadData2,
        MEM_ReadData
    );

    InstMemory i0(
        PC,
        IF_INST
    );

    signext s0(
        IF_ID_INST[15:0],
        ID_SignExt
    );

    always @(posedge clk)
    begin
        if(reset)
        begin
            PC <= 0;

            IF_ID_PCADD4 <= 0;
            IF_ID_INST <= 0;

            ID_EX_PCADD4 <= 0;
            ID_EX_ReadData1 <= 0;
            ID_EX_ReadData2 <= 0;
            ID_EX_SIGNEXT <= 0;
            ID_EX_INST_HIGH <= 0;
            ID_EX_INST_LOW <= 0;
            ID_EX_RegWrite <= 0;
            ID_EX_MemToReg <= 0;
            ID_EX_Branch <= 0;
            ID_EX_MemWrite <= 0;
            ID_EX_MemRead <= 0;
            ID_EX_RegDst <= 0;
            ID_EX_ALUOp <= 0;
            ID_EX_ALUSrc <= 0;

            EX_MEM_BranchAddr <= 0;
            EX_MEM_ZERO <= 0;
            EX_MEM_ALURes <= 0;
            EX_MEM_ReadData2 <= 0;
            EX_MEM_INST_HL <= 0;
            EX_MEM_RegWrite <= 0;
            EX_MEM_MemToReg <= 0;
            EX_MEM_Branch <= 0;
            EX_MEM_MemWrite <= 0;
            EX_MEM_MemRead <= 0;

            MEM_WB_ReadData <= 0;
            MEM_WB_ALURes <= 0;
            MEM_WB_INST_HL <= 0;
            MEM_WB_RegWrite <= 0;
            MEM_WB_MemToReg <= 0;
        end
        else if(EX_MEM_Branch)
        begin
            IF_ID_INST <= 0;
            PC <= NewPC;
            EX_MEM_Branch <= 0;
            MEM_WB_ReadData <= MEM_ReadData;
            MEM_WB_ALURes <= EX_MEM_ALURes;
            MEM_WB_INST_HL <= EX_MEM_INST_HL;
            MEM_WB_RegWrite <= EX_MEM_RegWrite;
            MEM_WB_MemToReg <= EX_MEM_MemToReg;
        end
        
        else if(ID_EX_Branch)
        begin
            IF_ID_INST <= 0;
            PC <= PC;
            EX_MEM_INST_HL <= EX_INST_HL;
            EX_MEM_BranchAddr <= EX_BranchAddr;
            EX_MEM_ZERO <= EX_ALUZero;
            EX_MEM_RegWrite <= ID_EX_RegWrite;
            EX_MEM_MemWrite <= ID_EX_MemWrite;
            EX_MEM_MemRead <= ID_EX_MemRead;
            EX_MEM_ALURes <= EX_ALURes;
            EX_MEM_ReadData2 <= ID_EX_ReadData2;
            EX_MEM_MemToReg <= ID_EX_MemToReg;
            EX_MEM_Branch <= ID_EX_Branch;
            MEM_WB_ReadData <= MEM_ReadData;
            MEM_WB_INST_HL <= EX_MEM_INST_HL;
            MEM_WB_RegWrite <= EX_MEM_RegWrite;
            MEM_WB_MemToReg <= EX_MEM_MemToReg;
            MEM_WB_ALURes <= EX_MEM_ALURes;
            ID_EX_Branch <= 0;
        end
        else
        begin
            PC <= NewPC;

            IF_ID_PCADD4 <= PC_Add4;
            IF_ID_INST <= IF_INST;

            ID_EX_PCADD4 <= IF_ID_PCADD4;
            ID_EX_ReadData1 <= ID_ReadData1;
            ID_EX_ReadData2 <= ID_ReadData2;
            ID_EX_SIGNEXT <= ID_SignExt;
            ID_EX_INST_HIGH <= IF_ID_INST[20:16];
            ID_EX_INST_LOW <= IF_ID_INST[15:11];
            ID_EX_RegWrite <= ID_RegWrite;
            ID_EX_MemToReg <= ID_MemToReg;
            ID_EX_Branch <= ID_Branch;
            ID_EX_MemWrite <= ID_MemWrite;
            ID_EX_MemRead <= ID_MemRead;
            ID_EX_Jump <= ID_Jump;
            ID_EX_RegDst <= ID_RegDst;
            ID_EX_ALUOp <= ID_ALUOp;
            ID_EX_ALUSrc <= ID_ALUSrc;

            EX_MEM_BranchAddr <= EX_BranchAddr;
            EX_MEM_ZERO <= EX_ALUZero;
            EX_MEM_ALURes <= EX_ALURes;
            EX_MEM_ReadData2 <= ID_EX_ReadData2;
            EX_MEM_INST_HL <= EX_INST_HL;
            EX_MEM_RegWrite <= ID_EX_RegWrite;
            EX_MEM_MemToReg <= ID_EX_MemToReg;
            EX_MEM_Branch <= ID_EX_Branch;
            EX_MEM_MemWrite <= ID_EX_MemWrite;
            EX_MEM_MemRead <= ID_EX_MemRead;

            MEM_WB_ReadData <= MEM_ReadData;
            MEM_WB_ALURes <= EX_MEM_ALURes;
            MEM_WB_INST_HL <= EX_MEM_INST_HL;
            MEM_WB_RegWrite <= EX_MEM_RegWrite;
            MEM_WB_MemToReg <= EX_MEM_MemToReg;
        end
    end
endmodule
