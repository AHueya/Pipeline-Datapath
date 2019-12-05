module hazard(opCode, IF_ID_Op1, IF_ID_Op2, ID_EX_Op2, ID_EX_memRead, pcCtrl, bufferCtrl, ctrlMux, opCode_error);
    input [3:0] opCode, IF_ID_Op1, IF_ID_Op2, ID_EX_Op2;
    input ID_EX_memRead;
    output reg pcCtrl, bufferCtrl, ctrlMux, opCode_error;

    always @ (*) begin
        if(ID_EX_memRead && ( (IF_ID_Op1 == ID_EX_Op1) || (IF_ID_Op1 == ID_EX_Op2) ||
          (IF_ID_Op2 == ID_EX_Op1) || (IF_ID_Op2 == ID_EX_Op2) ) ) begin
            //Halt
            pcCtrl = 0;
            bufferCtrl = 0;
            ctrlMux = 1;
        end

        else begin
            pcCtrl = 1;
            bufferCtrl = 1;
            ctrlMux = 0;
        end
        
        if(opCode != 4'b0000 || opCode != 4'b0001 || opCode != 4'b0010 || opCode != 4'b1010 || opCode != 4'b1011 || opCode != 4'b1100 || opCode != 4'b1101 || opCode != 4'b0101 || opCode != 4'b0100 || opCode != 4'b0110 || opCode != 4'b0111 || opCode != 4'b1111)
            opCode_error = 1;
        else
            opCode_error = 0;
    end
endmodule
