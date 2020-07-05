`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 08:15:12
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
    reg [31:0] PC;//���������
    
    //����Ctrģ�������
    wire REG_DST,
        JUMP,
        BRANCH,
        MEM_READ,
        MEM_TO_REG,
        MEM_WRITE;
    wire[1:0] ALU_OP;
    wire ALU_SRC,
          REG_WRITE,
          ZEXT;
          
    //���ڼĴ���ģ�������
    wire [4:0] READ_REG1,
                READ_REG2,
                WRITE_REG;
    wire [31:0] WRITE_DATA,
                 READ_DATA1,
                 READ_DATA2;
                 
    //����ALUģ�������
    wire [31:0] INPUT_1,
                 INPUT_2;
    wire [3:0] ALU_CTR;
    wire ALU_ZERO;
    wire [31:0] ALU_RES;
    
    //����instmemory������
    wire [31:0] READ_ADDR,
                 INST;
                 
    //�����ڴ�ģ�������
    wire [31:0] DataAddr;
	wire [31:0] ReadData;
	wire [31:0] WriteDataMem;
	
	//���ڷ���λ��չ������
	wire [31:0] signext;
    
    Ctr mainCtr(INST[31:26], REG_DST, ALU_SRC, MEM_TO_REG, REG_WRITE, MEM_READ, MEM_WRITE, BRANCH, ALU_OP, JUMP, ZEXT);
    dataMemory data(clk, DataAddr, WriteDataMem, MEM_WRITE, MEM_READ, ReadData);
    InstMemory instMem(READ_ADDR, INST);
    Registers regs(clk, READ_REG1, READ_REG2, WRITE_REG, WRITE_DATA, REG_WRITE, READ_DATA1, READ_DATA2, reset);
    signext sig(INST[15:0], signext, ZEXT);
    ALU alu(INPUT_1, INPUT_2, ALU_CTR, INST[10:6], ALU_ZERO, ALU_RES);
    ALUCtr ctr(ALU_OP, INST[5:0],INST[31:26], ALU_CTR);
    
    always @ (posedge clk)
	begin
		if (reset == 1) PC <= 0;
		else if (JUMP) PC <= {PC[31:28],(INST[25:0] << 2)};
		else if (BRANCH & ALU_ZERO) PC <= (signext << 2) + PC;
		else PC <= PC+4;
	end
	
	always @ (negedge clk)
	begin
	   if (reset == 1) PC = 0;
	end
	
	assign INPUT_1 = READ_DATA1;
    assign INPUT_2 = (ALU_SRC == 1'b0) ? READ_DATA2 : signext;
    
    assign WRITE_REG = (REG_DST == 1'b1) ? INST[15:11] : INST[20:16];
    assign WRITE_DATA = (MEM_TO_REG == 1'b1) ? ReadData : ALU_RES;
	
	assign READ_REG1 = INST[25:21];
	assign READ_REG2 = INST[20:16];

	assign READ_ADDR = PC;
	
	assign DataAddr = ALU_RES;
	assign WriteDataMem = READ_DATA2;
	
endmodule
