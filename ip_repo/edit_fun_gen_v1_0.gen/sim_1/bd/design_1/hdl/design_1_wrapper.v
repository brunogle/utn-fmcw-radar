//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
//Date        : Tue Jul 22 20:26:53 2025
//Host        : bruno-desktop-fedora running 64-bit Fedora Linux 42 (Workstation Edition)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper (
  input wire clk_100MHz,
  input wire reset_rtl_0
);

  design_1 design_1_i (
    .clk_100MHz(clk_100MHz),
    .reset_rtl_0(reset_rtl_0)
  );

endmodule