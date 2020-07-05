`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/10 10:32:25
// Design Name: 
// Module Name: signext
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


module signext(
    input [15:0] inst,
    output reg [31:0] data
    );
    
    always @(inst)
    begin
        if(inst[15:15] == 1'b0)
            begin
                data = 32'b00000000000000000000000000000000;
                data[15:0] = inst;
            end
        else
            begin
                data = 32'b11111111111111111111111111111111;
                data[15:0] = inst;
            end
    end
endmodule
