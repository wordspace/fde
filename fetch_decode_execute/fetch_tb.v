`timescale 1ns / 100ps

module fetch_tb;

// Inputs to the uut are reg type
reg clock;
reg reset;

// Outputs from the UUT are wire type
wire [63:0] IF_ID;
wire [31:0] pc;

// Instantiate the Unit Under Test (UUT)
fetch uut (
.clock(clock), 
.reset(reset),
//.pc(pc),
.IF_ID(IF_ID)
);

initial begin
// Initialize Inputs
clock = 0;
reset = 1;
#15;
reset=0;
// Wait 100 ns for global reset to finish
#100;
end

always begin
#10 clock = ~clock;
end
endmodule