module user_input(pressed, clk, button);
   output reg pressed;
	input clk, button;
	
   reg ps;
	reg ns;
	
	parameter off = 1'b0, on = 1'b1;
	always @(*)
	   case(ps)
		   off: if (button) ns = on;
			     else ns = off;
			on: if (button) ns = on;
			    else ns = off;
			default ns = off;
		endcase	

	always @(posedge clk) begin
	   pressed <= (~ps & button);
	   ps <= ns;
	end
endmodule
