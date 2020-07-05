`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/04/17 09:46:39
// Design Name: 
// Module Name: signext_tb
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


module signext_tb(

    );
    
    wire [15:0] init;
    wire [31:0] data;
    
    reg [15:0] Init;
     
    assign init = Init;
    
    signext s0(
        .init(init),
        .data(data)
    );
   
initial
begin
    Init = 0;
    
    #100 Init = 1;
    
    #100 Init = 2;
    
    #100 Init = 16'b1111111111111110;
    
    #100 Init = 16'b1111111111111111;
end
endmodule
