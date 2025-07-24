transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xilinx_vip  -incr -l axi4stream_vip_v1_1_21 "+incdir+/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -l axi4stream_vip_v1_1_21 "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/434f/hdl" "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/a9be" "+incdir+../../../../../../../../../opt/Xilinx/2025.1/data/rsb/busdef" "+incdir+/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib \
"/opt/Xilinx/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93  -incr \
"/opt/Xilinx/2025.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/434f/hdl" "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/a9be" "+incdir+../../../../../../../../../opt/Xilinx/2025.1/data/rsb/busdef" "+incdir+/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib \
"../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/434f/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -l axi4stream_vip_v1_1_21 "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/434f/hdl" "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/a9be" "+incdir+../../../../../../../../../opt/Xilinx/2025.1/data/rsb/busdef" "+incdir+/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib \
"../../../bd/design_1/ip/design_1_axi4stream_vip_0_1/sim/design_1_axi4stream_vip_0_1_pkg.sv" \
"../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/235a/hdl/axi4stream_vip_v1_1_vl_rfs.sv" \
"../../../bd/design_1/ip/design_1_axi4stream_vip_0_1/sim/design_1_axi4stream_vip_0_1.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/434f/hdl" "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/a9be" "+incdir+../../../../../../../../../opt/Xilinx/2025.1/data/rsb/busdef" "+incdir+/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib \
"../../../bd/design_1/ip/design_1_fun_gen_0_0/sim/design_1_fun_gen_0_0.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0/design_1_clk_wiz_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0/design_1_clk_wiz_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
"../../../bd/design_1/ip/design_1_rst_clk_wiz_100M_0/sim/design_1_rst_clk_wiz_100M_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/434f/hdl" "+incdir+../../../../edit_fun_gen_v1_0.gen/sim_1/bd/design_1/ipshared/a9be" "+incdir+../../../../../../../../../opt/Xilinx/2025.1/data/rsb/busdef" "+incdir+/opt/Xilinx/2025.1/Vivado/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xil_defaultlib \
"../../../bd/design_1/sim/design_1.v" \

vlog -work xil_defaultlib \
"glbl.v"

