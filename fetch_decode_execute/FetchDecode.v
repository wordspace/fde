`timescale 1ns / 100ps

module fetch_decode(
	input clock,
	input reset,
	output [180:0] ID_EX
	);

wire [63:0] IF_ID;

/*initial begin
$dumpfile("fetch_decode.vcd");
#1
$dumpvars;
#100  //this line sets the amount of time we want to record waves for
$finish;
end*/

fetch IF1(clock, reset, IF_ID);
decoder ID1(IF_ID, clock, ID_EX);
endmodule
