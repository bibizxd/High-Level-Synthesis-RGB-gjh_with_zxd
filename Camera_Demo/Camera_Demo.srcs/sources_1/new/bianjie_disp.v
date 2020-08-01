`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 20:24:58
// Design Name: 
// Module Name: bianjie_disp
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


module bianjie_disp(
    input clk_in,
    input  data_valid,
    input  [31:0] hang_up,
    input  [31:0] hang_down,
    input  [31:0] lie_left,
    input  [31:0] lie_right,
    input  [23:0] data_in,
    input [31:0]hang_flag,
    input [31:0]lie_flag,
    output [23:0] data_out
    );
    parameter [7:0]width=100;
    reg [23:0] data_out;
    always @(posedge clk_in)
        begin
            if(hang_flag<hang_up && hang_flag>=(hang_up-width) && data_valid==1)
                begin
                    if(lie_flag<(lie_right+width) && lie_flag>=(lie_left-width))
                        data_out<={8'b11111111,8'b0,8'b0};
                        else
                        data_out<=data_in;
                end
             else if(hang_flag>hang_down && hang_flag<=(hang_down+width) && data_valid==1)
             begin
                    if(lie_flag<(lie_right+width) && lie_flag>=(lie_left-width))
                        data_out<={8'b11111111,8'b0,8'b0};
                        else
                        data_out<=data_in;
                end
              else if(hang_flag>=hang_up && hang_flag<=hang_down && data_valid==1)
               begin
                    if(lie_flag<=(lie_right+width) && lie_flag>(lie_right))
                        data_out<={8'b11111111,8'b0,8'b0};
                        else
                        data_out<=data_in;
                end
                else if(hang_flag>=hang_up && hang_flag<=hang_down && data_valid==1)
               begin
                    if(lie_flag<(lie_left) && lie_flag>=(lie_left-width))
                        data_out<={8'b11111111,8'b0,8'b0};
                        else
                        data_out<=data_in;
                end
                else
                //data_out<={8'b11111111,8'b11111111,8'b0} ;
                data_out<=data_in;
        end
endmodule
