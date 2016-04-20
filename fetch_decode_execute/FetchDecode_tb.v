`timescale 1ns / 100ps

module fetchDecode_tb;

// Inputs
reg clock;
reg reset;

// Outputs
wire [175:0] ID_EX;
wire [63:0] IF_ID;

// Instantiate the Unit Under Test (UUT)
fetchDecode uut (
.clock(clock), 
.reset(reset), 
.ID_EX(ID_EX)
);
/*
initial begin
#1
$dumpfile("fetchDecode.vcd"); // this is for iverilog  comment out for xilinx
$dumpvars;
#100    //this line sets the amount of time we want to record waves for
$finish;	// comment this initial block out for xilinx use
end*/

initial begin
// Initialize Inputs

clock <= 0;
reset = 1;
#15 reset = 0;
// Wait 100 ns for global reset to finish
#500;
$finish;        
// Add stimulus here
end

// Initialize Inputs
/*initial begin
clock = 0;
reset = 1;
#15 reset = 0;
// Wait 100 ns for global reset to finish
#100
$finish
*/

always
begin
#10 clock = ~clock;
end
      
endmodule
