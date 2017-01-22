module sb_detect (receive_enable, reset, clk, data_in, char_received);
	output reg receive_enable;
	input reset, clk;
	input data_in, char_received;
	
	initial receive_enable = 1'b0;
	always@(negedge clk)
	if(reset) begin
	case(char_received)
		1'b0: if(!data_in & 1'b0 == receive_enable) receive_enable = 1'b1;
				else if(1'b1 == receive_enable) receive_enable = 1'b1;
				else receive_enable = 1'b0;
		1'b1: receive_enable = 1'b0;
		default receive_enable = 1'b0;
	endcase
	end
	else 
	receive_enable <= 1'b0;
endmodule
