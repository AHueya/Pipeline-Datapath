`include "add.v"

module add_fixture;

    reg [15:0] dataIn_1, dataIn_2;
    wire [15:0] dataOut;

    initial
        $vcdpluson;

    initial
        $monitor($time, " dataIn_1 = %b dataIn_2 = %b dataOut = %b", dataIn_1, dataIn_2, dataOut);

    add g1(dataIn_1, dataIn_2, dataOut);

    initial begin
        dataIn_1 = 10; dataIn_2 = 15;
        #10 $finish;
    end
endmodule
