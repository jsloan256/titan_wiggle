module wiggle (osc, gpio_a, gpio_b, perstn, refclkp, refclkn, hdinp0, hdinn0, hdoutp0, hdoutn0, ddr3_rstn, ddr3_ck0, ddr3_cke, ddr3_a, ddr3_ba, ddr3_d, ddr3_dm, ddr3_dqs0, ddr3_csn, ddr3_casn, ddr3_rasn, ddr3_wen, ddr3_odt);

input osc;
output [31:0] gpio_a;
output [31:0] gpio_b;
input perstn, refclkp, refclkn, hdinp0, hdinn0;
output hdoutp0, hdoutn0;

output ddr3_rstn;
output ddr3_ck0;
output ddr3_cke;
output [13:0] ddr3_a;
output [2:0] ddr3_ba;
inout [15:0] ddr3_d;
output [1:0] ddr3_dm;
inout [1:0] ddr3_dqs0;
output ddr3_csn;
output ddr3_casn; 
output ddr3_rasn;
output ddr3_wen;
output ddr3_odt;

wire clk;
wire clk125;
reg [23:0] count;
reg [31:0] sreg;
reg shift;
wire [31:0] gpio_a;
wire [31:0] gpio_b;

assign rst = ~perstn;
assign rstn = ~rst;
assign clk = clk125;

always @(posedge clk or posedge rst)
begin
	if (rst)
		count <= 0;
	else
		count <= count + 1;
end

always @(posedge clk or posedge rst)
begin
	if (rst)
		shift <= 0;
	else if (count == 3)
		shift <= 1;
	else
		shift <= 0;
end

always @(posedge clk or posedge rst)
begin
	if (rst) begin
		sreg <= 32'b1111_1111_1111_1111_1111_1111_1111_1110;
	end else if (shift == 1) begin
		sreg <= sreg << 1;
		sreg[0] <= sreg[31];
//	end else begin
//		sreg <= sreg;
	end
end

assign gpio_a = sreg;
assign gpio_b = sreg;



