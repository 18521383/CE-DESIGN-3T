module PC(clk,OUT,rst);
	input clk,rst;
	output reg [16:0] OUT;
always @(posedge clk)
begin
 if (!rst)
	 OUT<= 17'd0;
	else
	OUT <= OUT +17'd1;
end
endmodule 
