`include "buffer.v"

module buffer_fixture;

reg clk, rst;
reg [15:0] data_in;
wire [15:0] data_out;

initial
	$vcdpluson;

initial
	$monitor($time, " data_in = %h data_out = %h Reset = %b",  data_in, data_out, rst);

	buffer #(.N(16)) c1(.data_in(data_in), .clk(clk), .rst(rst), .data_out(data_out));

initial
	begin
		rst = 0; data_in = 0; 
        	#10 rst = 1; data_in = 16'h0E20; 
        	#20 rst = 1; data_in = 16'h0B21;
        	#20 rst = 1; data_in = 16'h2388;
        end

initial
        begin
		clk = 1'b0;
		forever #10 clk = ~clk;
        end

initial
	begin
		#100 $finish;
	end
endmodule


