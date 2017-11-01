`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:51 10/25/2017 
// Design Name: 
// Module Name:    SevenSegment_Driver 
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
module SevenSegment_Driver(
    input [12:0] i_Bin13,
    input i_CLK,
	 input i_CLK_Bin2BCD,
    output o_SegData,
    output o_SegLatch
    );
	 
	 wire [15:0] o_BCD4x4;
	 
	 wire o_DV;
	 
	 Binary_to_BCD_13_to_4 _Binary_to_BCD_13_to_4 (
    .i_Clock(i_CLK_Bin2BCD), 
    .i_Binary(i_Bin13), 
    .i_Start(1'b1), 
    .o_BCD(o_BCD4x4), 
    .o_DV(o_DV)
    );

	wire [7:0] _7Seg_0;
	wire [7:0] _7Seg_1;
	wire [7:0] _7Seg_2;
	wire [7:0] _7Seg_3;

	BCD_to_7Seg _BCD_to_7Seg_0 (
    .i_BCD(o_BCD4x4[3 -: 4]), 
    .o_7Seg(_7Seg_0)
    );
	 
	 BCD_to_7Seg _BCD_to_7Seg_1 (
    .i_BCD(o_BCD4x4[7 -: 4]), 
    .o_7Seg(_7Seg_1)
    );
	 
	 BCD_to_7Seg _BCD_to_7Seg_2 (
    .i_BCD(o_BCD4x4[11 -: 4]), 
    .o_7Seg(_7Seg_2)
    );
	 
	 BCD_to_7Seg _BCD_to_7Seg_3 (
    .i_BCD(o_BCD4x4[15 -: 4]), 
    .o_7Seg(_7Seg_3)
    );

	wire [15:0] _7SegControlled_0;
	wire [15:0] _7SegControlled_1;
	wire [15:0] _7SegControlled_2;
	wire [15:0] _7SegControlled_3;

	SevenSeg_to_7SegControlled _SevenSeg_to_7SegControlled_0 (
    .i_7Seg(_7Seg_0), 
    .i_Position(2'b00), 
    .o_7SegControlled(_7SegControlled_0)
    );

	SevenSeg_to_7SegControlled _SevenSeg_to_7SegControlled_1 (
    .i_7Seg(_7Seg_1), 
    .i_Position(2'b01), 
    .o_7SegControlled(_7SegControlled_1)
    );
	 
	 SevenSeg_to_7SegControlled _SevenSeg_to_7SegControlled_2 (
    .i_7Seg(_7Seg_2), 
    .i_Position(2'b10), 
    .o_7SegControlled(_7SegControlled_2)
    );
	 
	 SevenSeg_to_7SegControlled _SevenSeg_to_7SegControlled_3 (
    .i_7Seg(_7Seg_3), 
    .i_Position(2'b11), 
    .o_7SegControlled(_7SegControlled_3)
    );
	 
	 SevenSeg_Seriallizer _SevenSeg_Seriallizer (
    .i_CLK(i_CLK), 
    .i_7SegData16_0(_7SegControlled_0), 
    .i_7SegData16_1(_7SegControlled_1), 
    .i_7SegData16_2(_7SegControlled_2), 
    .i_7SegData16_3(_7SegControlled_3), 
    .i_RESET(1'b0), 
    .o_7SegData(o_SegData), 
    .o_7Seg_Latch(o_SegLatch)
    );



endmodule
