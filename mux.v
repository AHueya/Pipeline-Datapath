module mux (input sel, input[15:0] d0, d1, output reg [15:0] y);
	always @ (*) begin
		if (sel) y = d0;
		else y = d1;
	end
endmodule
