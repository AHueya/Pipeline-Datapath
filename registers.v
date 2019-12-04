module registers (input [3:0] regAddress1, regAddress2, writeAddress, input [15:0] writeData, writeR15,
		  input clk, rst, regWrite, output reg [15:0] readData1, readData2, readR15);

	reg [15:0] mem [15:1];

	always @ (posedge clk, negedge rst) begin
		if (!rst) begin
			
			mem[1] <= 16'h7B18; //R1
			mem[2] <= 16'h245B; //R2
			mem[3] <= 16'hFF0F; //R3
			mem[4] <= 16'hF0FF; //R4
			mem[5] <= 16'h0051; //R5
			mem[6] <= 16'h6666; //R6
			mem[7] <= 16'h00FF; //R7
			mem[8] <= 16'hFF88; //R8
			mem[9] <= 16'h0000; //R9
			mem[10] <= 16'h0000; //R10
			mem[11] <= 16'h3099; //R11
			mem[12] <= 16'hCCCC; //R12
			mem[13] <= 16'h0002; //R13
			mem[14] <= 16'h0011; //R14
			mem[15] <= 16'h0000; //R15
		end
		else begin
		
			readData1 <= mem[regAddress1];
			readData2 <= mem[regAddress2];
			readR15 <= mem[15];

			if (regWrite)
				mem[writeAddress] <= writeData;
				mem[15] <= writeR15;
			end		
		end
	


endmodule