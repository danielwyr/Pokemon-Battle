module pokeball(clk, rst, x, y, r, g, b, x0, y0, enable);
	input clk, rst, enable;
	input [9:0] x, x0;
	input [8:0] y, y0;
	output reg [7:0] r, g, b;
	
	//14 * 14  scale parameter: 12  --> 192*192

	always @(posedge clk) begin
		if(enable) begin
			if(x <= x0 + 10'b0000001110 & x > x0 & y <= y0 + 9'b000001110 & y > y0) begin
				if(y > y0 & y <= y0 + 1) begin
					if(x > x0 + 5 & x <= x0 + 9) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 1 & y <= y0 + 2) begin
					if((x > x0 + 3 & x <= x0 + 5) | (x > x0 + 10 & x <= x0 + 11)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if (x > x0 + 5 & x <= x0 + 10) begin
						r <= 8'b11111111;
						g <= 8'b00000000;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 2 & y <= y0 + 3) begin
					if((x > x0 + 2 & x <= x0 + 3) | (x > x0 + 11 & x <= x0 + 12)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if (x > x0 + 3 & x <= x0 + 11) begin
						r <= 8'b11111111;
						g <= 8'b00000000;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 3 & y <= y0 + 5) begin
					if((x > x0 + 1 & x <= x0 + 2) | (x > x0 + 12 & x <= x0 + 13)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if (x > x0 + 2 & x <= x0 + 12) begin
						r <= 8'b11111111;
						g <= 8'b00000000;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 5 & y <= y0 + 6) begin
					if((x > x0 & x <= x0 + 1) | (x > x0 + 6 & x <= x0 + 8) | (x > x0 + 13 & x <= x0 + 14)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 1 & x <= x0 + 6) |  (x > x0 + 8 & x <= x0 + 13))begin
						r <= 8'b11111111;
						g <= 8'b00000000;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 6 & y <= y0 + 7) begin
					if((x > x0 & x <= x0 + 1) | (x > x0 + 5 & x <= x0 + 6) | (x > x0 + 8 & x <= x0 + 9) | (x > x0 + 13 & x <= x0 + 14)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 1 & x <= x0 + 5) |  (x > x0 + 9 & x <= x0 + 13))begin
						r <= 8'b11111111;
						g <= 8'b00000000;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 7 & y <= y0 + 8) begin
					if((x > x0 & x <= x0 + 6) | (x > x0 + 9 & x <= x0 + 14)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 8 & y <= y0 + 9) begin
					if((x > x0 & x <= x0 + 1) | (x > x0 + 6 & x <= x0 + 8) | (x > x0 + 13 & x <= x0 + 14)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 9 & y <= y0 + 11) begin
					if((x > x0 + 1 & x <= x0 + 2) | (x > x0 + 12 & x <= x0 + 13)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 11 & y <= y0 + 12) begin
					if((x > x0 + 2 & x <= x0 + 3) | (x > x0 + 11 & x <= x0 + 12)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 12 & y <= y0 + 13) begin
					if((x > x0 + 3 & x <= x0 + 5) | (x > x0 + 9 & x <= x0 + 11)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if(y > y0 + 13& y <= y0 + 14) begin
					if(x > x0 + 5 & x <= x0 + 9) begin
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
		end else begin
			r <= 8'b11111111;
			g <= 8'b11111111;
			b <= 8'b11111111;
		end
	end 
	
endmodule 