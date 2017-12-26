`define _CNT_
`define INSTR_MODE i_Instr[15]
`define MODE_REG 1'b0
`define MODE_DAT 1'b1

`define R1LOC_REG i_Instr[5 -: 3]
`define R2LOC_REG i_Instr[2 -: 3]
`define RLOC_DAT i_Instr[10 -: 3]
`define DTADR_DAT i_Instr[7 -: 8]

`define ALUOP_PD1 4'h0
`define ALUOP_PD2 4'h1
`define ALUOP_ADD 4'h2
`define ALUOP_SUB 4'h3
`define ALUOP_ADC 4'h4
//`define ALUOP_MUL 4'h4
//`define ALUOP_DIV 4'h5
`define ALUOP_SAR 4'h6
`define ALUOP_SLR 4'h7
`define ALUOP_SAL 4'h8
`define ALUOP_ROR 4'h9
`define ALUOP_ROL 4'hA
`define ALUOP_SLL 4'hB
`define ALUOP_AND 4'hC
`define ALUOP_OR 4'hD
`define ALUOP_XOR 4'hE
`define ALUOP_NOT 4'hF

//`define ALUOP_ZER 4'hF

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

`define OPR_ShowR 9'b000010010
`define OPR_ShowRR 9'b000010011

`define OPCODE_DAT i_Instr[14 -: 4]
