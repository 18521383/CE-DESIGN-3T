module IMEM (
	input [20:0] addr,
	output reg [23:0] q
);

	reg [23:0] rom[2**15:0];

	initial begin
		$readmemb("binary.txt", rom);
	end

	always @(addr) begin
		q = rom[addr];
	end

endmodule