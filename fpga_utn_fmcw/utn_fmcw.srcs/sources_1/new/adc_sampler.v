`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2025 11:08:44 PM
// Design Name: 
// Module Name: adc_sampler
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


module adc_sampler #
(
  parameter integer AXIS_TDATA_WIDTH = 16
)
(
    
     // Slave side
    output wire                        S_AXIS_TREADY,
    input  wire [AXIS_TDATA_WIDTH-1:0] S_AXIS_TDATA,
    input  wire                        S_AXIS_TVALID,
    input  wire                        S_AXIS_TLAST,
    input  wire [0:3]                  S_AXIS_TKEEP,

    // Master side
    input   wire                        M_AXIS_TREADY,
    output  wire [AXIS_TDATA_WIDTH-1:0] M_AXIS_TDATA,
    output  wire                        M_AXIS_TVALID,
    output  wire                        M_AXIS_TLAST,
    output  wire  [0:3]                 M_AXIS_TKEEP
    );
    
    
endmodule
