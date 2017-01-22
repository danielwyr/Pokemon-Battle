module sampling_mod (S_data_out, reset, sc_clk_ctrl, data, sample_phase);
	output reg S_data_out;
	input reset, sc_clk_ctrl, data, sample_phase;
	
	reg [2:0] n_count, p_count;
	
	always@(*)
	if(3'b111 != p_count & 1'b1 == sample_phase) begin
	n_count = p_count + 3'b001;
	S_data_out = S_data_out;
	end
	else begin
	n_count = 3'b000;
	S_data_out = data;
	end
	
	always@(negedge sc_clk_ctrl)
	if(reset)
	p_count <= n_count;
	else
	p_count <= 3'b000;
endmodule
