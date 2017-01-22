module S2P_SR (P_data_out, reset, ic_clk_ctrl, S_data_in, read, receive_enable);
	output reg [7:0] P_data_out; 
	input reset, ic_clk_ctrl, S_data_in, read, receive_enable;
	reg [8:0] buffer;

	always@(*)
	if(receive_enable & !read) begin
	P_data_out <= P_data_out;
	end
	else if(receive_enable & read) begin
	P_data_out <= buffer[8:1];
	end
	else begin
	P_data_out <= 8'b11111111;
	end
	
	always@(negedge ic_clk_ctrl)
	if(reset) begin
		if(receive_enable) begin
		buffer = buffer << 1;
		buffer[0] = S_data_in;
		end
		else begin 
		buffer <= buffer; 
		end
	end
	else
	buffer <= 9'b111111111;
endmodule
