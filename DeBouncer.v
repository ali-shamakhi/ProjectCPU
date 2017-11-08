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
	 
	 reg [19:0] _count;
	 
		initial
		begin
	      _count = 20'd0;
			o_Data = 1;
		end
		
		always @(posedge i_CLK)
		begin
		
			if (i_Data != o_Data)
				_count = _count + 20'd1;
			else
				_count = 20'd0;
					
			if (_count >= 20'd500000)
			begin
				_count = 20'd0;
				o_Data = ~o_Data;
			end
			
		end

endmodule
