`timescale 1ns / 100ps

module fetch_decode_tb;

// Inputs
reg CLOCK;
reg RESET;

// Outputs
wire [175:0] ID_EX;

// Instantiate the Unit Under Test (UUT)
fetch_decode uut (
.CLOCK(CLOCK), 
.RESET(RESET), 
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
CLOCK = 0;
RESET = 1;
#15 RESET = 0;
// Wait 100 ns for global reset to finish
#100;

end
always
begin
#1 CLOCK = ~CLOCK;
end
      
endmodule
