module shiftLeft (dataIn, dataOut);
    input [15:0] dataIn;
    output reg [15:0] dataOut;    

    always @ (*) begin
        assign dataOut = dataIn <<< 1;
    end
endmodule
