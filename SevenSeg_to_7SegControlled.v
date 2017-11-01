`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:27:54 10/25/2017 
// Design Name: 
// Module Name:    SevenSeg_to_7SegControlled 
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
module SevenSeg_to_7SegControlled(
    input [7:0] i_7Seg,
	input [1:0] i_Position,
    output [15:0] o_7SegControlled
    );
	 
	 reg [7:0] _int_cont;
	 
	 assign o_7SegControlled[15 -: 8] = i_7Seg;
	 
	 assign o_7SegControlled[7 -: 8] = _int_cont;
	 
	 always @(i_7Seg, i_Position)
	 
	 begin
	 
		case(i_Position)
		
			2'b00: _int_cont = 8'b01000000;
			2'b01: _int_cont = 8'b00100000;
			2'b10: _int_cont = 8'b00001000;
			2'b11: _int_cont = 8'b00000100;
			default: _int_cont = 8'b00000000;
		
		endcase
		
	end

endmodule
