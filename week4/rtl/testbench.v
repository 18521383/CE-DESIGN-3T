`timescale 1ns/1ns
module testbench();

reg Clk;
reg rst;
reg valid_in;
//wire valid_out;
wire [8:0] h;
wire [7:0] s;
wire [7:0] l;
integer file_id,i;

convert a(Clk,rst,valid_in,h,s,l);
always #5 Clk=~Clk;
initial 
begin
	Clk= 0; rst = 1;
	valid_in =1'b0;
	#7 rst = 1'b0;
	@(posedge Clk);
	@(negedge Clk);
	#10 
	rst =1'b1;
	#32
	valid_in =1'b1;
end
initial 
begin
  	file_id = $fopen("OutputHSL_HDL.txt","w");
	@(posedge rst);
	@(posedge Clk);
	for (i = 0; i<35000; i=i+1) begin
      		@(posedge Clk);
		if (i>=10 && i<=25009) begin
      		$fwrite(file_id,"%d\t",   h);
        	$fwrite(file_id,"%d\t",   s);
        	$fwrite(file_id,"%d\n",   l);
    		end
	end
	$fclose(file_id);
	//#10 $stop;
    	$finish;
end
endmodule
