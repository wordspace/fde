`timescale 1ns / 100ps

module execute(
	input clock,
	input [175:0] ID_EX,
	output reg [70:0] EX_WB  	
	);
integer i;

initial 
begin
EX_WB[70:69] = 2'b00;
end

always @ (posedge clock) begin
//EX_WB[70:69] = 2'b00;
case(ID_EX[175:160])
16'b0000000000000001:									// Add
	begin
		EX_WB[31:0] <= ID_EX[95:64] + ID_EX[127:96]; 	//95-64 is the source bits
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end
16'b0000000000000010:							// Sub			   //127-96 is target bits
	begin
		EX_WB[31:0] <= ID_EX[95:64]  - ID_EX[127:96];
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end
16'b0000000000000100: 									// Load Immediate
	begin	
		EX_WB[31:0] <= 16'b0;
		EX_WB[15:0] <= ID_EX[15:0];						// Load immediate first 16 bits into register
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end 
16'b0000000000001000: 									// Shift Left
	begin
		EX_WB[31:0] <= ID_EX[127:96] << ID_EX[10:6];
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end 
16'b0000000000010000:									// Shift Right
	begin
		EX_WB[31:0] <= ID_EX[127:96] >> ID_EX[10:6];
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end
16'b0000000000100000: 									// AND
	begin
		EX_WB[31:0] <= ID_EX[127:96] & ID_EX[95:64];
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[100:96];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end
16'b0000000001000000: 									// OR
	begin
		EX_WB[31:0] <= ID_EX[127:96] | ID_EX[95:64];
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end 
16'b0000000010000000:									// XOR
	begin
		EX_WB[31:0] <= ID_EX[127:96] ^ ID_EX[95:64];
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end
16'b0000000100000000: 									// BR "unconditional jump"
	begin	
		EX_WB[69:69] = 1'b0;
		EX_WB[70:70] = 1'b1;
		EX_WB[63:32] = ID_EX[63:32] + ID_EX[25:0];		// use bits [25:0] as the offset, we chose 3 
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
	end	
16'b0000001000000000: 									// Branch if not equal to (J-type)
	begin
		if(ID_EX[127:96] != ID_EX[95:64]) 
			begin
				EX_WB[69:69] <= 1'b0;
				EX_WB[70:70] <= 1'b1;
				EX_WB[63:32] <= ID_EX[63:32] + ID_EX[15:0];   // add the sign extended immediate to the pc 
				EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
				
			end
	end					
16'b0000010000000000: 									// MOV
	begin
		EX_WB[31:0] <=  ID_EX[95:64]; 					// write this back to the target bits in data_rf  
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;	
	end
16'b0000100000000000: 									// ADI
	begin
		EX_WB[31:0] <= ID_EX[159:28] + ID_EX[95:64];  	// add the 32 bit immediate sign extended with the source and place in target.
		EX_WB[63:32] <= ID_EX[63:32];					// PC
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go straight through
		EX_WB[69:69]  <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end
16'b0001000000000000: 									// MUL
	begin
		EX_WB[31:0] <= ID_EX[159:28] * ID_EX[95:64];		// place the product of the 
		EX_WB[63:32] <= ID_EX[63:32];					// PC goes the write back reg
		EX_WB[68:64] <= ID_EX[15:11];					// 5 address Destination bits go thru to wb reg
		EX_WB[69:69] <= 1'b1;
		EX_WB[70:70] <= 1'b0;
	end
16'b0010000000000000: 									// HLT
	begin
														//  create a write and read enable for IF and de-assert
	end  
16'b0100000000000000: 									// NOP
	begin
	end

default: begin
		EX_WB[69:69] = 1'b0;
		EX_WB[70:70] = 1'b0;
		end
endcase

end
endmodule


