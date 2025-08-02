`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/29/2025 09:31:04 AM
// Design Name: 
// Module Name: test_tb
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


`timescale 1ns / 1ps

module sampler_tb;

    // Testbench signals
    reg clk = 0;
    reg aresetn = 0;
    reg sample = 0;

    wire s_axis_tready;
    reg [15:0] s_axis_tdata = 16'hABCD;
    reg s_axis_tvalid = 1;

    reg m_axis_tready = 1;
    wire [15:0] m_axis_tdata;
    wire m_axis_tvalid;
    wire m_axis_tlast;
    wire [0:1] m_axis_tkeep;

    // Instantiate the DUT
    adc_sampler uut (
        .sample(sample),
        .clk(clk),
        .aresetn(aresetn),
        .s_axis_tready(s_axis_tready),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tvalid(s_axis_tvalid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tkeep(m_axis_tkeep)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    integer cycle = 0;

    initial begin

        // Reset for 3 clocks
        aresetn = 0;
        repeat(3) @(posedge clk);
        aresetn = 1;

        // sample = 0 for 10 clocks
        #3
        sample = 0;
        
        repeat(10) begin
            s_axis_tdata = s_axis_tdata + 1;
            @(posedge clk);
        end

        // sample = 1 for 10 clocks
        #3
        sample = 1;
        
        repeat(10) begin
            s_axis_tdata = s_axis_tdata + 1;
            @(posedge clk);
        end

        // sample = 0 again
        #3
        sample = 0;
        
        repeat(10) begin
            s_axis_tdata = s_axis_tdata + 1;
            @(posedge clk);
        end

        // Done
        $finish;
    end

endmodule

