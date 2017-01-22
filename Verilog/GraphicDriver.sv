module GraphicDriver(CLOCK_50, reset, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, VGA_SYNC_N, VGA_BLANK_N, VGA_CLK, KEY, enable, getAttack, blood1, blood2, magic, life, command);
	input CLOCK_50, reset, getAttack;
	input [3:0] KEY;
	input [11:0] enable;
	input [9:0] blood1, blood2, magic;
	input [2:0] life;
	output VGA_HS, VGA_VS;
	output VGA_CLK;
	output reg  VGA_BLANK_N;
	output reg VGA_SYNC_N;
	output reg [7:0] VGA_R, VGA_G, VGA_B;
	output reg [5:0] command;
	
	//assign VGA_CLK = CLOCK_50;
	wire [31:0] clk;
	wire [9:0] x;
	wire [8:0] y;
	wire [7:0] r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4, r5, g5, b5, r6, g6, b6, r7, g7, b7, r8, g8, b8, 
					r9, g9, b9, r10, g10, b10, r11, g11, b11, r12, g12, b12, r13, g13, b13, r14, g14, b14, r15, g15, b15,
					r16, g16, b16, r17, g17, b17, r18, g18, b18, r19, g19, b19, r20, g20, b20;
	reg [7:0] r, g, b;
	wire pressed1, pressed2, pressed3;
	wire [9:0] point_x;
	wire [8:0] point_y;
	wire [7:0] offset;
	
	
	clock_divider cdiv (CLOCK_50, clk);
	video_driver vd(CLOCK_50, reset, x, y, r, g, b, VGA_R, VGA_G, VGA_B, VGA_BLANK_N, VGA_CLK, VGA_HS, VGA_SYNC_N, VGA_VS);
	
	user_input u1 (pressed1, clk[0], KEY[2]);
	user_input u2 (pressed2, clk[0], KEY[3]);
	user_input u3 (pressed3, clk[0], KEY[0]);
	
	
	// player 1
	pikachu p1(clk[0], reset, x, y, r1, g1, b1, 60 + offset, 275 - offset, enable[0]);
	mushroom m1(clk[0], reset, x, y, r3, g3, b3, 60 + offset, 275 - offset, enable[1]);
	kirby k1(clk[0], reset, x, y, r5, g5, b5, 60 + offset, 275 - offset, enable[2]);
	squirtle s1(clk[0], reset, x, y, r7, g7, b7, 60 + offset, 275 - offset, enable[3]);
	hulk h1(clk[0], reset, x, y, r9, g9, b9, 60 + offset, 275 - offset, enable[4]);
	ironman i1(clk[0], reset, x, y, r11, g11, b11, 60 + offset, 275 - offset, enable[5]);
	
	
	// player 2
	pikachu p2(clk[0], reset, x, y, r2, g2, b2, 380, 75, enable[6]);
	mushroom m2(clk[0], reset, x, y, r4, g4, b4, 380, 75, enable[7]);
	kirby k2(clk[0], reset, x, y, r6, g6, b6, 380, 75, enable[8]);
	squirtle s2(clk[0], reset, x, y, r8, g8, b8, 380, 75, enable[9]);
	hulk h2(clk[0], reset, x, y, r10, g10, b10, 380, 75, enable[10]);
	ironman i2(clk[0], reset, x, y, r12, g12, b12, 380, 75, enable[11]);
	
	//assign magic = 10'b0001111000;
	
	mp mp(clk[0], reset, x, y, r13, g13, b13, 60, 244, magic);
	blood_bar bb1(clk[0], reset, x, y, r14, g14, b14, 380, 30, blood1);
	blood_bar bb2(clk[0], reset, x, y, r15, g15, b15, 60, 230, blood2);
	
	
	
	Menu m(clk[0], reset, x, y, r16, g16, b16, 350, 300);
	pointer_locat pl(clk[0], reset, pressed2, pressed1, point_x, point_y, ~KEY[0], command);
	pointer p(clk[0], reset, x, y, r17, g17, b17, 350 + point_x, 300 + point_y);
	pokeball pb1(clk[0], reset, x, y, r18, g18, b18, 362, 317, life[0]);
	pokeball pb2(clk[0], reset, x, y, r19, g19, b19, 386, 317, life[1]);
	pokeball pb3(clk[0], reset, x, y, r20, g20, b20, 410, 317, life[2]);
	
	
	// flash screen if get attacked
	always @(*) 
		if(getAttack) 
			r = 8'b11111111;
		else begin
			if(r1 > r2 & r3 > r2 & r4 > r2 & r5 > r2 & r6 > r2 & r7 > r2 & r8 > r2 & r9 > r2 & r10 > r2 & r11 > r2 & r12 > r2 & r13 > r2 & r14 > r2 & r15 > r2 & r16 > r2 & r17 > r2 & r18 > r2 & r19 > r2 & r20 > r2) 
				r = r2;
			else if(r2 > r1 & r3 > r1 & r4 > r1 & r5 > r1 & r6 > r1 & r7 > r1 & r8 > r1 & r9 > r1 & r10 > r1 & r11 > r1 & r12 > r1 & r13 > r1 & r14 > r1 & r15 > r1 & r16 > r1 & r17 > r1 & r18 > r1 & r19 > r1 & r20 > r1)
				r = r1;
			else if(r1 > r3 & r2 > r3 & r4 > r3 & r5 > r3 & r6 > r3 & r7 > r3 & r8 > r3 & r9 > r3 & r10 > r3 & r11 > r3 & r12 > r3 & r13 > r3 & r14 > r3 & r15 > r3 & r16 > r3 & r17 > r3 & r18 > r3 & r19 > r3 & r20 > r3)
				r = r3;
			else if(r1 > r4 & r2 > r4 & r3 > r4 & r5 > r4 & r6 > r4 & r7 > r4 & r8 > r4 & r9 > r4 & r10 > r4 & r11 > r4 & r12 > r4 & r13 > r4 & r14 > r4 & r15 > r4 & r16 > r4 & r17 > r4 & r18 > r4 & r19 > r4 & r20 > r4)
				r = r4;
			else if(r1 > r5 & r2 > r5 & r3 > r5 & r4 > r5 & r6 > r5 & r7 > r5 & r8 > r5 & r9 > r5 & r10 > r5 & r11 > r5 & r12 > r5 & r13 > r5 & r14 > r5 & r15 > r5 & r16 > r5 & r17 > r5 & r18 > r5 & r19 > r5 & r20 > r5)
				r = r5;
			else if(r1 > r6 & r2 > r6 & r3 > r6 & r4 > r6 & r5 > r6 & r7 > r6 & r8 > r6 & r9 > r6 & r10 > r6 & r11 > r6 & r12 > r6 & r13 > r6 & r14 > r6 & r15 > r6 & r16 > r6 & r17 > r6 & r18 > r6 & r19 > r6 & r20 > r6)
				r = r6;
			else if(r1 > r7 & r2 > r7 & r3 > r7 & r4 > r7 & r5 > r7 & r6 > r7 & r8 > r7 & r9 > r7 & r10 > r7 & r11 > r7 & r12 > r7 & r13 > r7 & r14 > r7 & r15 > r7 & r16 > r7 & r17 > r7 & r18 > r7 & r19 > r7 & r20 > r7)
				r = r7;
			else if(r1 > r8 & r2 > r8 & r3 > r8 & r4 > r8 & r5 > r8 & r6 > r8 & r7 > r8 & r9 > r8 & r10 > r8 & r11 > r8 & r12 > r8 & r13 > r8 & r14 > r8 & r15 > r8 & r16 > r8 & r17 > r8 & r18 > r8 & r19 > r8 & r20 > r8)
				r = r8;
			else if(r1 > r9 & r2 > r9 & r3 > r9 & r4 > r9 & r5 > r9 & r6 > r9 & r7 > r9 & r8 > r9 & r10 > r9 & r11 > r9 & r12 > r9 & r13 > r9 & r14 > r9 & r15 > r9 & r16 > r9 & r17 > r9 & r18 > r9 & r19 > r9 & r20 > r9)
				r = r9;
			else if(r1 > r10 & r2 > r10 & r3 > r10 & r4 > r10 & r5 > r10 & r6 > r10 & r7 > r10 & r8 > r10 & r9 > r10 & r11 > r10 & r12 > r10 & r13 > r10 & r14 > r10 & r15 > r10 & r16 > r10 & r17 > r10 & r18 > r10 & r19 > r10 & r20 > r10)
				r = r10;
			else if(r1 > r11 & r2 > r11 & r3 > r11 & r4 > r11 & r5 > r11 & r6 > r11 & r7 > r11 & r8 > r11 & r9 > r11 & r10 > r11 & r12 > r11 & r13 > r11 & r14 > r11 & r15 > r11 & r16 > r11 & r17 > r11 & r18 > r11 & r19 > r11 & r20 > r11)
				r = r11;
			else if(r1 > r12 & r2 > r12 & r3 > r12 & r4 > r12 & r5 > r12 & r6 > r12 & r7 > r12 & r8 > r12 & r9 > r12 & r10 > r12 & r11 > r12 & r13 > r12 & r14 > r12 & r15 > r12 & r16 > r12 & r17 > r12 & r18 > r12 & r19 > r12 & r20 > r12)
				r = r12;
			else if(r1 > r13 & r2 > r13 & r3 > r13 & r4 > r13 & r5 > r13 & r6 > r13 & r7 > r13 & r8 > r13 & r9 > r13 & r10 > r13 & r11 > r13 & r12 > r13 & r14 > r13 & r15 > r13 & r16 > r13 & r17 > r13 & r18 > r13 & r19 > r13 & r20 > r13)
				r = r13;
			else if(r1 > r14 & r2 > r14 & r3 > r14 & r4 > r14 & r5 > r14 & r6 > r14 & r7 > r14 & r8 > r14 & r9 > r14 & r10 > r14 & r11 > r14 & r12 > r14 & r13 > r14 & r15 > r14 & r16 > r14 & r17 > r14 & r18 > r14 & r19 > r14 & r20 > r14)
				r = r14;
			else if(r1 > r15 & r2 > r15 & r3 > r15 & r4 > r15 & r5 > r15 & r6 > r15 & r7 > r15 & r8 > r15 & r9 > r15 & r10 > r15 & r11 > r15 & r12 > r15 & r13 > r15 & r14 > r15 & r16 > r15 & r17 > r15 & r18 > r15 & r19 > r15 & r20 > r15)
				r = r15;
			else if(r1 > r16 & r2 > r16 & r3 > r16 & r4 > r16 & r5 > r16 & r6 > r16 & r7 > r16 & r8 > r16 & r9 > r16 & r10 > r16 & r11 > r16 & r12 > r16 & r13 > r16 & r14 > r16 & r15 > r16 & r17 > r16 & r18 > r16 & r19 > r16 & r20 > r16)
				r = r16;
			else if(r1 > r17 & r2 > r17 & r3 > r17 & r4 > r17 & r5 > r17 & r6 > r17 & r7 > r17 & r8 > r17 & r9 > r17 & r10 > r17 & r11 > r17 & r12 > r17 & r13 > r17 & r14 > r17 & r15 > r17 & r16 > r17 & r18 > r17 & r19 > r17 & r20 > r17)
				r = r17;
			else if(r1 > r18 & r2 > r18 & r3 > r18 & r4 > r18 & r5 > r18 & r6 > r18 & r7 > r18 & r8 > r18 & r9 > r18 & r10 > r18 & r11 > r18 & r12 > r18 & r13 > r18 & r14 > r18 & r15 > r18 & r16 > r18 & r17 > r18 & r19 > r18 & r20 > r18)
				r = r18;
			else if(r1 > r19 & r2 > r19 & r3 > r19 & r4 > r19 & r5 > r19 & r6 > r19 & r7 > r19 & r8 > r19 & r9 > r19 & r10 > r19 & r11 > r19 & r12 > r19 & r13 > r19 & r14 > r19 & r15 > r19 & r16 > r19 & r17 > r19 & r18 > r19 & r20 > r19)
				r = r19;
			else 
				r = r20;
		end



	always @(*) 
		if(getAttack) 
			g = 8'b00001111;
		else begin
			if(g1 > g2 & g3 > g2 & g4 > g2 & g5 > g2 & g6 > g2 & g7 > g2 & g8 > g2 & g9 > g2 & g10 > g2 & g11 > g2 & g12 > g2 & g13 > g2 & g14 > g2 & g15 > g2 & g16 > g2 & g17 > g2 & g18 > g2 & g19 > g2 & g20 > g2) 
				g = g2;
			else if(g2 > g1 & g3 > g1 & g4 > g1 & g5 > g1 & g6 > g1 & g7 > g1 & g8 > g1 & g9 > g1 & g10 > g1 & g11 > g1 & g12 > g1 & g13 > g1 & g14 > g1 & g15 > g1 & g16 > g1 & g17 > g1 & g18 > g1 & g19 > g1 & g20 > g1)
				g = g1;
			else if(g1 > g3 & g2 > g3 & g4 > g3 & g5 > g3 & g6 > g3 & g7 > g3 & g8 > g3 & g9 > g3 & g10 > g3 & g11 > g3 & g12 > g3 & g13 > g3 & g14 > g3 & g15 > g3 & g16 > g3 & g17 > g3 & g18 > g3 & g19 > g3 & g20 > g3)
				g = g3;
			else if(g1 > g4 & g2 > g4 & g3 > g4 & g5 > g4 & g6 > g4 & g7 > g4 & g8 > g4 & g9 > g4 & g10 > g4 & g11 > g4 & g12 > g4 & g13 > g4 & g14 > g4 & g15 > g4 & g16 > g4 & g17 > g4 & g18 > g4 & g19 > g4 & g20 > g4)
				g = g4;
			else if(g1 > g5 & g2 > g5 & g3 > g5 & g4 > g5 & g6 > g5 & g7 > g5 & g8 > g5 & g9 > g5 & g10 > g5 & g11 > g5 & g12 > g5 & g13 > g5 & g14 > g5 & g15 > g5 & g16 > g5 & g17 > g5 & g18 > g5 & g19 > g5 & g20 > g5)
				g = g5;
			else if(g1 > g6 & g2 > g6 & g3 > g6 & g4 > g6 & g5 > g6 & g7 > g6 & g8 > g6 & g9 > g6 & g10 > g6 & g11 > g6 & g12 > g6 & g13 > g6 & g14 > g6 & g15 > g6 & g16 > g6 & g17 > g6 & g18 > g6 & g19 > g6 & g20 > g6)
				g = g6;
			else if(g1 > g7 & g2 > g7 & g3 > g7 & g4 > g7 & g5 > g7 & g6 > g7 & g8 > g7 & g9 > g7 & g10 > g7 & g11 > g7 & g12 > g7 & g13 > g7 & g14 > g7 & g15 > g7 & g16 > g7 & g17 > g7 & g18 > g7 & g19 > g7 & g20 > g7)
				g = g7;
			else if(g1 > g8 & g2 > g8 & g3 > g8 & g4 > g8 & g5 > g8 & g6 > g8 & g7 > g8 & g9 > g8 & g10 > g8 & g11 > g8 & g12 > g8 & g13 > g8 & g14 > g8 & g15 > g8 & g16 > g8 & g17 > g8 & g18 > g8 & g19 > g8 & g20 > g8)
				g = g8;
			else if(g1 > g9 & g2 > g9 & g3 > g9 & g4 > g9 & g5 > g9 & g6 > g9 & g7 > g9 & g8 > g9 & g10 > g9 & g11 > g9 & g12 > g9 & g13 > g9 & g14 > g9 & g15 > g9 & g16 > g9 & g17 > g9 & g18 > g9 & g19 > g9 & g20 > g9)
				g = g9;
			else if(g1 > g10 & g2 > g10 & g3 > g10 & g4 > g10 & g5 > g10 & g6 > g10 & g7 > g10 & g8 > g10 & g9 > g10 & g11 > g10 & g12 > g10 & g13 > g10 & g14 > g10 & g15 > g10 & g16 > g10 & g17 > g10 & g18 > g10 & g19 > g10 & g20 > g10)
				g = g10;
			else if(g1 > g11 & g2 > g11 & g3 > g11 & g4 > g11 & g5 > g11 & g6 > g11 & g7 > g11 & g8 > g11 & g9 > g11 & g10 > g11 & g12 > g11 & g13 > g11 & g14 > g11 & g15 > g11 & g16 > g11 & g17 > g11 & g18 > g11 & g19 > g11 & g20 > g11)
				g = g11;
			else if(g1 > g12 & g2 > g12 & g3 > g12 & g4 > g12 & g5 > g12 & g6 > g12 & g7 > g12 & g8 > g12 & g9 > g12 & g10 > g12 & g11 > g12 & g13 > g12 & g14 > g12 & g15 > g12 & g16 > g12 & g17 > g12 & g18 > g12 & g19 > g12 & g20 > g12)
				g = g12;
			else if(g1 > g13 & g2 > g13 & g3 > g13 & g4 > g13 & g5 > g13 & g6 > g13 & g7 > g13 & g8 > g13 & g9 > g13 & g10 > g13 & g11 > g13 & g12 > g13 & g14 > g13 & g15 > g13 & g16 > g13 & g17 > g13 & g18 > g13 & g19 > g13 & g20 > g13)
				g = g13;
			else if(g1 > g14 & g2 > g14 & g3 > g14 & g4 > g14 & g5 > g14 & g6 > g14 & g7 > g14 & g8 > g14 & g9 > g14 & g10 > g14 & g11 > g14 & g12 > g14 & g13 > g14 & g15 > g14 & g16 > g14 & g17 > g14 & g18 > g14 & g19 > g14 & g20 > g14)
				g = g14;
			else if(g1 > g15 & g2 > g15 & g3 > g15 & g4 > g15 & g5 > g15 & g6 > g15 & g7 > g15 & g8 > g15 & g9 > g15 & g10 > g15 & g11 > g15 & g12 > g15 & g13 > g15 & g14 > g15 & g16 > g15 & g17 > g15 & g18 > g15 & g19 > g15 & g20 > g15)
				g = g15;
			else if(g1 > g16 & g2 > g16 & g3 > g16 & g4 > g16 & g5 > g16 & g6 > g16 & g7 > g16 & g8 > g16 & g9 > g16 & g10 > g16 & g11 > g16 & g12 > g16 & g13 > g16 & g14 > g16 & g15 > g16 & g17 > g16 & g18 > g16 & g19 > g16 & g20 > g16)
				g = g16;
			else if(g1 > g17 & g2 > g17 & g3 > g17 & g4 > g17 & g5 > g17 & g6 > g17 & g7 > g17 & g8 > g17 & g9 > g17 & g10 > g17 & g11 > g17 & g12 > g17 & g13 > g17 & g14 > g17 & g15 > g17 & g16 > g17 & g18 > g17 & g19 > g17 & g20 > g17)
				g = g17;
			else if(g1 > g18 & g2 > g18 & g3 > g18 & g4 > g18 & g5 > g18 & g6 > g18 & g7 > g18 & g8 > g18 & g9 > g18 & g10 > g18 & g11 > g18 & g12 > g18 & g13 > g18 & g14 > g18 & g15 > g18 & g16 > g18 & g17 > g18 & g19 > g18 & g20 > g18)
				g = g18;
			else if(g1 > g19 & g2 > g19 & g3 > g19 & g4 > g19 & g5 > g19 & g6 > g19 & g7 > g19 & g8 > g19 & g9 > g19 & g10 > g19 & g11 > g19 & g12 > g19 & g13 > g19 & g14 > g19 & g15 > g19 & g16 > g19 & g17 > g19 & g18 > g19 & g20 > g19)
				g = g19;
			else 
				g = g20;
		end

			
	always @(*) 
		if(getAttack) 
			b = 8'b00001111;
		else begin
			if(b1 > b2 & b3 > b2 & b4 > b2 & b5 > b2 & b6 > b2 & b7 > b2 & b8 > b2 & b9 > b2 & b10 > b2 & b11 > b2 & b12 > b2 & b13 > b2 & b14 > b2 & b15 > b2 & b16 > b2 & b17 > b2 & b18 > b2 & b19 > b2 & b20 > b2) 
				b = b2;
			else if(b2 > b1 & b3 > b1 & b4 > b1 & b5 > b1 & b6 > b1 & b7 > b1 & b8 > b1 & b9 > b1 & b10 > b1 & b11 > b1 & b12 > b1 & b13 > b1 & b14 > b1 & b15 > b1 & b16 > b1 & b17 > b1 & b18 > b1 & b19 > b1 & b20 > b1)
				b = b1;
			else if(b1 > b3 & b2 > b3 & b4 > b3 & b5 > b3 & b6 > b3 & b7 > b3 & b8 > b3 & b9 > b3 & b10 > b3 & b11 > b3 & b12 > b3 & b13 > b3 & b14 > b3 & b15 > b3 & b16 > b3 & b17 > b3 & b18 > b3 & b19 > b3 & b20 > b3)
				b = b3;
			else if(b1 > b4 & b2 > b4 & b3 > b4 & b5 > b4 & b6 > b4 & b7 > b4 & b8 > b4 & b9 > b4 & b10 > b4 & b11 > b4 & b12 > b4 & b13 > b4 & b14 > b4 & b15 > b4 & b16 > b4 & b17 > b4 & b18 > b4 & b19 > b4 & b20 > b4)
				b = b4;
			else if(b1 > b5 & b2 > b5 & b3 > b5 & b4 > b5 & b6 > b5 & b7 > b5 & b8 > b5 & b9 > b5 & b10 > b5 & b11 > b5 & b12 > b5 & b13 > b5 & b14 > b5 & b15 > b5 & b16 > b5 & b17 > b5 & b18 > b5 & b19 > b5 & b20 > b5)
				b = b5;
			else if(b1 > b6 & b2 > b6 & b3 > b6 & b4 > b6 & b5 > b6 & b7 > b6 & b8 > b6 & b9 > b6 & b10 > b6 & b11 > b6 & b12 > b6 & b13 > b6 & b14 > b6 & b15 > b6 & b16 > b6 & b17 > b6 & b18 > b6 & b19 > b6 & b20 > b6)
				b = b6;
			else if(b1 > b7 & b2 > b7 & b3 > b7 & b4 > b7 & b5 > b7 & b6 > b7 & b8 > b7 & b9 > b7 & b10 > b7 & b11 > b7 & b12 > b7 & b13 > b7 & b14 > b7 & b15 > b7 & b16 > b7 & b17 > b7 & b18 > b7 & b19 > b7 & b20 > b7)
				b = b7;
			else if(b1 > b8 & b2 > b8 & b3 > b8 & b4 > b8 & b5 > b8 & b6 > b8 & b7 > b8 & b9 > b8 & b10 > b8 & b11 > b8 & b12 > b8 & b13 > b8 & b14 > b8 & b15 > b8 & b16 > b8 & b17 > b8 & b18 > b8 & b19 > b8 & b20 > b8)
				b = b8;
			else if(b1 > b9 & b2 > b9 & b3 > b9 & b4 > b9 & b5 > b9 & b6 > b9 & b7 > b9 & b8 > b9 & b10 > b9 & b11 > b9 & b12 > b9 & b13 > b9 & b14 > b9 & b15 > b9 & b16 > b9 & b17 > b9 & b18 > b9 & b19 > b9 & b20 > b9)
				b = b9;
			else if(b1 > b10 & b2 > b10 & b3 > b10 & b4 > b10 & b5 > b10 & b6 > b10 & b7 > b10 & b8 > b10 & b9 > b10 & b11 > b10 & b12 > b10 & b13 > b10 & b14 > b10 & b15 > b10 & b16 > b10 & b17 > b10 & b18 > b10 & b19 > b10 & b20 > b10)
				b = b10;
			else if(b1 > b11 & b2 > b11 & b3 > b11 & b4 > b11 & b5 > b11 & b6 > b11 & b7 > b11 & b8 > b11 & b9 > b11 & b10 > b11 & b12 > b11 & b13 > b11 & b14 > b11 & b15 > b11 & b16 > b11 & b17 > b11 & b18 > b11 & b19 > b11 & b20 > b11)
				b = b11;
			else if(b1 > b12 & b2 > b12 & b3 > b12 & b4 > b12 & b5 > b12 & b6 > b12 & b7 > b12 & b8 > b12 & b9 > b12 & b10 > b12 & b11 > b12 & b13 > b12 & b14 > b12 & b15 > b12 & b16 > b12 & b17 > b12 & b18 > b12 & b19 > b12 & b20 > b12)
				b = b12;
			else if(b1 > b13 & b2 > b13 & b3 > b13 & b4 > b13 & b5 > b13 & b6 > b13 & b7 > b13 & b8 > b13 & b9 > b13 & b10 > b13 & b11 > b13 & b12 > b13 & b14 > b13 & b15 > b13 & b16 > b13 & b17 > b13 & b18 > b13 & b19 > b13 & b20 > b13)
				b = b13;
			else if(b1 > b14 & b2 > b14 & b3 > b14 & b4 > b14 & b5 > b14 & b6 > b14 & b7 > b14 & b8 > b14 & b9 > b14 & b10 > b14 & b11 > b14 & b12 > b14 & b13 > b14 & b15 > b14 & b16 > b14 & b17 > b14 & b18 > b14 & b19 > b14 & b20 > b14)
				b = b14;
			else if(b1 > b15 & b2 > b15 & b3 > b15 & b4 > b15 & b5 > b15 & b6 > b15 & b7 > b15 & b8 > b15 & b9 > b15 & b10 > b15 & b11 > b15 & b12 > b15 & b13 > b15 & b14 > b15 & b16 > b15 & b17 > b15 & b18 > b15 & b19 > b15 & b20 > b15)
				b = b15;
			else if(b1 > b16 & b2 > b16 & b3 > b16 & b4 > b16 & b5 > b16 & b6 > b16 & b7 > b16 & b8 > b16 & b9 > b16 & b10 > b16 & b11 > b16 & b12 > b16 & b13 > b16 & b14 > b16 & b15 > b16 & b17 > b16 & b18 > b16 & b19 > b16 & b20 > b16)
				b = b16;
			else if(b1 > b17 & b2 > b17 & b3 > b17 & b4 > b17 & b5 > b17 & b6 > b17 & b7 > b17 & b8 > b17 & b9 > b17 & b10 > b17 & b11 > b17 & b12 > b17 & b13 > b17 & b14 > b17 & b15 > b17 & b16 > b17 & b18 > b17 & b19 > b17 & b20 > b17)
				b = b17;
			else if(b1 > b18 & b2 > b18 & b3 > b18 & b4 > b18 & b5 > b18 & b6 > b18 & b7 > b18 & b8 > b18 & b9 > b18 & b10 > b18 & b11 > b18 & b12 > b18 & b13 > b18 & b14 > b18 & b15 > b18 & b16 > b18 & b17 > b18 & b19 > b18 & b20 > b18)
				b = b18;
			else if(b1 > b19 & b2 > b19 & b3 > b19 & b4 > b19 & b5 > b19 & b6 > b19 & b7 > b19 & b8 > b19 & b9 > b19 & b10 > b19 & b11 > b19 & b12 > b19 & b13 > b19 & b14 > b19 & b15 > b19 & b16 > b19 & b17 > b19 & b18 > b19 & b20 > b19)
				b = b19;
			else 
				b = b20;
		end



	
