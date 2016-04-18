`timescale 1ns / 100ps

module fetch_decode_tb;

// Inputs
reg clock;
reg reset;

// Outputs
wire [180:0] ID_EX;

// Instantiate the Unit Under Test (UUT)
fetch_decode uut (
.clock(clock), 
.reset(reset), 
.ID_EX(ID_EX)
);

initial begin
#1
$dumpvars;
#100    //this line sets the amount of time we want to record waves for
$finish;	// comment this initial block out for xilinx use
end

initial begin
// Initialize Inputs
$dumpfile("fetch_decode.vcd"); // this is for iverilog  comment out for xilinx
clock = 0;
reset = 1;
#15 reset = 0;
// Wait 100 ns for global reset to finish
#100;
end

always
begin
#10 clock = ~clock;
end
      
endmodule
