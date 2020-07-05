`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 11:46:57
// Design Name: 
// Module Name: Top_tb
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


module Top_tb(

    );
	reg clk;
	reg reset;

	Top uut (
		.clk(clk), 
		.reset(reset)
	);
	
    always #10 clk = !clk;
	initial begin
		clk = 1;
		reset = 1;
		
		#25;
		reset = 0;

	end
endmodule
