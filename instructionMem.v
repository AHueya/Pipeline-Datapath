module instructionMem(input clk, rst, input [7:0] addr, output reg [15:0] inst_out);
	reg [15:0] mem [63:0];
	always @(posedge clk, negedge rst) begin
		if (!rst) begin
		mem[0] <= 16'h0E20; //ADD R14, R2
		mem[2] <= 16'h0B21; //SUB R11, R2
		mem[4] <= 16'h2388; //ORi R3, 0088
		mem[6] <= 16'h149A; //ANDi R4, 9A
		mem[8] <= 16'h0564; //MUL R5, R6
		mem[10] <= 16'h0165; //DIV R1, R6
		mem[12] <= 16'hD59A; //SW R5, A(R9)
		mem[14] <= 16'h2802; //ORi R8, 2
		mem[16] <= 16'hCE9A; //LW R14, A(R9)
		mem[18] <= 16'h0FF1; //SUB R15, R15
		mem[20] <= 16'h0120; //ADD R1, R2
		mem[22] <= 16'h0121; //SUB R1, R2
		mem[24] <= 16'h1802; //ANDi R8, 2
		mem[26] <= 16'hA694; //LBU R6, 4(R9)
		mem[28] <= 16'hB696; //SB R6, 6(R9)
		mem[30] <= 16'hC696; //LW R6, 6(R9)
		mem[32] <= 16'h07D1; //SUB R7, R13  
		mem[34] <= 16'h6704; //BEQ R7, 4
		mem[36] <= 16'h0B10; //ADD R11, R1
		mem[38] <= 16'h5705; //BLT R7, 5
		mem[40] <= 16'h0B20; //ADD R11, R2
		mem[42] <= 16'h4702; //BGT R7, 2
		mem[44] <= 16'h0110; //ADD R1, R1
		mem[46] <= 16'h0110; //ADD R1, R1
		mem[48] <= 16'hC890; //LW R8, 0(R9)
		mem[50] <= 16'h0880; //ADD R8, R8
		mem[52] <= 16'hD892; //SW R8, 2(R9)
		mem[54] <= 16'hCA92; //LW R10, 2(R9)
		mem[56] <= 16'h0CC0; //ADD R12, R12
		mem[58] <= 16'h0DD1; //SUB R13, R13
		mem[60] <= 16'h0CD0; //ADD R12, R13
		mem[62] <= 16'hF000; //HALT
		end
	end
	always @ (*) begin
		inst_out <= mem[addr];
	end
	
	
	
endmodule