//	always @(posedge clk[0]) begin
//		if((x > 10'b0001111000 & x < 10'b1000001000) & (y > 9'b000101000 & y < 9'b110111000)) begin
//			if(y > 9'b000101000 & y < 9'b011011100) begin 
//				r <= 8'b11110000;
//				g <= 8'b00001111;
//				b <= 8'b00001111;
//			end else if(y >= 9'b011011100 & y < 9'b011100110) begin
//					if(x < 10'b0100101100 | x > 10'b0101010100) begin
//						r <= 8'b11110000;
//						g <= 8'b00001111;
//						b <= 8'b00001111;
//					end else begin
//						r <= 8'b00001111;
//						g <= 8'b00001111;
//						b <= 8'b00001111;
//					end 
//			end else if(y >= 9'b011100110 & y < 9'b011111010) begin 
//					if(x < 10'b0100110110 | x > 10'b0101001010) begin
//						r <= 8'b00001111;
//						g <= 8'b00001111;
//						b <= 8'b00001111;
//					end else begin
//						r <= 8'b11110000; //white
//						g <= 8'b11110000;
//						b <= 8'b11110000;
//					end
//			end else if(y >= 9'b011111010 & y < 9'b100000100) begin
//					if(x < 10'b0100101100 | x > 10'b0101010100) begin
//						r <= 8'b11110000; //white
//						g <= 8'b11110000;
//						b <= 8'b11110000;
//					end else begin
//						r <= 8'b00001111;
//						g <= 8'b00001111;
//						b <= 8'b00001111;
//					end 
//			end else begin
//					r <= 8'b11110000; //white
//					g <= 8'b11110000;
//					b <= 8'b11110000;
//			end
//		end else begin
//				r <= 8'b11111111; //white
//				g <= 8'b11111111;
//				b <= 8'b11111111;
//		end
//	end
		
	
	
	
endmodule


// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz, [25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
input clock;
output [31:0] divided_clocks;
reg [31:0] divided_clocks;
initial
divided_clocks = 0;
always @(posedge clock)
divided_clocks = divided_clocks + 1;
endmodule