`timescale 1ns / 100ps

module fetch(
	input clock,
	input reset,
	//input branch,
	output reg [63:0] IF_ID  //this must be stated exactly as is, error if not	
	);
output reg [31:0] pc;
reg [31:0] IR[127:0];
initial begin
#3
$dumpvars;
#100  //this line sets the amount of time we want to record waves for
$finish;
end


/*integer i;
initial begin
$dumpfile("fetch.vcd");
for (i=0; i<128; i=i+1)
	begin
	inst_mem[i] <= 32'b0;//32'b0;
	end
#1
pc [31:0] <= 32'b0;
end*/
initial begin
$dumpfile("fetch.vcd");
IR[0] <= 32'h0AAAAAAA;
IR[1] <= 32'h0BBBBBBB;
IR[2] <= 32'h0CCCCCCC;
IR[3] <= 32'h0DDDDDDD;
IR[4] <= 32'h0FFFFFFF;
#1
pc [31:0] <= 32'b0;
end

always @ (posedge clock) 
begin
if(reset == 1'b0) 
begin
IF_ID[31:0] <= IR[pc];	// instruction is indexed by program count and set to lower 32 bits of  IF_ID 
IF_ID[63:32] <= pc;   	// program count goes into upper 32 bits of 64 bit IF_ID
pc <= pc + 1;      		// program count is incremented 
end
end
endmodule
