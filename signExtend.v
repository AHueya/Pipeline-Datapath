module signExtend #(parameter N = 4) (input [N-1:0] dataIn, output reg [15:0] dataOut );
    always @ (*) begin
        assign dataOut = { {16{dataIn[N-1]}}, dataIn};
    end
endmodule
