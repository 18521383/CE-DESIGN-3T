module compare(In_R, In_G, In_B, CLK, Max_Sel_Out, Min_Sel_Out);
	parameter   Red   = 2'b00,
					Green = 2'b01,
					Blue  = 2'b10;
	output reg [1:0] Max_Sel_Out, Min_Sel_Out;
	input [7:0] In_R, In_G, In_B;
	input CLK;
	wire [1:0] Max_Sel, Min_Sel;
	reg [1:0] Max_r1, Max_r2, Max_r3, Min_r1, Min_r2, Min_r3;
	assign Max_Sel=(In_R>=In_G&&In_R>=In_B)?Red:(In_G>=In_R&&In_G>=In_B)?Green:Blue;
	assign Min_Sel=(In_R<=In_G&&In_R<=In_B)?Red:(In_G<=In_R&&In_G<=In_B)?Green:Blue;
	always @(posedge CLK)
	begin
		Max_r1 <= Max_Sel;
		Max_r2 <= Max_r1;
		Max_r3 <= Max_r2;
		Max_Sel_Out = Max_r3;
		Min_r1 <= Min_Sel;
		Min_r2 <= Min_r1;
		Min_r3 <= Min_r2;
		Min_Sel_Out <= Min_r3;
	end
endmodule 