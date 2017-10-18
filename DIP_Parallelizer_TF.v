`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:01:39 10/18/2017
// Design Name:   DIP_Parallelizer
// Module Name:   D:/ArchLab/ProjectCPU/DIP_Parallelizer_TF.v
// Project Name:  ProjectCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DIP_Parallelizer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DIP_Parallelizer_TF;

	// Inputs
	reg i_CLK;
	reg i_Data;
	reg i_RESET;

	// Outputs
	wire [15:0] o_DIP16;
	wire o_DIPLatch;

	// Instantiate the Unit Under Test (UUT)
	DIP_Parallelizer uut (
		.i_CLK(i_CLK), 
		.i_Data(i_Data), 
		.i_RESET(i_RESET), 
		.o_DIP16(o_DIP16), 
		.o_DIPLatch(o_DIPLatch)
	);

	always
		#5 i_CLK = !i_CLK;

	initial begin
		// Initialize Inputs
		i_CLK = 1;
		i_Data = 0;
		i_RESET = 1;

		// Wait X ns for global reset to finish
		#15;
        
		// Add stimulus here
		
		i_RESET = 0;
		#10
		
		i_Data = 1;
		#10;
		i_Data = 0;
		#10;
		i_Data = 0;
		#10;
		i_Data = 0;
		#10;
		i_Data = 0;
		#10;
		i_Data = 1;
		#10;
		i_Data = 1;
		#10;
		i_Data = 0;
		#10;
		
		i_Data = 0;
		#10;
		i_Data = 1;
		#10;
		i_Data = 0;
		#10;
		i_Data = 0;
		#10;
		i_Data = 1;
		#10;
		i_Data = 0;
		#10;
		i_Data = 0;
		#10;
		i_Data = 0;
		#10;

	end
      
endmodule

