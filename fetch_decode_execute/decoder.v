`timescale 1ns / 100ps

module decoder(
	input clock,
	input [63:0] IF_ID,	
	input [70:0]EX_WB,
	output reg [175:0] ID_EX
	);

// Create data_rf memory and initialize to zero.
reg [31:0] data_rf[31:0];
integer i;

initial
begin
data_rf[0] <=32'hA; 		
data_rf[1] <= 32'h1;			
data_rf[2] <= 32'h2;
data_rf[3] <= 32'h3;
data_rf[4] <= 32'h4;
data_rf[5] <= 32'h5;
data_rf[6] <= 32'h6; 
data_rf[7] <= 32'h7;			
data_rf[8] <= 32'h8;
data_rf[10] <= 32'h1;
data_rf[11] <= 32'h1;
data_rf[12] <= 32'h1;
data_rf[13] <= 32'h1;
data_rf[14] <= 32'h1;
data_rf[15] <= 32'h1; 	// target address for the first ADD instruction
data_rf[16] <= 32'h1;	// target address for the first SUB instruction
data_rf[17] <= 32'h1;	// target address for the first LI instruction
data_rf[18] <= 32'h1;	// target address for the first SLL instruction
data_rf[19] <= 32'h1;	// target address for the first SRL instruction
data_rf[20] <= 32'h1;	// target address for the first AND instruction
data_rf[21] <= 32'h1;	// target address for the first OR instruction
data_rf[22] <= 32'h1;	// target address for the first XOR instruction
data_rf[23] <= 32'h1;	// 
data_rf[24] <= 32'h1;
data_rf[25] <= 32'h1;
data_rf[26] <= 32'h1;
data_rf[27] <= 32'h1;
data_rf[28] <= 32'h1;
data_rf[29] <= 32'h1;
data_rf[30] <= 32'h1;
data_rf[31] <= 32'h1;
end

always @ (posedge clock) begin
ID_EX[31:0] <= IF_ID[31:0]; 						// Instruction 32
ID_EX[63:32] <= IF_ID[63:32];						//PC goes straight to ID_EX  32
ID_EX[95:64] <= data_rf[IF_ID[25:21]];				//source bits    (rs) 32
ID_EX[127:96] <= data_rf[IF_ID[20:16]];  			//target bits	 (rt) 32
ID_EX[159:128] <= {{16{IF_ID[15]}}, IF_ID[15:0]};   //sign extended 32 bits
end

always @ (posedge clock)begin
case(IF_ID[31:26])
6'b000000: ID_EX[175:160] <= 16'b0000000000000001;  //Add
6'b000001: ID_EX[175:160] <= 16'b0000000000000010;  //Sub
6'b000010: ID_EX[175:160] <= 16'b0000000000000100;  // LI
6'b000011: ID_EX[175:160] <= 16'b0000000000001000;  //SHift Left
6'b000100: ID_EX[175:160] <= 16'b0000000000010000;  //SHift Right
6'b000101: ID_EX[175:160] <= 16'b0000000000100000;  //and
6'b000110: ID_EX[175:160] <= 16'b0000000001000000;  //or
6'b000111: ID_EX[175:160] <= 16'b0000000010000000;  //xor
6'b001000: ID_EX[175:160] <= 16'b0000000100000000;  //BR
6'b001001: ID_EX[175:160] <= 16'b0000001000000000;  //BNE
6'b001010: ID_EX[175:160] <= 16'b0000010000000000;  //MOV
6'b001011: ID_EX[175:160] <= 16'b0000100000000000;  //ADI
6'b001100: ID_EX[175:160] <= 16'b0001000000000000;  //MUL
6'b001101: ID_EX[175:160] <= 16'b0010000000000000;  //HLT
6'b001110: ID_EX[175:160] <= 16'b0100000000000000;  //NOP
endcase
end
endmodule