claritycores _inst (
	// PCIe interface
	// --------------------
	// Physcial Pins
	.refclk_refclkp(refclkp),
	.refclk_refclkn(refclkn),
	.pcie_x1_hdinp0(hdinp0),
	.pcie_x1_hdinn0(hdinn0), 
	.pcie_x1_hdoutp0(hdoutp0), 
	.pcie_x1_hdoutn0(hdoutn0),
	.pcie_x1_rst_n(perstn),
	.pcie_x1_sys_clk_125(clk125), 

	// Transmit TLP Interface
	.pcie_x1_tx_data_vc0(16'd0),
	.pcie_x1_tx_req_vc0(1'b0), 
	.pcie_x1_tx_rdy_vc0(),
	.pcie_x1_tx_st_vc0(1'b0),
	.pcie_x1_tx_end_vc0(1'b0),
	.pcie_x1_tx_nlfy_vc0(1'b0),
	.pcie_x1_tx_ca_ph_vc0(),
	.pcie_x1_tx_ca_nph_vc0(),
	.pcie_x1_tx_ca_cplh_vc0(), 
	.pcie_x1_tx_ca_pd_vc0(), 
	.pcie_x1_tx_ca_npd_vc0(),
	.pcie_x1_tx_ca_cpld_vc0(),
	.pcie_x1_tx_ca_p_recheck_vc0(), 
	.pcie_x1_tx_ca_cpl_recheck_vc0(),

	// Receive TLP Interface
	.pcie_x1_rx_data_vc0(),
	.pcie_x1_rx_st_vc0(),
	.pcie_x1_rx_end_vc0(),
	.pcie_x1_rx_us_req_vc0(),
	.pcie_x1_rx_malf_tlp_vc0(), 
	.pcie_x1_rx_bar_hit( ),
	.pcie_x1_ur_np_ext(1'b0), 
	.pcie_x1_ur_p_ext(1'b0),
	.pcie_x1_ph_buf_status_vc0(1'b0),
	.pcie_x1_pd_buf_status_vc0(1'b0),
	.pcie_x1_nph_buf_status_vc0(1'b0),
	.pcie_x1_npd_buf_status_vc0(1'b0),
	.pcie_x1_ph_processed_vc0(1'b0), 
	.pcie_x1_nph_processed_vc0(1'b0), 
	.pcie_x1_pd_processed_vc0(1'b0), 
	.pcie_x1_npd_processed_vc0(1'b0), 
	.pcie_x1_pd_num_vc0(1'b0),
	.pcie_x1_npd_num_vc0(1'b0), 

	// Control and Status
	.pcie_x1_no_pcie_train(1'b0), 
	.pcie_x1_force_lsm_active(1'b0), 
	.pcie_x1_force_rec_ei(1'b0),
	.pcie_x1_force_phy_status(1'b0),
	.pcie_x1_force_disable_scr(1'b0),
	.pcie_x1_hl_snd_beacon(1'b0), 
	.pcie_x1_hl_disable_scr(1'b0),
	.pcie_x1_hl_gto_dis(1'b0),
	.pcie_x1_hl_gto_det(1'b0), 
	.pcie_x1_hl_gto_hrst(1'b0),
	.pcie_x1_hl_gto_l0stx(1'b0), 
	.pcie_x1_hl_gto_l0stxfts(1'b0),
	.pcie_x1_hl_gto_l1(1'b0),
	.pcie_x1_hl_gto_l2(1'b0), 
	.pcie_x1_hl_gto_lbk(4'd0),
	.pcie_x1_hl_gto_rcvry(1'b0),
	.pcie_x1_hl_gto_cfg(1'b0),
	.pcie_x1_phy_ltssm_state(),
	.pcie_x1_phy_pol_compliance(),
	.pcie_x1_tx_lbk_rdy(), 
	.pcie_x1_tx_lbk_kcntl(2'd0),
	.pcie_x1_tx_lbk_data(16'd0),
	.pcie_x1_rx_lbk_kcntl(),
	.pcie_x1_rx_lbk_data(), 

	.pcie_x1_flip_lanes(1'b0), 

	// Data Link Layer
	.pcie_x1_dl_inactive( ), 
	.pcie_x1_dl_init( ),
	.pcie_x1_dl_active( ),
	.pcie_x1_dl_up(),
	.pcie_x1_tx_dllp_val(2'd0), 
	.pcie_x1_tx_pmtype(3'd0), 
	.pcie_x1_tx_vsd_data(24'd0),
	.pcie_x1_tx_dllp_sent(),
	.pcie_x1_rxdp_pmd_type(), 
	.pcie_x1_rxdp_vsd_data(),
	.pcie_x1_rxdp_dllp_val(),

	// Transaction Layer
	.pcie_x1_cmpln_tout(),
	.pcie_x1_cmpltr_abort_np(), 
	.pcie_x1_cmpltr_abort_p(1'd0),
	.pcie_x1_unexp_cmpln(1'd0),
	.pcie_x1_np_req_pend(1'd0),

	// Configuration Registers
	.pcie_x1_bus_num( ),
	.pcie_x1_dev_num( ),
	.pcie_x1_func_num( ),
	.pcie_x1_cmd_reg_out( ),
	.pcie_x1_dev_cntl_out( ), 
	.pcie_x1_lnk_cntl_out( ), 
	.pcie_x1_inta_n(1'b1),
	.pcie_x1_msi(8'd0),
	.pcie_x1_mm_enable( ),
	.pcie_x1_msi_enable( ),
	.pcie_x1_pme_status(1'b0), 
	.pcie_x1_pme_en(),
	.pcie_x1_pm_power_state( ),

	// DDR3 interface
	// --------------------
	// Physcial Pins
	.ddr3_x16_em_ddr_reset_n(ddr3_rstn),
	.ddr3_x16_em_ddr_clk(ddr3_ck0),
	.ddr3_x16_em_ddr_cke(ddr3_cke),
	.ddr3_x16_em_ddr_addr(ddr3_a),
	.ddr3_x16_em_ddr_ba(ddr3_ba), 
	.ddr3_x16_em_ddr_data(ddr3_d),
	.ddr3_x16_em_ddr_dm(ddr3_dm),
	.ddr3_x16_em_ddr_dqs(ddr3_dqs0), 
	.ddr3_x16_em_ddr_cs_n(ddr3_csn), 
	.ddr3_x16_em_ddr_cas_n(ddr3_casn), 
	.ddr3_x16_em_ddr_ras_n(ddr3_rasn),
	.ddr3_x16_em_ddr_we_n(ddr3_wen), 
	.ddr3_x16_em_ddr_odt(ddr3_odt),

	// Local user interface
	.ddr3_x16_clk_in(clk125),
	.ddr3_x16_sclk_out(),
	.ddr3_x16_clocking_good(),
	.ddr3_x16_rst_n(rstn), 
	.ddr3_x16_mem_rst_n(rstn), 
	.ddr3_x16_init_start(1'b0),
	.ddr3_x16_cmd(4'b0000),
	.ddr3_x16_cmd_valid(1'b0),
	.ddr3_x16_addr(26'd0),
	.ddr3_x16_cmd_burst_cnt(5'b00000), 
	.ddr3_x16_ofly_burst_len(1'b0),
	.ddr3_x16_write_data(64'd0), 
	.ddr3_x16_data_mask(8'd0),
	.ddr3_x16_init_done(),
	.ddr3_x16_cmd_rdy(), 
	.ddr3_x16_datain_rdy(),
	.ddr3_x16_read_data(),
	.ddr3_x16_read_data_valid(),
	.ddr3_x16_wl_err()
);

endmodule
