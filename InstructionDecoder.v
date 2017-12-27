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
	input i_Z,
	input i_S,
	input i_C,
	input i_OF,
	input [15:0] i_DIP_DATA,
    output reg [2:0] o_AddrReg1,
    output reg [2:0] o_AddrReg2,
	output reg [7:0] o_IMM8,
	output reg [7:0] o_IMM8_2,
    output reg [4:0] o_ALUOp,
	 output reg o_WriteBack,
	 output reg o_WriteBack2,
	 output reg o_SEL_IMM3,
	 output reg o_SEL_JMP,
	 output reg o_SEL_IMM8_DAT,
	 output reg o_SEL_IMM8_DAT2,
	 output reg o_ShowR1,
	 output reg o_ShowR2
	 //output reg o_CLK_ID
    );
	
	initial
	begin
		o_AddrReg1 = 3'b000;
		o_AddrReg2 = 3'b000;
		o_IMM8 = 8'h00;
		o_IMM8_2 = 8'h00;
		o_ALUOp = 5'h00;
		o_WriteBack = 1'b0;
		o_WriteBack2 = 1'b0;
		o_SEL_IMM3 = 1'b0;
		o_SEL_JMP = 1'b0;
		o_SEL_IMM8_DAT = 1'b0;
		o_SEL_IMM8_DAT2 = 1'b0;
		o_ShowR1 = 1'b0;
		o_ShowR2 = 1'b0;
		//o_CLK_ID = 1'b1;
	end
	
	always @(i_Instr)
	begin
	
		//o_CLK_ID = ~o_CLK_ID;
	
		// TODO: always check for all flags
		case(`INSTR_MODE)
		
			`MODE_REG:
			begin
			
				o_AddrReg1 = `R1LOC_REG;
				o_AddrReg2 = `R2LOC_REG;
				
				// _SEL_IMM8_DAT
				case(`OPCODE_REG)
					`OPR_LoadDipR:
					begin
						o_SEL_IMM8_DAT = 1'b1;
						o_SEL_IMM8_DAT2 = 1'b0;
					end
						
					`OPR_LoadDipRR:
					begin
						o_SEL_IMM8_DAT = 1'b1;
						o_SEL_IMM8_DAT2 = 1'b1;
					end
						
					default:
					begin
						o_SEL_IMM8_DAT = 1'b0;
						o_SEL_IMM8_DAT2 = 1'b0;
					end
						
				endcase
				
				// JMP control flag
				o_SEL_JMP = 1'b0;
				
				// ShowR control flag
				case(`OPCODE_REG)
					`OPR_ShowRR:
					begin
						o_ShowR1 = 1'b1;
						o_ShowR2 = 1'b1;
					end
						
					`OPR_ShowR:
					begin
						o_ShowR1 = 1'b1;
						o_ShowR2 = 1'b0;
					end
					
					default:
					begin
						o_ShowR1 = 1'b0;
						o_ShowR2 = 1'b0;
					end
					
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
					`OPR_ROR,
					`OPR_INC,
					`OPR_DEC,
					`OPR_LoadDipR:
					begin
						o_WriteBack = 1'b1;
						o_WriteBack2 = 1'b0;
					end
						
					`OPR_LoadDipRR:
					begin
						o_WriteBack = 1'b1;
						o_WriteBack2 = 1'b1;
					end
					
					default:
					begin
						o_WriteBack = 1'b0;
						o_WriteBack2 = 1'b0;
					end
					
				endcase
				
				// SEL_IMM3 control flag
				case(`OPCODE_REG)
				
					`OPR_SAR,
					`OPR_SLR,
					`OPR_SAL,
					`OPR_SLL,
					`OPR_ROL,
					`OPR_ROR:
						o_SEL_IMM3 = 1'b1;
					
					default:
						o_SEL_IMM3 = 1'b0;
					
				endcase
				
				// ALU operation
				case(`OPCODE_REG)
						
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
					
					`OPR_INC:
						o_ALUOp = `ALUOP_INC;
					
					`OPR_DEC:
						o_ALUOp = `ALUOP_DEC;
					
					`OPR_NOP:
						o_ALUOp = `ALUOP_NOP;
					
					`OPR_ShowR:
						//o_ALUOp = `ALUOP_PD1;
						o_ALUOp = `ALUOP_NOP;
					
					`OPR_ShowRR:
						//o_ALUOp = `ALUOP_PDS;
						o_ALUOp = `ALUOP_NOP;
					
					`OPR_LoadDipR:
					begin
						o_IMM8 = i_DIP_DATA[7 -: 8];
						o_ALUOp = `ALUOP_PD1;
					end
					
					`OPR_LoadDipRR:
					begin
						o_IMM8 = i_DIP_DATA[15 -: 8];
						o_IMM8_2 = i_DIP_DATA[7 -: 8];
						o_ALUOp = `ALUOP_PDS;
					end
					
					`OPR_CMP:
						o_ALUOp = `ALUOP_CMP;
					
					default:
						o_ALUOp = `ALUOP_NOP;
				
				endcase
						
			end
		
			`MODE_DAT:
			begin
				
				o_AddrReg1 = `RLOC_DAT;
				o_IMM8 = `DTADR_DAT;
				
				o_SEL_IMM8_DAT = 1'b1;
				
				// ShowR control flag
				o_ShowR1 = 1'b0;
				o_ShowR2 = 1'b0;
				
				// SEL_IMM3 control flag
				o_SEL_IMM3 = 1'b0;
				
				// WriteBack control flag
				o_WriteBack2 = 1'b0;
				case(`OPCODE_DAT)
				
					`OPR_LI,
					`OPR_LM:
						o_WriteBack = 1'b1;
					
					default:
						o_WriteBack = 1'b0;
					
				endcase
				
				// ALU operation
				case(`OPCODE_DAT)
				
					`OPR_LI,
					`OPR_LM:
						o_ALUOp = `ALUOP_PD1;
						
					default:
						o_ALUOp = `ALUOP_NOP;
				
				endcase
				
				// JMP control flag
				case(`OPCODE_DAT)
				
					`OPR_JE:
						o_SEL_JMP = i_Z;
					
					`OPR_JB:
						o_SEL_JMP = i_C;
					
					`OPR_JA:
						o_SEL_JMP = (~i_C) & (~i_Z);
					
					`OPR_JL:
						o_SEL_JMP = (i_S ^ i_OF);
					
					`OPR_JG:
						o_SEL_JMP = (~(i_S ^ i_OF)) & (~i_Z);
						
					`OPR_JMP:
						o_SEL_JMP = 1'b1;
					
					default:
						o_SEL_JMP = 1'B0;	
		
				endcase
				
			end
		
		//o_CLK_ID = 1'b1;
		
		endcase
		
	end

endmodule
