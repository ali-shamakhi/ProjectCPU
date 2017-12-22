`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:31:26 12/20/2017 
// Design Name: 
// Module Name:    ClockDelayer 
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
module ClockDelayer2HF(
    input i_CLK,
    input i_CLK_HF,
    output reg o_CLK
    );
	 
	 //parameter Num_HF_Delay = 2;
	 //reg [3:0] _N_HFD_count;
	 
	 reg _CLK_next2;
	 reg _CLK_next1;
	 
	initial
	begin
		o_CLK = 0;
		_CLK_next2 = 0;
		_CLK_next1 = 0;
	end
	
	always @(posedge i_CLK_HF)
	begin
		o_CLK = _CLK_next1;
		_CLK_next1 = _CLK_next2;
		_CLK_next2 = i_CLK;
	end

endmodule
