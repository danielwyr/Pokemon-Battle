// andorTop0.v
`include "synchronizer.v"
module synchronizer_testbench;
	wire filtered_data;
	wire reset, clk, S_data_in;

 // declare an instance of the DE1_SoC
 synchronizer de1 (filtered_data, reset, clk, S_data_in);
 // declare an instance of the testlt module
 Tester dTester (filtered_data, reset, clk, S_data_in);


 // file for gtkwave
 initial begin
 // these two files support gtkwave and are required
 $dumpfile("testBench.vcd");
 $dumpvars(1,de1); 
 end
endmodule 


// Tester
module Tester (filtered_data, reset, clk, S_data_in);
	input filtered_data;
	output reset, clk, S_data_in;
	reg reset, clk, S_data_in;
	
	parameter CLOCK_PERIOD=20;
	initial clk=1;
	always begin
	#(CLOCK_PERIOD/2);
	clk = ~clk;
	end
	initial // Response
	begin
		$display("\t\t filtered_data \t reset, clk, S_data_in \t Time ");
		$monitor("\t\t %b\t %b \t %b \t %b", filtered_data, reset, clk, S_data_in , $time);
	end
	
	initial //Stimulus
	begin 
	 #0 reset<=1'b1; 
	 #10 reset<=1'b0;
	 #20 reset<=1'b1; S_data_in <= 1'b1;
	 #20 S_data_in <= 1'b0;
	 #10000
	 $finish;
	 end
endmodule