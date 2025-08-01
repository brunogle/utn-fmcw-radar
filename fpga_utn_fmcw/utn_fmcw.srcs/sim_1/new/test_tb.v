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

module test_tb;

    reg clk = 0;
    reg resetn = 0;

    // AXI-Lite signals
    reg [31:0] s_axi_awaddr = 0;
    reg        s_axi_awvalid = 0;
    wire       s_axi_awready;

    reg [31:0] s_axi_wdata = 0;
    reg [3:0]  s_axi_wstrb = 4'hF;
    reg        s_axi_wvalid = 0;
    wire       s_axi_wready;

    wire [1:0] s_axi_bresp;
    wire       s_axi_bvalid;
    reg        s_axi_bready = 1;

    reg [31:0] s_axi_araddr = 0;
    reg        s_axi_arvalid = 0;
    wire       s_axi_arready;
    wire [31:0] s_axi_rdata;
    wire [1:0]  s_axi_rresp;
    wire        s_axi_rvalid;
    reg         s_axi_rready = 1;

    // AXI Stream Master
    wire [15:0] m_axis_tdata;
    wire        m_axis_tvalid;
    reg         m_axis_tready;
    wire        m_axis_tlast;
    wire [1:0]  m_axis_tkeep;

    // BRAM interface
    wire bram_clk;
    wire bram_rst;
    wire bram_en;
    wire [13:0] bram_addr;
    wire [15:0] bram_dout;
    wire [0:0]  bram_we;

    // BRAM model (simple ROM for test)
    reg [15:0] bram_mem [0:15];

    // Instantiate DUT
    radar_sweep_ctrl dut (
        .clk(clk),
        .resetn(resetn),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_awready(s_axi_awready),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid),
        .s_axi_wready(s_axi_wready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_arready(s_axi_arready),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_rready(s_axi_rready),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tvalid(m_axis_tvalid),
        .m_axis_tready(m_axis_tready),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tkeep(m_axis_tkeep),
        .bram_clk(bram_clk),
        .bram_rst(bram_rst),
        .bram_en(bram_en),
        .bram_addr(bram_addr),
        .bram_dout(bram_dout),
        .bram_we(bram_we),
        .sampling()
    );

    // Clock generation
    always #5 clk = ~clk; // 100 MHz

    // Clocked output
    reg [31:0] bram_dout_reg;
    assign bram_dout = bram_dout_reg;
    
    // Clocked BRAM read
    always @(posedge clk) begin
        if (bram_en)
            bram_dout_reg <= bram_mem[bram_addr];
    end
    
    // Task to perform AXI-Lite write
    task axi_write(input [31:0] addr, input [31:0] data);
    begin
        @(posedge clk);
        s_axi_awaddr  <= addr;
        s_axi_awvalid <= 1;
        s_axi_wdata   <= data;
        s_axi_wvalid  <= 1;
        wait(s_axi_awready && s_axi_wready);
        @(posedge clk);
        s_axi_awvalid <= 0;
        s_axi_wvalid  <= 0;
        wait(s_axi_bvalid);
        @(posedge clk);
    end
    endtask

    // Initialize BRAM and run simulation
    initial begin
        // Initialize BRAM content
        m_axis_tready = 1;
        bram_mem[0] = 16'h1111;
        bram_mem[1] = 16'h2222;
        bram_mem[2] = 16'h3333;
        bram_mem[3] = 16'h4444;
        bram_mem[4] = 16'h5555;
        bram_mem[5] = 16'h6666;
        bram_mem[6] = 16'h7777;
        bram_mem[7] = 16'h8888;
        bram_mem[8] = 16'h9999;
        bram_mem[9] = 16'haaaa;
        bram_mem[10] = 16'hbbbb;
        bram_mem[11] = 16'hcccc;
        bram_mem[12] = 16'hdddd;
        bram_mem[13] = 16'heeee;
        bram_mem[14] = 16'hffff;
        bram_mem[15] = 16'hefef;
        m_axis_tready = 1;
        // Apply reset
        resetn = 0;
        #100;
        resetn = 1;

        // Wait a few cycles
       
        #20;

        // Write sweep_clk_div = 5
        axi_write(32'h04, 32'd0);

             
        
        // Write sweep_length = 5
        axi_write(32'h08, 32'd15);

        // Start sweep
        axi_write(32'h00, 32'd1);

        #102        
        m_axis_tready = 0;
        #97
        m_axis_tready = 1;

        // Let it run
        #500;
        


        axi_write(32'h00, 32'd1);
        #2000;


        $finish;
    end

    // Monitor AXI Stream output
    always @(posedge clk) begin
        if (m_axis_tvalid && m_axis_tready) begin
            $display("tdata = 0x%04X, tlast = %0d @ time %0t", m_axis_tdata, m_axis_tlast, $time);
        end
    end

endmodule

