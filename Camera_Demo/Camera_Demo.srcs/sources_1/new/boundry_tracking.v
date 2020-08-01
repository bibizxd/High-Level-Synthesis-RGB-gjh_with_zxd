`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 17:00:38
// Design Name: 
// Module Name: boundry_tracking
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


module boundry_tracking(
    input clk_in,
    input rst,
    input [23:0]  data_in,
    output  [31:0] hang_up,
    output  [31:0] hang_down,
    output  [31:0] lie_left,
    output  [31:0] lie_right,
    output  [23:0] data_out,
    output  data_valid,
    output  clk_out,
    output [31:0]hang_flag,
    output [31:0]lie_flag
    );
    parameter [31:0] hang= 720;
    parameter [31:0] lie = 1280;
    reg [31:0]hang_flag;
    reg [31:0]lie_flag;
    reg [7:0]data_buf;
    reg [7:0]data_buf1;
    reg  [31:0] hang_up;
    reg  [31:0] hang_down;
    reg  [31:0] lie_left;
    reg  [31:0] lie_right;
    reg  [23:0] data_out;
    reg  data_valid;
    
    assign clk_out=clk_in;


    
    always @(posedge clk_in or negedge rst)
    begin 
    if(!rst)
    begin 
    data_buf<=0;
    data_buf1<=0;
    data_valid<=0;
    hang_flag<=0;
    lie_flag<=0;
    end
    else
    begin
     data_buf1<=data_buf;
     data_buf<=data_in[7:0];
     data_out<=data_in;
     if (lie_flag == lie-1 && hang_flag != hang-1)
      begin
      hang_flag<=hang_flag+1'b1;
      lie_flag<=0;
      end
      else if (lie_flag <lie-1)
      lie_flag<=lie_flag+1'b1;
      else 
        begin
            hang_flag<=0;
            lie_flag<=0;
            data_valid<=~data_valid;
        end
    end
 end
    always @(posedge clk_in or negedge rst)
    begin 
    if(!rst)
    begin
        hang_up<=hang-1;
        hang_down<=0;
        lie_left<=lie-1;
        lie_right<=0;
    end
    else
        begin
             if(data_buf==0 && data_buf1==255 )
                 begin 
                    hang_up<=hang_up < hang_flag ? hang_up:hang_flag;
                    hang_down<=hang_down > hang_flag ? hang_down:hang_flag;
                    lie_left<=lie_left < lie_flag ? lie_left:lie_flag;
                 end
              if(data_buf==255 && data_buf1==0 ) 
                begin
                    lie_right<=lie_right > lie_flag ? lie_right:lie_flag;
                end
             end 
    end

endmodule
