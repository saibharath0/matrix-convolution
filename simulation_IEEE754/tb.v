`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2024 03:29:09
// Design Name: 
// Module Name: tb
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


module tb();
wire [31:0]out;
reg clk,rst;
reg [2:0]stride;
reg [31:0]feature,filter;
wire done;
reg [2:0]pad;
conv convol( out,done,feature,filter,clk,rst,stride,pad);
initial begin
$monitor("out : %b, done : %b ",out,done);
end
initial 
begin
clk = 1;
forever #5 clk = ~clk;
end

initial
begin
rst = 1;
#100
rst = 0;
stride = 1;pad=1;
feature = 32'b10111111110000000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b10111111100000000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b11000000001000000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b11000000011000000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b10111111100000000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b11000000011100000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b11000000001100000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b10111111111000000000000000000000; filter = 32'b00000000000000000000000000000000;
#20
feature = 32'b10111111101000000000000000000000; filter = 32'b00000000000000000000000000000000;
#20


feature = 32'b00000000000000000000000000000000; filter = 32'b00111111100000000000000000000000;
#20
feature = 32'b00000000000000000000000000000000; filter = 32'b00111111110000000000000000000000;
#20
feature = 32'b00000000000000000000000000000000; filter = 32'b00111111110000000000000000000000;
#20
feature = 32'b00000000000000000000000000000000; filter = 32'b00111111100000000000000000000000;


end
endmodule
