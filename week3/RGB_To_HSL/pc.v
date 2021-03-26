module pc(clk,out,rst);
	input clk,rst;
	output [20:0] out;
	reg [20:0] i;
always @(posedge clk or negedge rst)
begin
 if (!rst)
	 i<= 16'd0;
	else
	i = i +16'd1;
end
assign out = i;
endmodule
	