module FP32_To_Int(fb32bit, out_int);
	input [31:0] fb32bit;
	output [8:0] out_int;
	wire [23:0] integer_value;
	wire [7:0] index;
	wire [23:0] round;
//(2^len + mantissa)/ 2^(len -exp -bias )
	assign index = 8'd23-(fb32bit[30:23]-8'd127); //len -exp -bias // len =23; bias =127
	assign integer_value = {1'b1,fb32bit[22:0]}>>index; //{2^32 + mantissa}/2^index
		Rounding rounding(integer_value, round);
	assign out_int = round[8:0];
endmodule 