`include "zeroSignExtend.v"

module zeroSignExtend_fixture;

    reg [7:0] dataIn;
    wire [15:0] dataOut;

    initial
        $vcdpluson;

    initial
        $monitor($time, " dataIn = %b dataOut = %b", dataIn, dataOut);

    zeroSignExtend g1(dataIn, dataOut);

    initial begin
        dataIn = 10;
        #10 dataIn = 128;
        #10 dataIn = 255;
        #10 $finish;
    end
endmodule
