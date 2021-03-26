module  rgb_hsl(
	input                         clk,
	input                       	rst,	
	input	     [7:0]            rgb_r,
	input	     [7:0]            rgb_g,
	input	     [7:0]            rgb_b,	
	output reg [8:0] 			  hsl_h,//  0 - 360
	output reg [7:0] 			  hsl_s,// 0- 255
	output reg [7:0] 			  hsl_l // 0- 255
);
reg [13:0] top_60;//60*()
reg [2:0] rgb_se;
reg [7:0] max;//Maximum weight
reg [7:0] min;//Minimum component
reg [7:0] max_min;//max - min
reg [8:0] division;//division
wire [8:0] max_add_min;
//find max min 1----
assign r_g = (rgb_r > rgb_g)? 1'b1:1'b0; 
assign r_b = (rgb_r > rgb_b)? 1'b1:1'b0; 
assign g_b = (rgb_g > rgb_b)? 1'b1:1'b0; 
always @ (posedge clk or negedge rst)
begin
	if (!rst)
	begin
		max <= 8'd0;
		min <= 8'd0;
		max_min <= 8'd0;
		top_60 <= 8'd0;
		rgb_se <= 3'b010;
	end
	else 
	begin
	case ({r_g,r_b,g_b})
	
	3'b000:
			begin//b g r
			max <= rgb_b;
			min <= rgb_r;
			max_min <= rgb_b - rgb_r; // max - min
			top_60 <= {(rgb_g - rgb_r),6'b000000} - {(rgb_g - rgb_r),2'b00}; //*60
			rgb_se <= 3'b000;
			end
	3'b001:
			begin//g b r
			max <= rgb_g;
			min <= rgb_r;
			max_min <= rgb_g - rgb_r;
			top_60 <= {(rgb_b - rgb_r),6'b000000} - {(rgb_b - rgb_r),2'b00};
			rgb_se <= 3'b001;
			end
	3'b011:
			begin//g r b
			max <= rgb_g;
			min <= rgb_b;
			max_min <= rgb_g -rgb_b;
			top_60 <= {(rgb_r - rgb_b),6'b000000} - {(rgb_r - rgb_b),2'b00};
			rgb_se <= 3'b011;
			end
	3'b100:
			begin//b r g
			max <= rgb_b;
			min <= rgb_g;
			max_min <= rgb_b - rgb_g;
			top_60 <= {(rgb_r - rgb_g),6'b000000} - {(rgb_r - rgb_g),2'b00}; //+
			rgb_se <= 3'b100;
			end
	3'b110:
			begin//r b g
			max <= rgb_r;
			min <= rgb_g;
			max_min <= rgb_r - rgb_g;
			top_60 <= {(rgb_b - rgb_g),6'b000000} - {(rgb_b - rgb_g),2'b00}; // *60 
			rgb_se <= 3'b110;
			end
	3'b111:
			begin//r g b
			max <= rgb_r;
			min <= rgb_b;
			max_min <= rgb_r -rgb_b;
			top_60 <= {(rgb_g - rgb_b),6'b000000} - {(rgb_g - rgb_b),2'b00}; //-
			rgb_se <= 3'b111;
			end
	default
			begin
			max <= 8'd0;
			min <= 8'd0;
			max_min <= 8'd0;
			top_60 <= 14'd0;
			rgb_se <= 3'b010;
			end
	endcase
end
end
//  60*top /(max - min)    
always @ (*)
begin
	division <= (max_min > 8'd0) ? top_60/(max_min) : 8'd240;//Note that max = min  
end
// + - 120 240 360
always @ (posedge clk or negedge rst)
begin
	if (!rst)
	
		hsl_h <= 9'd0;
	else 
	begin
	case (rgb_se)
	
	3'b000:
			//b g r
			hsl_h <= 9'd240 - division;//-		
	3'b001:
			//g b r
			hsl_h <= 9'd120 + division;//+		
	3'b011:
			//g r b
			hsl_h <= 9'd120 - division;//-	
	3'b100:
			//b r g
			hsl_h <= 9'd240 + division;//+		
	3'b110:
			//r b g
			hsl_h <= 9'd360 - division;//-	
	3'b111:
			//r g b
			hsl_h <= division;//+	
	default
			hsl_h <= 9'd0;
	endcase
end
end
// l=(max+min)/2
// |2*l -255| = |(max+min) -255|
wire [7:0] temp;
assign max_add_min = max +min; //max: 510
assign temp = (max_add_min > 8'd255)? max_add_min -8'd 255 : 8'd255 -max_add_min;
//  s=((max - min)/(1-|2*l-1|))*255
always@(posedge clk or negedge rst)
begin
	if (!rst)
      hsl_s <= 8'd0;
	else
	hsl_s <= (max_min == 8'd0)?  8'd0 : ({max_min [7:0],8'b00000000}-16'd1)/(8'd255-temp);
end

//  hsl_l = (max+min)/2
always@(posedge clk or negedge rst)
begin
  if (!rst) begin
  hsl_l <= 8'd0;
	end
  else begin
  hsl_l <= (max + min)/2;
  end
 end
endmodule