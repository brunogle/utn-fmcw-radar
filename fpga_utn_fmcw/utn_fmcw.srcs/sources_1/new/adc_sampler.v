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
    
    input sample,
    input clk,
    input aresetn,
    
     // Slave side
    output wire                        s_axis_tready,
    input  wire [AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
    input  wire                        s_axis_tvalid,
    input  wire                        s_axis_tlast,
    input  wire [0:3]                  s_axis_tkeep,

    // Master side
    input   wire                        m_axis_tready,
    output  wire [AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
    output  wire                        m_axis_tvalid,
    output  wire                        m_axis_tlast,
    output  wire  [0:3]                 m_axis_tkeep
    );
   
    reg [AXIS_TDATA_WIDTH-1:0] buffer_data;
    reg                  buffer_valid;
    reg                  buffer_tlast;
    reg [0:3]            buffer_tkeep;
    
    assign m_axis_tdata  = buffer_data;
    assign m_axis_tvalid = buffer_valid;
    assign s_axis_tready = ~buffer_valid || (m_axis_tready && buffer_valid);
    assign m_axis_tkeep = buffer_tkeep;
    assign m_axis_tlast = buffer_tlast;
    
    always @(posedge clk) begin
        if (!aresetn) begin
            buffer_data  <= 0;
            buffer_valid <= 0;
            buffer_tlast <= 0;
        end else begin
            if (s_axis_tvalid && s_axis_tready) begin
                buffer_data  <= s_axis_tdata;
                buffer_tlast <= s_axis_tlast;
                buffer_valid <= 1;
                buffer_tkeep <= buffer_tkeep;
            end else if (m_axis_tready && buffer_valid) begin
                buffer_valid <= 0;
            end
        end
    end

    
    
endmodule
