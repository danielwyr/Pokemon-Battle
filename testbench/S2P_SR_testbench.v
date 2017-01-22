// andorTop0.v
`include "S2P_SR.v"
module S2P_SR_testbench;
	wire [7:0] P_data_out;
	wire reset, ic_clk_ctrl, S_data_in, read;

 // declare an instance of the DE1_SoC
 S2P_SR de1 (P_data_out, reset, ic_clk_ctrl, S_data_in, read);
 // declare an instance of the testlt module
 Tester dTester (P_data_out, reset, ic_clk_ctrl, S_data_in, read);


 // file for gtkwave
 initial begin
 // these two files support gtkwave and are required
 $dumpfile("testBench.vcd");
 $dumpvars(1,de1); 
 end
endmodule 


// Tester
module Tester (P_data_out, reset, ic_clk_ctrl, S_data_in, read);
	input [7:0] P_data_out;
	output reset, ic_clk_ctrl, S_data_in, read;
	reg reset, ic_clk_ctrl, S_data_in, read;
	
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
		$display("\t\t P_data_out \t reset, ic_clk_ctrl, S_data_in, read \t Time ");
		$monitor("\t\t %b\t %b \t %b \t %b", P_data_out, reset, ic_clk_ctrl, S_data_in, read , $time);
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
	 
	 #stimDelay ic_clk_ctrl=1'b0; reset<=1'b1;
	 #stimDelay ic_clk_ctrl=ic_clk_ctrl; reset<=1'b0; 
	 #stimDelay ic_clk_ctrl=ic_clk_ctrl; reset<=1'b1;
	 #stimDelay ic_clk_ctrl=ic_clk_ctrl; read <= 1'b0; S_data_in <= 1'b1;
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
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; read <= 1'b1;
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 #stimDelay ic_clk_ctrl=~ic_clk_ctrl; 
	 $finish;
	 end
endmodule