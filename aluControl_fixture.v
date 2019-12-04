`include "aluControl.v"

module aluControl_fixture;
    reg [3:0] opCode, funCode;
    wire [2:0] aluOp;

    initial
        $vcdpluson;

    initial
        $monitor($time, " opCode = %b funCode = %b aluOp = %b", opCode, funCode, aluOp);

    aluControl g1(opCode, funCode, aluOp);

    initial begin
        opCode = 0; funCode = 0;
        #10 funCode = 1;
        #10 funCode = 4;
        #10 funCode = 5;

        #10 opCode = 1; funCode = 4'bxxxx;
        #10 opCode = 2;
        #10 opCode = 10;
        #10 opCode = 11;
        #10 opCode = 12;
        #10 opCode = 13;
        #10 opCode = 4'bxxxx; 
        #10 $finish;
    end

endmodule
