`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 15:18:16
// Design Name: 
// Module Name: Gray_To_Binarization
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


module Gray_To_Binarization(
input  clk,
input [23:0] Gray_Data,
output [23:0] Binary_Data,
output clk_out
    );
 
reg [7:0] gray_data;
parameter [7:0] thershold_value = 80;
assign clk_out=clk;
assign  Binary_Data={gray_data[7:0],gray_data[7:0],gray_data[7:0]};
always@(clk)
    begin 
        gray_data<=Gray_Data[7:0] > thershold_value ? 255:0;
    end

endmodule
