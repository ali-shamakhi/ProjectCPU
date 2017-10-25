`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:50 10/09/2017 
// Design Name: 
// Module Name:    SevenSeg_Seriallizer 
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
module SevenSeg_Seriallizer (
    input i_CLK,	// ~i_CLK to 7SEG_CLK
    input [12:0] i_7SegData16,
    input i_RESET,
    output o_7SegData,
    output o_7Seg_Latch	// active low
    );
	
	reg [4:0] _pos;
	
	reg _working;
	
	reg _last_pos_low;
	
	reg [12:0] _int_7SegData;

	assign o_7SegData = _int_7SegData[_pos];
	
	assign o_7Seg_Latch = ~(~_last_pos_low & ~i_CLK & _working);

	initial
	begin
	
		_pos = 4'h0;
		_working = 0;
		_last_pos_low = 0;
		_int_7SegData = 13'b0000000000000;
		
	end
	
	always @ (posedge i_CLK)
	begin
	
		if (i_RESET)
		begin
		
			_pos = 4'h0;
			_working = 0;
			_int_7SegData = 13'b0000000000000;
			
		end
		
		
		if (~i_RESET)
		begin
			if (_working == 0)
				_working = 1;
			else if (_working == 1)
				_pos = _pos + 1;
			if (_pos == 13)
				_pos = 0;
		end
		
		if (_pos == 4'hF)
			_int_7SegData = i_7SegData16;
		
	end
	
	always @ (negedge i_CLK)
	begin
		
		if (_pos == 12)
			_last_pos_low = 0;
		else
			_last_pos_low = 1;
	end

endmodule
