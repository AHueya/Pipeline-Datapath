module aluControl(opCode, funCode, aluOp);
    input [3:0] opCode, funCode;
    output reg [2:0] aluOp;

    always @ (*) begin
        case(opCode)
            4'b0000: begin              //Signed Arithmetic 
                if(funCode == 4'b0000)
                    aluOp = 3'b000;     //Signed Addition
                if(funCode == 4'b0001)
                    aluOp = 3'b001;     //Signed Subtraction
                if(funCode == 4'b0100)
                    aluOp = 3'b010;     //Signed Multiplication
                if(funCode == 4'b0101)
                    aluOp = 3'b011;     //Signed Division
            end

            4'b0001: aluOp = 3'b100;    //And
            4'b0010: aluOp = 3'b101;    //Or
            4'b1010: aluOp = 3'b110;    //Load Byte Unsigned
            4'b1011: aluOp = 3'b110;    //Store Byte (Unsigned Addition)
            4'b1100: aluOp = 3'b110;    //Load (Unsigned Addition)
            4'b1101: aluOp = 3'b110;    //Store (Unsigned Addition)
            4'b1111: aluOp = 3'b111;    //Halt
            
            default: aluOp = 3'b111;
        endcase
    end
endmodule
