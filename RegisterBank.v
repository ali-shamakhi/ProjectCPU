`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:33:09 11/22/2017 
// Design Name: 
// Module Name:    RegisterBank 
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
module RegisterBank(
    input [2:0] i_AddrReg1,
    input [2:0] i_AddrReg2,
    input [2:0] i_AddrRegDest,
	 input [7:0] i_WriteData,
    input i_WriteBack,
	 //input i_CLK_ID,
    input i_CLK,						// write-back on negedge
    output [7:0] o_Data1,
    output [7:0] o_Data2
	 //output reg o_DataReady
    );

	reg [7:0] _R [7:0];
	
	assign o_Data1 = _R[i_AddrReg1];
	assign o_Data2 = _R[i_AddrReg2];
	
	initial
	begin
		_R[0] = 8'h00;
		_R[1] = 8'h82;	// 130
		_R[2] = 8'h83;	// 131
		_R[3] = 8'h00;
		_R[4] = 8'h00;
		_R[5] = 8'h00;
		_R[6] = 8'h00;
		_R[7] = 8'h00;
		//o_Data1 = 8'h00;
		//o_Data2 = 8'h00;
		//o_DataReady = 1'b1;
	end
	
	always @(negedge i_CLK)
	begin
		
			if (i_WriteBack)
				_R[i_AddrRegDest] = i_WriteData;
		
	end
	
	/*
	always @(i_CLK_ID)
	begin
			if (i_CLK_ID)
			begin
				o_Data1 = _R[i_AddrReg1];
				o_Data2 = _R[i_AddrReg2];
				//o_DataReady = 1'b1;
			end
			//else
				//o_DataReady = 1'b0;
	end
	*/

endmodule
