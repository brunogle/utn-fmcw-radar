`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 04:13:40 PM
// Design Name: 
// Module Name: axis_adc
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


module axis_adc(
    
    // ADC IC Signals

    input wire [15:0]   adc_dat_a,
    input wire [15:0]   adc_dat_b,
    output wire         adc_csn,
    
    // AXIS Signals
    input wire          aclk,
    output wire         m_axis_tvalid,
    output wire [31:0]  m_axis_tdata
    );
    
    reg  [15:0] int_dat_a_reg;
    reg  [15:0] int_dat_b_reg;
    
    always @(posedge aclk)
    begin
        int_dat_a_reg <= adc_dat_a[15:2];
        int_dat_b_reg <= adc_dat_b[15:2];
    end
    
    assign m_axis_tdata = {
    {(2+1){int_dat_b_reg[14-1]}}, ~int_dat_b_reg[14-2:0],
    {(2+1){int_dat_a_reg[14-1]}}, ~int_dat_a_reg[14-2:0]};
 
    
    assign adc_csn = 1'b1;

    assign m_axis_tvalid = 1'b1;
    
endmodule
