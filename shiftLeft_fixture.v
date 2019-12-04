`include "shiftLeft.v"

module shiftLeft_fixture;

    reg [15:0] dataIn;
    wire [15:0] dataOut;

    initial
        $vcdpluson;

    initial
        $monitor($time, " DataIn = %b DataOut = %b", dataIn, dataOut);

    shiftLeft g1(dataIn, dataOut);

    initial begin
        dataIn = 1;
        #10 $finish;
    end
endmodule
