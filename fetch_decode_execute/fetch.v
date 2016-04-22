`timescale 1ns / 100ps

module fetch(
	input clock,
	input reset,
	output reg [63:0] IF_ID  //this must be stated exactly as is, error if not	
	);

input branchFlag;
output reg [31:0] pc;
reg [31:0] IR[127:0];
initial begin
 IR[0] <= 32'b00111100000000000000000000000000; //32'h0AAAAAAA;
  IR[1] <= 32'h0BBBBBBB;
  IR[2] <= 32'h0CCCCCCC;
  //IR[3] <= 32'b00111100000000000000000000000000;
 #1pc [31:0] <= 32'b0;
  end

/*initial begin  //set IR reg with loop
//$dumpfile("fetch.vcd");
//IF_ID <= 64'hEEEEEEEEEEEEEEEE;   // COMMENT THIS OUT LATER IF NEEDED IT SETS THE BITS
// THE IF_ID LATCH SO WE CAN SEE THEM EASIER IN THE WAVEFORM
IR[0] <= 32'h00011000;
IR[1] <= 32'h00021000;
IR[2] <= 32'h00031000;
IR[3] <= 32'h00041000;
IR[4] <= 32'h00051000;
IR[5] <= 32'h00061000;
IR[6] <= 32'h0AAAAAAA;
IR[7] <= 32'h0BBBBBBB;
IR[8] <= 32'h0CCCCCCC;
IR[9] <= 32'h0DDDDDDD;
IR[10] <= 32'h0EEEEEEE;
IR[11] <= 32'h0FFFFFFF;
IR[12] <= 32'h0AAAAAAA;
IR[13] <= 32'h0BBBBBBB;
IR[14] <= 32'h0CCCCCCC;
IR[15] <= 32'h0DDDDDDD;
IR[16] <= 32'h0EEEEEEE;
IR[16] <= 32'h0FFFFFFF;
IR[17] <= 32'h0AAAAAAA;
IR[18] <= 32'h0BBBBBBB;
IR[19] <= 32'h0CCCCCCC;
IR[20] <= 32'h0DDDDDDD;
IR[21] <= 32'h0EEEEEEE;
IR[22] <= 32'h0FFFFFFF;
IR[23] <= 32'h0DDDDDDD;
IR[24] <= 32'h0EEEEEEE;
IR[25] <= 32'h0FFFFFFF;
IR[26] <= 32'h0AAAAAAA;
IR[27] <= 32'h0BBBBBBB;
IR[28] <= 32'h0CCCCCCC;
IR[29] <= 32'h0DDDDDDD;
IR[30] <= 32'h0EEEEEEE;
IR[31] <= 32'h0FFFFFFF;
//#1
#1pc [31:0] <= 32'b0;
end
*/



always @ (posedge clock) begin
if(reset == 1'b0) begin
IF_ID[31:0] <= IR[pc];	// instruction is indexed by program count and set to lower 32 bits of  IF_ID 
IF_ID[63:32] <= pc ;   	// program count goes into upper 32 bits of 64 bit IF_ID
pc <= pc +1;
end
end   		// program count is incremented 

endmodule
