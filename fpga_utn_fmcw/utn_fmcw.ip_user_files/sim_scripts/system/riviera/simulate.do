transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+system  -L xil_defaultlib -L xilinx_vip -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_21 -L processing_system7_vip_v1_0_23 -L proc_sys_reset_v5_0_17 -L blk_mem_gen_v8_4_11 -L xlconstant_v1_1_10 -L smartconnect_v1_0 -L axi_register_slice_v2_1_35 -L axi_bram_ctrl_v4_1_13 -L axi_datamover_v5_1_37 -L axi_sg_v4_1_21 -L axi_dma_v7_1_36 -L axi_jtag_v1_0_3 -L bsip_v1_1_1 -L gigantic_mux -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.system xil_defaultlib.glbl

do {system.udo}

run 1000ns

endsim

quit -force
