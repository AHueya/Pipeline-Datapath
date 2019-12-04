module alu(A, B, Operation, signFlag, Out, R);

    input[2:0] Operation;
    input [15:0] A, B;
    output reg signFlag;
    output reg [15:0] Out, R;

    always @(*) begin 
        case(Operation)
        3'b000: begin 
            Out = A + B;              //Signed Addition
            signFlag = 1;
            R = 0;
        end
        3'b001: begin
            Out = A - B;              //Signed Subtraction
            signFlag = 1;
            R = 0;
        end
        3'b010: begin
            {R, Out} = A * B;         //Signed Multiplication (16 Bit remainder)
            signFlag = 1;
        end
        3'b011: begin
            Out = A / B;              //Signed Division (16 bit remainder)
            R = A % B;
            signFlag = 1;
        end

        3'b100: begin
            Out = A & B;            //AND Immediate
            signFlag = 0;
            R = 0;
        end
        3'b101: begin
            Out = A | B;            //OR Immediate
            signFlag = 0;
            R = 0;
        end
        
        3'b110: begin               //Load Byte Unsigned
            Out = A + B;            //Unsigned Addition
            signFlag = 0;           //Store Byte, Load, Store
            R = 0;
        end

        3'b111: begin               //No value
            Out = 0;
            signFlag = 0;
            R = 0;
        end
        default: begin
            Out = 0;
            R = 0;
            signFlag = 0;
        end
        endcase
    end
endmodule
