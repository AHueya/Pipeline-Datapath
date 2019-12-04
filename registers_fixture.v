`include "registers.v"

module registers_fixture;
	reg clk, rst, regWrite;
	reg [3:0] regAddress1, regAddress2, writeAddress;
	reg [15:0] writeData, writeR15;
	wire [15:0] readData1, readData2, readR15;

	initial
        	$vcdpluson;

	initial
       		$monitor($time, " regAddress1 = %d regAddress2 = %d regWrite = %d writeAddress = %d writeData = %h writeR15 = %h readData1 = %h readData2 = %h readR15 = %h",
				 regAddress1, regAddress2, regWrite, writeAddress, writeData, writeR15, readData1, readData2, readR15);

	registers c1(.regAddress1(regAddress1), .regAddress2(regAddress2), 
		     .writeAddress(writeAddress), .writeData(writeData), .writeR15(writeR15),
		     .clk(clk), .rst(rst), .regWrite(regWrite), .readData1(readData1), .readData2(readData2), .readR15(readR15));

	initial
	begin
	        rst = 0; regAddress1 = 0; regAddress2 = 0; regWrite = 0; writeAddress = 0; writeData = 0; writeR15 = 0;
		#10 rst = 1; 
		#20 regAddress1 = 14; regAddress2 = 2; regWrite = 1; writeAddress = 14; writeData = 16'h246C; writeR15 = 16'h1234;
		#20 regAddress1 = 14; regAddress2 = 2; regWrite = 0; writeAddress = 0; writeData = 0; writeR15 = 16'h1234;
		#20 regAddress1 = 11; regAddress2 = 2; regWrite = 1; writeAddress = 11; writeData = 16'h0C3E; writeR15 = 16'habcd;
		#20 regAddress1 = 11; regAddress2 = 2; regWrite = 0; writeAddress = 0; writeData = 0; writeR15 = 16'habcd;
		#20 rst = 0;
		#20 rst = 1;
		#20 regAddress1 = 14; regAddress2 = 2; regWrite = 0; writeAddress = 0; writeData = 0; writeR15 = 16'hFFFF;

	end

	initial
	begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial
	begin
		#160 $finish;
	end

endmodule
