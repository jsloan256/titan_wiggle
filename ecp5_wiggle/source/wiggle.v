module wiggle (clk, rstn, led, gpio);

input clk, rstn;
output [7:0] led;
output [23:0] gpio;

reg [23:0] count;
reg [7:0] sreg;
reg shift;
wire rstn;
wire [7:0] led;
wire [23:0] gpio;

assign rst = ~rstn;

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
		sreg <= 8'b1111_1110;
	end else if (shift == 1) begin
		sreg <= sreg << 1;
		sreg[0] <= sreg[7];
//	end else begin
//		sreg <= sreg;
	end
end

assign led = sreg;
assign gpio = count;



claritycores _inst (
	// Physcial Pins
	.refclk_inst_refclkn(),
	.refclk_inst_refclkp(),
	.pcie_end_hdinn0(), 
	.pcie_end_hdinp0(),
	.pcie_end_hdoutn0(),
	.pcie_end_hdoutp0(), 
	.pcie_end_rst_n(),
	.pcie_end_sys_clk_125(), 

	// Transmit TLP Interface
	.pcie_end_tx_data_vc0(),
	.pcie_end_tx_req_vc0(), 
	.pcie_end_tx_rdy_vc0(),
	.pcie_end_tx_st_vc0(),
	.pcie_end_tx_end_vc0(),
	.pcie_end_tx_nlfy_vc0(),
	.pcie_end_tx_ca_ph_vc0(),
	.pcie_end_tx_ca_nph_vc0(),
	.pcie_end_tx_ca_cplh_vc0(), 
	.pcie_end_tx_ca_pd_vc0(), 
	.pcie_end_tx_ca_npd_vc0(),
	.pcie_end_tx_ca_cpld_vc0(),
	.pcie_end_tx_ca_p_recheck_vc0(), 
	.pcie_end_tx_ca_cpl_recheck_vc0(),

	// Receive TLP Interface
	.pcie_end_rx_data_vc0(),
	.pcie_end_rx_st_vc0(),
	.pcie_end_rx_end_vc0(),
	.pcie_end_rx_us_req_vc0(),
	.pcie_end_rx_malf_tlp_vc0(), 
	.pcie_end_rx_bar_hit(),
	.pcie_end_ur_np_ext(), 
	.pcie_end_ur_p_ext());
	.pcie_end_ph_buf_status_vc0(),
	.pcie_end_pd_buf_status_vc0(),
	.pcie_end_nph_buf_status_vc0(),
	.pcie_end_npd_buf_status_vc0(),
	.pcie_end_ph_processed_vc0(), 
	.pcie_end_nph_processed_vc0(), 
	.pcie_end_pd_processed_vc0(), 
	.pcie_end_npd_processed_vc0(), 
	.pcie_end_pd_num_vc0(),
	.pcie_end_npd_num_vc0(), 

	// Control and Status
	.pcie_end_no_pcie_train(), 
	.pcie_end_force_lsm_active(), 
	.pcie_end_force_rec_ei(),
	.pcie_end_force_phy_status(),
	.pcie_end_force_disable_scr(),
	.pcie_end_hl_snd_beacon(), 
	.pcie_end_hl_disable_scr(),
	.pcie_end_hl_gto_dis(),
	.pcie_end_hl_gto_det(), 
	.pcie_end_hl_gto_hrst(),
	.pcie_end_hl_gto_l0stx(), 
	.pcie_end_hl_gto_l0stxfts(),
	.pcie_end_hl_gto_l1(),
	.pcie_end_hl_gto_l2(), 
	.pcie_end_hl_gto_lbk(),
	.pcie_end_hl_gto_rcvry(),
	.pcie_end_hl_gto_cfg(),
	.pcie_end_phy_ltssm_state(),
	.pcie_end_phy_pol_compliance(),
	.pcie_end_tx_lbk_rdy(), 
	.pcie_end_tx_lbk_kcntl(),
	.pcie_end_tx_lbk_data(),
	.pcie_end_rx_lbk_kcntl(),
	.pcie_end_rx_lbk_data(), 

	.pcie_end_bus_num(),
	.pcie_end_cmd_reg_out(),
	.pcie_end_dev_cntl_out(), 
	.pcie_end_dev_num(),
	.pcie_end_func_num(),
	.pcie_end_lnk_cntl_out(), 
	.pcie_end_mm_enable(),
	.pcie_end_msi(),
	.pcie_end_pm_power_state(), 
	.pcie_end_rxdp_dllp_val(),
	.pcie_end_rxdp_pmd_type(), 
	.pcie_end_rxdp_vsd_data(),
	.pcie_end_tx_dllp_val(), 
	.pcie_end_tx_pmtype(), 
	.pcie_end_tx_vsd_data(),
	.pcie_end_cmpln_tout(),
	.pcie_end_cmpltr_abort_np(), 
	.pcie_end_cmpltr_abort_p(),
	.pcie_end_dl_active(),
	.pcie_end_dl_inactive(), 
	.pcie_end_dl_init(),
	.pcie_end_dl_up(),
	.pcie_end_flip_lanes(), 
	.pcie_end_inta_n(),
	.pcie_end_msi_enable(),
	.pcie_end_np_req_pend(),
	.pcie_end_pme_en(),
	.pcie_end_pme_status(), 
	.pcie_end_tx_dllp_sent(),
	.pcie_end_unexp_cmpln(),



endmodule
