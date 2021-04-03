module convert(
	input CLK,
	input Reset,
	input valid_in,
	output wire [8:0] 			  	hsl_h,//  0 - 360
	output wire [7:0] 			  	hsl_s,// 0- 255
	output wire [7:0] 			  	hsl_l // 0- 255
	//output wire valid_out
	);
	wire [23:0]	Datain;
	wire [20:0] addr;
	wire [8:0] hsl_hh,hsl_ss, hsl_ll;
	wire [20:0] contact;
	wire [31:0] H,S,L,H_multi_10, temp_S, temp_L;
assign contact = valid_in ? addr :21'dz;
pc pc_inst(.clk(CLK),.out(addr),.rst(Reset), .valid_in(valid_in));
IMEM mem(contact,Datain);
RGB_to_HSL RGB_to_HSL_inst(.H(H), 
									.S(S), 
									.L(L), 
									.R_in(Datain[23:16] ), 
									.G_in(Datain[15:8] ), 
									.B_in(Datain[7:0] ), 
									.CLK(CLK), 
									.Reset(~Reset));
Multiplication H_X_1000 ( .a_operand(H),
									  .b_operand(32'h41200000), //*10
									  .result(H_multi_10));
Multiplication S_X_1000 ( .a_operand(S),
									  .b_operand(32'h451f6000), //*255 *10
									  .result(temp_S));
 Multiplication L_X_1000 ( .a_operand(L),
									  .b_operand(32'h451f6000),
									  .result(temp_L));
FP32_To_Int fbtoint_H(.fb32bit(H_multi_10), .out_int(hsl_hh));
FP32_To_Int fbtoint_S(.fb32bit(temp_S), .out_int(hsl_ss));
FP32_To_Int fbtoint_L(.fb32bit(temp_L), .out_int(hsl_ll));
assign hsl_h =hsl_hh;
assign hsl_s = hsl_ss[7:0];
assign hsl_l =hsl_ll[7:0];
//assign valid_out =((hsl_hh == 1'bx)|(hsl_ss ==1'bx)|(hsl_ll ==1'bx))? 1'bz:1'b1;
endmodule
		