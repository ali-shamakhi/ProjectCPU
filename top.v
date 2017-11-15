`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:16 10/04/2017 
// Design Name: 
// Module Name:    top 
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
module top(
    input i_CLK,
    output o_PSCLK,	// ouput clock for other modules
    output o_LEDData,	// serial LED Data output
    output o_LEDLatch,	// commits LED Data
    output o_DIPLatch,	// commits DIP Data
    input i_DIPData,	// serial
    output o_SEGData,	// 7-segment
    output o_SEGLatch,
    output o_LCDData,
    output o_LCDLatch,
    output o_Eth_RST,
    input i_Eth_INT,
    output o_Eth_CS,
    output o_Eth_RD,
    output o_Eth_WR,
    output o_USB_SLOE,
    inout io_USB_IFCLK,
    output o_USB_SLRD,
    output o_USB_SLWR,
    inout [7:0] io_Data,
    inout [9:0] io_MuxEthUSB,
    output o_VGA_blue0,
    output o_VGA_blue1,
    output o_VGA_green0,
    output o_VGA_green1,
    output o_VGA_red0,
    output o_VGA_red1,
    output o_VGA_vsync,
    output o_VGA_hsync,
    input i_SW1,
    input i_SW2,
    input i_SW3,
    input i_SW4,
    output o_TXD1,
    input i_RXD1,
    output o_TXD2,
    input i_RXD2,
    output o_MMC_SCK,
    input i_MMC_DO,
    output o_MMC_DI,
    output o_MMC_CS,
    input i_SYS_RESET
    );

wire o_CLK_5;
wire o_CLK_20;
wire o_CLK_50;
wire o_CLK_100;

//////////////////////////////////////

// all unused output to Z

assign o_PSCLK = ~o_CLK_5;
//assign o_LEDData = 1'bz;
//assign o_LEDLatch = 1'bz;


//assign o_DIPLatch = 1'bz;
//assign o_SEGData = 1'bz;
//assign o_SEGLatc = 1'bz;
assign o_LCDData = 1'bz;
assign o_LCDLatch = 1'bz;

assign o_MMC_SCK	= 1'bz;

assign o_MMC_DI = 1'bz;
assign o_MMC_CS = 1'bz;

assign o_VGA_blue0 = 1'bz;
assign o_VGA_blue1 = 1'bz;
assign o_VGA_green0 = 1'bz;
assign o_VGA_green1 = 1'bz;
assign o_VGA_red0 = 1'bz;
assign o_VGA_red1 = 1'bz;
assign o_VGA_vsync = 1'bz;
assign o_VGA_hsync = 1'bz;

assign o_Eth_RST = 1'bz;

assign o_Eth_CS = 1'bz;
assign o_Eth_RD = 1'bz;
assign o_Eth_WR = 1'bz;
assign o_USB_SLOE = 1'bz;
assign io_USB_IFCLK = 1'bz;
assign o_USB_SLRD = 1'bz;
assign o_USB_SLWR = 1'bz;
assign io_Data = 8'bz;
assign io_MuxEthUSB = 10'bz;

assign o_TXD1 = 1'bz;
assign o_TXD2 = 1'bz;



//assign o_SEGData = 1'bz;
//assign o_SEGLatch = 1'bz;

assign o_LCDData = 1'bz;
assign o_LCDLatch = 1'bz;

//////////////////////////////////////
	
	wire [15:0] _DIP16;
	wire [4:0] _Switch5;
	
	wire [7:0] o_PC;
	wire [15:0] _INSTR;

   clock_gen _clock_gen
   (
	 // Clock in ports
    .i_CLK_50(i_CLK),      // IN
    // Clock out ports
    .o_CLK_5(o_CLK_5),     // OUT
    .o_CLK_20(o_CLK_20),     // OUT
    .o_CLK_50(o_CLK_50),     // OUT
    .o_CLK_100(o_CLK_100)    // OUT
	);
	 
   LED_Driver _LED_Driver
   (
		.i_CLK(o_CLK_5), 
		.i_Data16(_INSTR), 
		.i_RESET(1'b0), 
		.o_LEDData(o_LEDData), 
		.o_LEDLatch(o_LEDLatch)
	);
	
	DIP_Parallelizer _DIP_Parallelizer (
    .i_CLK(o_CLK_5), 
    .i_Data(i_DIPData), 
    .i_RESET(i_RESET), 
    .o_DIP16(_DIP16),
	 .o_Switch5(_Switch5),
    .o_DIPLatch(o_DIPLatch)
    );
	 
	 //wire _PC_INC;
	 //wire _PC_RESET;
	 
	 DeBouncer _DeBouncer3 (
	 .i_Data(_Switch5[0]), 	// SW3
    .i_CLK(o_CLK_5), 
    .o_Data(_PC_INC)
    );

	DeBouncer _DeBouncer4 (
	 .i_Data(_Switch5[1]), 	// SW4
    .i_CLK(o_CLK_5), 
    .o_Data(_PC_RESET)
    );
	 
	 PC _PC (
    .i_CLK(~_PC_INC),
    .i_RESET(_PC_RESET), 
    .o_PC(o_PC)
    );
	 
	 InstructionMemory _InstructionMemory (
		.clka(o_CLK_5), // input clka
		.addra(o_PC), // input [7 : 0] addra
		.douta(_INSTR) // output [15 : 0] douta
		);
	 
	 SevenSegment_Driver _SevenSegment_Driver (
    .i_Bin13({5'h00, o_PC}), 
    .i_CLK(o_CLK_5), 
    .i_CLK_Bin2BCD(o_CLK_100), 
    .o_SegData(o_SEGData),
    .o_SegLatch(o_SEGLatch)
    );
	


endmodule
