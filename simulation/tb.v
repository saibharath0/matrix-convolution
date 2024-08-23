`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2024 16:56:39
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
wire [15:0]out;
reg clk,rst;
reg [2:0]stride;
reg [7:0]feature,filter;
wire done,complete;
reg [2:0]pad;
conv convol( out,done,complete,feature,filter,clk,rst,stride,pad);
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
//feature = 8'b00100000; filter = 8'b00000000;
//#20
//feature = 8'b00010000; filter = 8'b00000000;
//#20
//feature = 8'b00100000; filter = 8'b00000000;
//#20
//feature = 8'b00010000; filter = 8'b00000000;
//#20
//feature = 8'b00100000; filter = 8'b00000000;
//#20
//feature = 8'b00010000; filter = 8'b00000000;
//#20
//feature = 8'b00100000; filter = 8'b00000000;
//#20
//feature = 8'b00010000; filter = 8'b00000000;
//#20
//feature = 8'b00100000; filter = 8'b00000000;
//#20
////feature = 8'b00000000; filter = 8'b00010000;

//feature = 8'b00000000; filter = 8'b11111000;
//#20
//feature = 8'b00000000; filter = 8'b11101000;
//#20
//feature = 8'b00000000; filter = 8'b11101000;
//#20
//feature = 8'b00000000; filter = 8'b11111000;

feature = 8'b00000001; filter = 8'b00000000;
#20
feature = 8'b00000010; filter = 8'b00000000;
#20
feature = 8'b00000001; filter = 8'b00000000;
#20
feature = 8'b00000010; filter = 8'b00000000;
#20
feature = 8'b00000001; filter = 8'b00000000;
#20
feature = 8'b00000010; filter = 8'b00000000;
#20
feature = 8'b00000001; filter = 8'b00000000;
#20
feature = 8'b00000010; filter = 8'b00000000;
#20
feature = 8'b00000001; filter = 8'b00000000;
#20
//feature = 8'b00000000; filter = 8'b00010000;

feature = 8'b00000000; filter = 8'b00000010;
#20
feature = 8'b00000000; filter = 8'b00000001;
#20
feature = 8'b00000000; filter = 8'b00000010;
#20
feature = 8'b00000000; filter = 8'b00000001;


end
endmodule

