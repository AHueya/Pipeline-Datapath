`include "registerForward.v"

module registerForward_fixture;
	reg clk;
	reg [3:0] op1, op2, memRd, wbRd;
	reg memRegWrite, wbRegWrite;
	wire [1:0] aluSrc1, aluSrc2;
	
	initial
		$vcdpluson;

	initial
		$monitor ($time, " op1 = %b op2 = %b memRd = %b wbRd = %b memRegWrite = %d wbRegWrite = %d aluSrc1 = %b aluSrc2 = %b ",op1, op2, memRd, wbRd, memRegWrite, wbRegWrite, aluSrc1, aluSrc2);

	registerForward g1 (.op1(op1), .op2(op2), .memRd(memRd), .wbRd(wbRd), .memRegWrite(memRegWrite), .wbRegWrite(wbRegWrite), .aluSrc1(aluSrc1), .aluSrc2(aluSrc2));

	initial
	begin
		op1 = 0; op2 = 0; memRd = 0; wbRd = 0; memRegWrite = 0; wbRegWrite = 0;
	 	#20 op1 = 4'd1; op2 = 4'd2; memRd = 4'd1; wbRd = 4'd0; memRegWrite = 1; wbRegWrite = 0;
		#20 op1 = 1; op2 = 2; memRd = 0; wbRd = 1; memRegWrite = 0; wbRegWrite = 1;
		#20 op1 = 1; op2 = 2; memRd = 2; wbRd = 0; memRegWrite = 1; wbRegWrite = 0;
		#20 op1 = 1; op2 = 2; memRd = 0; wbRd = 2; memRegWrite = 0; wbRegWrite = 1;
		#20 op1 = 1; op2 = 2; memRd = 0; wbRd = 0; memRegWrite = 1; wbRegWrite = 0;
		#20 op1 = 1; op2 = 2; memRd = 0; wbRd = 0; memRegWrite = 0; wbRegWrite = 1;
	end

	initial
	begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial
	begin
		#150 $finish;
	end

endmodule
