
module aeMB2_ram(/*AUTOARG*/
   // Outputs
   mwb_dat_i, mwb_ack_i,
   // Inputs
   mwb_adr_o, mwb_dat_o, mwb_sel_o, mwb_stb_o, mwb_wre_o, mwb_cyc_o,
   mwb_tag_o, sys_rst_i, sys_clk_i
   );
   parameter AW = 14;   
   
   output [31:0] mwb_dat_i;
   output 	 mwb_ack_i;
   
   input [AW-1:2] mwb_adr_o;   
   input [31:0]  mwb_dat_o;
   input [3:0] 	 mwb_sel_o;   
   input 	 mwb_stb_o,
		 mwb_wre_o;

   input 	 mwb_cyc_o,
		 mwb_tag_o;   
   
   input 	 sys_rst_i,
		 sys_clk_i;   

   reg 		 mwb_ack_i;
   
   always @(posedge sys_clk_i)
      if (sys_rst_i) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 mwb_ack_i <= 1'h0;
	 // End of automatics
      end else begin
	 mwb_ack_i <= mwb_stb_o & !mwb_ack_i;	 
      end
   
   aeMB2_spsram #(AW-2, 8)
   b0 (
       // Outputs
       .dat_o				(mwb_dat_i[7:0]),
       // Inputs
       .adr_i				(mwb_adr_o[AW-1:2]),
       .dat_i				(mwb_dat_o[7:0]),
       .wre_i				(mwb_wre_o),
       .ena_i				(mwb_stb_o & mwb_sel_o[0]),
       .rst_i				(sys_rst_i),
       .clk_i				(sys_clk_i));   
   
   aeMB2_spsram #(AW-2, 8)
   b1 (
       // Outputs
       .dat_o				(mwb_dat_i[15:8]),
       // Inputs
       .dat_i				(mwb_dat_o[15:8]),
       .adr_i				(mwb_adr_o[AW-1:2]),
       .wre_i				(mwb_wre_o),
       .ena_i				(mwb_stb_o & mwb_sel_o[1]),
       .rst_i				(sys_rst_i),
       .clk_i				(sys_clk_i));   

   aeMB2_spsram #(AW-2, 8)
   b2 (
       // Outputs
       .dat_o				(mwb_dat_i[23:16]),
       // Inputs
       .dat_i				(mwb_dat_o[23:16]),
       .adr_i				(mwb_adr_o[AW-1:2]),
       .wre_i				(mwb_wre_o),
       .ena_i				(mwb_stb_o & mwb_sel_o[2]),
       .rst_i				(sys_rst_i),
       .clk_i				(sys_clk_i));   

   aeMB2_spsram #(AW-2, 8)
   b3 (
       // Outputs
       .dat_o				(mwb_dat_i[31:24]),
       // Inputs
       .dat_i				(mwb_dat_o[31:24]),
       .adr_i				(mwb_adr_o[AW-1:2]),
       .wre_i				(mwb_wre_o),
       .ena_i				(mwb_stb_o & mwb_sel_o[3]),
       .rst_i				(sys_rst_i),
       .clk_i				(sys_clk_i));   
   
