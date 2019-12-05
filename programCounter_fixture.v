`include "programCounter.v"

module programCounter_fixture;

	reg clk, rst, w_enable;
	reg [15:0]  inc;
	wire [15:0] pc;

	initial
		$vcdpluson;

	initial
		$monitor ($time, "reset = %d w_enable = %d, pc = %d", rst, w_enable, pc);

	programCounter c1(.clk(clk), .rst(rst), .w_enable(w_enable), .inc(inc), .pc(pc));

	initial begin
		rst = 0; w_enable = 0; inc = 0;
		#10 rst = 1; w_enable = 1; inc = 2;
		#20 rst = 1; w_enable = 1; inc = 4;
		#20 rst = 1; w_enable = 1; inc = 6;
	end

	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end


	initial begin
		#100 $finish;
	end

endmodule
