`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/28 17:16:15
// Design Name: 
// Module Name: RGB_To_Gray
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

module RGB_To_Gray(
 input   clk,
 input [7:0]RGB_Data_R, //Pixel data R
 input [7:0]RGB_Data_G, //Pixel data G
 input [7:0]RGB_Data_B, //Pixel data B
 output [23:0]Gray_Data, //Output grayscale data
 output clk_out
 );
 //Temporary grayscale data
 reg [32:0]Out_Data=0;
 //Output grayscale data
 assign Gray_Data={Out_Data[7:0],Out_Data[7:0],Out_Data[7:0]};
 assign clk_out=clk;
 //Gray value calculation
 always@(posedge clk)
 begin
 //Different precision digits, 0-20 digits
Out_Data=(RGB_Data_R*30+RGB_Data_B*11+RGB_Data_G*59+50)/100;
 end
endmodule
