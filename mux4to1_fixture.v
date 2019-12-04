`include "mux4to1.v"

module mux4to1_fixture;

        reg [15:0] d0,d1,d2,d3;
        reg [1:0] sel;
        wire [15:0] y;

        initial
                $vcdpluson;

        initial
                $monitor($time, " Sel = %b d0= %b d1 = %b d2 = %b d3 =%b y = %b",  sel, d0[15:0], d1[15:0], d2[15:0], d3[15:0], y[15:0]);

  	  mux4to1 c1(sel, d0, d1, d2, d3, y);


	initial
	begin
		sel = 0; d0 = 0; d1 = 0; d2 = 0; d3 = 0;
		#10 sel = 0; d0 = 20; d1 = 60; d2 = 95; d3 = 70;
		#10 sel = 1; d0 = 50; d1 = 70; d2 = 10; d3 = 2;
		#10 sel = 2; d0 = 40; d1 = 80; d2 = 1;  d3 = 39;
		#10 sel = 3; d0 = 90; d1 = 100; d2 = 51; d3 = 13;
	end

	initial
	begin
		#50
		$finish;
	end
endmodule
