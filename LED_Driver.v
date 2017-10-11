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
    output reg o_LEDData,
    output o_LEDLatch	// active low
    );
	
	reg [3:0] _pos;
	wire [3:0] _xpos;
	reg _carry;
	
	reg _working;

	assign _xpos = _pos ^ 4'h8;
	assign o_LEDLatch = !_carry;

	initial
	begin
	
		_pos = 4'h0;
		_carry = 1'b0;
		o_LEDData = 1'b0;
		_working = 0;
		
	end
	
	always @ (posedge i_CLK)
	begin
	
	//o_LEDLatch = 1'b1;
	
		if (i_RESET)
		begin
		
			_pos = 4'h0;
			_carry = 1'b0;
			o_LEDData = 1'b0;
			_working = 0;
			
		end
		
		else
		begin
			
			o_LEDData = i_Data16[_xpos];
			
		end
		
	end
	
	always @ (negedge i_CLK)
	begin
		
		if (i_RESET)
		begin
		
			_pos = 4'h0;
			_carry = 1'b0;
			o_LEDData = 1'b0;
			_working = 0;
			
		end
		
		
		else
		begin
		if (_working == 0)
			_working = 1;
		else
			{_carry, _pos} = _pos + 1;
		
		//if (_carry)
		//	o_LEDLatch = 1'b0;	// enable
		//else
		//	o_LEDLatch = 1'b1;	// disable
		end
			
		
		
	end

endmodule