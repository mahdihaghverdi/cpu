`timescale 1ns / 1ps
module FullAdder (
    input A,
    input B,
    input C,
    output Sum,
    output Carry
    );
  
	wire [3:0] sim;
	HalfAdder h1(
		.A(A),
		.B(B),
		.S(sim[1]),
		.C(sim[0])
		);
		
	HalfAdder h2(
		.A(sim[1]),
		.B(C),
		.S(sim[3]),
		.C(sim[2])
		);
		
		assign Sum = sim[3];
		or(Carry,sim[0],sim[2]);
		
endmodule
