// andorTop0.v
`include "com_mod.v"
`include "bit_counter.v"
`include "P2S_SR.v"
`include "sampling_mod.v"
`include "sb_detect.v"
`include "S2P_SR.v"
module com_mod_testbench;
	wire S_data_out, char_sent, char_received;
	wire [7:0] P_data_out;
	wire CLOCK_50, reset;
	wire transmit_enable, load, S_data_in;
	wire [7:0] P_data_in;

 // declare an instance of the DE1_SoC
 com_mod de1 (S_data_out, P_data_out, char_sent, char_received, reset, CLOCK_50, transmit_enable, P_data_in, load, S_data_in);
 // declare an instance of the testlt module
 Tester dTester (S_data_out, P_data_out, char_sent, char_received, reset, CLOCK_50, transmit_enable, P_data_in, load, S_data_in);


 // file for gtkwave
 initial begin
 // these two files support gtkwave and are required
 $dumpfile("testBench.vcd");
 $dumpvars(1,de1); 
 end
endmodule 




// Tester
module Tester (S_data_out, P_data_out, char_sent, char_received, reset, CLOCK_50, transmit_enable, P_data_in, load, S_data_in);
	input S_data_out, char_sent, char_received;
	input [7:0] P_data_out;
	output CLOCK_50, reset;
	output transmit_enable, load, S_data_in;
	output [7:0] P_data_in;
	
	reg CLOCK_50, reset;
	reg transmit_enable, load, S_data_in;
	reg [7:0] P_data_in;
	
	parameter CLOCK_PERIOD=10;
	initial CLOCK_50=1;
	always begin
	#(CLOCK_PERIOD/2);
	CLOCK_50 = ~CLOCK_50;
	end
	
	initial // Response
	begin
		$display("\t\t S_data_out, char_sent, char_received, P_data_out \t CLOCK_50, reset, transmit_enable, load, S_data_in, P_data_in \t Time ");
		$monitor("\t\t %b\t %b \t %b \t %b", S_data_out, P_data_out, char_sent, char_received, reset, CLOCK_50, transmit_enable, P_data_in, load, S_data_in , $time);
	end
	
	initial //Stimulus
	begin 
	 #0 reset<=1'b1; load <= 1'b0; 
	 #10 reset<=1'b0; load <= 1'b1; P_data_in <= 8'b11111111; S_data_in <= 1'b0;
	 #20 reset<=1'b1; 
	 #30 load <= 1'b0; transmit_enable <= 1'b1;
	 #20000 transmit_enable <= 1'b0;
	 #20010 S_data_in <= 1'b1;
	 #18020 S_data_in <= 1'b0; 
	 $finish;
	 end
endmodule