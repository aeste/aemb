
module aeMB2_uram(/*AUTOARG*/
   // Outputs
   mwb_dat_i, iwb_dat_i, mwb_ack_i, iwb_ack_i,
   // Inputs
   sys_clk_i, mwb_wre_o, mwb_dat_o, mwb_adr_o, iwb_wre_o, iwb_stb_o,
   iwb_adr_o, mwb_stb_o, mwb_sel_o, iwb_sel_o, sys_rst_i, iwb_cyc_o,
   iwb_tag_o, mwb_cyc_o, mwb_tag_o
   );
   parameter AW = 14;   
   
   /*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   output [31:0]	iwb_dat_i;		// From ram0 of aeMB2_dpsram.v, ...
   output [31:0]	mwb_dat_i;		// From ram0 of aeMB2_dpsram.v, ...
   // End of automatics
   output 		mwb_ack_i;
   output 		iwb_ack_i;
   
   /*AUTOINPUT*/
   // Beginning of automatic inputs (from unused autoinst inputs)
   input [AW-1:2]	iwb_adr_o;		// To ram0 of aeMB2_dpsram.v, ...
   input		iwb_stb_o;		// To ram0 of aeMB2_dpsram.v, ...
   input		iwb_wre_o;		// To ram0 of aeMB2_dpsram.v, ...
   input [AW-1:2]	mwb_adr_o;		// To ram0 of aeMB2_dpsram.v, ...
   input [31:0]		mwb_dat_o;		// To ram0 of aeMB2_dpsram.v, ...
   input		mwb_wre_o;		// To ram0 of aeMB2_dpsram.v, ...
   input		sys_clk_i;		// To ram0 of aeMB2_dpsram.v, ...
   // End of automatics

   input 		mwb_stb_o;   
   input [3:0] 		mwb_sel_o,
			iwb_sel_o;   

   input 		sys_rst_i;
   
   // tie-off unused signals
   input 		iwb_cyc_o,
			iwb_tag_o;   
   input 		mwb_cyc_o,
			mwb_tag_o;   

   /*AUTOWIRE*/
   /*AUTOREG*/
   // Beginning of automatic regs (for this module's undeclared outputs)
   reg			iwb_ack_i;
   reg			mwb_ack_i;
   // End of automatics
       
   always @(posedge sys_clk_i)
      if (sys_rst_i) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 iwb_ack_i <= 1'h0;
	 // End of automatics
      end else begin
	 iwb_ack_i <= iwb_stb_o & !iwb_ack_i;	 
      end
   
   always @(posedge sys_clk_i)
      if (sys_rst_i) begin
	 /*AUTORESET*/
	 // Beginning of autoreset for uninitialized flops
	 mwb_ack_i <= 1'h0;
	 // End of automatics
      end else begin
	 mwb_ack_i <= mwb_stb_o & !mwb_ack_i;	 
      end


   wire [3:0] dwb_sel = mwb_sel_o & {(4){mwb_stb_o}};   
   
   /* aeMB2_dpsram AUTO_TEMPLATE (
    .AW(AW-2),
    .DW(8),
    .dat_o(mwb_dat_i[@"(+ (* 8 @) 7)":@"(* 8 @)"]),
    .dat_i(mwb_dat_o[@"(+ (* 8 @) 7)":@"(* 8 @)"]),

    .adr_i(mwb_adr_o[AW-1:2]),
    .wre_i(mwb_wre_o),
    .ena_i(dwb_sel[@]),    

    .xdat_o(iwb_dat_i[@"(+ (* 8 @) 7)":@"(* 8 @)"]),
    .xdat_i(32'hX),
    .xadr_i(iwb_adr_o[AW-1:2]),
    .xwre_i(iwb_wre_o),
    .xena_i(iwb_stb_o),    
    
    .clk_i(sys_clk_i),
    .rst_i(sys_rst_i),
    ); */
   
   aeMB2_dpsram #(/*AUTOINSTPARAM*/
		  // Parameters
		  .AW			(AW-2),			 // Templated
		  .DW			(8))			 // Templated
   ram0 (/*AUTOINST*/
	 // Outputs
	 .dat_o				(mwb_dat_i[7:0]),	 // Templated
	 .xdat_o			(iwb_dat_i[7:0]),	 // Templated
	 // Inputs
	 .adr_i				(mwb_adr_o[AW-1:2]),	 // Templated
	 .dat_i				(mwb_dat_o[7:0]),	 // Templated
	 .wre_i				(mwb_wre_o),		 // Templated
	 .ena_i				(dwb_sel[0]),		 // Templated
	 .xadr_i			(iwb_adr_o[AW-1:2]),	 // Templated
	 .xdat_i			(32'hX),		 // Templated
	 .xwre_i			(iwb_wre_o),		 // Templated
	 .xena_i			(iwb_stb_o),		 // Templated
	 .clk_i				(sys_clk_i));		 // Templated

   aeMB2_dpsram #(/*AUTOINSTPARAM*/
		  // Parameters
		  .AW			(AW-2),			 // Templated
		  .DW			(8))			 // Templated
   ram1 (/*AUTOINST*/
	 // Outputs
	 .dat_o				(mwb_dat_i[15:8]),	 // Templated
	 .xdat_o			(iwb_dat_i[15:8]),	 // Templated
	 // Inputs
	 .adr_i				(mwb_adr_o[AW-1:2]),	 // Templated
	 .dat_i				(mwb_dat_o[15:8]),	 // Templated
	 .wre_i				(mwb_wre_o),		 // Templated
	 .ena_i				(dwb_sel[1]),		 // Templated
	 .xadr_i			(iwb_adr_o[AW-1:2]),	 // Templated
	 .xdat_i			(32'hX),		 // Templated
	 .xwre_i			(iwb_wre_o),		 // Templated
	 .xena_i			(iwb_stb_o),		 // Templated
	 .clk_i				(sys_clk_i));		 // Templated
   
   aeMB2_dpsram #(/*AUTOINSTPARAM*/
		  // Parameters
		  .AW			(AW-2),			 // Templated
		  .DW			(8))			 // Templated
   ram2 (/*AUTOINST*/
	 // Outputs
	 .dat_o				(mwb_dat_i[23:16]),	 // Templated
	 .xdat_o			(iwb_dat_i[23:16]),	 // Templated
	 // Inputs
	 .adr_i				(mwb_adr_o[AW-1:2]),	 // Templated
	 .dat_i				(mwb_dat_o[23:16]),	 // Templated
	 .wre_i				(mwb_wre_o),		 // Templated
	 .ena_i				(dwb_sel[2]),		 // Templated
	 .xadr_i			(iwb_adr_o[AW-1:2]),	 // Templated
	 .xdat_i			(32'hX),		 // Templated
	 .xwre_i			(iwb_wre_o),		 // Templated
	 .xena_i			(iwb_stb_o),		 // Templated
	 .clk_i				(sys_clk_i));		 // Templated
   
   aeMB2_dpsram #(/*AUTOINSTPARAM*/
		  // Parameters
		  .AW			(AW-2),			 // Templated
		  .DW			(8))			 // Templated
   ram3 (/*AUTOINST*/
	 // Outputs
	 .dat_o				(mwb_dat_i[31:24]),	 // Templated
	 .xdat_o			(iwb_dat_i[31:24]),	 // Templated
	 // Inputs
	 .adr_i				(mwb_adr_o[AW-1:2]),	 // Templated
	 .dat_i				(mwb_dat_o[31:24]),	 // Templated
	 .wre_i				(mwb_wre_o),		 // Templated
	 .ena_i				(dwb_sel[3]),		 // Templated
	 .xadr_i			(iwb_adr_o[AW-1:2]),	 // Templated
	 .xdat_i			(32'hX),		 // Templated
	 .xwre_i			(iwb_wre_o),		 // Templated
	 .xena_i			(iwb_stb_o),		 // Templated
	 .clk_i				(sys_clk_i));		 // Templated
   
   
endmodule // aeMB2_ram


