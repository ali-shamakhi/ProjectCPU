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
	 //output reg o_CLK_ID
    );
	
	initial
	begin
		o_AddrReg1 = 3'b000;
		o_AddrReg2 = 3'b000;
		o_ALUOp = 4'h0;
		o_WriteBack = 1'b0;
		o_ShowR1 = 1'b0;
		//o_CLK_ID = 1'b1;
	end
	
	always @(i_Instr)
	begin
	
		//o_CLK_ID = ~o_CLK_ID;
	
		case(`INSTR_MODE)
		
			`MODE_REG:
			begin
			
				o_AddrReg1 = `R1LOC_REG;
				o_AddrReg2 = `R2LOC_REG;
				
				// ShowR1 control flag
				case(`OPCODE_REG)
					`OPR_ShowR:
						o_ShowR1 = 1'b1;
					
					default:
						o_ShowR1 = 1'b0;
					
				endcase
				
				// WriteBack control flag
				case(`OPCODE_REG)
				
					`OPR_ADD,
					`OPR_AND,
					`OPR_SUB,
					`OPR_OR ,
					`OPR_XOR,
					`OPR_MOV,
					`OPR_ADC,
					`OPR_NOT,
					`OPR_SAR,
					`OPR_SLR,
					`OPR_SAL,
					`OPR_SLL,
					`OPR_ROL,
					`OPR_ROR:
						o_WriteBack = 1'b1;
					
					default:
						o_WriteBack = 1'b0;
					
				endcase
				
				// ALU operation
				case(`OPCODE_REG)
			
					`OPR_ShowR:
						o_ALUOp = `ALUOP_PD1;
						
					`OPR_ADD:
						o_ALUOp = `ALUOP_ADD;
						
					`OPR_AND:
						o_ALUOp = `ALUOP_AND;
					
					`OPR_SUB:
						o_ALUOp = `ALUOP_SUB;
						
					`OPR_OR:
						o_ALUOp = `ALUOP_OR;
						
					`OPR_XOR:
						o_ALUOp = `ALUOP_XOR;
						
					`OPR_MOV:
						o_ALUOp = `ALUOP_PD2;
						
					`OPR_ADC:
						o_ALUOp = `ALUOP_ADC;
						
					`OPR_NOT:
						o_ALUOp = `ALUOP_NOT;
						
					`OPR_SAR:
						o_ALUOp = `ALUOP_SAR;
						
					`OPR_SLR:
						o_ALUOp = `ALUOP_SLR;
						
					`OPR_SAL:
						o_ALUOp = `ALUOP_SAL;
						
					`OPR_SLL:
						o_ALUOp = `ALUOP_SLL;
						
					`OPR_ROL:
						o_ALUOp = `ALUOP_ROL;
						
					`OPR_ROR:
						o_ALUOp = `ALUOP_ROR;
						
					
					default:
						o_ALUOp = `ALUOP_PD1;
				
				endcase
						
			end
		
			//MODE_DAT:

			//default:
		
		endcase
		
		//o_CLK_ID = 1'b1;
		
	end

endmodule
