//`define IDEXMSB 175
//`define ALUOP ID_EX[175:160]
`timescale 1ns / 100ps


module execute(
	input clock,
	input reset,
	input [175:0] ID_EX,
	output reg [127:0] EX_WB
	);

always @ (posedge clock) begin
EX_WB[4:0]<=ID_EX[100:96];	// Destination bits go straight through
//EX_WB[37:6] where i want to store the WB data


end


always @ (posedge clock)
case(ID_EX[175:160])
6'b000000: EX_WB[36:5] = data_rf[0] + data_rf[1];	// Add
6'b000001: EX_WB[36:5] = data_rf[0] - data_rf[1];	// Sub
6'b000010: EX_WB[36:5] = 							//I type
6'b000011: EX_WB[36:5] = data_rf[0] * 2;			// Need to figure out how to do bitwise register operations
6'b000100: EX_WB[36:5] = data_rf[0] / 2;
6'b000101: EX_WB[36:5] = data_rf[0] & data_rf[1];
6'b000110: EX_WB[36:5] = data_rf[0] | data_rf[1];
6'b000111: EX_WB[36:5] = 
6'b001000: EX_WB[36:5] = 							// I type
6'b001001: EX_WB[36:5] = 							// I type
6'b001010: EX_WB[36:5] =
6'b001011: EX_WB[36:5] =
6'b001100: EX_WB[36:5] =
6'b001101: EX_WB[36:5] =
6'b001110: EX_WB[36:5] = 
endcase





