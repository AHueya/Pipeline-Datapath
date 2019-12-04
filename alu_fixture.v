`include "alu.v"

module alu_fixture;

    reg [15:0] A, B;
    reg [2:0] Operation;
    wire signFlag;
    wire [15:0] Out, R;

    initial
        $vcdpluson;

    initial
        $monitor($time, " Op = %b A = %b B = %b signFlag = %b Out = %b R = %b", Operation, A, B, signFlag, Out, R);
    alu g1(A, B, Operation, signFlag, Out, R);

    initial begin
       Operation = 3'b000; A = 2; B = 2;                //Add
       #10 A = 2; B = -4;
       
       #10 Operation = 3'b001; A = 2; B = 2;            //Subtract
       #10 A = -4; B = -2;
       
       #10 Operation = 3'b010; A = 65535; B = 65535;    //Multiplication
       #10 A = 5; B = 8;
       #10 A = 2; B = 2;

       #10 Operation = 3'b011; A = 10; B = 5;           //Division
       #10 A = 13; B = 3;
       
       #10 Operation = 3'b100; A = 255; B = 15;         //And
       #10 Operation = 3'b101; A = 10; B = 5;           //Or
       
       #10 Operation = 3'b110; A = 5; B = 5;            //LBU
       #10 Operation = 3'b111; A = 5; B = 5;            //Unsigned Addition
       #10 $finish; 
    end

endmodule

