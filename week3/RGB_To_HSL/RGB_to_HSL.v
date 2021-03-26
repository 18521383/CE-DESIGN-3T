module RGB_to_HSL(H, S, L, R_in, G_in, B_in, CLK, Reset);
	output [31:0] H, S, L;
	input [7:0] R_in, G_in, B_in;
	input CLK, Reset;
	wire [1:0]  Max_Sel_Out, Min_Sel_Out;
	wire [31:0] R_AD, G_AD, B_AD;
	
	parameter   Red   = 2'b00,
					Green = 2'b01,
					Blue  = 2'b10;
	wire[31:0] Cmax, Cmin;
	//wire [31:0] Cmax, Cmin;
	wire [2:0] Qout;
	//wire [31:0] R_AD, G_AD, B_AD; // after divide R,G,B for 255;
	Counter Counter_inst(.Qout(Qout), .CLK(CLK), .Reset(Reset));
	compare compare_inst1( .In_R(R_in), 
								  .In_G(G_in), 
								  .In_B(B_in), 
								  .CLK(CLK), 
								  .Max_Sel_Out(Max_Sel_Out), 
								  .Min_Sel_Out(Min_Sel_Out));
	// Tinh R_AD
	fpu fpu_instan(.clk(CLK), 
						.rmode(2'b00),
						.fpu_op(3'b011), 
						.opa({24'b0,R_in}), 
						.opb(32'h000000FF),
						.out(R_AD));
	// Tinh G_AD
	fpu fpu_instan1(.clk(CLK), 
						.rmode(2'b00),
						.fpu_op(3'b011), 
						.opa({24'b0,G_in}), 
						.opb(32'h000000FF),
						.out(G_AD));
	// Tinh R_AD
	fpu fpu_instan2(.clk(CLK), 
						.rmode(2'b00),
						.fpu_op(3'b011), 
						.opa({24'b0,B_in}), 
						.opb(32'h000000FF),
						.out(B_AD));
	assign Cmax =  (Qout == 4 && Max_Sel_Out == Red)? R_AD: 
						(Qout == 4 && Max_Sel_Out == Green)?G_AD : B_AD;
	assign Cmin =  (Qout == 4 && Min_Sel_Out == Red)? R_AD: 
						(Qout == 4 && Min_Sel_Out == Green)?G_AD : B_AD;			
	//// Delta = Cmax - Cmin
	wire [31:0] Delta;
	Addition_Subtraction AS_inst( .a_operand(Cmax),
											.b_operand(Cmin),
											.AddBar_Sub(1'b1),
											.result(Delta));		
	wire [31:0] Sub_At_H; // gia tri cua bieu thuc G' - B' hoac B' - R' hoac R' - G'
	wire [31:0] In_To_Sub_At_H_A, In_To_Sub_At_H_B; 
	assign In_To_Sub_At_H_A = Max_Sel_Out == Red ? G_AD : Max_Sel_Out == Green ? B_AD : R_AD;
	assign In_To_Sub_At_H_B = Max_Sel_Out == Red ? B_AD : Max_Sel_Out == Green ? R_AD : G_AD;
	Addition_Subtraction AS_inst1( .a_operand(In_To_Sub_At_H_A),
											.b_operand(In_To_Sub_At_H_B),
											.AddBar_Sub(1'b1),
											.result(Sub_At_H));
	/////
	wire [31:0] H_Before_Done;
	fpu fpu_instan3(.clk(CLK), 
						.rmode(2'b00),
						.fpu_op(3'b011), 
						.opa(Sub_At_H), 
						.opb(Delta),
						.out(H_Before_Done));
	///// Luu lai gia tri cong cho bao nhieu de pipeline
	parameter ADD0 = 2'b00,
				 ADD2 = 2'b01,
				 ADD4 = 2'b10,
				 ADD6 = 2'b11;
	wire [1:0] ADD_Sel;
	assign ADD_Sel = Max_Sel_Out == Green ? ADD2: 
						  Max_Sel_Out == Blue ? ADD4:
						  (Max_Sel_Out == Red && Min_Sel_Out == Green)? ADD6 : ADD0;
	reg [1:0] ADD_Sel_r1, ADD_Sel_r2,ADD_Sel_r3, ADD_Sel_final;
	always @(posedge CLK) begin
		if (Qout == 4) begin
			ADD_Sel_r1 <= ADD_Sel;
			ADD_Sel_r2 <= ADD_Sel_r1;
			ADD_Sel_r3 <= ADD_Sel_r2;
			ADD_Sel_final <= ADD_Sel_r3;
		end
	end
	////////////// Tính thanh cong duoc H 
	wire [31:0] Vaule_ADD, H_Almost;
	assign Vaule_ADD = ADD_Sel_final == ADD0? 32'h0 :
							 ADD_Sel_final == ADD2? 32'h40000000 :
							 ADD_Sel_final == ADD4? 32'h40800000 : 32'h40C00000;
	//// Cong H_Before_Done voi  0 / 2 / 4 / 6
	Addition_Subtraction AS_inst2( .a_operand(H_Before_Done),
											.b_operand(Vaule_ADD),
											.AddBar_Sub(1'b0),
											.result(H_Almost));
	Multiplication Multiplication_inst( .a_operand(H_Almost),
													.b_operand(32'h42700000),
													.result(H));
	
	////////////// Tinh gia tri cua S 
	wire [31:0] DoubleL; ///// 2L 
	Addition_Subtraction AS_inst3( .a_operand(Cmax),
											.b_operand(Cmin),
											.AddBar_Sub(1'b0),
											.result(DoubleL));
	/// 2L - 1
	wire [31:0] DoubleL_M_O; /// DoubleL Minus One (DMO)
	Addition_Subtraction AS_inst4( .a_operand(DoubleL),
											.b_operand(32'h3F800000),
											.AddBar_Sub(1'b1),
											.result(DoubleL_M_O));
	/// 1 - |2L -1|
	wire [31:0] ODMO; /// One Minus DMO
	wire [31:0] ABS_DoubleL_M_O;
	assign ABS_DoubleL_M_O[31] = 1'b0;
	assign ABS_DoubleL_M_O[30:0] = DoubleL_M_O[30:0];
	Addition_Subtraction AS_inst5( .a_operand(32'h3F800000),
											.b_operand(ABS_DoubleL_M_O),
											.AddBar_Sub(1'b1),
											.result(ODMO));
	/// Tinh thanh cong gia tri S
	fpu fpu_instan4(.clk(CLK), 
						.rmode(2'b00),
						.fpu_op(3'b011), 
						.opa(Delta), 
						.opb(ODMO),
						.out(S));
						
						
	///////////// Tinh gia tri L =(Cmax + Cmin) /2 = DoubleL / 2
	fpu fpu_instan5(.clk(CLK), 
						.rmode(2'b00),
						.fpu_op(3'b011), 
						.opa(DoubleL), 
						.opb(32'h40000000),
						.out(L));
endmodule	