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
claritycores/ddr3_x16/ddr_p_eval/testbench/top/ecp5um/odt_watchdog.v \
claritycores/ddr3_x16/ddr_p_eval/testbench/top/ecp5um/monitor.v \
claritycores/ddr3_x16/ddr_p_eval/testbench/top/ecp5um/test_mem_ctrl.v


vsim -O5 +access +r -t 1ps -lib titan_design -L ovi_ecp5um titan_design.test_mem_ctrl 

add wave -noupdate -divider {Global Signals}
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/clk_in
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/rst_n
add wave -noupdate -divider {Memory Interface Signals}
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_reset_n
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_cke
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_clk
wave -virtual "em_ddr_cmd" -expand /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_cs_n /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_ras_n /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_cas_n /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_we_n
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_addr
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_ba
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_data
add wave -noupdate -format Literal /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_dqs
add wave -noupdate -format Literal /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_dm
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/em_ddr_odt
add wave -noupdate -divider {Local Interface Signals}
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/sclk_out
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/init_start
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/init_done
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/wl_err
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/rt_err
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/clocking_good
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/addr
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/cmd
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/cmd_valid
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/cmd_rdy
add wave -noupdate -format Literal /test_mem_ctrl/U1_ddr_sdram_mem_top/cmd_burst_cnt
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/ofly_burst_len
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/datain_rdy
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/write_data
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/data_mask
add wave -noupdate -format Literal -radix hexadecimal /test_mem_ctrl/U1_ddr_sdram_mem_top/read_data
add wave -noupdate -format Logic /test_mem_ctrl/U1_ddr_sdram_mem_top/read_data_valid
run -all
