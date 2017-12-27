`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:35 11/08/2017 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input i_CLK,					// posedge action
    input i_RST,				// active low
	input i_SEL_JMP,
	input [7:0] i_JMP_ADDR,
    output reg [7:0] o_PC
    );
	 
	 //reg [7:0] _next_PC;
	 
	initial
	begin
		o_PC = 8'hFF;
		//_next_PC = 8'h00;
	end
	
	always @(negedge i_RST or posedge i_CLK)
	begin
	
		if (i_RST == 1'b0)
		begin
			o_PC = 8'hFF;
			//_next_PC = 8'h00;
		end
		else
		begin
			if (i_SEL_JMP)
				o_PC = i_JMP_ADDR;
			else
				o_PC = o_PC + 8'h01;
			//_next_PC = _next_PC + 8'h01;
		end
	end

endmodule
