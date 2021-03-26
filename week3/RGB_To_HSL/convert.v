module convert(
	input CLK,
	input Reset,
	output wire [31:0] 			  	hsl_h,//  0 - 360
	output wire [31:0] 			  	hsl_s,// 0- 255
	output wire [31:0] 			  	hsl_l // 0- 255
	);
	
	wire [23:0]				Datain;
	wire [20:0] addr;
pc pc_inst(.clk(CLK),.out(addr),.rst(Reset));
IMEM aa(addr,Datain);
RGB_to_HSL RGB_to_HSL_inst(.H(hsl_h), 
									.S(hsl_s), 
									.L(hsl_l), 
									.R_in(Datain[23:16] ), 
									.G_in(Datain[15:8] ), 
									.B_in(Datain[7:0] ), 
									.CLK(CLK), 
									.Reset(~Reset));
endmodule
		