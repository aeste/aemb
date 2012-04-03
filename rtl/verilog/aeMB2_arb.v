





			 

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

   //*AUTOOUTPUT*/
   // Beginning of automatic outputs (from unused autoinst outputs)
   //output		gpio_ack;		// From gpio0 of vpio_gpio.v
   //output [7:0]		gpio_dat;		// From gpio0 of vpio_gpio.v
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
   wire [7:0] 		gpio_dat;
   wire 		gpio_ack;      
   
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


// Local Variables:
// verilog-library-directories:("." "../../lib/vpio/" );
// End: