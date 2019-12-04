`include "comparator.v"

module comparator_fixture;
    reg [1:0] branchControl;
    reg [15:0] Op1, r15;
    wire [1:0] branch;

    comparator g1(branchControl, Op1, r15, branch);

    initial
        $vcdpluson;

    initial
        $monitor($time, " branchControl = %b Op1 = %b R15 = %b Branch = %b", branchControl, Op1, r15, branch);
    initial begin
        branchControl = 0; Op1 = 10; r15 = 5;
        #10 Op1 = 5; r15 = 10;
        #10 branchControl = 1;
        #10 Op1 = 10; r15 = 5;
        #10 branchControl = 2;
        #10 Op1 = 5;
        #20 $finish;
    end
endmodule
