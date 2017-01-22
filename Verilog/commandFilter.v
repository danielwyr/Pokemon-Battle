module commandFilter(clk, reset, command, offset, x, y, enter);
		output reg [5:0] command;
		output reg [7:0] offset;
		input clk, reset, enter;
		input [9:0] x;
		input [8:0] y;
		
		parameter OFF_SET = 8'b00100000;
		
		
		always@(posedge clk)
		if(enter) begin
			if(88 == x & 22 == y) begin
			command <= 6'b010000;
			offset <= 8'b00000000; 
			end
			else if(128 == x & 22 == y) begin
			command <= 6'b100000;
			offset <= 8'b00000000;
			end
			else if(8 == x & 62 == y) begin
			command <= 6'b000001;
			offset <= OFF_SET;
			end
			else if(48 == x & 62 == y) begin
			command <= 6'b000010;
			offset <= OFF_SET;
			end
			else if(88 == x & 62 == y) begin
			command <= 6'b000100;
			offset <= OFF_SET;
			end
			else if(128 == x & 62 == y) begin 
			command <= 6'b001000;
			offset <= OFF_SET;
			end
			else begin
			command <= 6'b000000;
			offset <= OFF_SET;
			end
		end
		else begin
		command <= 6'b000000;
		offset <= 8'b00000000;
		end
endmodule
