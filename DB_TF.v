`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:03:44 11/08/2017
// Design Name:   DeBouncer
// Module Name:   D:/ArchLab/ProjectCPU/DB_TF.v
// Project Name:  ProjectCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: DeBouncer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module DB_TF;

	// Inputs
	reg i_Data;
	reg i_CLK;

	// Outputs
	wire o_Data;

	// Instantiate the Unit Under Test (UUT)
	DeBouncer uut (
		.i_Data(i_Data), 
		.i_CLK(i_CLK), 
		.o_Data(o_Data)
	);

	always
	begin
		#5 i_CLK = ~i_CLK;
	end

	initial begin
		// Initialize Inputs
		i_Data = 1;
		i_CLK = 1;

		// Wait 100 ns for global reset to finish
		#10	
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 0;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 0;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		#10
		i_Data = 1;
		
        
		// Add stimulus here

	end
      
endmodule

