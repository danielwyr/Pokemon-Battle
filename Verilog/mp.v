module mp(clk, rst, x, y, r, g, b, x0, y0, magic);
	input clk, rst;
	input [9:0] x, x0;
	input [8:0] y, y0;
	input [9:0] magic;
	output reg [7:0] r, g, b;
	
	
	//124*14 pixel
	//2 pixel outer bound
	//magic: 120 * 10 pixel
	
	always @(posedge clk) begin
		if(x <= x0 + 10'b0011001000 & x > x0 & y <= y0 + 9'b011001000 & y > y0) begin
			if(y > y0 & y <= y0 + 2) begin
				if((x > x0 & x <= x0 + 124)) begin
					r <= 8'b00001111;
					g <= 8'b00001111;
					b <= 8'b00001111;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 2 & y <= y0 + 12) begin
				if((x > x0 & x <= x0 + 2) | (x > x0 + 122 & x <= x0 + 124)) begin
					r <= 8'b00001111;
					g <= 8'b00001111;
					b <= 8'b00001111;
				end else if (x > x0 + 2 & x <= x0 + magic) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b11111111;
				end else begin			
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 12 & y <= y0 + 14) begin
				if((x > x0 & x <= x0 + 124)) begin
					r <= 8'b00001111;
					g <= 8'b00001111;
					b <= 8'b00001111;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end	
		end else begin 
			r <= 8'b11111111;
			g <= 8'b11111111;
			b <= 8'b11111111;
		end
	end 

endmodule 