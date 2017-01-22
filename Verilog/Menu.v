module Menu(clk, rst, x, y, r, g, b, x0, y0);
	input clk, rst;
	input [9:0] x, x0;
	input [8:0] y, y0;
	output reg [7:0] r, g, b;
	
	//parameter scale = 10;
	//2 pixel outer bound
	//blood: 179 * 99 pixel
	
	always @(posedge clk) begin
		if(x <= x0 + 10'b0011001000 & x > x0 & y <= y0 + 9'b011001000 & y > y0) begin
			if(y > y0 & y <= y0 + 2) begin
				if((x > x0 & x <= x0 + 179)) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b00000000;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 2 & y <= y0 + 17) begin
				if((x > x0 & x <= x0 + 2) | (x > x0 + 177 & x <= x0 + 179)) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b00000000;
				end else begin			
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 17 & y <= y0 + 42) begin
				if((x > x0 & x <= x0 + 2) | (x > x0 + 177 & x <= x0 + 179)) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b00000000;
				end else if((x > x0 + 97 & x <= x0 + 122)) begin
					r <= 8'b11111111;
					g <= 8'b00000000;
					b <= 8'b00000000;
				end else if (x > x0 + 137 & x <= x0 + 162) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b11111111;
				end else begin			
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 42 & y <= y0 + 57) begin
				if((x > x0 & x <= x0 + 2) | (x > x0 + 177 & x <= x0 + 179)) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b00000000;
				end else begin			
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 57 & y <= y0 + 82) begin
				if((x > x0 & x <= x0 + 2) | (x > x0 + 177 & x <= x0 + 179)) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b00000000;
				end else if((x > x0 + 17 & x <= x0 + 42)) begin
					r <= 8'b00101111;
					g <= 8'b00101111;
					b <= 8'b00101111;
				end else if((x > x0 + 57 & x <= x0 + 82)) begin
					r <= 8'b00011111;
					g <= 8'b00011111;
					b <= 8'b00011111;
				end else if((x > x0 + 97 & x <= x0 + 122)) begin
					r <= 8'b00010011;
					g <= 8'b00010011;
					b <= 8'b00010011;
				end else if((x > x0 + 137 & x <= x0 + 162)) begin
					r <= 8'b00001100;
					g <= 8'b00001100;
					b <= 8'b00001100;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 82 & y <= y0 + 97) begin
				if((x > x0 & x <= x0 + 2) | (x > x0 + 177 & x <= x0 + 179)) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b00000000;
				end else begin 
					r <= 8'b11111111;
					g <= 8'b11111111;
					b <= 8'b11111111;
				end
			end else if(y > y0 + 97 & y <= y0 + 99) begin
				if((x > x0 & x <= x0 + 179)) begin
					r <= 8'b00000000;
					g <= 8'b00000000;
					b <= 8'b00000000;
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