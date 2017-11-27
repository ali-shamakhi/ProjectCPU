`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:10:19 11/22/2017 
// Design Name: 
// Module Name:    InstructionDecoder 
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
`ifndef _CNT_
`include "Constants.v"
`endif

module InstructionDecoder(
    input [15:0] i_Instr,
    output reg [2:0] o_AddrReg1,
    output reg [2:0] o_AddrReg2,
    output reg [3:0] o_ALUOp,
	 output reg o_WriteBack,
	 output reg o_ShowR1
    );
	
	initial
	begin
		o_AddrReg1 = 3'b000;
		o_AddrReg2 = 3'b000;
		o_ALUOp = 4'h0;
		o_WriteBack = 1'b0;
		o_ShowR1 = 1'b0;
	end
	
	always @(i_Instr)
	begin
	
		case(`INSTR_MODE)
		
			`MODE_REG:
			begin
			
				o_AddrReg1 <= `R1LOC_REG;
				o_AddrReg2 <= `R2LOC_REG;
				
				case(`OPCODE_REG)
					`OPR_ShowR:
						o_ShowR1 <= 1'b1;
					
					default:
						o_ShowR1 <= 1'b0;
					
				endcase
				
				case(`OPCODE_REG)
					`OPR_Add:
						o_WriteBack <= 1'b1;
					
					default:
						o_WriteBack <= 1'b0;
					
				endcase
				
				case(`OPCODE_REG)
			
					`OPR_ShowR:
						o_ALUOp <= `ALUOP_PD1;
						
					`OPR_Add:
						o_ALUOp <= `ALUOP_ADD;
						
					default:
						o_ALUOp <= `ALUOP_ZER;
				
				endcase
						
			end
		
			//MODE_DAT:

			//default:
		
		endcase
		
	end

endmodule
