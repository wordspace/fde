//`define IDEXMSB 175
`define ALUOP EX_WB[31:0]
`define SRC ID_EX[63:32]
`define TRG ID_EX[95:64]
`define ADDR ID_EX[100:96]
`define IMM ID_EX[127:112]
`define SHAMT ID_EX[180:176]

`timescale 1ns / 100ps


module execute(
	input clock,
	input reset,
	input [180:0] ID_EX,
	output reg [180:0] EX_WB  // [31:0] for ALUOP WB data  [68:64] for WB address [63:32] open??
	);
	
reg branchFlag;

/*always @ (posedge clock) begin
EX_WB[4:0]<=ID_EX[100:96];	// Destination bits go straight through
//EX_WB[37:6] where i want to store the WB data
end
*/

always @ (posedge clock)
case(ID_EX[175:160])
16'h1:	// Add
	begin
		ALUOP = SRC + TRG;
	end
16'h2:	// Sub
	begin
		ALUOP = SRC - TRG;
	end
16'h2: 	// Imm
	begin
		ALUOP = IMM;
	end 
16'h4: 	// Shift Left
	begin
		ALUOP = TRG << SHAMT;
	end 
16'h5:	// Shift Right
	begin
		ALUOP = TRG >> SHAMT;
	end
16'h6: 	// AND
	begin
		ALUOP = SRC & TRG;
	end
16'h7: 	// OR
	begin
		ALUOP = SRC | TRG;
	end 
16'h8:	// XOR
	begin
		ALUOP = SRC ^ TRG;
	end
16'h9: 	// BR "unconditional jump"
	begin
		ALUOP <= 
	end	
16'hA: 	// BNE
	begin
		if(SRC!=TRG)
			begin
				ALUOP = 
			end
	end					
16'hB: 	// MOV
	begin
		ALUOP =
	end
16'hC: 	// ADI
	begin
		ALUOP = 
	end
16'hD: 	// MUL
	begin
		ALUOP = SRC * TRG;
	end
16'hE: 	// HLT
	begin
		ALUOP =
	end
16'hF: 	// NOP
	begin
	end
endcase





