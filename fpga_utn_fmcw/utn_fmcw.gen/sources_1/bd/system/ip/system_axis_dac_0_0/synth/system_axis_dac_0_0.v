// (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of AMD and is protected under U.S. and international copyright
// and other intellectual property laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// AMD, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) AMD shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or AMD had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// AMD products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of AMD products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:axis_dac:1.0
// IP Revision: 1

(* X_CORE_INFO = "axis_dac,Vivado 2025.1" *)
(* CHECK_LICENSE_TYPE = "system_axis_dac_0_0,axis_dac,{}" *)
(* CORE_GENERATION_INFO = "system_axis_dac_0_0,axis_dac,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=axis_dac,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_axis_dac_0_0 (
  aclk,
  ddr_clk,
  wrt_clk,
  locked,
  dac_cl,
  dac_rst,
  dac_sel,
  dac_wrt,
  dac_dat,
  S01_AXIS_TREADY,
  S01_AXIS_TDATA,
  S01_AXIS_TVALID,
  S02_AXIS_TREADY,
  S02_AXIS_TDATA,
  S02_AXIS_TVALID
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF S01_AXIS:S02_AXIS, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_pll_0_0_clk_out1, INSERT_VIP 0" *)
input wire aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 ddr_clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME ddr_clk, FREQ_HZ 250000000, FREQ_TOLERANCE_HZ 0, PHASE 157.5, CLK_DOMAIN system_pll_0_0_clk_out1, INSERT_VIP 0" *)
input wire ddr_clk;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 wrt_clk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME wrt_clk, FREQ_HZ 250000000, FREQ_TOLERANCE_HZ 0, PHASE 202.5, CLK_DOMAIN system_pll_0_0_clk_out1, INSERT_VIP 0" *)
input wire wrt_clk;
input wire locked;
output wire dac_cl;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 dac_rst RST" *)
(* X_INTERFACE_MODE = "master" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME dac_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
output wire dac_rst;
output wire dac_sel;
output wire dac_wrt;
output wire [13 : 0] dac_dat;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TREADY" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S01_AXIS, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 125000000, PHASE 0.0, CLK_DOMAIN system_pll_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
output wire S01_AXIS_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TDATA" *)
input wire [15 : 0] S01_AXIS_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S01_AXIS TVALID" *)
input wire S01_AXIS_TVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TREADY" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S02_AXIS, TDATA_NUM_BYTES 2, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 125000000, PHASE 0.0, CLK_DOMAIN system_pll_0_0_clk_out1, LAYERED_METADATA undef, INSERT_VIP 0" *)
output wire S02_AXIS_TREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TDATA" *)
input wire [15 : 0] S02_AXIS_TDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S02_AXIS TVALID" *)
input wire S02_AXIS_TVALID;

  axis_dac inst (
    .aclk(aclk),
    .ddr_clk(ddr_clk),
    .wrt_clk(wrt_clk),
    .locked(locked),
    .dac_cl(dac_cl),
    .dac_rst(dac_rst),
    .dac_sel(dac_sel),
    .dac_wrt(dac_wrt),
    .dac_dat(dac_dat),
    .S01_AXIS_TREADY(S01_AXIS_TREADY),
    .S01_AXIS_TDATA(S01_AXIS_TDATA),
    .S01_AXIS_TVALID(S01_AXIS_TVALID),
    .S02_AXIS_TREADY(S02_AXIS_TREADY),
    .S02_AXIS_TDATA(S02_AXIS_TDATA),
    .S02_AXIS_TVALID(S02_AXIS_TVALID)
  );
endmodule
