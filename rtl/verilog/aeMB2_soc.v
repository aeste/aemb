









module aeMB2_soc(/*AUTOARG*/
   // Outputs
   gpio_dat, gpio_ack,
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
   // Beginning of automatic outputs (from unused autoinst outputs)
   output		gpio_ack;		// From arb0 of aeMB2_arb.v
   output [7:0]		gpio_dat;		// From arb0 of aeMB2_arb.v
   // End of automatics
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
   wire			iwb_ack_i;		// From dram0 of aeMB2_uram.v
   wire [AEMB_IWB-1:2]	iwb_adr_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_cyc_o;		// From cpu0 of aeMB2_edk63.v
   wire [31:0]		iwb_dat_i;		// From dram0 of aeMB2_uram.v
   wire [3:0]		iwb_sel_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_stb_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_tag_o;		// From cpu0 of aeMB2_edk63.v
   wire			iwb_wre_o;		// From cpu0 of aeMB2_edk63.v
   wire			mwb_ack_i;		// From dram0 of aeMB2_uram.v
   wire [AEMB_DWB-1:2]	mwb_adr_o;		// From arb0 of aeMB2_arb.v
   wire			mwb_cyc_o;		// From arb0 of aeMB2_arb.v
   wire [31:0]		mwb_dat_i;		// From dram0 of aeMB2_uram.v
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
      .gpio_ack				(gpio_ack),
      .gpio_dat				(gpio_dat[7:0]),
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


   /* aeMB2_uram AUTO_TEMPLATE    
    (
    .AW(14),
    .mwb_adr_o (mwb_adr_o[13:2]),
    .iwb_adr_o (iwb_adr_o[13:2]),
    ); */
   
   aeMB2_uram #(/*AUTOINSTPARAM*/
		// Parameters
		.AW			(14))			 // Templated
   dram0
     (/*AUTOINST*/
      // Outputs
      .iwb_dat_i			(iwb_dat_i[31:0]),
      .mwb_dat_i			(mwb_dat_i[31:0]),
      .mwb_ack_i			(mwb_ack_i),
      .iwb_ack_i			(iwb_ack_i),
      // Inputs
      .iwb_adr_o			(iwb_adr_o[13:2]),	 // Templated
      .iwb_stb_o			(iwb_stb_o),
      .iwb_wre_o			(iwb_wre_o),
      .mwb_adr_o			(mwb_adr_o[13:2]),	 // Templated
      .mwb_dat_o			(mwb_dat_o[31:0]),
      .mwb_wre_o			(mwb_wre_o),
      .sys_clk_i			(sys_clk_i),
      .mwb_stb_o			(mwb_stb_o),
      .mwb_sel_o			(mwb_sel_o[3:0]),
      .iwb_sel_o			(iwb_sel_o[3:0]),
      .sys_rst_i			(sys_rst_i),
      .iwb_cyc_o			(iwb_cyc_o),
      .iwb_tag_o			(iwb_tag_o),
      .mwb_cyc_o			(mwb_cyc_o),
      .mwb_tag_o			(mwb_tag_o));
   

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
