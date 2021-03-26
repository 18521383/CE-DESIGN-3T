module IMEM (
	input [16:0] addr,
	output reg [23:0] R_G_B
);
	reg [23:0] rom[0:100000];
	initial begin
		$readmemb("binary.txt", rom);
	end

	always @(addr) begin
		R_G_B <= rom[addr];
	end
endmodule 