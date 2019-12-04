`include "control.v"

module control_fixture;

    reg [3:0] opCode, funCode;
    wire [2:0] aluOp;
    wire [1:0] seSrc, cpCtrl, memWrite, memRead, memToReg;
    wire regWrite, seCtrl, aluSrc1, aluSrc4, fwSrc, pcSrc;

    
    initial
        $vcdpluson;

    initial
        $monitor($time, " opCode = %b funCode = %b seCtrl = %b seSrc = %b aluSrc1 = %b aluSrc4 = %b \n fwSrc = %b pcSrc = %b memRead = %b memWrite = %b cpCtrl = %b regWrite = %b aluOp = %b memToReg = %b", opCode, funCode, seCtrl, seSrc, aluSrc1, aluSrc4, fwSrc, pcSrc, memRead, memWrite, cpCtrl, regWrite, aluOp, memToReg);

    control g1(opCode, funCode, aluOp, seSrc, cpCtrl, memWrite, memRead, memToReg, regWrite, seCtrl, aluSrc1, aluSrc4, fwSrc, pcSrc);

    initial begin
        opCode = 0; funCode = 4;
        #10 opCode = 1;     //And
        #10 opCode = 2;     //Or
        #10 opCode = 10;    //LBU
        #10 opCode = 11;    //Store Byte
        #10 opCode = 12;    //Load
        #10 opCode = 13;    //Store
        #10 opCode = 5;     //BLT
        #10 opCode = 4;     //BGT
        #10 opCode = 6;     //BE
        #10 opCode = 7;     //JMP
        #10 opCode = 4'b1111;    //Halt
        #10 $finish;
    end
    
endmodule
