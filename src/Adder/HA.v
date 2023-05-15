`timescale 1ns / 1ps
module HalfAdder (
    input A,
    input B,
    output S,
    output C
    );
	 
	xor(S,A,B);
	and(C,A,B);

endmodule
