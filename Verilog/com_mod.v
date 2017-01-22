module com_mod (S_data_out, P_data_out, char_sent, char_received, reset, CLOCK_50, transmit_enable, P_data_in, load, S_data_in);
	output S_data_out, char_sent, char_received;
	output [7:0] P_data_out;
	input CLOCK_50, reset;
	input transmit_enable, load, S_data_in;
	input [7:0] P_data_in;
	
	
	// Clock divider
	reg [31:0] divided_clocks;
	initial
	divided_clocks = 0;

	always @(posedge CLOCK_50)
	divided_clocks = divided_clocks + 1;
	
	parameter SELECTED_CLOCK = 7; // Set the baud rate to 9600 bps
	
	// Transmitting modules' internal connections
	wire data_s_o;
	wire [7:0] bit_count_o;
	//wire sc_clk_ctrl_o, ic_clk_ctrl_o;
	
	 
	// Receiving modules' internal connections
	wire receive_enable, data_s_i, filtered_data;
	wire [7:0] bit_count_i;
	wire fake_char_received;
	//wire sc_clk_ctrl_i, ic_clk_ctrl_i;

	// Transmitting modules
	bit_counter bc_o (char_sent, bit_count_o, reset, divided_clocks[SELECTED_CLOCK], transmit_enable, load);
	P2S_SR p2s_sreg (data_s_o, reset, ~bit_count_o[3], CLOCK_50, P_data_in, load, 5'b100011 == bit_count_o[7:2]);
	sampling_mod spm_o (S_data_out, reset, bit_count_o[0], data_s_o, bit_count_o[3]);
	  
	// Receiving modules
	sb_detect sbd (receive_enable, reset, divided_clocks[SELECTED_CLOCK], S_data_in, fake_char_received);
	bit_counter bc_i (fake_char_received, bit_count_i, reset, divided_clocks[SELECTED_CLOCK], receive_enable, 1'b0);
	S2P_SR s2p_sreg (P_data_out, reset, ~bit_count_i[3], data_s_i, 5'b10011 == bit_count_i[7:3], receive_enable);
	sampling_mod spm_i (data_s_i, reset, bit_count_i[0], S_data_in, bit_count_i[3]);
	//synchronizer sync (filtered_data, reset, divided_clocks[SELECTED_CLOCK], S_data_in);
	
	assign char_received = (5'b10011 == bit_count_i[7:3]);
endmodule
