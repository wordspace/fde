`timescale 1ns / 100ps

module fetchDecExe_tb;

// Inputs
reg clock;
reg reset;
//reg [175:0] ID_EX;

// Outputs
wire [70:0] EX_WB;
reg [175:0] ID_EX;
reg [63:0] IF_ID;


// Instantiate the Unit Under Test (UUT)
fetchDecExe uut (
.clock(clock), 
.reset(reset), 
.EX_WB(EX_WB)
);

/*fetch uut(
	.clock(clock), 
	.reset(reset), 
	.IF_ID(IF_ID)
	);

decoder uut(
	.clock(clock), 
	.ID_EX(IF_ID), 
	.ID_EX(ID_EX)
	);

execute uut(
	.clock(clock), 
.ID_EX(ID_EX), 
.EX_WB(EX_WB)
	);*/



/*initial begin
clock <= 0;
#100
$finish;
end*/

initial begin
#1
$dumpvars;
#100    //
$finish;    // comment this initial block out for xilinx use
end

initial begin
// Initialize Inputs
$dumpfile("fetchDecExe.vcd"); // this is for iverilog  comment out for xilinx
clock = 0;
reset = 1;
IF_ID <= 64'hDDDDDDDDDDDDDDDD;
//EX_WB[69:0] <= 70'b0;
#15 reset = 0;
// Wait 100 ns for global reset to finish
#600;
end


always
begin
#10 clock = ~clock;
end
endmodule
      