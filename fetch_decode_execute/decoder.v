`timescale 1ns / 100ps

module decoder(
	input [63:0] IF_ID,
	input clock,
	output reg [180:0] ID_EX
	);

// Create data_rf memory and initialize to zero.
reg [31:0] data_rf[31:0];
integer i;
/*initial begin
$dumpfile("decoder.vcd");
for (i=0; i<32; i=i+1)
	begin
	data_rf[i] <= 32'h0; //32'b0;
	end
	end*/

initial
begin
data_rf[0] = 32'hAAAAAAAA; //source bits
data_rf[1] = 32'hFFFFFFFF; //target bits
end

/*initial begin
#2
$dumpfile("decoder.vcd");
$dumpvars;
#100  //time spent sampling
$finish;
end
*/
always @ (posedge clock) begin
ID_EX[31:0] <= IF_ID[63:32]; 						//PC goes straight to ID_EX
ID_EX[63:32] <= data_rf[IF_ID[25:21]]; 				//source bits    (rs)
ID_EX[95:64] <= data_rf[IF_ID[20:16]];  			//target bits	 (rt)
ID_EX[100:96] <= IF_ID[15:11];  					//address of destination (rd)
ID_EX[111:101] <= IF_ID[10:0];  					//branch offset 11 bit
ID_EX[127:112] <= IF_ID[15:0];  					//immediate 32 bits
ID_EX[159:128] <= {{16{IF_ID[15]}}, IF_ID[15:0]};   //sign extended 32 bits
ID_EX[180:176] <= IF_ID[10:6];   					// 5 bits of shift amount
end

always @ (posedge clock)
case (IF_ID[31:26])
6'b000000: ID_EX[175:160] = 16'b0000000000000001;  //Add
6'b000001: ID_EX[175:160] = 16'b0000000000000010;  //Sub
6'b000010: ID_EX[175:160] = 16'b0000000000000100;  // LI
6'b000011: ID_EX[175:160] = 16'b0000000000001000;  //SHift Left
6'b000100: ID_EX[175:160] = 16'b0000000000010000;  //SHift Right
6'b000101: ID_EX[175:160] = 16'b0000000000100000;  //and
6'b000110: ID_EX[175:160] = 16'b0000000001000000;  //or
6'b000111: ID_EX[175:160] = 16'b0000000010000000;  //xor
6'b001000: ID_EX[175:160] = 16'b0000000100000000;  //BR
6'b001001: ID_EX[175:160] = 16'b0000001000000000;  //BNE
6'b001010: ID_EX[175:160] = 16'b0000010000000000;  //MOV
6'b001011: ID_EX[175:160] = 16'b0000100000000000;  //ADI
6'b001100: ID_EX[175:160] = 16'b0001000000000000;  //MUL
6'b001101: ID_EX[175:160] = 16'b0010000000000000;  //HLT
6'b001110: ID_EX[175:160] = 16'b0100000000000000;  //NOP
endcase
endmodule
