`timescale 1ns / 100ps

module fetchDecExe_tb;

// Inputs
reg clock;
reg reset;

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
#920    //
$finish;    // comment this initial block out for xilinx use
end

initial begin
// Initialize Inputs
clock = 0;
reset = 1;

#15 reset = 0;
// Wait 100 ns for global reset to finish
#900;
end

always
begin
#5 clock = ~clock;
end
endmodule
      