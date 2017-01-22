module pointer_locat(clk, rst, toLeft, toRight, x, y, enter, command);
	input clk, rst;
	input toLeft, toRight;
	output reg [9:0] x;
	output reg [8:0] y;
	input enter;
	output reg [5:0] command;
	
	parameter case_blood = 3'b000, case_magic = 3'b001, case_1 = 3'b010, case_2 = 3'b011,
					case_3 = 3'b100, case_4 = 3'b101;
	reg [3:0] ps, ns;
	
	always @ (*)
		case (ps)
			case_blood: if(toLeft & ~toRight & ~enter) begin
								ns = case_4;
								command = 6'b000000;
							end else if (toRight & ~toLeft & ~enter) begin 
								ns = case_magic;
								command = 6'b000000;
							end else if (~toRight & ~toLeft & enter) begin
								ns = case_blood;
								command = 6'b010000;
							end else begin
								ns = ps;
								command = 6'b000000;
							end
			case_magic: if(toLeft & ~toRight & ~enter) begin
								ns = case_blood;
								command = 6'b000000;
							end else if (toRight & ~toLeft & ~enter) begin 
								ns = case_1;
								command = 6'b000000;
							end else if (~toRight & ~toLeft & enter) begin
								ns = case_magic;
								command = 6'b100000;
							end else begin
								ns = ps;
								command = 6'b000000;
							end
			case_1: if(toLeft & ~toRight & ~enter) begin
							ns = case_magic;
							command = 6'b000000;
						end else if (toRight & ~toLeft & ~enter) begin 
							ns = case_2;
							command = 6'b000000;
						end else if (~toRight & ~toLeft & enter) begin
							ns = case_1;
							command = 6'b000001;
						end else begin
								ns = ps;
								command = 6'b000000;
						end
			case_2: if(toLeft & ~toRight & ~enter) begin
							ns = case_1;
							command = 6'b000000;
						end else if (toRight & ~toLeft & ~enter) begin 
							ns = case_3;
							command = 6'b000000;
						end else if (~toRight & ~toLeft & enter) begin
							ns = case_2;
							command = 6'b000010;
						end else begin
								ns = ps;
								command = 6'b000000;
						end
			case_3: if(toLeft & ~toRight & ~enter) begin
							ns = case_2;
							command = 6'b000000;
						end else if (toRight & ~toLeft & ~enter) begin 
							ns = case_4;
							command = 6'b000000;
						end else if (~toRight & ~toLeft & enter) begin
							ns = case_3;
							command = 6'b000100;
						end else begin
								ns = ps;
								command = 6'b000000;
						end
			case_4: if(toLeft & ~toRight & ~enter) begin
							ns = case_3;
							command = 6'b000000;
						end else if (toRight & ~toLeft & ~enter) begin 
							ns = case_blood;
							command = 6'b000000;
						end else if (~toRight & ~toLeft & enter) begin
							ns = case_4;
							command = 6'b001000;
						end else begin
								ns = ps;
								command = 6'b000000;
						end
			default begin
						command = 6'b000000;
					end
		endcase
		
	always @ (*)
		case (ps)
			case_blood: begin 
							x = 88;
							y = 22;
							end
			case_magic: begin 
							x = 128;
							y = 22;
							end
			case_1: begin 
							x = 8;
							y = 62;
							end				
			case_2: begin 
							x = 48;
							y = 62;
							end	
			case_3: begin 
							x = 88;
							y = 62;
							end
			case_4: begin 
							x = 128;
							y = 62;
							end
			default begin 
							x = 88;
							y = 22;
						
					end
		endcase
		
		always @(posedge clk)
			if (rst)
				ps <= case_blood;
			else 
				ps <= ns;
			
endmodule

	