`timescale 1ns / 100ps

module execute(
	input clock,
	input [175:0] ID_EX,
	output reg [70:0] EX_WB  	// 0-32[31:0] for wbdata, 32-64 for pc, 65-69 address, 70 branchflag
	);

always @ (posedge clock) begin
EX_WB[68:64] = ID_EX[100:96];	// 5 address Destination bits go straight through
EX_WB[63:32] = ID_EX[63:32];
EX_WB[69:69] = 1'b0; // branch enable / "branchFlag"
EX_WB[70:70] = 1'b0; // writeback flag/enable
end

//reg branchFlag;
//reg writeBack;

//** gonna try this in decoder instead! since in cant change id_ex in execute stage!
//	Need to find a way to test branchflag first and perfrom NOP if it is high
always @ (posedge clock) begin
//if(branchFlag)begin
//ID_EX[175:160] = 16'b0100000000000000;
//end

case(ID_EX[175:160])
16'b0000000000000001:							// Add
	begin
		EX_WB[31:0] = ID_EX[95:64] + ID_EX[127:96]; //95-64 is the source bits
		//writeBack = ;
	end
16'b0000000000000010:							// Sub			   //127-96 is target bits
	begin
		EX_WB[31:0] = ID_EX[95:64] - ID_EX[63:32]; 	
	end
16'b0000000000000100: 							// Load Immediate
	begin
		EX_WB[31:0] = ID_EX[15:0];		// Load immediate first 16 bits into register
	end 
16'b0000000000001000: 							// Shift Left
	begin
		EX_WB[31:0] = ID_EX[95:64] << ID_EX[10:6];

	end 
16'b0000000000010000:							// Shift Right
	begin
		EX_WB[31:0] = ID_EX[95:64] >> ID_EX[10:6];
	end
16'b0000000000100000: 							// AND
	begin
		EX_WB[31:0] = ID_EX[63:32] & ID_EX[95:64];
	end
16'b0000000001000000: 							// OR
	begin
		EX_WB[31:0] = ID_EX[63:32] | ID_EX[95:64];
	end 
16'b0000000010000000:							// XOR
	begin
		EX_WB[31:0] = ID_EX[63:32] ^ ID_EX[95:64];
	end
16'b0000000100000000: 							// BR "unconditional jump"
	begin
		EX_WB[63:32] <= ID_EX[63:32] + {ID_EX[9:0],ID_EX[25:10]};		// pc in EX_WB is 
		//branchFlag = ID_EX[168];
		//EX_WB[69]=branchFlag;
	end	
16'b0000001000000000: 							// Branch if not equal to (J-type)
	begin
		if(ID_EX[63:32]!=ID_EX[95:64]) 
			begin
				EX_WB[63:32] = ID_EX[63:32] + ID_EX[159:128];  // add the sign extended immediate to the pc 
			end
	end					
16'b0000010000000000: 	// MOV
	begin
		EX_WB[31:0] =  ID_EX[95:64]; // write this backto the target bits in data_rf
		
	end
16'b0000100000000000: 	// ADI
	begin
		EX_WB[31:0] = ID_EX[159:28] + ID_EX[95:64];  // add the 32 bit immediate sign extended with the source and place in target.
	end
16'b0001000000000000: 	// MUL
	begin
		EX_WB[31:0] = ID_EX[63:32] * ID_EX[95:64];
	end
16'b0010000000000000: 	// HLT
	begin
		$stop;
	end  
16'b0100000000000000: 	// NOP
	begin
	end
endcase
end
endmodule


