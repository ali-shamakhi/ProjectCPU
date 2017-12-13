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
		output [7:0] o_PC,
		output [15:0] o_INSTR,
		output o_Z,
		output o_S,
		output o_C,
		output o_OF,
		output o_ShowR1
    );
	 
	 PC _PC_Module (
    .i_CLK(i_CLK),
    .i_RESET(i_RST), 
    .o_PC(o_PC)
    );
	 
	 InstructionMemory _InstructionMemory (
		.clka(i_CLK_MEM), // input clka
		.addra(o_PC), // input [7 : 0] addra
		.douta(o_INSTR) // output [15 : 0] douta
	 );
	 
	 wire [2:0] _AddrReg1;
	 wire [2:0] _AddrReg2;
	 wire [3:0] _ALUOp;
	 
	 InstructionDecoder _InstructionDecoder (
    .i_Instr(o_INSTR), 
    .o_AddrReg1(_AddrReg1), 
    .o_AddrReg2(_AddrReg2), 
    .o_ALUOp(_ALUOp), 
    .o_WriteBack(_WriteBack),
	.o_ShowR1(o_ShowR1)
    );
	 
	 wire [7:0] _Result;
	 
	 wire [7:0] _Data1;
	 wire [7:0] _Data2;
	 
	 RegisterBank _RegisterBank (
    .i_AddrReg1(_AddrReg1), 
    .i_AddrReg2(_AddrReg2), 
    .i_AddrRegDest(_AddrReg1), 
    .i_WriteData(_Result), 
    .i_WriteBack(_WriteBack),
    .i_CLK(_PC_INC), 
    .o_Data1(_Data1), 
    .o_Data2(_Data2)
    );
	 
	 ALU _ALU (
	 .i_CLK(i_CLK),
    .i_Data1(_Data1), 
    .i_Data2(_Data2), 
    .i_ALUOp(_ALUOp), 
    .o_Result(_Result), 
    .o_Z(o_Z), 
    .o_S(o_S), 
	.o_C(o_C),
    .o_OF(o_OF)
    );


endmodule
