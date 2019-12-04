`include "aluControl.v"

module control(opCode, funCode, aluOp, seSrc, cpCtrl, memWrite, memRead, memToReg,
               regWrite, seCtrl, aluSrc1, aluSrc4, fwSrc, pcSrc);
    input [3:0] opCode, funCode;
    output reg [2:0] aluOp;
    output reg [1:0] seSrc, cpCtrl, memWrite, memRead, memToReg;
    output reg regWrite, seCtrl, aluSrc1, aluSrc4, fwSrc, pcSrc;

    wire [2:0] aluOp_tmp;

    aluControl g1(.opCode(opCode), .funCode(funCode), .aluOp(aluOp_tmp));   //Calculates aluOp

    always @(*) begin
        regWrite = 0;
        seCtrl = 0;
        seSrc = 2'b00;
        aluSrc1 = 0;
        aluSrc4 = 0;
        aluOp = aluOp_tmp;
        fwSrc = 0;
        pcSrc = 0;
        cpCtrl = 2'b00;
        memWrite = 2'b00;
        memRead = 2'b00;
        memToReg = 2'b00;

        case(opCode)
            4'b0000:  begin     //Arithmetic
                fwSrc = 1;
                pcSrc = 1;
                regWrite = 1;
                memToReg = 1;
            end
            4'b0001:  begin     //And
                seCtrl = 1;
                aluSrc1 = 1;
                aluSrc4 = 1;
                fwSrc = 1;
                pcSrc = 1;
                regWrite = 1;
                memToReg = 1;
            end
            4'b0010:  begin     //Or
                 seCtrl = 1;
                 aluSrc1 = 1;
                 aluSrc4 = 1;
                 fwSrc = 1;
                 pcSrc = 1;
                 regWrite = 1;
                 memToReg = 1; 
            end
            4'b1010:  begin     //Load Byte Unsigned
                aluSrc1 = 1;
                aluSrc4 = 1;
                pcSrc = 1;
                memRead = 2;
                regWrite = 1;
            end
            4'b1011:  begin     //Store Byte
                aluSrc1 = 1;
                aluSrc4 = 1;
                pcSrc = 1;
                memWrite = 2;
            end
            4'b1100:  begin     //Load
                aluSrc1 = 1;
                aluSrc4 = 1;
                pcSrc = 1;
                memRead = 1;
                regWrite = 1;
            end
            4'b1101:  begin     //Store
                aluSrc1 = 1;
                aluSrc4 = 1;
                pcSrc = 1;
                memWrite = 1;
            end
            4'b0101:  begin     //Branch Less Than
                seSrc = 1;
            end
            4'b0100:  begin     //Branch Greater Than
                seSrc = 1;
                cpCtrl = 1;
            end
            4'b0110:  begin     //Branch Equal
                seSrc = 1;
                cpCtrl = 2;
            end
            4'b0111:  begin     //Jump
                seSrc = 2;
            end
            4'b1111:  begin     //Halt
            end
        endcase
    end
endmodule
