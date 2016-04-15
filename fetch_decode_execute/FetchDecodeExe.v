`timescale 1ns / 1ps
module fetch_decode_exe(
	input clock,
	input reset,
	output [191:0] ID_EX
	);

wire [63:0] IF_ID;
wire WB;

fetch IF1(CLOCK, RESET, IF_ID);
decoder ID1(IF_ID, CLOCK, ID_EX);
execute EX1(ID_EX, CLOCK, WB);



