`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:54:16 05/10/2023
// Design Name:   HA
// Module Name:   C:/Users/hoseini/Desktop/New folder/ac/test_HA.v
// Project Name:  ac
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: HA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_HA;

	// Inputs
	reg A;
	reg B;

	// Outputs
	wire S;
	wire C;

	// Instantiate the Unit Under Test (UUT)
	HA uut (
		.A(A), 
		.B(B), 
		.S(S), 
		.C(C)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		A = 0;
		B = 1;
		
		#100;
		
		A = 1;
		B = 0;
		
		#100;
		
		A = 1;
		B = 1;
		
        
		// Add stimulus here

	end
      
endmodule

