`timescale 1ns / 100ps

module decoder_tb;

// Inputs
reg [63:0] IF_ID; 
reg clock;

// Outputs from the DUT are wire type!!
wire [175:0] ID_EX;

// Instantiate the Unit Under Test (UUT)
decoder uut (
.IF_ID(IF_ID), 
.clock(clock),
.ID_EX(ID_EX)
);

initial begin
// Initialize Inputs
IF_ID <= 64'hFFFF0000FFFF0000;
clock <= 0;
// Wait 100 ns for global reset to finish
#100;
$finish;        
// Add stimulus here
end

always begin
#10 clock = ~clock;
end
      
endmodule
