`define _CNT_
`define INSTR_MODE i_Instr[15]
`define MODE_REG 1'b0
`define MODE_DAT 1'b1

`define R1LOC_REG i_Instr[5 -: 3]
`define R2LOC_REG i_Instr[2 -: 3]
`define RLOC_DAT i_Instr[10 -: 3]
`define DTADR_DAT i_Instr[7 -: 8]

`define ALUOP_NOP 5'h00
`define ALUOP_PD1 5'h01
`define ALUOP_PD2 5'h02
`define ALUOP_ADD 5'h03
`define ALUOP_SUB 5'h04
`define ALUOP_ADC 5'h05
`define ALUOP_INC 5'h06
`define ALUOP_DEC 5'h07
`define ALUOP_SAR 5'h08
`define ALUOP_SLR 5'h09
`define ALUOP_SAL 5'h0A
`define ALUOP_ROR 5'h0B
`define ALUOP_ROL 5'h0C
`define ALUOP_SLL 5'h0D
`define ALUOP_AND 5'h0E
`define ALUOP_OR 5'h0F
`define ALUOP_XOR 5'h10
`define ALUOP_NOT 5'h11

//`define ALUOP_ZER 5'h0F

`define OPCODE_REG i_Instr[14 -: 9]
// OPCODE REG
`define OPR_ADD 9'b000000001
`define OPR_AND 9'b000000010
`define OPR_SUB 9'b000000011
`define OPR_OR  9'b000000100
`define OPR_XOR 9'b000000101
`define OPR_MOV 9'b000000110
`define OPR_ADC 9'b000000111
`define OPR_NOT 9'b000001000
//---
`define OPR_SAR 9'b000001001
`define OPR_SLR 9'b000001010
`define OPR_SAL 9'b000001011
`define OPR_SLL 9'b000001100
`define OPR_ROL 9'b000001101
`define OPR_ROR 9'b000001110
//--
`define OPR_INC 9'b000001111
`define OPR_DEC 9'b000010000
`define OPR_NOP 9'b000000000
`define OPR_ShowR 9'b000010010
`define OPR_ShowRR 9'b000010011
`define OPR_LoadDipR 9'b000010100
`define OPR_LoadDipRR 9'b000010101
`define OPR_CMP 9'b000010110

// OPCODE DAT
`define OPR_JE 5'b10000
`define OPR_JB 5'b10001
`define OPR_JA 5'b10010
`define OPR_JL 5'b10011
`define OPR_JG 5'b10100
`define OPR_JMP 5'b10101
`define OPR_LI 5'b10110
`define OPR_LM 5'b10111
`define OPR_ShowDM 5'b11000
`define OPR_ShowIM 5'b11001

`define OPCODE_DAT i_Instr[14 -: 4]
