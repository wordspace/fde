`timescale 1ns / 100ps

module fetchDecode(
	input clock,
	input reset,
	output [175:0] ID_EX
	);

wire [63:0] IF_ID;


initial begin
$dumpfile("fetchDecode.vcd");
#1
$dumpvars;
#100  //this line sets the amount of time we want to record waves for
$finish;
end

fetch IF1(clock, reset, IF_ID);
decoder ID1(clock, IF_ID, ID_EX);
endmodule
