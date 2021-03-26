module Testbench();

parameter cycle = 50;
reg Clk;
reg rst;
wire [8:0] h;
wire [7:0] s;
wire [7:0] l;
//wire [15:0] addr;
//wire [24:0] out;
integer file_id,i;
//assign out = {h,s,l};
Convert_RGB_To_HSL RGB_HSL(Clk,rst,h,s,l);///
always #30 Clk=~Clk;
initial 
begin
	Clk= 0; rst = 0;
	#50
	rst =1'b1;
	//#1000 $stop;
end
initial 
begin
  	file_id = $fopen("rgb.txt","w");
	@(posedge Clk);
	for (i = 0; i<100002; i=i+1) begin
      		@(posedge Clk);
			if (i>2) begin
      		$fwrite(file_id,"%d\t", h);
				$fwrite(file_id,"%d\t", s);
				$fwrite(file_id,"%d\n", l);
				end
    	end
	$fclose(file_id);
	$finish;
end

endmodule