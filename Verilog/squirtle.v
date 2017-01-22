module squirtle(clk, rst, x, y, r, g, b, x0, y0, chosen);
	input clk, rst, chosen;
	input [9:0] x, x0;
	input [8:0] y, y0;
	output reg [7:0] r, g, b;
	
	parameter scale = 6;
	
	//21 * 17  scale parameter: 6-7  

always @(posedge clk) begin
		if(chosen) begin
			if(x <= x0 + 10'b0011001000 & x > x0 & y <= y0 + 9'b011001000 & y > y0) begin
				if(y > y0 & y <= y0 + scale) begin
					if((x > x0 + 2*scale & x <= x0 + 5*scale) | (x > x0 + 14*scale & x <= x0 + 18*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + scale & y <= y0 + 2*scale) begin
					if((x > x0 + 1*scale & x <= x0 + 2*scale) | (x > x0 + 5*scale & x <= x0 + 6*scale) | (x > x0 + 12*scale & x <= x0 + 14*scale) | (x > x0 + 18*scale & x <= x0 + 19*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 2*scale & x <= x0 + 5*scale) | (x > x0 + 14*scale & x <= x0 + 18*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 2*scale & y <= y0 + 3*scale) begin
					if((x > x0 & x <= x0 + scale) | (x > x0 + 6*scale & x <= x0 + 7*scale) | (x > x0 + 10*scale & x <= x0 + 12*scale) | (x > x0 + 19*scale & x <= x0 + 20*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + scale & x <= x0 + 6*scale) | (x > x0 + 12*scale & x <= x0 + 19*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 3*scale & y <= y0 + 4*scale) begin
					if((x > x0 & x <= x0 + scale) | (x > x0 + 2*scale & x <= x0 + 3*scale) | (x > x0 + 6*scale & x <= x0 + 7*scale) | (x > x0 + 8*scale & x <= x0 + 10*scale) | (x > x0 + 11*scale & x <= x0 + 12*scale) | (x > x0 + 19*scale & x <= x0 + 20*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + scale & x <= x0 + 2*scale) | (x > x0 + 3*scale & x <= x0 + 6*scale) | (x > x0 + 12*scale & x <= x0 + 19*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if (x > x0 + 10*scale & x <= x0 + 11*scale) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 4*scale & y <= y0 + 5*scale) begin
					if((x > x0 & x <= x0 + scale) | (x > x0 + 3*scale & x <= x0 + 4*scale) | (x > x0 + 7*scale & x <= x0 + 8*scale) | (x > x0 + 20*scale & x <= x0 + 21*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + scale & x <= x0 + 3*scale) | (x > x0 + 4*scale & x <= x0 + 7*scale) | (x > x0 + 11*scale & x <= x0 + 19*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if ((x > x0 + 8*scale & x <= x0 + 11*scale) | (x > x0 + 19*scale & x <= x0 + 20*scale)) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 5*scale & y <= y0 + 6*scale) begin
					if((x > x0 + scale & x <= x0 + 2*scale) | (x > x0 + 3*scale & x <= x0 + 4*scale) | (x > x0 + 6*scale & x <= x0 + 7*scale) | (x > x0 + 20*scale & x <= x0 + 21*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 2*scale & x <= x0 + 3*scale) | (x > x0 + 4*scale & x <= x0 + 6*scale) | (x > x0 + 10*scale & x <= x0 + 14*scale) | (x > x0 + 16*scale & x <= x0 + 20*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if ((x > x0 + 7*scale & x <= x0 + 10*scale) | (x > x0 + 14*scale & x <= x0 + 15*scale)) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 6*scale & y <= y0 + 7*scale) begin
					if((x > x0 + 2*scale & x <= x0 + 5*scale) | (x > x0 + 6*scale & x <= x0 + 7*scale) | (x > x0 + 15*scale & x <= x0 + 16*scale) | (x > x0 + 20*scale & x <= x0 + 21*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 5*scale & x <= x0 + 6*scale) | (x > x0 + 10*scale & x <= x0 + 14*scale) | (x > x0 + 16*scale & x <= x0 + 20*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if ((x > x0 + 7*scale & x <= x0 + 10*scale) | (x > x0 + 14*scale & x <= x0 + 15*scale)) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 7*scale & y <= y0 + 8*scale) begin
					if((x > x0 + 4*scale & x <= x0 +6*scale) | (x > x0 + 10*scale & x <= x0 + 11*scale) | (x > x0 + 15*scale & x <= x0 + 16*scale) | (x > x0 + 19*scale & x <= x0 + 20*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 9*scale & x <= x0 + 10*scale) | (x > x0 + 11*scale & x <= x0 + 14*scale) | (x > x0 + 16*scale & x <= x0 + 19*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if ((x > x0 + 6*scale & x <= x0 + 9*scale) | (x > x0 + 14*scale & x <= x0 + 15*scale)) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 8*scale & y <= y0 + 9*scale) begin
					if((x > x0 + 5*scale & x <= x0 + 6*scale) | (x > x0 + 11*scale & x <= x0 + 13*scale) | (x > x0 + 17*scale & x <= x0 + 19*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 8*scale & x <= x0 + 11*scale) | (x > x0 + 13*scale & x <= x0 +17*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if (x > x0 + 6*scale & x <= x0 + 8*scale) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 9*scale & y <= y0 + 10*scale) begin
					if((x > x0 + 5*scale & x <= x0 + 6*scale) | (x > x0 + 13*scale & x <= x0 + 17*scale) | (x > x0 + 18*scale & x <= x0 + 19*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 8*scale & x <= x0 + 13*scale) | (x > x0 + 17*scale & x <= x0 +18*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if (x > x0 + 6*scale & x <= x0 + 8*scale) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 10*scale & y <= y0 + 11*scale) begin
					if((x > x0 + 5*scale & x <= x0 + 6*scale) | (x > x0 + 9*scale & x <= x0 + 10*scale) | (x > x0 + 13*scale & x <= x0 + 15*scale) | (x > x0 + 17*scale & x <= x0 + 18*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 8*scale & x <= x0 + 9*scale) | (x > x0 + 10*scale & x <= x0 +13*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if (x > x0 + 6*scale & x <= x0 + 8*scale) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else if (x > x0 + 15*scale & x <= x0 + 17*scale) begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 11*scale & y <= y0 + 12*scale) begin
					if((x > x0 + 5*scale & x <= x0 + 6*scale) | (x > x0 + 9*scale & x <= x0 + 13*scale) | (x > x0 + 16*scale & x <= x0 + 17*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 8*scale & x <= x0 + 9*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if (x > x0 + 6*scale & x <= x0 + 8*scale) begin
						r <= 8'b11111111; // shit
						g <= 8'b11001100;
						b <= 8'b00000000;
					end else if (x > x0 + 13*scale & x <= x0 + 16*scale) begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 12*scale & y <= y0 + 13*scale) begin
					if((x > x0 + 6*scale & x <= x0 + 7*scale) | (x > x0 + 8*scale & x <= x0 + 9*scale) | (x > x0 + 14*scale & x <= x0 + 16*scale) | (x > x0 + 17*scale & x <= x0 + 18*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 7*scale & x <= x0 + 8*scale) | (x > x0 + 16*scale & x <= x0 + 17*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if (x > x0 + 9*scale & x <= x0 + 14*scale) begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 13*scale & y <= y0 + 14*scale) begin
					if((x > x0 + 6*scale & x <= x0 + 7*scale) | (x > x0 + 8*scale & x <= x0 + 9*scale) | (x > x0 + 12*scale & x <= x0 + 17*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if ((x > x0 + 7*scale & x <= x0 + 8*scale) | (x > x0 + 9*scale & x <= x0 + 10*scale)) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else if (x > x0 + 10*scale & x <= x0 + 12*scale) begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b00000000;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 14*scale & y <= y0 + 15*scale) begin
					if((x > x0 + 7*scale & x <= x0 + 9*scale) | (x > x0 + 10*scale & x <= x0 + 13*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if (x > x0 + 9*scale & x <= x0 + 10*scale) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 15*scale & y <= y0 + 16*scale) begin
					if((x > x0 + 7*scale & x <= x0 + 8*scale) | (x > x0 + 11*scale & x <= x0 + 12*scale)) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else if (x > x0 + 8*scale & x <= x0 + 11*scale) begin
						r <= 8'b00000000;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end
				end else if (y > y0 + 16*scale & y <= y0 + 17*scale) begin
					if(x > x0 + 7*scale & x <= x0 + 12*scale) begin
						r <= 8'b00001111;
						g <= 8'b00001111;
						b <= 8'b00001111;
					end else begin
						r <= 8'b11111111;
						g <= 8'b11111111;
						b <= 8'b11111111;
					end	
				end
			end 
		end else begin
			r <= 8'b11111111;
			g <= 8'b11111111;
			b <= 8'b11111111;
		end
	end 
	
endmodule 