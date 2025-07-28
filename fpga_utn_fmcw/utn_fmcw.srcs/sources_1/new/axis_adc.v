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

 
module axis_adc #
(
  parameter integer DAC_DATA_WIDTH = 14,
  parameter integer AXIS_TDATA_WIDTH = 32,
  parameter integer AXIS_STREAM_LENGTH = 16
)
(
    // ADC IC Signals

    input wire [15:0]   adc_dat_a,
    input wire [15:0]   adc_dat_b,
    output wire         adc_csn,
    
    // AXIS Signals
    input wire          aclk,
    
    
    // Master side
    input wire                          M01_AXIS_TREADY,
    output  wire [AXIS_TDATA_WIDTH-1:0]  M01_AXIS_TDATA,
    output  wire                        M01_AXIS_TVALID,
    output  wire                        M01_AXIS_TLAST,
    output  wire [0:3]                  M01_AXIS_TKEEP,

    // Master side
    input wire                          M02_AXIS_TREADY,
    output  wire [AXIS_TDATA_WIDTH-1:0] M02_AXIS_TDATA,
    output  wire                        M02_AXIS_TVALID,
    output  wire                        M02_AXIS_TLAST,
    output  wire  [0:3]                 M02_AXIS_TKEEP

    );
    
    reg  [15:0] int_dat_a_reg;
    reg  [15:0] int_dat_b_reg;
    
    reg  [31:0] int_dat_count;
    
    always @(posedge aclk)
    begin
        int_dat_a_reg <= adc_dat_a[15:2];
        int_dat_b_reg <= adc_dat_b[15:2];
        if(int_dat_count < AXIS_STREAM_LENGTH) begin
            int_dat_count <= int_dat_count + 1;
        end else begin
            int_dat_count <= 0;
        end
    end
    
    assign M01_AXIS_TDATA = { {19{~int_dat_a_reg[13]}}, int_dat_a_reg[12:0] };
    assign M02_AXIS_TDATA = { {19{~int_dat_b_reg[13]}}, int_dat_b_reg[12:0] };
    
    assign adc_csn = 1'b1;
    assign M01_AXIS_TVALID = 1'b1;
    assign M02_AXIS_TVALID = 1'b1;
    
    assign M01_AXIS_TLAST = (int_dat_count == AXIS_STREAM_LENGTH);
    assign M02_AXIS_TLAST = (int_dat_count == AXIS_STREAM_LENGTH);
    
    assign M01_AXIS_TKEEP = 4'hf;
    assign M02_AXIS_TKEEP = 4'hf;
    
endmodule
