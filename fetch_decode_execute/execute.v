`timescale 1ns / 100ps

module execute(
	input clock,
	input [175:0] ID_EX,
	output reg [70:0] EX_WB  	// 0-32[31:0] for wbdata, 32-64 for pc, 65-69 address, 70 branchflag
	);

initial begin
EX_WB[68:64] = ID_EX[100:96];	// 5 address Destination bits go straight through
EX_WB[63:32] = ID_EX[63:32];
EX_WB[69:69] = 1'b0; // branch enable / "branchFlag"
EX_WB[70:70] = 1'b0; // writeback flag/enable
end
reg branchFlag;
reg writeBack;

//	Need to find a way to test branchflag first and perfrom NOP if it is high
always @ (posedge clock)begin
//if(branchFlag)begin
//ID_EX[175:160] = 16'b0100000000000000;
//end

case(ID_EX[175:160])
16'h1:							// Add
	begin
		EX_WB[31:0] = ID_EX[95:64] + ID_EX[63:32]; //95-64 is the source bits
		//writeBack = ;
	end
16'h2:							// Sub			   //127-96 is target bits
	begin
		EX_WB[31:0] = ID_EX[95:64] - ID_EX[63:32]; 	
	end
16'h4: 							// Load Immediate
	begin
		EX_WB[31:0] = ID_EX[15:0];		// Load immediate first 16 bits into register
	end 
16'h8: 							// Shift Left
	begin
		EX_WB[31:0] = ID_EX[95:64] << ID_EX[10:6];

	end 
16'h10:							// Shift Right
	begin
		EX_WB[31:0] = ID_EX[95:64] >> ID_EX[10:6];
	end
16'h20: 							// AND
	begin
		EX_WB[31:0] = ID_EX[63:32] & ID_EX[95:64];
	end
16'h40: 							// OR
	begin
		EX_WB[31:0] = ID_EX[63:32] | ID_EX[95:64];
	end 
16'h80:							// XOR
	begin
		EX_WB[31:0] = ID_EX[63:32] ^ ID_EX[95:64];
	end
16'h100: 							// BR "unconditional jump"
	begin
		EX_WB[63:32] <= ID_EX[63:32] + {ID_EX[9:0],ID_EX[25:0]};		// pc in EX_WB is 
		branchFlag = ID_EX[168];
		EX_WB[69]=branchFlag;
	end	
16'h200: 							// Branch if not equal to (J-type)
	begin
		if(ID_EX[63:32]!=ID_EX[95:64]) 
			begin
				EX_WB[63:32] = 32'hAAAAAAAA;  //replace this only there for debug
			end
	end					
16'h400: 	// MOV
	begin
		EX_WB[31:0] =  ID_EX[95:64]; // write this backto the target bits in data_rf
		
	end
16'h800: 	// ADI
	begin
		EX_WB[31:0] = ID_EX[159:28] + ID_EX[95:64];  // add the 32 bit immediate sign extended with the source and place in target.
	end
16'h1000: 	// MUL
	begin
		EX_WB[31:0] = ID_EX[63:32] * ID_EX[95:64];
	end
16'h2000: 	// HLT
	begin
		$stop;
	end  
16'h4000: 	// NOP
	begin
	end
endcase
end
endmodule


