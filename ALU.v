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
	input i_CLK, // action at posedge, flags write-back at negedge
    input [7:0] i_Data1,
    input [7:0] i_Data2,
    input [3:0] i_ALUOp,
    output reg [7:0] o_Result,
    output reg o_Z,
	 output reg o_S,
    output reg o_C,
    output reg o_OF
    );
	 
	 reg _Z;
	 reg _S;
	 reg _C;
	 reg _OF;
	 
	initial
	begin
		o_Result = 8'h00;
		o_Z = 1'b0;
		o_S = 1'b0;
		o_C = 1'b0;
		o_OF = 1'b0;
		
		_Z = 1'b0;
		_S = 1'b0;
		_C = 1'b0;
		_OF = 1'b0;
	end

	always @(negedge i_CLK)
	begin
		// write-back flags
		o_Z = _Z;
		o_S = _S;
		o_C = _C;
		o_OF = _OF;
	end

	always @(i_Data1 or i_Data2 or i_ALUOp)
	begin
		
		if (i_CLK)
		begin
		
			case(i_ALUOp)
			
				`ALUOP_PD1:
				begin
					o_Result = i_Data1;
				end
			
				`ALUOP_PD2:
				begin
					o_Result = i_Data2;
				end
				
				`ALUOP_ADD:
				begin
					{_C, o_Result} = i_Data1 + i_Data2;
					_S = o_Result[7];
					_OF = (i_Data1[7] == i_Data2[7] ? o_Result[7] != i_Data1[7] : 1'b0);
					_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
			
				`ALUOP_SUB:
				begin
					{_C, o_Result} = i_Data1 - i_Data2;
					_S = o_Result[7];
					_OF = (i_Data1[7] != i_Data2[7] ? o_Result[7] != i_Data1[7] : 1'b0);
					_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
				end
			
			endcase
			
		end
		
	end

endmodule
