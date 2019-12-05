module programCounter(input clk, rst, w_enable, input [15:0] inc, output reg [15:0] pc);
	always @ (posedge clk, negedge rst) begin
		if (!rst) 
			pc <= 0;
		else if (w_enable)
			pc <= inc;
	end
endmodule
