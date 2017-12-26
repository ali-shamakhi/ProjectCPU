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
	 input i_CLK,
	 input i_CLK_RO,
    input [2:0] i_AddrReg1,
    input [2:0] i_AddrReg2,
    input [2:0] i_AddrRegDest,
	 input [7:0] i_WriteData,
    input i_WriteBack,
	 //input i_CLK_ID,
    output reg [7:0] o_Data1,
    output reg [7:0] o_Data2,
	output [7:0] o_RegShowing1,
	output [7:0] o_RegShowing2
	 //output reg o_DataReady
    );

	reg [7:0] _R [7:0];
	
	assign o_RegShowing1 = _R[i_AddrReg1];
	assign o_RegShowing2 = _R[i_AddrReg2];
	
	reg _WriteBack_D1;
	reg [2:0] _AddrRegDest_D1;
	//reg [7:0] _WriteData_D1;	// invalid
	
	initial
	begin
		_R[0] = 8'h00;
		_R[1] = 8'h00;	// 130
		_R[2] = 8'h00;	// 131
		_R[3] = 8'h00;
		_R[4] = 8'h00;
		_R[5] = 8'h00;
		_R[6] = 8'h00;
		_R[7] = 8'h00;
		o_Data1 = 8'h00;
		o_Data2 = 8'h00;
		_WriteBack_D1 = 0;
		_AddrRegDest_D1 = 3'h0;
		//_WriteData_D1 = 8'h00;	// invalid
		//_init = 1;
		//o_DataReady = 1'b1;
	end
	
	always @(posedge i_CLK)	// TODO: check for more delay
	begin
			if (_WriteBack_D1)
				_R[_AddrRegDest_D1] = i_WriteData;
				
			_WriteBack_D1 = i_WriteBack;
			_AddrRegDest_D1 = i_AddrRegDest;
			//_WriteData_D1 = i_WriteData;	// invalid
		
	end
	
	always @(negedge i_CLK_RO)
	begin
		o_Data1 = _R[i_AddrReg1];
		o_Data2 = _R[i_AddrReg2];
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
