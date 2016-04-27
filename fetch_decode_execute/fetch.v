`timescale 1ns / 100ps

module fetch(
	input clock,
	input reset,
	input [70:0]EX_WB,
	output reg [63:0] IF_ID  //this must be stated exactly as is, error if not	
	);

//input branchFlag;
integer i;
output reg [31:0] pc;
reg [31:0] IR[127:0];
initial 
begin		//   000000'00000'00000'00000'00000'000000	
	IR[0] <= 32'b00000000000000010010100000000000;		// add reg 0 and 1 and put in reg 3
	IR[1] <= 32'b00000000000000010011100000000000;		// add reg0 and reg1 and put in reg5
	IR[2] <= 32'b00100000000000000000110000000001;		// jump to neg
	IR[3] <= 32'b00000000001000010010100000000000;
	IR[4] <= 32'b00000000001000100010100000000000; 
	IR[5] <= 32'b00000000000000100010100000000000;
	IR[6] <= 32'b00000000000000010010100000000000;
	IR[7] <= 32'b00000000000000010010100000000000;
	IR[8] <= 32'b00000000000000010010100000000000; 
	IR[9] <= 32'b00000000000000010010100000000000;
	IR[10] <= 32'b00000000000000010010100000000000;
	IR[11] <= 32'b00000000000000010010100000000000;
	for(i=12;i<32; i=i+1)
	begin						// Initialize to zero just to a bunch of X's on waveform
		IR[i] = 32'h0;
		pc [31:0] <= 32'b0;
	end
end

always @ (posedge clock) 
begin
	if(reset == 1'b0) 
	begin
			if(!EX_WB[70:70])
			begin//begin
				IF_ID[31:0] <= IR[pc];	// instruction is indexed by program count and set to lower 32 bits of  IF_ID 
				IF_ID[63:32] <= pc;   	// program count goes into upper 32 bits of 64 bit IF_ID
				pc <= pc + 1;
			end

			if (EX_WB[70:70])
			begin
				pc = EX_WB[63:32];
				IF_ID[31:0] = IR[pc];
				IF_ID[63:32] = pc;
				pc = pc + 1;
			end
	end
end

endmodule

/*

add reg 0 to reg 1 and put in reg 5
000000 00000 00000 00000 00000 000000 stencil
000000 00000 00001 00101 00000 000000
00000000000000010010100000000000
*/