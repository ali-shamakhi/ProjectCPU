`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:21:04 10/18/2017 
// Design Name: 
// Module Name:    DIP_Parallelizer 
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
module DIP_Parallelizer(
    input i_CLK,	// ~i_CLK to DIP_CLK
    input i_Data,
    input i_RESET,
    output reg [15:0] o_DIP16,
    output o_DIPLatch
    );
	
	reg [3:0] _pos;
	
	reg _working;
	
	reg _last_pos_low;
	
	reg [15:0] _int_DIP16;

	assign o_DIPLatch = _last_pos_low | i_CLK | ~_working;

	initial
	begin
	
		_pos = 4'h0;
		_working = 0;
		_int_DIP16 = 16'h0000;
		o_DIP16 = 16'h0000;
		
		_last_pos_low = 0;
		
	end
	
	always @ (posedge i_CLK)
	begin
		
		if (i_RESET)
		begin
		
			_pos = 4'h0;
			_working = 0;
			_int_DIP16 = 16'h0000;
			o_DIP16 = 16'h0000;
			
		end
			
		if (_pos == 4'h0)
			o_DIP16 = _int_DIP16;
		
		if (_working)
			_int_DIP16[_pos ^ 4'h8] = i_Data;
			
		if (~i_RESET)
		begin
			if (_working == 0)
				_working = 1;
			else if (_working == 1)
				_pos = _pos + 1;
		end
		
	end
	
	always @ (negedge i_CLK)
	begin
	
		if (_pos == 4'h0)
		begin
			_last_pos_low = 0;
		end
		else
			_last_pos_low = 1;
	
	end


endmodule
