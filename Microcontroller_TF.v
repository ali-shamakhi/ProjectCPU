`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:03:14 12/13/2017
// Design Name:   Microcontroller
// Module Name:   D:/ArchLab/ProjectCPU/Microcontroller_TF.v
// Project Name:  ProjectCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Microcontroller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Microcontroller_TF;

	// Inputs
	reg i_CLK;
	reg i_CLK_MEM;
	reg i_RST;

	// Outputs
	wire [7:0] o_PC;
	wire [15:0] o_INSTR;
	wire o_Z;
	wire o_S;
	wire o_C;
	wire o_OF;
	wire o_ShowR1;

	// Instantiate the Unit Under Test (UUT)
	Microcontroller micro (
		.i_CLK(i_CLK), 
		.i_CLK_MEM(i_CLK_MEM), 
		.i_RST(i_RST), 
		.o_PC(o_PC), 
		.o_INSTR(o_INSTR), 
		.o_Z(o_Z), 
		.o_S(o_S), 
		.o_C(o_C), 
		.o_OF(o_OF), 
		.o_ShowR1(o_ShowR1)
	);
	
	reg [2:0] _cnt;

	initial begin
		// Initialize Inputs
		i_CLK = 0;
		i_CLK_MEM = 0;
		i_RST = 0;
		
		_cnt = 0;

		// Wait 100 ns for global reset to finish
		#20;
		
		i_RST = 1;
        
		// Add stimulus here

	end
	
	always
	begin
	
		#1;
		i_CLK_MEM = ~i_CLK_MEM;
		_cnt = _cnt + 1;
		
		if (_cnt == 3'b111)
			i_CLK = ~i_CLK;
			
	end
      
endmodule

