`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 01:37:06 PM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps

module testbench;

  reg clk_100MHz = 0;
  reg reset_rtl_0 = 1;

  // Clock generation
  always #5 clk_100MHz = ~clk_100MHz;

  initial begin
    reset_rtl_0 = 1;
    @(posedge clk_100MHz);
    reset_rtl_0 = 0;
  end

  // DUT instantiation
  design_1_wrapper dut (
    .clk_100MHz(clk_100MHz),
    .reset_rtl_0(reset_rtl_0)
  );

  initial begin
    #1000;
    $finish;
  end

endmodule