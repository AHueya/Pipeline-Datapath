module comparator(branchControl, Op1, r15, branch);
    input [1:0] branchControl;
    input [15:0] Op1, r15;
    output reg [1:0] branch;

    always @ (*) begin
        case(branchControl)
            2'b00:  branch = (Op1 < r15 ? 1 : 0); 
            2'b01:  branch = (Op1 > r15 ? 1 : 0);
            2'b10:  branch = (Op1 == r15 ? 1 : 0);  
            default: branch = 0;
        endcase
    end
endmodule
