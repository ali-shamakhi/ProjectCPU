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
    input i_RESET,				// active low
    output reg [7:0] o_PC
    );
	 
	 reg [7:0] _next_PC;
	 
	initial
	begin
		o_PC = 8'h00;
		_next_PC = 8'h00;
	end
	
	always @(negedge i_RESET or posedge i_CLK)
	begin
	
		if (i_RESET == 1'b0)
		begin
			o_PC = 8'h00;
			_next_PC = 8'h00;
		end
		else
		begin
			o_PC = _next_PC;
			_next_PC = _next_PC + 8'h01;
		end
	end

endmodule
