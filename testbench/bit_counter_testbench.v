// andorTop0.v
`include "bit_counter.v"
module bit_counter_testbench;
	wire [7:0]bit_count;
	wire char_sent;
	wire reset, clk, transmit_enable, load;

 // declare an instance of the DE1_SoC
 bit_counter de1 (char_sent, bit_count, reset, clk, transmit_enable, load);
 // declare an instance of the testlt module
 Tester dTester (char_sent, bit_count, reset, clk, transmit_enable, load);


 // file for gtkwave
 initial begin
 // these two files support gtkwave and are required
 $dumpfile("testBench.vcd");
 $dumpvars(1,de1); 
 end
endmodule 


// Tester
module Tester (char_sent, bit_count, reset, clk, transmit_enable, load);
	input [7:0]bit_count;
	input char_sent;
	output reset, clk, transmit_enable, load;
	reg reset, clk, transmit_enable, load;
	
	parameter CLOCK_PERIOD=20;
	initial clk=1;
	always begin
	#(CLOCK_PERIOD/2);
	clk = ~clk;
	end
	initial // Response
	begin
		$display("\t\t bit_count, char_sent \t reset, clk, transmit_enable, load \t Time ");
		$monitor("\t\t %b\t %b \t %b \t %b", char_sent, bit_count, reset, clk, transmit_enable, load , $time);
	end
	
	initial //Stimulus
	begin 
	 #0 reset<=1'b1; load <= 1'b0;
	 #10 reset<=1'b0; load <= 1'b1; transmit_enable <= 1'b1;
	 #20 reset<=1'b1; 
	 #30 load <= 1'b0;
	 #10000
	 $finish;
	 end
endmodule