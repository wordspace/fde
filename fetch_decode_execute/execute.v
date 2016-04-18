`timescale 1ns / 100ps

module execute(
	input clock,
	input reset,
	input [180:0] ID_EX,
	output reg [180:0] EX_WB  // [31:0] for EX_WB[31:0] WB data  [68:64] for WB address [63:32] open??
	);
	
reg branchFlag;

initial @ (posedge clock) begin
EX_WB[4:0]<=ID_EX[100:96];	// Destination bits go straight through
//EX_WB[37:6] where i want to store the WB data
end

always @ (posedge clock)
case(ID_EX[175:160])
16'h1:	// Add
	begin
		EX_WB[31:0] = ID_EX[63:32] + ID_EX[95:64];
	end
16'h2:	// Sub
	begin
		EX_WB[31:0] = ID_EX[63:32] - ID_EX[95:64];
	end
16'h2: 	// ID_EX[127:112]
	begin
		EX_WB[31:0] = ID_EX[127:112];
	end 
16'h4: 	// Shift Left
	begin
		EX_WB[31:0] = ID_EX[95:64] << ID_EX[180:176];
	end 
16'h5:	// Shift Right
	begin
		EX_WB[31:0] = ID_EX[95:64] >> ID_EX[180:176];
	end
16'h6: 	// AND
	begin
		EX_WB[31:0] = ID_EX[63:32] & ID_EX[95:64];
	end
16'h7: 	// OR
	begin
		EX_WB[31:0] = ID_EX[63:32] | ID_EX[95:64];
	end 
16'h8:	// XOR
	begin
		EX_WB[31:0] = ID_EX[63:32] ^ ID_EX[95:64];
	end
/*16'h9: 	// BR "unconditional jump"
	begin
		EX_WB[31:0] <= 
	end	
16'hA: 	// BNE
	begin
		if(ID_EX[63:32]!=ID_EX[95:64])
			begin
				EX_WB[31:0] = 
			end
	end					
16'hB: 	// MOV
	begin
		EX_WB[31:0] =
	end
16'hC: 	// ADI
	begin
		EX_WB[31:0] = 
	end*/
16'hD: 	// MUL
	begin
		EX_WB[31:0] = ID_EX[63:32] * ID_EX[95:64];
	end
/*16'hE: 	// HLT
	begin
		EX_WB[31:0] =
	end  */
16'hF: 	// NOP
	begin
	end
endcase
endmodule


