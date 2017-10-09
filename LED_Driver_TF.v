`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:04:03 10/09/2017
// Design Name:   LED_Driver
// Module Name:   D:/ArchLab/ProjectCPU/LED_Driver_TF.v
// Project Name:  ProjectCPU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: LED_Driver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module LED_Driver_TF;

	// Inputs
	reg i_CLK;
	reg [15:0] i_Data16;
	reg i_RESET;

	// Outputs
	wire o_LEDData;
	wire o_LEDLatch;

	// Instantiate the Unit Under Test (UUT)
	LED_Driver uut (
		.i_CLK(i_CLK), 
		.i_Data16(i_Data16), 
		.i_RESET(i_RESET), 
		.o_LEDData(o_LEDData), 
		.o_LEDLatch(o_LEDLatch)
	);

	always
		#5 i_CLK = !i_CLK;

	initial begin
		// Initialize Inputs
		i_CLK = 0;
		i_Data16 = 0;
		i_RESET = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		i_RESET = 0;
		
		i_Data16 = 16'h9D1F;

	end
      
endmodule

