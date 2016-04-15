`timescale 1ns / 100ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:25:40 04/08/2016
// Design Name:   Fetch_decode
// Module Name:   U:/New folder/Module_InstructionFetch/Fetch_decode_tb.v
// Project Name:  Module_InstructionFetch
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Fetch_decode
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fetch_decode_tb;

// Inputs
reg CLOCK;
reg RESET;

// Outputs
wire [191:0] ID_EX;

// Instantiate the Unit Under Test (UUT)
fetch_decode uut (
.CLOCK(CLOCK), 
.RESET(RESET), 
.ID_EX(ID_EX)
);

initial begin
#1
$dumpvars;
#100  //this line sets the amount of time we want to record waves for
$finish;
end

initial begin
// Initialize Inputs
$dumpfile("fetch_decode.vcd");
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
