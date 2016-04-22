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

initial begin
$dumpfile("fetchDecExe.vcd"); // this is for iverilog  comment out for xilinx
#1
$dumpvars;
#125    //
$finish;    // comment this initial block out for xilinx use
end

initial begin
// Initialize Inputs
clock = 0;
reset = 1;
//IF_ID <= 64'hDDDDDDDDDDDDDDDD;
//EX_WB[69:0] <= 70'b0;
#15 reset = 0;
// Wait 100 ns for global reset to finish
#100;
end

always
begin
#6 clock = ~clock;
end
endmodule
      