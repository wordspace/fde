`timescale 1ns / 100ps

module fetch_decode_exe(
	input clock,
	input reset,
	output [175:0] ID_EX
	);
//
wire [63:0] IF_ID;
wire [175:0] ID_EX;
output [69:0] EX_WB;


fetch IF1(clock, reset, IF_ID);
decoder ID1(IF_ID, clock, ID_EX);
execute EX1(ID_EX, clock, reset, EX_WB);

