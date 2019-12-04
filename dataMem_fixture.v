`include "dataMem.v"

module dataMem_fixture;

	reg clk, rst;
	reg [1:0] memRead, memWrite;
	reg [15:0] addr;
	reg [15:0] writeData;
	wire [15:0] readData;
	
	initial
		$vcdpluson;

	initial
		$monitor($time, "address = %d writeData = %h readData = %h ", addr, writeData, readData);

	data_mem g1(.rst(rst), .clk(clk), .memRead(memRead), .memWrite(memWrite), .addr(addr),
				      .writeData(writeData), .readData(readData));

	initial
	begin
		rst = 0; addr = 0; writeData = 0; memRead = 0; memWrite = 0;
		#10 rst = 1;// addr = 0; memRead = 2'b01;
		//Load Word
		#20 addr = 0; memRead = 2'b01;
		#20 addr = 2; memRead = 2'b01;
		#20 addr = 4; memRead = 2'b01;
		#20 addr = 6; memRead = 2'b01;
		#20 addr = 8; memRead = 2'b01;
		//Load Byte
		#20 addr = 0; memRead = 2'b10;
		#20 addr = 2; memRead = 2'b10;
		#20 addr = 4; memRead = 2'b10;
		#20 addr = 6; memRead = 2'b10;
		#20 addr = 8; memRead = 2'b10;
		//Store Word
		#20 addr = 0; memRead = 2'b01; memWrite = 2'b01; writeData = 16'habcd;
		//Store Byte 
		#20 addr = 2; memWrite = 2'b10; writeData = 16'h0e1a;
		
		#20 addr = 0; memWrite = 2'b00; writeData = 0;
		#20 addr = 2; memWrite = 2'b00; writeData = 0;
	end

	initial
	begin
		clk = 1'b0;
		forever #10 clk = ~clk;
	end

	initial
	begin
		#300 $finish;
	end

endmodule
