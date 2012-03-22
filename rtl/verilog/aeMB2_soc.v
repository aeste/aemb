
module aeMB2_ram(/*AUTOARG*/
   // Outputs
   mwb_dat_i, mwb_ack_i, iwb_dat_i, iwb_ack_i,
   // Inputs
   mwb_adr_o, mwb_dat_o, mwb_sel_o, mwb_stb_o, mwb_wre_o, mwb_cyc_o,
   mwb_tag_o, sys_rst_i, sys_clk_i, iwb_adr_o, iwb_sel_o, iwb_stb_o,
   iwb_wre_o, iwb_cyc_o, iwb_tag_o
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


   // Beginning of automatic outputs (from unused autoinst outputs)
   output [31:0]	iwb_dat_i;		// From rom0 of aeMB2_ram.v
   // End of automatics
   output 		iwb_ack_i;
   
   // Beginning of automatic inputs (from unused autoinst inputs)
   input [AW-1:2]	iwb_adr_o;		// To rom0 of aeMB2_ram.v
   input [3:0]		iwb_sel_o;		// To rom0 of aeMB2_ram.v
   input		iwb_stb_o;		// To rom0 of aeMB2_ram.v
   input		iwb_wre_o;		// To rom0 of aeMB2_ram.v
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

   /* aeMB2_dpsram AUTO_TEMPLATE (
    .AW(AW-2),
    .DW(32),
    .dat_o(mwb_dat_i),
    .dat_i(mwb_dat_o),
    .adr_i(mwb_adr_o),
    .wre_i(mwb_wre_o),
    .ena_i(mwb_stb_o),    

    .xdat_o(iwb_dat_i),
    .xdat_i(32'hX),
    .xadr_i(iwb_adr_o),
    .xwre_i(1'b0),
    .xena_i(iwb_stb_o),    
    
    .clk_i(sys_clk_i),
    .rst_i(sys_rst_i),
    ); */
   
   aeMB2_dpsram #(/*AUTOINSTPARAM*/
		  // Parameters
		  .AW			(AW-2),			 // Templated
		  .DW			(32))			 // Templated
   ram0 (/*AUTOINST*/
	 // Outputs
	 .dat_o				(mwb_dat_i),		 // Templated
	 .xdat_o			(iwb_dat_i),		 // Templated
	 // Inputs
	 .adr_i				(mwb_adr_o),		 // Templated
	 .dat_i				(mwb_dat_o),		 // Templated
	 .wre_i				(mwb_wre_o),		 // Templated
	 .ena_i				(mwb_stb_o),		 // Templated
	 .xadr_i			(iwb_adr_o),		 // Templated
	 .xdat_i			(32'hX),		 // Templated
	 .xwre_i			(1'b0),			 // Templated
	 .xena_i			(iwb_stb_o),		 // Templated
	 .clk_i				(sys_clk_i));		 // Templated
   
   
endmodule // aeMB2_ram




















			 

module aeMB2_arb(/*AUTOARG*/
   // Outputs
   mwb_adr_o, mwb_dat_o, mwb_sel_o, mwb_stb_o, mwb_wre_o, mwb_cyc_o,
   mwb_tag_o, dwb_dat_i, dwb_ack_i, xwb_dat_i, xwb_ack_i,
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

   wire [7:0] 		 gpio_dat;
   wire  		 gpio_ack;      

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
	    or dwb_sel_o or dwb_stb_o or dwb_tag_o or dwb_wre_o
	    or gpio_ack or gpio_dat or mwb_ack_i or mwb_dat_i or sel) begin
      
      dwb_ack_i <= (sel) ? gpio_ack : mwb_ack_i;
      dwb_dat_i <= (sel) ? gpio_dat : mwb_dat_i;    

      mwb_stb_o <= (sel) ? 1'b0 : dwb_stb_o;

      mwb_wre_o <= (sel) ? 1'b0 : dwb_wre_o;      
      
      mwb_adr_o <= dwb_adr_o;
      mwb_cyc_o <= dwb_cyc_o;
      mwb_dat_o <= dwb_dat_o;
      mwb_sel_o <= dwb_sel_o;
      mwb_tag_o <= dwb_tag_o;     
   end
   
   /* vpio_gpio AUTO_TEMPLATE (
    .IO(8),
    .gpio_io(gpio),
   
    .wb_ack_o(gpio_ack),
    .wb_dat_o(gpio_dat[7:0]),
     
    .wb_clk_i(sys_clk_i),
    .wb_rst_i(sys_rst_i),
    
    .wb_stb_i(dwb_adr_o[30]),
    
    .wb_wre_i(dwb_wre_o),
    .wb_sel_i(dwb_sel_o[0]),
    .wb_adr_i(dwb_adr_o[2]),
    .wb_dat_i(dwb_dat_o[7:0]),
    ); */
   
   vpio_gpio #(/*AUTOINSTPARAM*/
	       // Parameters
	       .IO			(8))			 // Templated
   gpio0 (/*AUTOINST*/
	  // Outputs
	  .wb_dat_o			(gpio_dat[7:0]),	 // Templated
	  .wb_ack_o			(gpio_ack),		 // Templated
	  // Inouts
	  .gpio_io			(gpio),			 // Templated
	  // Inputs
	  .wb_dat_i			(dwb_dat_o[7:0]),	 // Templated
	  .wb_adr_i			(dwb_adr_o[2]),		 // Templated
	  .wb_stb_i			(dwb_adr_o[30]),	 // Templated
	  .wb_sel_i			(dwb_sel_o[0]),		 // Templated
	  .wb_wre_i			(dwb_wre_o),		 // Templated
	  .wb_clk_i			(sys_clk_i),		 // Templated
	  .wb_rst_i			(sys_rst_i));		 // Templated
   
   
endmodule // aeMB2_arb			 







module aeMB2_soc(/*AUTOARG*/
   // Inouts
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
   wire			iwb_ack_i;		// From dram0 of aeMB2_ram.v
   wire [AEMB_IWB-1:2]	iwb_adr_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_cyc_o;		// From cpu0 of aeMB2_edk63.v
   wire [31:0]		iwb_dat_i;		// From dram0 of aeMB2_ram.v
   wire [3:0]		iwb_sel_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_stb_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_tag_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_wre_o;		// From cpu0 of aeMB2_edk63.v
   wire			mwb_ack_i;		// From dram0 of aeMB2_ram.v
   wire [AEMB_DWB-1:2]	mwb_adr_o;		// From arb0 of aeMB2_arb.v
   wire			mwb_cyc_o;		// From arb0 of aeMB2_arb.v
   wire [31:0]		mwb_dat_i;		// From dram0 of aeMB2_ram.v
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
   inout [7:0] 		gpio;
   
   
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
    .AW(14),
    .mwb_adr_o (mwb_adr_o[13:2]),
    .iwb_adr_o (iwb_adr_o[13:2]),
    ); */
   aeMB2_ram #(/*AUTOINSTPARAM*/
	       // Parameters
	       .AW			(14))			 // Templated
   dram0
     (/*AUTOINST*/
      // Outputs
      .mwb_dat_i			(mwb_dat_i[31:0]),
      .mwb_ack_i			(mwb_ack_i),
      .iwb_dat_i			(iwb_dat_i[31:0]),
      .iwb_ack_i			(iwb_ack_i),
      // Inputs
      .mwb_adr_o			(mwb_adr_o[13:2]),	 // Templated
      .mwb_dat_o			(mwb_dat_o[31:0]),
      .mwb_sel_o			(mwb_sel_o[3:0]),
      .mwb_stb_o			(mwb_stb_o),
      .mwb_wre_o			(mwb_wre_o),
      .mwb_cyc_o			(mwb_cyc_o),
      .mwb_tag_o			(mwb_tag_o),
      .sys_rst_i			(sys_rst_i),
      .sys_clk_i			(sys_clk_i),
      .iwb_adr_o			(iwb_adr_o[13:2]),	 // Templated
      .iwb_sel_o			(iwb_sel_o[3:0]),
      .iwb_stb_o			(iwb_stb_o),
      .iwb_wre_o			(iwb_wre_o),
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