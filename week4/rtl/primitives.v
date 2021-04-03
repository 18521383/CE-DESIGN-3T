`timescale 1ns / 100ps
 
 
////////////////////////////////////////////////////////////////////////
//
// Add/Sub
//
 
module add_sub27(add, opa, opb, sum, co);
input		add;
input	[26:0]	opa, opb;
output	[26:0]	sum;
output		co;
 
 
 
assign {co, sum} = add ? (opa + opb) : (opa - opb);
 
endmodule
 
////////////////////////////////////////////////////////////////////////
//
// Multiply
//
 
module mul_r2(clk, opa, opb, prod);
input		clk;
input	[23:0]	opa, opb;
output	[47:0]	prod;
 
reg	[47:0]	prod1, prod;
 
always @(posedge clk)
	prod1 <=  opa * opb;
 
always @(posedge clk)
	prod <=  prod1;
 
endmodule
 
////////////////////////////////////////////////////////////////////////
//
// Divide
//
 
module div_r2(clk, opa, opb, quo, rem);
input		clk;
input	[49:0]	opa;
input	[23:0]	opb;
output	[49:0]	quo, rem;
 
reg	[49:0]	quo, rem, quo1, remainder;
 
always @(posedge clk)
	quo1 <=  opa / opb;
 
always @(posedge clk)
	quo <=  quo1;
 
always @(posedge clk)
	remainder <=  opa % opb;
 
always @(posedge clk)
	rem <=  remainder;
 
endmodule 