module bufferWE #(parameter N = 16) (input [N - 1:0] data_in, input clk, w_enable, rst, output reg  [N - 1:0] data_out);

	always @ (posedge clk, negedge rst)
	begin
		if (!rst)
			data_out <= 0;
		else if (w_enable)
			data_out <= data_in;
	end
endmodule
