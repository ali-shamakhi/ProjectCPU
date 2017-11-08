`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:15:39 11/07/2017 
// Design Name: 
// Module Name:    DeBouncer 
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
module DeBouncer(
    input i_Data,
    input i_CLK,
    output reg o_Data
    );
	 
	 unsigned reg [19:0] _count;
	 
		initial
		begin
	      _count = 0;
		end
		
		always @(posedge i_CLK)
		begin
		
			if (i_Data == ~o_Data)
					_count = _count + 1;
				else
					_count = 0;
					
			if (_count >= 500000)
			begin
				_count = 0;
				o_Data = i_Data;
			end
			
		end

endmodule
