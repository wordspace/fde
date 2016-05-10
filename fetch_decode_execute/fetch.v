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
begin		//   OPCODE	SRC   TRGT   DEST  SHMT/imm   32'b001000 00000 00000 00001 10000000001;	
	pc[31:0] <= 32'h0;
	IR[0] <= 32'b00000000010000010111100000000000;		// ADD $15, $2, $1
	IR[1] <= 32'b00000100000000011000000000000000;		// SUB $16, $0, $1 rd = rs - rt	
	IR[2] <= 32'b00001000000000001000100000001111;		// LI  $17, 15
	IR[3] <= 32'b00001100000000011001000011000000;		// SLL $18, $1, 3 [SLL rd, rt, shamt]-
	IR[4] <= 32'b00010000000010001001100011000000; 		// SRL $19, $8, 3
	IR[5] <= 32'b00010100110001111010000000000000;		// AND $20, $6, $7 [rd, rs, rt]-
	IR[6] <= 32'b00011000110001111010100000000000;		// OR  $21, $6, $7-
	IR[7] <= 32'b00011100110001111011000000000000;		// XOR $22, $6, $7-
	IR[8] <= 32'b00100000000000000000000000000110;		// BR new pc = pc + 5
	IR[9] <= 32'b00000000010000010111100000000000;		//(copys of inst.1) these get jumped over.
	IR[10] <= 32'b00000000010000010111100000000000;
	IR[11] <= 32'b00000000010000010111100000000000;
	IR[12] <= 32'b00000000010000010111100000000000;
	IR[13] <= 32'b00000000010000010111100000000000;
	IR[14] <= 32'b00100100000000010000000000000110;		// BNE  IF src and trgt not equal, branch by offset of 2-
	IR[15] <= 32'b00000000010000010111100000000000;		// Branch on not equal will skip this instruction
	IR[16] <= 32'b00101000000000000101100000000000;		// MOV the source bits to the destination address "it puts a zero in the destination address"
	IR[17] <= 32'b00101100000110100000000000000011;		// ADI $rt, $rs + imm add immediate value to contents in source address and place in target address.
	IR[18] <= 32'b00110000010001111101100000000000;// MUL $27, $2, $7  "data_rf[2]*data_rf[7] -> data_rf[27]"
	IR[19] <= 32'b00110100000000000000000000000000;		// HLT
	IR[20] <= 32'b00111000000000000000000000000000;		// NOP
end 

assign branchFlag = EX_WB[70:70];

always @ (posedge clock) 
begin
	if(reset == 1'b0) 
	begin		
	
			if(!branchFlag)
			begin				
				IF_ID[31:0] <= IR[pc];	// instruction is indexed by program count and set to lower 32 bits of  IF_ID 
				IF_ID[63:32] <= pc;   	// program count goes into upper 32 bits of 64 bit IF_ID
				pc <= pc + 1;
			end

			if (branchFlag)
			begin
				pc[31:0] = EX_WB[63:32];
				IF_ID[31:0] = IR[pc[31:0]];//IR[pc[]]
				IF_ID[63:32] = pc[31:0];
				pc <= pc + 1;
			end
	

	end
end 

endmodule
