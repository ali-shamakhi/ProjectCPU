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
`define ALUOP_MUL 4'h4
`define ALUOP_DIV 4'h5
`define ALUOP_SHL 4'h6
`define ALUOP_SHR 4'h7

`define ALUOP_ZER 4'hF

`define OPCODE_REG i_Instr[14 -: 9]
// OPCODE REG
`define OPR_Add 9'b000000001
`define OPR_ShowR 9'b000010010

`define OPCODE_DAT i_Instr[14 -: 4]
