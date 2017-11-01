`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:42:44 10/25/2017
// Design Name:   SevenSegment_Driver
// Module Name:   D:/ArchLab/ProjectCPU/SevenSegment_Driver_TF.v
// Project Name:  ProjectCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SevenSegment_Driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module SevenSegment_Driver_TF;

	// Inputs
	reg [12:0] i_Bin13;
	reg i_CLK;
	reg i_CLK_Bin2BCD;
	
	reg [3:0] c;

	// Outputs
	wire o_SegData;
	wire o_SegLatch;

	// Instantiate the Unit Under Test (UUT)
	SevenSegment_Driver uut (
		.i_Bin13(i_Bin13), 
		.i_CLK(i_CLK),
		.i_CLK_Bin2BCD(i_CLK_Bin2BCD),
		.o_SegData(o_SegData), 
		.o_SegLatch(o_SegLatch)
	);

	always
	begin
		#1
		c = c + 1;
		if (c == 0) i_CLK = ~i_CLK;
		i_CLK_Bin2BCD = ~i_CLK_Bin2BCD;
	end

	initial begin
		// Initialize Inputs
		c = 0;
		i_CLK_Bin2BCD = 0;
		i_Bin13 = 0;
		i_CLK = 0;

		// Wait 100 ns for global reset to finish
		#30;
        
		// Add stimulus here
		
		i_Bin13 = 13'b0000000000001;
		#600
		i_Bin13 = 13'b0000000100000;

	end
      
endmodule

