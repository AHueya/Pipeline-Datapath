module registerForward(input [3:0] op1, op2, memRd, wbRd, input memRegWrite, wbRegWrite, output reg [1:0] aluSrc2, aluSrc3);
	always @ (*) begin
		aluSrc2<= 2'b00;
		aluSrc3 <= 2'b00;

		if (memRegWrite & memRd != 0 & memRd == op1)
			aluSrc3 <= 2'b10;
		else if (wbRegWrite & wbRd != 0 & wbRd == op1) 
			aluSrc3 <= 2'b01;

		if (memRegWrite & memRd != 0 & memRd == op2) 
			aluSrc2 <= 2'b10;
		else if (wbRegWrite & wbRd != 0 & wbRd == op2) 
			aluSrc2 <= 2'b01;
	end

endmodule
