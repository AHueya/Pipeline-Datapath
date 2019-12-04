`include "signExtend.v"

module signExtend_fixture;

    reg [3:0] dataIn;
    wire [15:0] dataOut;

    initial
        $vcdpluson;

    initial
        $monitor($time, " dataIn = %b dataOut = %b", dataIn, dataOut);

    signExtend #(4) g1(dataIn, dataOut);

    initial begin
        dataIn = 10;
        #10 $finish;
    end
endmodule
