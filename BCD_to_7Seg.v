`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:27:54 10/25/2017 
// Design Name: 
// Module Name:    BCD_to_7Seg 
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
module BCD_to_7Seg(
    input [3:0] i_BCD,
    output reg [7:0] o_7Seg
    );
	 
	 initial
		o_7Seg <= 8'h00;
	 
	 always @(i_BCD)
	 begin
	 
		case(i_BCD)
		
			4'h0: o_7Seg <= 8'b11101110;
			4'h1: o_7Seg <= 8'b01001000;
			4'h2: o_7Seg <= 8'b00111110;
			4'h3: o_7Seg <= 8'b01111100;
			4'h4: o_7Seg <= 8'b11011000;
			4'h5: o_7Seg <= 8'b11110100;
			4'h6: o_7Seg <= 8'b11110110;
			4'h7: o_7Seg <= 8'b01101000;
			4'h8: o_7Seg <= 8'b11111110;
			4'h9: o_7Seg <= 8'b11111100;
			default: o_7Seg <= 8'b00010000;
		
		endcase
		
	end

endmodule
