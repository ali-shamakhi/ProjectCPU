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
	
	reg o_LL;

	assign o_LEDData = i_Data16[_pos ^ 4'h8];
	//assign o_LL = !(_pos == 4'hF);
	assign o_LEDLatch = o_LL | i_CLK;

	initial
	begin
	
		_pos = 4'h0;
		_working = 0;
		
	end
	
	always @ (posedge i_CLK)
	begin
	
		//o_LL = 1;
	
		if (i_RESET)
		begin
		
			_pos = 4'h0;
			_working = 0;
			
		end
		else
		if (_working == 0)
			_working = 1;
		else if (_working == 1)
			_pos = _pos + 1;
		
	end
	
	always @ (negedge i_CLK)
	begin
		
		if (_pos == 4'hF)
			o_LL = 0;
		else
			o_LL = 1;
	end

endmodule
