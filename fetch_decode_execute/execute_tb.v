`timescale 1ns / 100ps

module execution;

// Inputs
reg clock;
reg reset;
reg [175:0] ID_EX;

// Outputs
wire [70:0] EX_WB;


// Instantiate the Unit Under Test (UUT)
execute uut (
.clock(clock), 
.reset(reset), 
.ID_EX(ID_EX),
.EX_WB(EX_WB)
);

initial begin
ID_EX <= 64'hFFFFFFFFFFFFFFFF;
clock <= 0;
#100
$finish;
end

initial begin
#1
$dumpvars;
#100    //this line sets the amount of time we want to record waves for
$finish;    // comment this initial block out for xilinx use
end

initial begin
// Initialize Inputs
$dumpfile("execute.vcd"); // this is for iverilog  comment out for xilinx
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
      