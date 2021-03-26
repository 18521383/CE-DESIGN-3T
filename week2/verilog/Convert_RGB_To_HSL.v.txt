module Convert_RGB_To_HSL (
	input clk,
	input rst,
	output wire [8:0] hsl_h, //  0 - 360
	output wire [7:0] hsl_s, //0 -255
	output wire [7:0] hsl_l //0 -255
	);
	wire [23:0] IN_rgbhsl;
	wire [16:0] addr;
	PC p_count (clk, addr, rst);
	IMEM memory_RGB (addr, IN_rgbhsl);
	rgb_hsl RGB_to_HSL (clk,rst, IN_rgbhsl[23:16], IN_rgbhsl[15:8], IN_rgbhsl[7:0], hsl_h, hsl_s, hsl_l);
endmodule 