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


// IP VLNV: xilinx.com:ip:sc_axi2sc:1.0
// IP Revision: 10

(* X_CORE_INFO = "sc_axi2sc_v1_0_10_top,Vivado 2025.1" *)
(* CHECK_LICENSE_TYPE = "bd_919a_s00a2s_0,sc_axi2sc_v1_0_10_top,{}" *)
(* CORE_GENERATION_INFO = "bd_919a_s00a2s_0,sc_axi2sc_v1_0_10_top,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=sc_axi2sc,x_ipVersion=1.0,x_ipCoreRevision=10,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_AXI_ADDR_WIDTH=32,C_AXI_ID_WIDTH=2,C_AXI_RDATA_WIDTH=32,C_AXI_WDATA_WIDTH=32,C_SC_ADDR_WIDTH=32,C_SC_ID_WIDTH=2,C_SC_RDATA_WIDTH=64,C_SC_WDATA_WIDTH=64,C_SC_RUSER_BITS_PER_BYTE=0,C_SC_WUSER_BITS_PER_BYTE=0,C_SC_ARUSER_WIDTH=0,C_SC_AWUSER_WIDTH=0,C_SC_BUSER_WIDTH=0,C_MSC_ROUTE_WIDTH=1,C_SSC_ROUTE_\
WIDTH=2,C_AWPAYLD_WIDTH=140,C_ARPAYLD_WIDTH=140,C_WPAYLD_WIDTH=88,C_RPAYLD_WIDTH=85,C_BPAYLD_WIDTH=7}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module bd_919a_s00a2s_0 (
  aclk,
  s_sc_r_req,
  s_sc_r_info,
  s_sc_r_send,
  s_sc_r_recv,
  s_sc_r_payld,
  m_sc_ar_req,
  m_sc_ar_info,
  m_sc_ar_send,
  m_sc_ar_recv,
  m_sc_ar_payld,
  s_axi_arid,
  s_axi_araddr,
  s_axi_arlen,
  s_axi_arlock,
  s_axi_arcache,
  s_axi_arprot,
  s_axi_arqos,
  s_axi_aruser,
  s_axi_arvalid,
  s_axi_arready,
  s_axi_rid,
  s_axi_rdata,
  s_axi_rresp,
  s_axi_rlast,
  s_axi_ruser,
  s_axi_rvalid,
  s_axi_rready
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF S_AXI:M_SC_AR:M_SC_AW:M_SC_W:S_SC_R:S_SC_B, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN system_pll_0_0_clk_out1, INSERT_VIP 0" *)
input wire aclk;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 S_SC_R REQ" *)
(* X_INTERFACE_MODE = "slave" *)
input wire s_sc_r_req;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 S_SC_R INFO" *)
input wire [0 : 0] s_sc_r_info;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 S_SC_R SEND" *)
input wire s_sc_r_send;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 S_SC_R RECV" *)
output wire s_sc_r_recv;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 S_SC_R PAYLD" *)
input wire [84 : 0] s_sc_r_payld;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 M_SC_AR REQ" *)
(* X_INTERFACE_MODE = "master" *)
output wire m_sc_ar_req;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 M_SC_AR INFO" *)
output wire [0 : 0] m_sc_ar_info;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 M_SC_AR SEND" *)
output wire m_sc_ar_send;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 M_SC_AR RECV" *)
input wire m_sc_ar_recv;
(* X_INTERFACE_INFO = "xilinx.com:interface:sc:1.0 M_SC_AR PAYLD" *)
output wire [139 : 0] m_sc_ar_payld;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARID" *)
(* X_INTERFACE_MODE = "slave" *)
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXI, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 125000000, ID_WIDTH 2, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 1024, WUSER_WIDTH 0, RUSER_WIDTH 1024, BUSER_WIDTH 0, READ_WRITE_MODE READ_ONLY, HAS_BURST 0, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 0, HAS_BRESP 0, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.0, CLK_DOMAIN system_pll_0_0_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_TH\
READS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
input wire [1 : 0] s_axi_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *)
input wire [31 : 0] s_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLEN" *)
input wire [7 : 0] s_axi_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARLOCK" *)
input wire [0 : 0] s_axi_arlock;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARCACHE" *)
input wire [3 : 0] s_axi_arcache;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *)
input wire [2 : 0] s_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARQOS" *)
input wire [3 : 0] s_axi_arqos;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARUSER" *)
input wire [1023 : 0] s_axi_aruser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *)
input wire s_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *)
output wire s_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RID" *)
output wire [1 : 0] s_axi_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *)
output wire [31 : 0] s_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *)
output wire [1 : 0] s_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RLAST" *)
output wire s_axi_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RUSER" *)
output wire [1023 : 0] s_axi_ruser;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *)
output wire s_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *)
input wire s_axi_rready;

  sc_axi2sc_v1_0_10_top #(
    .C_AXI_ADDR_WIDTH(32),
    .C_AXI_ID_WIDTH(2),
    .C_AXI_RDATA_WIDTH(32),
    .C_AXI_WDATA_WIDTH(32),
    .C_SC_ADDR_WIDTH(32),
    .C_SC_ID_WIDTH(2),
    .C_SC_RDATA_WIDTH(64),
    .C_SC_WDATA_WIDTH(64),
    .C_SC_RUSER_BITS_PER_BYTE(0),
    .C_SC_WUSER_BITS_PER_BYTE(0),
    .C_SC_ARUSER_WIDTH(0),
    .C_SC_AWUSER_WIDTH(0),
    .C_SC_BUSER_WIDTH(0),
    .C_MSC_ROUTE_WIDTH(1),
    .C_SSC_ROUTE_WIDTH(2),
    .C_AWPAYLD_WIDTH(140),
    .C_ARPAYLD_WIDTH(140),
    .C_WPAYLD_WIDTH(88),
    .C_RPAYLD_WIDTH(85),
    .C_BPAYLD_WIDTH(7)
  ) inst (
    .aclk(aclk),
    .s_sc_r_req(s_sc_r_req),
    .s_sc_r_info(s_sc_r_info),
    .s_sc_r_send(s_sc_r_send),
    .s_sc_r_recv(s_sc_r_recv),
    .s_sc_r_payld(s_sc_r_payld),
    .s_sc_b_req(1'D0),
    .s_sc_b_info(1'D0),
    .s_sc_b_send(1'D0),
    .s_sc_b_recv(),
    .s_sc_b_payld(7'D0),
    .m_sc_ar_req(m_sc_ar_req),
    .m_sc_ar_info(m_sc_ar_info),
    .m_sc_ar_send(m_sc_ar_send),
    .m_sc_ar_recv(m_sc_ar_recv),
    .m_sc_ar_payld(m_sc_ar_payld),
    .m_sc_aw_req(),
    .m_sc_aw_info(),
    .m_sc_aw_send(),
    .m_sc_aw_recv(1'D0),
    .m_sc_aw_payld(),
    .m_sc_w_req(),
    .m_sc_w_info(),
    .m_sc_w_send(),
    .m_sc_w_recv(1'D0),
    .m_sc_w_payld(),
    .s_axi_awid(2'H0),
    .s_axi_awaddr(32'H00000000),
    .s_axi_awlen(8'H0),
    .s_axi_awlock(1'H0),
    .s_axi_awcache(4'H0),
    .s_axi_awprot(3'H0),
    .s_axi_awqos(4'H0),
    .s_axi_awuser(1024'H0),
    .s_axi_awvalid(1'H0),
    .s_axi_awready(),
    .s_axi_wdata(32'H00000000),
    .s_axi_wstrb(4'HF),
    .s_axi_wlast(1'H1),
    .s_axi_wuser(1024'H0),
    .s_axi_wvalid(1'H0),
    .s_axi_wready(),
    .s_axi_bid(),
    .s_axi_bresp(),
    .s_axi_buser(),
    .s_axi_bvalid(),
    .s_axi_bready(1'H0),
    .s_axi_arid(s_axi_arid),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arlen(s_axi_arlen),
    .s_axi_arlock(s_axi_arlock),
    .s_axi_arcache(s_axi_arcache),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arqos(s_axi_arqos),
    .s_axi_aruser(s_axi_aruser),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rid(s_axi_rid),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rlast(s_axi_rlast),
    .s_axi_ruser(s_axi_ruser),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready)
  );
endmodule
