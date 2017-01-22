module inputExtender (userinOut, clk, reset, userin, count);
	output [5:0] userinOut;
	input clk, reset;
	input [5:0] userin;
	input [7:0] count;
	
	parameter [7:0] EXTEND_RATE = 8'b11111111;
	
	reg [5:0] ps, ns;
	always@(*)
	if(6'b000000 != userin & 6'b000000 == ps & EXTEND_RATE != count) ns = userin;
	else if(6'b000000 != ps & EXTEND_RATE != count) ns = ps;
	else ns = 6'b000000;
	
	
	always@(posedge clk)
	if(reset) ps <= ns;
	else ps <= 6'b000000;
	
	assign userinOut = ps;
endmodule

module inputExtenderCounter(count, clk, reset, userin);
	output [7:0] count;
	input clk, reset;
	input [5:0] userin;
	
	parameter [7:0] EXTEND_RATE = 8'b11111111;
	
	reg [7:0] ps, ns;
	always@(*)
	if(6'b000000 != userin & 8'b00000000 == ps) ns = ps + 8'b00000001;
	else if(8'b00000000 != ps & EXTEND_RATE != ps) ns = ps + 8'b00000001;
	else ns = 8'b00000000;

	assign count = ps;
endmodule
