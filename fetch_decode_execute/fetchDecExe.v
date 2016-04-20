`timescale 1ns / 100 ps
module fetchDecExe(
	input clock,
	input reset,
	output [70:0] EX_WB
	);

wire [175:0]ID_EX;
wire [63:0]IF_ID;
wire [70:0] EX_WB;

fetch fetch(clock,reset, IF_ID);
decoder decoder(clock, IF_ID, ID_EX);
execute execute(clock, ID_EX, EX_WB);

endmodule