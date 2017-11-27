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
    input [7:0] i_Data1,
    input [7:0] i_Data2,
    input [3:0] i_ALUOp,
    output reg [7:0] o_Result,
    output reg o_Z,
	 output reg o_S,
    output reg o_C,
    output reg o_OF
    );
	 
	initial
	begin
		o_Result = 8'h00;
		o_Z = 1'b0;
		o_S = 1'b0;
		o_OF = 1'b0;
		o_C = 1'b0;
	end

	always @(i_Data1, i_Data2, i_ALUOp)
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
				o_Result = i_Data1 + i_Data2;
				o_S = o_Result[7];
				o_OF = (i_Data1[7] == i_Data2[7] ? o_S != i_Data1[7] : 1'b0);
				o_Z = (o_Result == 8'h00 ? 1'b1 : 1'b0);
			end
			
			`ALUOP_ZER:
			begin
				o_Result = 8'h00;
				o_Z = 1'b1;
			end
			
		endcase
		
	end

endmodule
