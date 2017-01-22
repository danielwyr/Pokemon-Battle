// andorTop0.v
`include "P2S_SR.v"
module P2S_SR_testbench;
	wire S_data_out;
	wire reset, ic_clk_ctrl, load, end_pass;
	wire [7:0] P_data_in;

 // declare an instance of the DE1_SoC
 P2S_SR de1 (S_data_out, reset, ic_clk_ctrl, P_data_in, load, end_pass);
 // declare an instance of the testlt module
 Tester dTester (S_data_out, reset, ic_clk_ctrl, P_data_in, load, end_pass);


 // file for gtkwave
 initial begin
 // these two files support gtkwave and are required
 $dumpfile("testBench.vcd");
 $dumpvars(1,de1); 
 end
endmodule 


// Tester
module Tester (S_data_out, reset, ic_clk_ctrl, P_data_in, load, end_pass);
	input S_data_out;
	output reset, ic_clk_ctrl, load, end_pass;
	output [7:0] P_data_in;
	reg reset, ic_clk_ctrl, load, end_pass;
	reg [7:0] P_data_in;
	
	/*
	parameter CLOCK_PERIOD=60;
	initial ic_clk_ctrl=1;
	always begin
	#(CLOCK_PERIOD/2);
	ic_clk_ctrl = ~ic_clk_ctrl;
	end
	*/
	parameter stimDelay = 20;
	
	initial // Response
	begin
		$display("\t\t S_data_out \t reset, ic_clk_ctrl, load, end_pass, P_data_in \t Time ");
		$monitor("\t\t %b\t %b \t %b \t %b", S_data_out, reset, ic_clk_ctrl, P_data_in, load, end_pass , $time);
	end
	
	initial //Stimulus
	begin 
	 //#0	reset <= 1'b0;
	 //#10 reset <= 1'b1; load <= 1'b1; end_pass <= 1'b0; P_data_in <= 8'b11111111;
	 //#50 reset <= 1'b0;
	 //#100 reset <= 1'b1;
	 //#200 load <= 1'b0;
	 //#300
	 //#1000
	 
	 #stimDelay ic_clk_ctrl=1'b0; reset<=1'b1; load <= 1'b0;
	 #stimDelay ic_clk_ctrl=ic_clk_ctrl; reset<=1'b0; load <= 1'b1; end_pass <= 1'b0; P_data_in <= 8'b11111111;
	 #stimDelay ic_clk_ctrl=ic_clk_ctrl; reset<=1'b1;
	 #stimDelay ic_clk_ctrl=ic_clk_ctrl; load <= 1'b0;
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 $finish;
	 end
endmodule