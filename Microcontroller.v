`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:05:39 12/13/2017 
// Design Name: 
// Module Name:    Microcontroller 
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
module Microcontroller(
		input i_CLK,
		input i_CLK_MEM,
		input i_RST,	// active low
		input [15:0] i_DIP_DATA,
		output [7:0] o_PC,
		output [15:0] o_INSTR,
		output o_Z,
		output o_S,
		output o_C,
		output o_OF,
		output o_ShowR1,
		output o_ShowR2,
		output [7:0] o_RegShowing1,
		output [7:0] o_RegShowing2
    );
	 
	 wire [7:0] _Result;
	 wire [7:0] _Result2;
	 wire [7:0] _IMM8;
	 wire [7:0] _IMM8_2;
	 
	 PC _PC_Module (
    .i_CLK(i_CLK),
    .i_RST(i_RST), 
	.i_SEL_JMP(_SEL_JMP),
	.i_JMP_ADDR(_IMM8),
    .o_PC(o_PC)
    );
	 
	 InstructionMemory _InstructionMemory (
		.clka(i_CLK_MEM), // input clka
		.addra(o_PC), // input [7 : 0] addra
		.douta(o_INSTR) // output [15 : 0] douta
	 );
	 
	ClockDelayer2HF _ClockDelayer2HF (
    .i_CLK(i_CLK), 
    .i_CLK_HF(i_CLK_MEM), 
    .o_CLK(_CLK_Delayed2HF)
    );
	
	ClockDelayer2HF _ClockDelayer4HF (
    .i_CLK(_CLK_Delayed2HF), 
    .i_CLK_HF(i_CLK_MEM), 
    .o_CLK(_CLK_Delayed4HF)
    );
	 
	 wire [2:0] _AddrReg1;
	 wire [2:0] _AddrReg2_or_IMM3;
	 wire [4:0] _ALUOp;
	 
	 InstructionDecoder _InstructionDecoder (
    .i_Instr(o_INSTR),
	.i_Z(o_Z),
	.i_S(o_S),
	.i_C(o_C),
	.i_OF(o_OF),
	.i_DIP_DATA(i_DIP_DATA),
    .o_AddrReg1(_AddrReg1), 
    .o_AddrReg2(_AddrReg2_or_IMM3), 
	.o_IMM8(_IMM8),
	.o_IMM8_2(_IMM8_2),
    .o_ALUOp(_ALUOp), 
    .o_WriteBack(_WriteBack),
    .o_WriteBack2(_WriteBack2),
	.o_SEL_IMM3(_SEL_IMM3),
	.o_SEL_JMP(_SEL_JMP),
	.o_SEL_IMM8_DAT(_SEL_IMM8_DAT),
	.o_SEL_IMM8_DAT2(_SEL_IMM8_DAT2),
	.o_ShowR1(o_ShowR1),
	.o_ShowR2(o_ShowR2)
    );
	 
	 wire [7:0] _Data1;
	 wire [7:0] _Data2;
	 
	 RegisterBank _RegisterBank (
	 .i_CLK(_CLK_Delayed4HF), 
	.i_CLK_RO(i_CLK),
    .i_AddrReg1(_AddrReg1), 
    .i_AddrReg2(_AddrReg2_or_IMM3), 
    .i_AddrRegDest(_AddrReg1), 
	.i_AddrRegDest2(_AddrReg2_or_IMM3), 
    .i_WriteData(_Result), 
    .i_WriteData2(_Result2), 
	.i_IMM8_DAT(_IMM8),
	.i_IMM8_DAT2(_IMM8_2),
	.i_SEL_IMM8_DAT(_SEL_IMM8_DAT),
	.i_SEL_IMM8_DAT2(_SEL_IMM8_DAT2),
    .i_WriteBack(_WriteBack),
    .i_WriteBack2(_WriteBack2),
    .o_Data1(_Data1), 
    .o_Data2(_Data2),
	.o_RegShowing1(o_RegShowing1),
	.o_RegShowing2(o_RegShowing2)
    );
	 
	 ALU _ALU (
	 .i_CLK(_CLK_Delayed2HF),
	 .i_RST(i_RST),
    .i_Data1(_Data1), 
    .i_Data2(_SEL_IMM3 ? {5'b00, _AddrReg2_or_IMM3} : _Data2), 
    .i_ALUOp(_ALUOp), 
    .o_Result(_Result), 
    .o_Result2(_Result2), 
    .o_Z(o_Z), 
    .o_S(o_S), 
	.o_C(o_C),
    .o_OF(o_OF)
    );


endmodule
