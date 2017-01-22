module pointer(clk, rst, x, y, r, g, b, x0, y0);
	input clk, rst;
	input [9:0] x, x0;
	input [8:0] y, y0;
	output reg [7:0] r, g, b;
	
	parameter scale = 2;
	//blood: 8*14 pixel
	
	always @(posedge clk) begin
		if(x <= x0 + 10'b0000001000 & x > x0 & y <= y0 + 9'b000001110 & y > y0) begin
			if(y > y0 & y <= y0 + scale) begin
				if((x > x0 & x <= x0 + scale)) begin
					r <= 8'b11111111;
					g <= 8'b10011001;
					b <= 8'b11001100;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + scale & y <= y0 + 2*scale) begin
				if((x > x0 & x <= x0 + 2*scale)) begin
					r <= 8'b11111111;
					g <= 8'b10011001;
					b <= 8'b11001100;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 2*scale & y <= y0 + 3*scale) begin
				if((x > x0 & x <= x0 + 3*scale)) begin
					r <= 8'b11111111;
					g <= 8'b10011001;
					b <= 8'b11001100;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 3*scale & y <= y0 + 4*scale) begin
				if((x > x0 & x <= x0 + 4*scale)) begin
					r <= 8'b11111111;
					g <= 8'b10011001;
					b <= 8'b11001100;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 4*scale & y <= y0 + 5*scale) begin
				if((x > x0 & x <= x0 + 3*scale)) begin
					r <= 8'b11111111;
					g <= 8'b10011001;
					b <= 8'b11001100;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 5*scale & y <= y0 + 6*scale) begin
				if((x > x0 & x <= x0 + 2*scale)) begin
					r <= 8'b11111111;
					g <= 8'b10011001;
					b <= 8'b11001100;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end	
			end else if(y > y0 + 6*scale & y <= y0 + 7*scale) begin
				if((x > x0 & x <= x0 + scale)) begin
					r <= 8'b11111111;
					g <= 8'b10011001;
					b <= 8'b11001100;
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