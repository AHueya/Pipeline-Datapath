`include "instructionMem.v"

module instructionMem_fixture;

	reg clk, rst;
	reg [7:0] addr;
	wire [15:0] inst_out;

	initial
		$vcdpluson;

        initial
                $monitor($time, " Address = %b Instant Out = %h  reset = %b",addr, inst_out, rst);

                instruction_mem c1(clk, rst, addr, inst_out);

        initial
           begin
              rst = 1'b1;
              #10 rst = 1'b0;
              #20 addr = 0;
              #20 addr = 2;
              #20 addr = 4;
              #20 addr = 6;
              #20 addr = 58; 
           end

       
        initial
           begin
              clk = 1'b0;
              forever #10 clk = ~clk;
           end

        initial
           begin
              #140 $finish;
           end
         
endmodule