`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:54:02 05/10/2023
// Design Name:   FA
// Module Name:   C:/Users/hoseini/Desktop/New folder/ac/test_FA.v
// Project Name:  ac
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: FA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_FA;

	// Inputs
	reg A;
	reg B;
	reg C;

	// Outputs
	wire Sum;
	wire Carry;

	// Instantiate the Unit Under Test (UUT)
	FA uut (
		.A(A), 
		.B(B), 
		.C(C), 
		.Sum(Sum), 
		.Carry(Carry)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		C = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		A = 1;
		B = 1;
		C = 1;
		
		#100;
		
		A = 1;
		B = 0;
		C = 0;
		
		#100;
		
		A = 0;
		B = 1;
		C = 1;
        
		// Add stimulus here

	end
      
endmodule

