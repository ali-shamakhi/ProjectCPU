`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:53:15 11/22/2017 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`include "Constants.v"

module ALU(
	input i_CLK, // action at posedge
	input i_RST,	// active low
    input [7:0] i_Data1,
    input [7:0] i_Data2,
    input [4:0] i_ALUOp,
    output reg [7:0] o_Result,
    output reg [7:0] o_Result2,
    output reg o_Z,
	output reg o_S,
    output reg o_C,
    output reg o_OF
    );
	 
	 reg [7:0] _temp;
	 
	 //reg _Z;
	 //reg _S;
	 //reg _C;
	 //reg _OF;
	 
	initial
	begin
		o_Result = 8'h00;
		o_Result2 = 8'h00;
		o_Z = 1'b0;
		o_S = 1'b0;
		o_C = 1'b0;
		o_OF = 1'b0;
		
		_temp = 8'h00;
		
		//_Z = 1'b0;
		//_S = 1'b0;
		//_C = 1'b0;
		//_OF = 1'b0;
	end

	//always @(negedge i_CLK)
	//begin
	//	// write-back flags
	//	o_Z = _Z;
	//	o_S = _S;
	//	o_C = _C;
	//	o_OF = _OF;
	//end
		
		always @(negedge i_RST or negedge i_CLK)
		begin
			
			if (i_RST == 1'b0)
			begin
				o_Result = 8'h00;
				o_Result2 = 8'h00;
				o_Z = 1'b0;
				o_S = 1'b0;
				o_C = 1'b0;
				o_OF = 1'b0;
			end
			else
			case(i_ALUOp)
			
				`ALUOP_PD1:
				begin
					o_Result = i_Data1;
				end
			
				`ALUOP_PD2:
				begin
					o_Result = i_Data2;
				end
				
				`ALUOP_PDS:
				begin
					o_Result = i_Data1;
					o_Result2 = i_Data2;
				end
				
				`ALUOP_ADD:
				begin
					{o_C, o_Result} = i_Data1 + i_Data2;
					o_S = o_Result[7];
					o_OF = (i_Data1[7] == i_Data2[7] ? o_Result[7] != i_Data1[7] : 1'b0);
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
			
				`ALUOP_SUB:
				begin
					{o_C, o_Result} = i_Data1 - i_Data2;
					o_S = o_Result[7];
					o_OF = (i_Data1[7] != i_Data2[7] ? o_Result[7] != i_Data1[7] : 1'b0);
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_ADC:
				begin
					{o_C, o_Result} = i_Data1 + {7'h00, o_C};
					o_S = o_Result[7];
					o_OF = (i_Data1[7] == i_Data2[7] ? o_Result[7] != i_Data1[7] : 1'b0);
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_INC:
				begin
					{o_C, o_Result} = i_Data1 + 8'h01;
					o_S = o_Result[7];
					o_OF = (i_Data1[7] == 0 ? o_Result[7] != i_Data1[7] : 1'b0);
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_DEC:
				begin
					{o_C, o_Result} = i_Data1 - 8'h01;
					o_S = o_Result[7];
					o_OF = (i_Data1[7] != 0 ? o_Result[7] != i_Data1[7] : 1'b0);
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				// check signed or unsigned comparissons
				`ALUOP_SAR:
				begin
					o_Result = $signed(i_Data1) >>> i_Data2;
					if (i_Data2 > 0)
						o_C = i_Data1[i_Data2 - 1];
					o_OF = o_Result[7] != i_Data1[7];
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_SLR:
				begin
					o_Result = i_Data1 >> i_Data2;
					if (i_Data2 > 0)
						o_C = i_Data1[i_Data2 - 1];
					o_OF = o_Result[7] != i_Data1[7];
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_SAL:
				begin
					o_Result = $signed(i_Data1) <<< i_Data2;
					if (i_Data2 > 0)
						o_C = i_Data1[8 - i_Data2];
					o_OF = o_Result[7] != i_Data1[7];
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_SLL:
				begin
					o_Result = i_Data1 << i_Data2;
					if (i_Data2 > 0)
						o_C = i_Data1[8 - i_Data2];
					o_OF = o_Result[7] != i_Data1[7];
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_ROL:
				begin
					if (i_Data2 > 0)
					begin
						o_Result = (i_Data1 << i_Data2) | (i_Data1 >> (8 - i_Data2));
						o_C = i_Data1[8 - i_Data2];
					end
					o_OF = o_Result[7] != i_Data1[7];
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);						
				end
				
				`ALUOP_ROR:
				begin
					if (i_Data2 > 0)
					begin
						o_Result = (i_Data1 >> i_Data2) | (i_Data1 << (8 - i_Data2));
						o_C = i_Data1[i_Data2 - 1];
					end
					o_OF = o_Result[7] != i_Data1[7];
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_AND:
				begin
					o_Result = i_Data1 & i_Data2;
					o_C = 0;
					o_OF = 0;
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_OR :
				begin
					o_Result = i_Data1 | i_Data2;
					o_C = 0;
					o_OF = 0;
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_XOR:
				begin
					o_Result = i_Data1 ^ i_Data2;
					o_C = 0;
					o_OF = 0;
					o_S = o_Result[7];
					o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_CMP:
				begin
					{o_C, _temp} = i_Data1 - i_Data2;
					o_S = _temp[7];
					o_OF = (i_Data1[7] != i_Data2[7] ? _temp[7] != i_Data1[7] : 1'b0);
					o_Z = (_temp == 8'h00 ? 1'b1 : 1'b0);
				end
				
				`ALUOP_NOT:
				begin
					o_Result = ~i_Data1;
				end

			
			endcase
			
		end

endmodule
