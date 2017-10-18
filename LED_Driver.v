`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:21:50 10/09/2017 
// Design Name: 
// Module Name:    LED_Driver 
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
module LED_Driver(
    input i_CLK,	// ~i_CLK to LED_CLK
    input [15:0] i_Data16,
    input i_RESET,
    output o_LEDData,
    output o_LEDLatch	// active low
    );
	
	reg [3:0] _pos;
	
	reg _working;
	
	reg _last_pos_low;
	
	reg [15:0] _int_LED16;

	assign o_LEDData = _int_LED16[_pos ^ 4'h8];
	
	assign o_LEDLatch = ~(~_last_pos_low & ~i_CLK & _working);

	initial
	begin
	
		_pos = 4'hF;
		_working = 0;
		_last_pos_low = 0;
		_int_LED16 = 16'h0000;
		
	end
	
	always @ (posedge i_CLK)
	begin
	
		if (i_RESET)
		begin
		
			_pos = 4'hF;
			_working = 0;
			_int_LED16 = 16'h0000;
			
		end
		
		if (~i_RESET)
		begin
			if (_working == 0)
				_working = 1;
			else if (_working == 1)
				_pos = _pos - 1;
		end
		
		if (_pos == 4'hF)
			_int_LED16 = i_Data16;
		
	end
	
	always @ (negedge i_CLK)
	begin
		
		if (_pos == 4'h0)
			_last_pos_low = 0;
		else
			_last_pos_low = 1;
	end

endmodule
