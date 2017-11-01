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
    input [15:0] i_7SegData16_0,
    input [15:0] i_7SegData16_1,
    input [15:0] i_7SegData16_2,
    input [15:0] i_7SegData16_3,
    input i_RESET,
    output o_7SegData,
    output o_7Seg_Latch	// active low
    );
	
	reg [5:0] _pos;
	
	reg _working;
	
	reg _last_pos_low;
	
	reg [63:0] _int_7SegData64;

	assign o_7SegData = _int_7SegData64[_pos];
	
	assign o_7Seg_Latch = ~(~_last_pos_low & ~i_CLK & _working);

	initial
	begin
	
		_pos = 6'h0;
		_working = 0;
		_last_pos_low = 0;
		_int_7SegData64 = 64'h0000000000000000;
		
	end
	
	always @ (posedge i_CLK)
	begin
	
		if (i_RESET)
		begin
		
			_pos = 6'h0;
			_working = 0;
			_int_7SegData64 = 64'h0000000000000000;
			
		end
		
		
		if (~i_RESET)
		begin
			if (_working == 0)
				_working = 1;
			else if (_working == 1)
				_pos = _pos + 1;
		end
		
		if (_pos == 6'b000000)
		begin
			_int_7SegData64[15 -: 16] = i_7SegData16_0;
			_int_7SegData64[31 -: 16] = i_7SegData16_1;
			_int_7SegData64[47 -: 16] = i_7SegData16_2;
			_int_7SegData64[63 -: 16] = i_7SegData16_3;
		end
		
	end
	
	always @ (negedge i_CLK)
	begin
		
		if (_pos[3 -: 4] == 4'b1111)
			_last_pos_low = 0;
		else
			_last_pos_low = 1;
	end

endmodule
