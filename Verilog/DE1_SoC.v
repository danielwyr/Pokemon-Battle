module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, VGA_SYNC_N, VGA_BLANK_N, VGA_CLK, SW, GPIO_0, GPIO_1); 
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output [9:0] LEDR;
	output [35:0] GPIO_0;
	output VGA_HS, VGA_VS;
	output VGA_CLK;
	output VGA_BLANK_N;
	output VGA_SYNC_N;
	output [7:0] VGA_R, VGA_G, VGA_B;
	input [35:0] GPIO_1;
	input [3:0] KEY;
	input [9:0] SW;
	input CLOCK_50;
	
	nios_system u0 (
	  .addr_export            (addr),            //            addr.export
	  .char_received_export   (char_received),   //   char_received.export
	  .char_sent_export       (char_sent),       //       char_sent.export
	  .clk_clk                (CLOCK_50),                //             clk.clk
	  .data_in_export         (data_in),         //         data_in.export
	  .data_out_export        (data_out),        //        data_out.export
	  .p_data_in_export       (P_data_in),       //       p_data_in.export
	  .p_data_out_export      (P_data_out),      //      p_data_out.export
	  .read_write_export      (read_write),      //      read_write.export
	  .reset_reset_n          (SW[9]),          //           reset.reset_n
	  .transmit_enable_export (transmit_enable), // transmit_enable.export
	  .load_export            (load),             //            load.export
	  .ledr_export            (LEDR[7:0]),
	  .userin_export			  (userin),
	  .enable1_export			  (enable[5:0]),
	  .currenthp_export       (blood1[7:0]),       //       currenthp.export
     .currentmp_export       (magic[7:0]),       //       currentmp.export
     .currentehp_export      (blood2[7:0]),      //      currentehp.export
     .life_export            (life),
	  .enable2_export         (enable[11:6]),
	  .getattack_export       (getAttack)
   );
 
	// Dummy bus
	wire [7:0] ledr;
	wire [5:0] userin;
	
	reg [31:0] divided_clocks;
	wire [7:0] data_in, data_out;
	wire [10:0] addr_in, addr, addr_out;
	wire read_write;
	parameter READ_VAL = 1'b0, WRITE_VAL = 1'b1;

	SRAM s0 (data_out, data_in, CLOCK_50, addr, read_write, 1'b1);
	 
	 
	wire S_data_out, char_sent, char_received;
	wire [7:0] P_data_out;
	wire clk, reset;
	wire transmit_enable, load, S_data_in;
	wire [7:0] P_data_in;

	com_mod cm (S_data_out, P_data_out, char_sent, char_received, SW[9], CLOCK_50, transmit_enable, P_data_in, load, S_data_in);
	
	
	
	wire [11:0] enable;
	wire getAttack;
	wire [9:0] blood1, blood2, magic;
	wire [2:0] life; // pokemon left (decode currentMon)
	
	GraphicDriver gd (CLOCK_50, ~SW[9], VGA_HS, VGA_VS, VGA_R, VGA_G, VGA_B, VGA_SYNC_N, VGA_BLANK_N, VGA_CLK, KEY[3:0], enable, getAttack, blood1, blood2, magic, life, userin);
	
	assign GPIO_0[35] = S_data_out;
	assign S_data_in = GPIO_1[0];
	assign LEDR[9] = S_data_out;
	//assign LEDR[7:0] = P_data_out;
endmodule
