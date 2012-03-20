
module aeMB2_ram(/*AUTOARG*/
   // Outputs
   dwb_dat_i, dwb_ack_i,
   // Inputs
   dwb_adr_o, dwb_dat_o, dwb_sel_o, dwb_stb_o, dwb_wre_o, dwb_cyc_o,
   dwb_tag_o, sys_rst_i, sys_clk_i
   );
   parameter AW = 14;   
   
   output [31:0] dwb_dat_i;
   output 	 dwb_ack_i;
   
   input [AW-1:2] dwb_adr_o;   
   input [31:0]  dwb_dat_o;
   input [3:0] 	 dwb_sel_o;   
   input 	 dwb_stb_o,
		 dwb_wre_o;

   input 	 dwb_cyc_o,
		 dwb_tag_o;   
   
   input 	 sys_rst_i,
		 sys_clk_i;   

   reg 		 dwb_ack_i;
   
   always @(posedge sys_clk_i)
      if (sys_rst_i) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 dwb_ack_i <= 1'h0;
	 // End of automatics
      end else begin
	 dwb_ack_i <= dwb_stb_o & !dwb_ack_i;	 
      end
   
   aeMB2_spsram #(AW-2, 8)
   b0 (
       // Outputs
       .dat_o				(dwb_dat_i[7:0]),
       // Inputs
       .adr_i				(dwb_adr_o[AW-1:2]),
       .dat_i				(dwb_dat_o[7:0]),
       .wre_i				(dwb_wre_o),
       .ena_i				(dwb_stb_o & dwb_sel_o[0]),
       .rst_i				(sys_rst_i),
       .clk_i				(sys_clk_i));   
   
   aeMB2_spsram #(AW-2, 8)
   b1 (
       // Outputs
       .dat_o				(dwb_dat_i[15:8]),
       // Inputs
       .dat_i				(dwb_dat_o[15:8]),
       .adr_i				(dwb_adr_o[AW-1:2]),
       .wre_i				(dwb_wre_o),
       .ena_i				(dwb_stb_o & dwb_sel_o[1]),
       .rst_i				(sys_rst_i),
       .clk_i				(sys_clk_i));   

   aeMB2_spsram #(AW-2, 8)
   b2 (
       // Outputs
       .dat_o				(dwb_dat_i[23:16]),
       // Inputs
       .dat_i				(dwb_dat_o[23:16]),
       .adr_i				(dwb_adr_o[AW-1:2]),
       .wre_i				(dwb_wre_o),
       .ena_i				(dwb_stb_o & dwb_sel_o[2]),
       .rst_i				(sys_rst_i),
       .clk_i				(sys_clk_i));   

   aeMB2_spsram #(AW-2, 8)
   b3 (
       // Outputs
       .dat_o				(dwb_dat_i[31:24]),
       // Inputs
       .dat_i				(dwb_dat_o[31:24]),
       .adr_i				(dwb_adr_o[AW-1:2]),
       .wre_i				(dwb_wre_o),
       .ena_i				(dwb_stb_o & dwb_sel_o[3]),
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
	       .AW			(AW))
   rom0 (
	 // Outputs
	 .dwb_dat_i			(iwb_dat_i[31:0]),
	 // Inputs
	 .dwb_adr_o			(iwb_adr_o[AW-1:2]),
	 .dwb_sel_o			(iwb_sel_o[3:0]),
	 .dwb_stb_o			(iwb_stb_o),
	 .dwb_wre_o			(1'b0),
	 .sys_rst_i			(sys_rst_i),
	 .sys_clk_i			(sys_clk_i));   
   
endmodule // aeMB2_rom
			 

module aeMB2_arb(/*AUTOARG*/
   // Outputs
   xwb_dat_i, xwb_ack_i,
   // Inputs
   xwb_dat_o, xwb_adr_o, xwb_sel_o, xwb_stb_o, xwb_wre_o, xwb_cyc_o,
   xwb_tag_o, sys_clk_i, sys_rst_i
   );

   parameter AEMB_XWB = 5;   
   
   output [31:0] xwb_dat_i;
   output 	 xwb_ack_i;
   input [31:0]  xwb_dat_o;
   input [AEMB_XWB-1:2] xwb_adr_o;
   input [3:0] 		xwb_sel_o;
   input 		xwb_stb_o,
			xwb_wre_o;
      
   input 		xwb_cyc_o,
			xwb_tag_o;
   input 		sys_clk_i,
			sys_rst_i;

   // connect to I/O devices
   
   
endmodule // aeMB2_arb			 

module aeMB2_soc(/*AUTOARG*/
   // Inputs
   sys_rst_i, sys_int_i, sys_ena_i, sys_clk_i
   );

   parameter AEMB_DWB = 13;
   parameter AEMB_IWB = 13;
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
   wire			dwb_ack_i;		// From ram0 of aeMB2_ram.v
   wire [AEMB_DWB-1:2]	dwb_adr_o;		// From cpu0 of aeMB2_edk63.v
   wire			dwb_cyc_o;		// From cpu0 of aeMB2_edk63.v
   wire [31:0]		dwb_dat_i;		// From ram0 of aeMB2_ram.v
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

   aeMB2_arb #(/*AUTOINSTPARAM*/
	       // Parameters
	       .AEMB_XWB		(AEMB_XWB))
   arb0
     (/*AUTOINST*/
      // Outputs
      .xwb_dat_i			(xwb_dat_i[31:0]),
      .xwb_ack_i			(xwb_ack_i),
      // Inputs
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
    .dwb_adr_o (dwb_adr_o[AEMB_DWB-1:2]),
    ); */
   aeMB2_ram #(
	       // Parameters
	       .AW			(AEMB_DWB))
   ram0
     (/*AUTOINST*/
      // Outputs
      .dwb_dat_i			(dwb_dat_i[31:0]),
      .dwb_ack_i			(dwb_ack_i),
      // Inputs
      .dwb_adr_o			(dwb_adr_o[AEMB_DWB-1:2]), // Templated
      .dwb_dat_o			(dwb_dat_o[31:0]),
      .dwb_sel_o			(dwb_sel_o[3:0]),
      .dwb_stb_o			(dwb_stb_o),
      .dwb_wre_o			(dwb_wre_o),
      .dwb_cyc_o			(dwb_cyc_o),
      .dwb_tag_o			(dwb_tag_o),
      .sys_rst_i			(sys_rst_i),
      .sys_clk_i			(sys_clk_i));
   
   /* aeMB2_rom AUTO_TEMPLATE
    (
    .iwb_adr_o (iwb_adr_o[AEMB_IWB-1:2]),
    ); */
   aeMB2_rom #(
	       // Parameters
	       .AW			(AEMB_IWB))
   rom0
     (/*AUTOINST*/
      // Outputs
      .iwb_dat_i			(iwb_dat_i[31:0]),
      .iwb_ack_i			(iwb_ack_i),
      // Inputs
      .iwb_adr_o			(iwb_adr_o[AEMB_IWB-1:2]), // Templated
      .iwb_sel_o			(iwb_sel_o[3:0]),
      .iwb_stb_o			(iwb_stb_o),
      .iwb_wre_o			(iwb_wre_o),
      .sys_clk_i			(sys_clk_i),
      .sys_rst_i			(sys_rst_i),
      .iwb_cyc_o			(iwb_cyc_o),
      .iwb_tag_o			(iwb_tag_o));
   
   
   aeMB2_edk63 #(
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
