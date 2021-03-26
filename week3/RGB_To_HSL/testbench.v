`timescale 1ns/1ns
module testbench();

parameter cycle = 50;
reg Clk;
reg rst;
wire [31:0] h;
wire [31:0] s;
wire [31:0] l;
integer file_id,i;

convert a(Clk,rst,h,s,l);
always #5 Clk=~Clk;
initial 
begin
	Clk= 0; rst = 1;
	#7 rst = 1'b0;
	@(posedge Clk);
	@(negedge Clk);
	#10 
	rst =1'b1;
end
initial 
begin
  	file_id = $fopen("rgb.txt","w");
	@(posedge rst);
	@(posedge Clk);
	for (i = 0; i<650000; i=i+1) begin
      		@(posedge Clk);
		if (i >=7) begin
      		$fwrite(file_id,"%h\t",   h);
        	$fwrite(file_id,"%h\t",   s);
        	$fwrite(file_id,"%h\n",   l);
    		end
	end
	$fclose(file_id);
    	$finish;
end
endmodule
