module zeroSignExtend (dataIn, dataOut);
    input [7:0] dataIn;
    output reg [15:0] dataOut;

    always @ (*) begin
        assign dataOut = {8'b0, dataIn};
    end
endmodule
