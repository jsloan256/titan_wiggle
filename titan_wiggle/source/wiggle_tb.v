`timescale 1 ns / 100ps

module wiggle_tb ();

reg osc;
wire [31:0] gpio_a;
wire [31:0] gpio_b;
reg perstn;
wire refclkp, refclkn, hdinp0, hdinn0;
wire hdoutp0, hdoutn0;

wire ddr3_rstn;
wire ddr3_ck0;
wire ddr3_cke;
wire [12:0] ddr3_a;
wire [2:0] ddr3_ba;
wire [15:0] ddr3_d;
wire [1:0] ddr3_dm;
wire [1:0] ddr3_dqs;
wire ddr3_csn;
wire ddr3_casn; 
wire ddr3_rasn;
wire ddr3_wen;
wire ddr3_odt;


// --------------------------------------------------------------------
// Power on Reset
// --------------------------------------------------------------------
PUR     PUR_INST(.PUR(1'b1));
GSR     GSR_INST(.GSR(1'b1));

wiggle U1 ( .osc(osc),
				.gpio_a(gpio_a),
				.gpio_b(gpio_b),
				.perstn(perstn),
				.refclkp(refclkp),
				.refclkn(refclkn),
				.hdinp0(hdinp0),
				.hdinn0(hdinn0),
				.hdoutp0(hdoutp0),
				.hdoutn0(hdoutn0),
				.ddr3_rstn(ddr3_rstn),
				.ddr3_ck0(ddr3_ck0),
				.ddr3_cke(ddr3_cke),
				.ddr3_a(ddr3_a),
				.ddr3_ba(ddr3_ba),
				.ddr3_d(ddr3_d),
				.ddr3_dm(ddr3_dm),
				.ddr3_dqs(ddr3_dqs),
				.ddr3_csn(ddr3_csn),
				.ddr3_casn(ddr3_casn),
				.ddr3_rasn(ddr3_rasn),
				.ddr3_wen(ddr3_wen),
				.ddr3_odt(ddr3_odt)
			);

ddr3 U11 ( .rst_n(ddr3_rstn),
				.ck(ddr3_ck0),
				.ck_n(~ddr3_ck0),
				.cke(ddr3_cke),
				.cs_n(ddr3_csn),
				.ras_n(ddr3_rasn),
				.cas_n(ddr3_casn),
				.we_n(ddr3_wen),
				.dm_tdqs(ddr3_dm),
				.ba(ddr3_ba),
				.addr(ddr3_a),
				.dq(ddr3_d),
				.dqs(ddr3_dqs),
				.dqs_n(),	// ~ddr3_dqs ???
				.tdqs_n(),
				.odt(ddr3_odt)		// ???
			);

always
	#10 osc = ~osc;

initial
begin
	$display($time, " << Starting the Simulation >>");
	osc = 1'b0;
	perstn = 1'b0;

	// Change to ~100ms
	#100
	$display($time, " << Releasing PERSTn >>");
	perstn = 1'b1;

	#10000000
	$display($time, " << Stopping the Simulation >>");
	$stop;
end

endmodule
