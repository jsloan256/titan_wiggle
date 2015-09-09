workspace create titan_space
design create titan_design .
design open titan_design
waveformmode asdb
cd {../..}
vlog -msg 0 +define+ddr3_x16_NO_DEBUG+ddr3_x16_SIM+SIM+NO_DEBUG \
-y claritycores/ddr3_x16/ddr_p_eval/models/ecp5um +libext+.v \
-y claritycores/ddr3_x16/ddr_p_eval/models/mem +libext+.v \
+incdir+claritycores/ddr3_x16/ddr_p_eval/testbench/tests/ecp5um \
+incdir+claritycores/ddr3_x16/ddr_p_eval/ddr3_x16/src/params \
+incdir+claritycores/ddr3_x16/ddr_p_eval/models/mem \
claritycores/ddr3_x16/ddr_p_eval/ddr3_x16/src/params/ddr3_sdram_mem_params_ddr3_x16.v \
claritycores/ddr3_x16/ddr_p_eval/models/ecp5um/pmi_distributed_dpram.v \
claritycores/ddr3_x16/ddr3_x16_beh.v \
claritycores/ddr3_x16/ddr_p_eval/models/ecp5um/ddr_clks_src.v \
claritycores/ddr3_x16/ddr_p_eval/ddr3_x16/src/rtl/top/ecp5um/ddr3_sdram_mem_top_wrapper_ddr3_x16.v \
claritycores/refclk/refclk.v \
claritycores/pcie_x1/pcie_x1_core_bb.v \
claritycores/pcie_x1/pcie_eval/models/ecp5um/pcie_x1_ctc.v \
claritycores/pcie_x1/pcie_eval/models/ecp5um/pcie_x1_sync1s.v \
claritycores/pcie_x1/pcie_eval/models/ecp5um/pcie_x1_pipe.v \
claritycores/pcie_x1/pcie_eval/models/ecp5um/pcie_x1_extref.v \
claritycores/pcie_x1/pcie_eval/models/ecp5um/pcie_x1_pcs_softlogic.v \
claritycores/pcie_x1/pcie_eval/models/ecp5um/pcie_x1_pcs.v \
claritycores/pcie_x1/pcie_eval/models/ecp5um/pcie_x1_phy.v \
claritycores/pcie_x1/pcie_x1.v \
claritycores/claritycores.v \
titan_wiggle/source/ddr3_init_sm.v \
titan_wiggle/source/ddr3_data_exercise_sm.v \
titan_wiggle/source/wiggle.v \
titan_wiggle/source/wiggle_tb.v

vsim -O5 +access +r -t 1ps -lib titan_design -L ovi_ecp5um -L pmi_work -L pcsd_aldec_work titan_design.wiggle_tb

add wave -noupdate -divider {PCB Signals}
add wave -noupdate -format Logic /wiggle_tb/osc
add wave -noupdate -format Logic /wiggle_tb/perstn
wave -virtual "ddr3" -expand /wiggle_tb/ddr3_rstn /wiggle_tb/ddr3_ck0 /wiggle_tb/ddr3_cke /wiggle_tb/ddr3_csn /wiggle_tb/ddr3_casn /wiggle_tb/ddr3_rasn /wiggle_tb/ddr3_wen /wiggle_tb/ddr3_odt /wiggle_tb/ddr3_a /wiggle_tb/ddr3_ba /wiggle_tb/ddr3_d /wiggle_tb/ddr3_dm /wiggle_tb/dqs /wiggle_tb/ddr3_dqs_n

add wave -noupdate -divider {Internal FPGA Signals}
add wave -virtual "ddr3_core" -expand /wiggle_tb/U1/ddr3_sclk /wiggle_tb/U1/ddr3_clocking_good /wiggle_tb/U1/ddr3_init_start /wiggle_tb/U1/ddr3_init_done /wiggle_tb/U1/ddr3_addr /wiggle_tb/U1/ddr3_cmd_rdy /wiggle_tb/U1/ddr3_cmd_valid /wiggle_tb/U1/ddr3_cmd /wiggle_tb/U1/ddr3_datain_rdy /wiggle_tb/U1/ddr3_write_data /wiggle_tb/U1/ddr3_data_mask /wiggle_tb/U1/ddr3_cmd_burst_cnt /wiggle_tb/U1/ddr3_read_data /wiggle_tb/U1/ddr3_read_data_valid /wiggle_tb/U1/ddr3_wl_err

run -all
