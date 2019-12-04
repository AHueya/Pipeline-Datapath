module add(dataIn_1, dataIn_2, dataOut);

    input [15:0] dataIn_1, dataIn_2;
    output reg [15:0] dataOut;

    always @ (*) begin
        assign dataOut = dataIn_1 + dataIn_2;
    end

endmodule
