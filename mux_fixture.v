`include "mux.v"

module mux_fixture;

	reg [15:0] d0,d1;
	reg sel;
	wire [15:0] y;
	
	initial
		$vcdpluson;

        initial
                $monitor($time, " Sel = %b d0= %b d1 = %b y = %b",  sel, d0[15:0], d1[15:0], y[15:0]);
	// Instantiate the design block counter
          mux c1(sel, d0, d1, y);

        // Stimulate the Clear Signal
        initial
	begin
		sel = 0; d0 = 0; d1 = 0;
                #10 sel = 1; d0 = 20; d1 = 60;
                #10 sel = 0; d0 = 50; d1 = 70;
                #10 sel = 1; d0 = 40; d1 = 80;
		#10 sel = 0; d0 = 90; d1 = 100;
        end

        initial
        begin
		#50
                $finish;
        end
endmodule
