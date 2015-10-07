module pcie_x1_bfm_tb (perstn, refclkp, refclkn, hdinp0, hdinn0, hdoutp0, hdoutn0);

input wire perstn, refclkp, refclkn, hdinp0, hdinn0;
output wire hdoutp0, hdoutn0;

pcie_x1 pcie_x1_inst (
	// PCIe interface
	// --------------------
	// Physcial Pins
	.pll_refclki(refclkp),
	.rxrefclk(refclkp),
	.hdinp0(hdinp0),
	.hdinn0(hdinn0),
	.hdoutp0(hdoutp0),
	.hdoutn0(hdoutn0), 
	.rst_n(perstn),
	.sys_clk_125(pcie_x1_sys_clk_125), 

	// Transmit TLP Interface
	.tx_data_vc0({pcie_x1_tx_data_vc0}), 
	.tx_req_vc0(pcie_x1_tx_req_vc0),
	.tx_rdy_vc0(pcie_x1_tx_rdy_vc0), 
	.tx_st_vc0(pcie_x1_tx_st_vc0),
	.tx_end_vc0(pcie_x1_tx_end_vc0), 
	.tx_nlfy_vc0(pcie_x1_tx_nlfy_vc0), 
	.tx_ca_ph_vc0({pcie_x1_tx_ca_ph_vc0}),
	.tx_ca_nph_vc0({pcie_x1_tx_ca_nph_vc0}),
	.tx_ca_cplh_vc0({pcie_x1_tx_ca_cplh_vc0}),
	.tx_ca_pd_vc0({pcie_x1_tx_ca_pd_vc0}), 
	.tx_ca_npd_vc0({pcie_x1_tx_ca_npd_vc0}), 
	.tx_ca_cpld_vc0({pcie_x1_tx_ca_cpld_vc0}), 
	.tx_ca_p_recheck_vc0(pcie_x1_tx_ca_p_recheck_vc0), 
	.tx_ca_cpl_recheck_vc0(pcie_x1_tx_ca_cpl_recheck_vc0),

	// Receive TLP Interface
	.rx_data_vc0({pcie_x1_rx_data_vc0}),
	.rx_st_vc0(pcie_x1_rx_st_vc0),
	.rx_end_vc0(pcie_x1_rx_end_vc0),
	.rx_us_req_vc0(pcie_x1_rx_us_req_vc0), 
	.rx_malf_tlp_vc0(pcie_x1_rx_malf_tlp_vc0), 
	.rx_bar_hit({pcie_x1_rx_bar_hit}), 
	.ur_np_ext(pcie_x1_ur_np_ext),
	.ur_p_ext(pcie_x1_ur_p_ext),
	.ph_buf_status_vc0(pcie_x1_ph_buf_status_vc0), 
	.pd_buf_status_vc0(pcie_x1_pd_buf_status_vc0), 
	.nph_buf_status_vc0(pcie_x1_nph_buf_status_vc0), 
	.npd_buf_status_vc0(pcie_x1_npd_buf_status_vc0), 
	.ph_processed_vc0(pcie_x1_ph_processed_vc0),
	.nph_processed_vc0(pcie_x1_nph_processed_vc0),
	.pd_processed_vc0(pcie_x1_pd_processed_vc0),
	.npd_processed_vc0(pcie_x1_npd_processed_vc0),
	.pd_num_vc0({pcie_x1_pd_num_vc0}),
	.npd_num_vc0({pcie_x1_npd_num_vc0}), 

	// Control and Status
	.no_pcie_train(pcie_x1_no_pcie_train), 
	.force_lsm_active(pcie_x1_force_lsm_active), 
	.force_rec_ei(pcie_x1_force_rec_ei), 
	.force_phy_status(pcie_x1_force_phy_status),
	.force_disable_scr(pcie_x1_force_disable_scr),
	.hl_snd_beacon(pcie_x1_hl_snd_beacon),
	.hl_disable_scr(pcie_x1_hl_disable_scr), 
	.hl_gto_dis(pcie_x1_hl_gto_dis),
	.hl_gto_det(pcie_x1_hl_gto_det), 
	.hl_gto_hrst(pcie_x1_hl_gto_hrst), 
	.hl_gto_l0stx(pcie_x1_hl_gto_l0stx),
	.hl_gto_l0stxfts(pcie_x1_hl_gto_l0stxfts), 
	.hl_gto_l1(pcie_x1_hl_gto_l1),
	.hl_gto_l2(pcie_x1_hl_gto_l2), 
	.hl_gto_lbk(pcie_x1_hl_gto_lbk),
	.hl_gto_rcvry(pcie_x1_hl_gto_rcvry), 
	.hl_gto_cfg(pcie_x1_hl_gto_cfg),
	.phy_ltssm_state({pcie_x1_phy_ltssm_state}), 
	.phy_pol_compliance(pcie_x1_phy_pol_compliance), 
	.tx_lbk_rdy(pcie_x1_tx_lbk_rdy),
	.tx_lbk_kcntl({pcie_x1_tx_lbk_kcntl}),
	.tx_lbk_data({pcie_x1_tx_lbk_data}), 
	.rx_lbk_kcntl({pcie_x1_rx_lbk_kcntl}),
	.rx_lbk_data({pcie_x1_rx_lbk_data}), 

	.flip_lanes(pcie_x1_flip_lanes), 

	// Data Link Layer
	.dl_inactive(pcie_x1_dl_inactive), 
	.dl_init(pcie_x1_dl_init),
	.dl_active(pcie_x1_dl_active),
	.dl_up(pcie_x1_dl_up),
	.tx_dllp_val({pcie_x1_tx_dllp_val}),
	.tx_pmtype({pcie_x1_tx_pmtype}), 
	.tx_vsd_data({pcie_x1_tx_vsd_data}),
	.tx_dllp_sent(pcie_x1_tx_dllp_sent),
	.rxdp_pmd_type({pcie_x1_rxdp_pmd_type}),
	.rxdp_vsd_data({pcie_x1_rxdp_vsd_data}), 
	.rxdp_dllp_val({pcie_x1_rxdp_dllp_val}), 

	// Transaction Layer
	.cmpln_tout(pcie_x1_cmpln_tout), 
	.cmpltr_abort_np(pcie_x1_cmpltr_abort_np),
	.cmpltr_abort_p(pcie_x1_cmpltr_abort_p), 
	.unexp_cmpln(pcie_x1_unexp_cmpln), 
	.np_req_pend(pcie_x1_np_req_pend),

	// Configuration Registers
	.bus_num({pcie_x1_bus_num}),
	.dev_num({pcie_x1_dev_num}), 
	.func_num({pcie_x1_func_num}),
	.cmd_reg_out({pcie_x1_cmd_reg_out}), 
	.dev_cntl_out({pcie_x1_dev_cntl_out}),
	.lnk_cntl_out({pcie_x1_lnk_cntl_out}), 
	.inta_n(pcie_x1_inta_n), 
	.msi({pcie_x1_msi}),
	.mm_enable({pcie_x1_mm_enable}),
	.msi_enable(pcie_x1_msi_enable),
	.pme_status(pcie_x1_pme_status), 
	.pme_en(pcie_x1_pme_en),
	.pm_power_state({pcie_x1_pm_power_state}),


	.sci_addr({pcie_x1_sci_addr}),
	.sci_rddata({pcie_x1_sci_rddata}), 
	.sci_wrdata({pcie_x1_sci_wrdata}),
	.sci_en(pcie_x1_sci_en),
	.sci_en_dual(pcie_x1_sci_en_dual), 
	.sci_int(pcie_x1_sci_int),
	.sci_rd(pcie_x1_sci_rd),
	.sci_sel(pcie_x1_sci_sel), 
	.sci_sel_dual(pcie_x1_sci_sel_dual),
	.sci_wrn(pcie_x1_sci_wrn), 
	.serdes_pdb(pcie_x1_serdes_pdb),
	.serdes_rst_dual_c(pcie_x1_serdes_rst_dual_c), 
	.sli_rst(sli_rst_wire0),
	.tx_pwrup_c(pcie_x1_tx_pwrup_c),
	.tx_serdes_rst_c(pcie_x1_tx_serdes_rst_c)
);

endmodule
