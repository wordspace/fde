`timescale 1ns / 100ps

module fetch(
	input clock,
	input reset,
	//input branch,
	output reg [63:0] IF_ID  //this must be stated exactly as is, error if not	
	);
output reg [31:0] pc;
reg [31:0] inst_mem[127:0];
initial begin
#3
$dumpvars;
#100  //this line sets the amount of time we want to record waves for
$finish;
end

integer i;
initial begin
$dumpfile("fetch.vcd");
for (i=0; i<128; i=i+1)
	begin
	inst_mem[i] <= 32'b0;//32'b0;
	end
#1
pc [31:0] <= 32'b0;
end

always @ (posedge clock) begin
if(reset == 1'b0) begin
IF_ID[31:0] <= inst_mem [pc];
IF_ID[63:32] <= pc;
pc <= pc + 1;
end
end
endmodule
