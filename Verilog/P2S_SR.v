module P2S_SR (S_data_out, reset, ic_clk_ctrl, CLOCK_50, P_data_in, load, end_pass);
	output reg S_data_out;
	input reset, ic_clk_ctrl, CLOCK_50, load, end_pass;
	input [7:0] P_data_in;
	
	initial S_data_out = 1'b1;
	initial buffer = 10'b1111111111;
	reg clk, sel;
	reg [9:0] buffer;
	always@(*)
	if(1'b1 == load & 1'b0 == end_pass) begin
		//buffer = {1'b0, P_data_in, 1'b1};
		clk = CLOCK_50;
		//sel = 1'b0; // load data to the shiftregister
	end
	else if(1'b0 == load & 1'b0 == end_pass) begin
		//buffer = buffer;
		clk = ic_clk_ctrl;
		//sel = 1'b1; // start shifting data seirally out
	end
	else begin
		//p_buffer = 10'b1111111111;
		clk = ic_clk_ctrl;
		//sel = 1'b0;
	end
	
	always@(negedge clk)
	if(reset) begin
		if(1'b0 == load & 1'b0 == end_pass) begin
		
		buffer <= {buffer[8:0], 1'b1};
		S_data_out <= buffer[9];
		//buffer[0] = 1'b1;
		end
		else if(1'b1 == load & 1'b0 == end_pass) begin
		buffer[0] <= 1'b1;
		buffer[8:1] <= P_data_in;
		buffer[9] <= 1'b0;
		//buffer <= {1'b0, P_data_in, 1'b1};
		S_data_out <= 1'b1;
		end
		else begin
		buffer <= buffer;
		S_data_out <= 1'b1;
		end
	end
	else begin
		buffer <= 10'b1111111111;
		S_data_out <= 1'b1;
	end
endmodule