endmodule // aeMB2_ram







		       
module aeMB2_rom(/*AUTOARG*/
   // Outputs
   iwb_dat_i, iwb_ack_i,
   // Inputs
   iwb_adr_o, iwb_sel_o, iwb_stb_o, iwb_wre_o, sys_clk_i, sys_rst_i,
   iwb_cyc_o, iwb_tag_o
   );
   parameter AW = 14;   

   // Beginning of automatic outputs (from unused autoinst outputs)
   output [31:0]	iwb_dat_i;		// From rom0 of aeMB2_ram.v
   // End of automatics
   output 		iwb_ack_i;
   
   // Beginning of automatic inputs (from unused autoinst inputs)
   input [AW-1:2]	iwb_adr_o;		// To rom0 of aeMB2_ram.v
   input [3:0]		iwb_sel_o;		// To rom0 of aeMB2_ram.v
   input		iwb_stb_o;		// To rom0 of aeMB2_ram.v
   input		iwb_wre_o;		// To rom0 of aeMB2_ram.v
   input		sys_clk_i;		// To rom0 of aeMB2_ram.v
   input		sys_rst_i;		// To rom0 of aeMB2_ram.v
   // End of automatics

   input 		iwb_cyc_o,
			iwb_tag_o;
   
   // End of automatics
   reg 			iwb_ack_i;

   always @(posedge sys_clk_i)
      if (sys_rst_i) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 iwb_ack_i <= 1'h0;
	 // End of automatics
      end else begin
	 iwb_ack_i <= iwb_stb_o & !iwb_ack_i;	 
      end
   
   aeMB2_ram #(/*AUTOINSTPARAM*/
	       // Parameters
	       .AW			(13))			 // Templated
   rom0 (
	 // Outputs
	 .mwb_dat_i			(iwb_dat_i[31:0]),
	 // Inputs
	 .mwb_adr_o			(iwb_adr_o[AW-1:2]),
	 .mwb_sel_o			(iwb_sel_o[3:0]),
	 .mwb_stb_o			(iwb_stb_o),
	 .mwb_wre_o			(1'b0),
	 .sys_rst_i			(sys_rst_i),
	 .sys_clk_i			(sys_clk_i));   
   
endmodule // aeMB2_rom














			 

module aeMB2_arb(/*AUTOARG*/
   // Outputs
   gpio_dat, gpio_ack, mwb_adr_o, mwb_dat_o, mwb_sel_o, mwb_stb_o,
   mwb_wre_o, mwb_cyc_o, mwb_tag_o, dwb_dat_i, dwb_ack_i, xwb_dat_i,
   xwb_ack_i,
   // Inouts
   gpio,
   // Inputs
   mwb_dat_i, mwb_ack_i, dwb_dat_o, dwb_adr_o, dwb_sel_o, dwb_stb_o,
   dwb_wre_o, dwb_cyc_o, dwb_tag_o, xwb_dat_o, xwb_adr_o, xwb_sel_o,
   xwb_stb_o, xwb_wre_o, xwb_cyc_o, xwb_tag_o, sys_clk_i, sys_rst_i
   );
   parameter AEMB_DWB = 13;   
   parameter AEMB_XWB = 5;   

   // MWB - RAM interface
   output [AEMB_DWB-1:2] mwb_adr_o;
   output [31:0] 	 mwb_dat_o;
   output [3:0] 	 mwb_sel_o;
   output 		 mwb_stb_o,
			 mwb_wre_o,
			 mwb_cyc_o,
			 mwb_tag_o;
   input [31:0] 	 mwb_dat_i;
   input 		 mwb_ack_i;
   
   // DWB - CPU interface
   output [31:0] 	 dwb_dat_i;
   output 		 dwb_ack_i;
   input [31:0] 	 dwb_dat_o;
   input [AEMB_DWB-1:2]  dwb_adr_o;
   input [3:0] 		 dwb_sel_o;
   input 		 dwb_stb_o,
			 dwb_wre_o,
			 dwb_cyc_o,
			 dwb_tag_o;
   
   // XWB - destroyed
   output [31:0] 	 xwb_dat_i;
   output 		 xwb_ack_i;
   input [31:0] 	 xwb_dat_o;
   input [AEMB_XWB-1:2]  xwb_adr_o;
   input [3:0] 		 xwb_sel_o;
   input 		 xwb_stb_o,
			 xwb_wre_o,
 			 xwb_cyc_o,
			 xwb_tag_o;
   
   input 		 sys_clk_i,
			 sys_rst_i;

   inout [7:0] 		 gpio;
   
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output		gpio_ack;		// From gpio0 of vpio_gpio.v
   output		gpio_dat;		// From gpio0 of vpio_gpio.v
   // End of automatics
   /*AUTOINPUT*/
   /*AUTOWIRE*/
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			dwb_ack_i;
   reg [31:0]		dwb_dat_i;
   reg [AEMB_DWB-1:2]	mwb_adr_o;
   reg			mwb_cyc_o;
   reg [31:0]		mwb_dat_o;
   reg [3:0]		mwb_sel_o;
   reg			mwb_stb_o;
   reg			mwb_tag_o;
   reg			mwb_wre_o;
   reg			xwb_ack_i;
   reg [31:0]		xwb_dat_i;
   // End of automatics
   
   // connect to I/O devices

   wire  		sel = dwb_adr_o[30];
   
   always @(/*AUTOSENSE*/dwb_adr_o or dwb_cyc_o or dwb_dat_o
	    or dwb_sel_o or dwb_stb_o or dwb_tag_o or gpio_ack
	    or gpio_dat or mwb_ack_i or mwb_dat_i or sel) begin
      
      dwb_ack_i <= (sel) ? gpio_ack : mwb_ack_i;
      dwb_dat_i <= (sel) ? gpio_dat : mwb_dat_i;    

      mwb_stb_o <= (sel) ? 1'b0 : dwb_stb_o;
      
      mwb_adr_o <= dwb_adr_o;
      mwb_cyc_o <= dwb_cyc_o;
      mwb_dat_o <= dwb_dat_o;
      mwb_sel_o <= dwb_sel_o;
      mwb_tag_o <= dwb_tag_o;     
   end
   
   /* vpio_gpio AUTO_TEMPLATE (
    .gpio_io(gpio),
   
    .wb_ack_o(gpio_ack),
    .wb_dat_o(gpio_dat),
     
    .wb_clk_i(sys_clk_i),
    .wb_rst_i(sys_rst_i),
    
    .wb_stb_i(dwb_adr_o[30]),
    
    .wb_wre_i(dwb_wre_o),
    .wb_sel_i(dwb_sel_o),
    .wb_adr_i(dwb_adr_o[2]),
    .wb_dat_i(dwb_dat_o),
    ); */
   
   vpio_gpio #(8)
   gpio0 (/*AUTOINST*/
	  // Outputs
	  .wb_dat_o			(gpio_dat),		 // Templated
	  .wb_ack_o			(gpio_ack),		 // Templated
	  // Inouts
	  .gpio_io			(gpio),			 // Templated
	  // Inputs
	  .wb_dat_i			(dwb_dat_o),		 // Templated
	  .wb_adr_i			(dwb_adr_o[2]),		 // Templated
	  .wb_stb_i			(dwb_adr_o[30]),	 // Templated
	  .wb_sel_i			(dwb_sel_o),		 // Templated
	  .wb_wre_i			(dwb_wre_o),		 // Templated
	  .wb_clk_i			(sys_clk_i),		 // Templated
	  .wb_rst_i			(sys_rst_i));		 // Templated
   
   
endmodule // aeMB2_arb			 







module aeMB2_soc(/*AUTOARG*/
   // Outputs
   gpio,
   // Inputs
   sys_rst_i, sys_int_i, sys_ena_i, sys_clk_i
   );

   parameter AEMB_DWB = 32;
   parameter AEMB_IWB = 32;
   parameter AEMB_XWB = 4;

   parameter AEMB_BSF = 1;
   parameter AEMB_MUL = 1;
   parameter AEMB_DIV = 0;
   parameter AEMB_FPU = 0;

   parameter AEMB_ICH = 11;
   parameter AEMB_IDX = 6;   

   
   /*AUTOOUTPUT*/
   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input		sys_clk_i;		// To arb0 of aeMB2_arb.v, ...
   input		sys_ena_i;		// To cpu0 of aeMB2_edk63.v
   input		sys_int_i;		// To cpu0 of aeMB2_edk63.v
   input		sys_rst_i;		// To arb0 of aeMB2_arb.v, ...
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire			dwb_ack_i;		// From arb0 of aeMB2_arb.v
   wire [AEMB_DWB-1:2]	dwb_adr_o;		// From cpu0 of aeMB2_edk63.v
   wire			dwb_cyc_o;		// From cpu0 of aeMB2_edk63.v
   wire [31:0]		dwb_dat_i;		// From arb0 of aeMB2_arb.v
   wire [31:0]		dwb_dat_o;		// From cpu0 of aeMB2_edk63.v
   wire [3:0]		dwb_sel_o;		// From cpu0 of aeMB2_edk63.v
   wire			dwb_stb_o;		// From cpu0 of aeMB2_edk63.v
   wire			dwb_tag_o;		// From cpu0 of aeMB2_edk63.v
   wire			dwb_wre_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_ack_i;		// From rom0 of aeMB2_rom.v
   wire [AEMB_IWB-1:2]	iwb_adr_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_cyc_o;		// From cpu0 of aeMB2_edk63.v
   wire [31:0]		iwb_dat_i;		// From rom0 of aeMB2_rom.v
   wire [3:0]		iwb_sel_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_stb_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_tag_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_wre_o;		// From cpu0 of aeMB2_edk63.v
   wire			mwb_ack_i;		// From ram0 of aeMB2_ram.v
   wire [AEMB_DWB-1:2]	mwb_adr_o;		// From arb0 of aeMB2_arb.v
   wire			mwb_cyc_o;		// From arb0 of aeMB2_arb.v
   wire [31:0]		mwb_dat_i;		// From ram0 of aeMB2_ram.v
   wire [31:0]		mwb_dat_o;		// From arb0 of aeMB2_arb.v
   wire [3:0]		mwb_sel_o;		// From arb0 of aeMB2_arb.v
   wire			mwb_stb_o;		// From arb0 of aeMB2_arb.v
   wire			mwb_tag_o;		// From arb0 of aeMB2_arb.v
   wire			mwb_wre_o;		// From arb0 of aeMB2_arb.v
   wire			xwb_ack_i;		// From arb0 of aeMB2_arb.v
   wire [AEMB_XWB-1:2]	xwb_adr_o;		// From cpu0 of aeMB2_edk63.v
   wire			xwb_cyc_o;		// From cpu0 of aeMB2_edk63.v
   wire [31:0]		xwb_dat_i;		// From arb0 of aeMB2_arb.v
   wire [31:0]		xwb_dat_o;		// From cpu0 of aeMB2_edk63.v
   wire [3:0]		xwb_sel_o;		// From cpu0 of aeMB2_edk63.v
   wire			xwb_stb_o;		// From cpu0 of aeMB2_edk63.v
   wire			xwb_tag_o;		// From cpu0 of aeMB2_edk63.v
   wire			xwb_wre_o;		// From cpu0 of aeMB2_edk63.v
   // End of automatics
   /*AUTOREG*/
   output [7:0] 	gpio;
   
   
   aeMB2_arb #(/*AUTOINSTPARAM*/
	       // Parameters
	       .AEMB_DWB		(AEMB_DWB),
	       .AEMB_XWB		(AEMB_XWB))
   arb0
     (/*AUTOINST*/
      // Outputs
      .mwb_adr_o			(mwb_adr_o[AEMB_DWB-1:2]),
      .mwb_dat_o			(mwb_dat_o[31:0]),
      .mwb_sel_o			(mwb_sel_o[3:0]),
      .mwb_stb_o			(mwb_stb_o),
      .mwb_wre_o			(mwb_wre_o),
      .mwb_cyc_o			(mwb_cyc_o),
      .mwb_tag_o			(mwb_tag_o),
      .dwb_dat_i			(dwb_dat_i[31:0]),
      .dwb_ack_i			(dwb_ack_i),
      .xwb_dat_i			(xwb_dat_i[31:0]),
      .xwb_ack_i			(xwb_ack_i),
      // Inouts
      .gpio				(gpio[7:0]),
      // Inputs
      .mwb_dat_i			(mwb_dat_i[31:0]),
      .mwb_ack_i			(mwb_ack_i),
      .dwb_dat_o			(dwb_dat_o[31:0]),
      .dwb_adr_o			(dwb_adr_o[AEMB_DWB-1:2]),
      .dwb_sel_o			(dwb_sel_o[3:0]),
      .dwb_stb_o			(dwb_stb_o),
      .dwb_wre_o			(dwb_wre_o),
      .dwb_cyc_o			(dwb_cyc_o),
      .dwb_tag_o			(dwb_tag_o),
      .xwb_dat_o			(xwb_dat_o[31:0]),
      .xwb_adr_o			(xwb_adr_o[AEMB_XWB-1:2]),
      .xwb_sel_o			(xwb_sel_o[3:0]),
      .xwb_stb_o			(xwb_stb_o),
      .xwb_wre_o			(xwb_wre_o),
      .xwb_cyc_o			(xwb_cyc_o),
      .xwb_tag_o			(xwb_tag_o),
      .sys_clk_i			(sys_clk_i),
      .sys_rst_i			(sys_rst_i));   


   /* aeMB2_ram AUTO_TEMPLATE    
    (
    .AW(13),
    .mwb_adr_o (mwb_adr_o[12:2]),
    ); */
   aeMB2_ram #(/*AUTOINSTPARAM*/
	       // Parameters
	       .AW			(13))			 // Templated
   ram0
     (/*AUTOINST*/
      // Outputs
      .mwb_dat_i			(mwb_dat_i[31:0]),
      .mwb_ack_i			(mwb_ack_i),
      // Inputs
      .mwb_adr_o			(mwb_adr_o[12:2]),	 // Templated
      .mwb_dat_o			(mwb_dat_o[31:0]),
      .mwb_sel_o			(mwb_sel_o[3:0]),
      .mwb_stb_o			(mwb_stb_o),
      .mwb_wre_o			(mwb_wre_o),
      .mwb_cyc_o			(mwb_cyc_o),
      .mwb_tag_o			(mwb_tag_o),
      .sys_rst_i			(sys_rst_i),
      .sys_clk_i			(sys_clk_i));
   
   /* aeMB2_rom AUTO_TEMPLATE
    (
    .AW(13),
    .iwb_adr_o (iwb_adr_o[12:2]),
    ); */
   aeMB2_rom #(/*AUTOINSTPARAM*/
	       // Parameters
	       .AW			(13))			 // Templated
   rom0
     (/*AUTOINST*/
      // Outputs
      .iwb_dat_i			(iwb_dat_i[31:0]),
      .iwb_ack_i			(iwb_ack_i),
      // Inputs
      .iwb_adr_o			(iwb_adr_o[12:2]),	 // Templated
      .iwb_sel_o			(iwb_sel_o[3:0]),
      .iwb_stb_o			(iwb_stb_o),
      .iwb_wre_o			(iwb_wre_o),
      .sys_clk_i			(sys_clk_i),
      .sys_rst_i			(sys_rst_i),
      .iwb_cyc_o			(iwb_cyc_o),
      .iwb_tag_o			(iwb_tag_o));
   
   
   aeMB2_edk63 #(/*AUTOINSTPARAM*/
		 // Parameters
		 .AEMB_IWB		(AEMB_IWB),
		 .AEMB_DWB		(AEMB_DWB),
		 .AEMB_XWB		(AEMB_XWB),
		 .AEMB_ICH		(AEMB_ICH),
		 .AEMB_IDX		(AEMB_IDX),
		 .AEMB_BSF		(AEMB_BSF),
		 .AEMB_MUL		(AEMB_MUL),
		 .AEMB_DIV		(AEMB_DIV),
		 .AEMB_FPU		(AEMB_FPU))
   cpu0 (/*AUTOINST*/
	 // Outputs
	 .dwb_adr_o			(dwb_adr_o[AEMB_DWB-1:2]),
	 .dwb_cyc_o			(dwb_cyc_o),
	 .dwb_dat_o			(dwb_dat_o[31:0]),
	 .dwb_sel_o			(dwb_sel_o[3:0]),
	 .dwb_stb_o			(dwb_stb_o),
	 .dwb_tag_o			(dwb_tag_o),
	 .dwb_wre_o			(dwb_wre_o),
	 .iwb_adr_o			(iwb_adr_o[AEMB_IWB-1:2]),
	 .iwb_cyc_o			(iwb_cyc_o),
	 .iwb_sel_o			(iwb_sel_o[3:0]),
	 .iwb_stb_o			(iwb_stb_o),
	 .iwb_tag_o			(iwb_tag_o),
	 .iwb_wre_o			(iwb_wre_o),
	 .xwb_adr_o			(xwb_adr_o[AEMB_XWB-1:2]),
	 .xwb_cyc_o			(xwb_cyc_o),
	 .xwb_dat_o			(xwb_dat_o[31:0]),
	 .xwb_sel_o			(xwb_sel_o[3:0]),
	 .xwb_stb_o			(xwb_stb_o),
	 .xwb_tag_o			(xwb_tag_o),
	 .xwb_wre_o			(xwb_wre_o),
	 // Inputs
	 .dwb_ack_i			(dwb_ack_i),
	 .dwb_dat_i			(dwb_dat_i[31:0]),
	 .iwb_ack_i			(iwb_ack_i),
	 .iwb_dat_i			(iwb_dat_i[31:0]),
	 .sys_clk_i			(sys_clk_i),
	 .sys_ena_i			(sys_ena_i),
	 .sys_int_i			(sys_int_i),
	 .sys_rst_i			(sys_rst_i),
	 .xwb_ack_i			(xwb_ack_i),
	 .xwb_dat_i			(xwb_dat_i[31:0]));
   
   
endmodule // aeMB2_soc

// Local Variables:
// verilog-library-directories:("." "../../lib/vpio/" );
// End: