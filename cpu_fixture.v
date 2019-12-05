`include "cpu.v"

module cpu_fixture;
	reg clk, rst;

	initial
		$vcdpluson;
	
	initial
	$display ($time, "");	

	cpu our_cpu (.clk(clk), .rst(rst));

	initial
	begin
		rst = 0;
		#10 rst = 1;
	//	#20 rst = 0;
	//	#20 rst = 1;
	//	#20 rst = 0;	
	end	

	initial begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial
		#1000 $finish;


endmodule
