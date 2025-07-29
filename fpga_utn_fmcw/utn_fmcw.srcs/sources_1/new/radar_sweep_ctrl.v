`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2025 08:50:59 AM
// Design Name: 
// Module Name: radar_sweep_ctrl
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


module radar_sweep_ctrl(
    input wire          clk,
    input wire          resetn,
    
    // AXI-LITE SLAVE SIGNALS: Used for configuration
    input wire [31:0]   s_axi_awaddr,
    input wire          s_axi_awvalid,
    output wire         s_axi_awready,
    input wire [31:0]   s_axi_wdata,
    input wire [3:0]    s_axi_wstrb,
    input wire          s_axi_wvalid,
    output wire         s_axi_wready,
    output wire [1:0]   s_axi_bresp,
    output wire         s_axi_bvalid,
    input wire          s_axi_bready,
    input wire [31:0]   s_axi_araddr,
    input wire          s_axi_arvalid,
    output wire         s_axi_arready,
    output wire [31:0]  s_axi_rdata,
    output wire [1:0]   s_axi_rresp,
    output wire         s_axi_rvalid,
    input wire          s_axi_rready,

    // AXI STREAM MASTER: Used for signal output
    output wire [15:0] m_axis_tdata,
    output wire m_axis_tvalid,
    input  wire m_axis_tready,
    output wire m_axis_tlast,
    output wire [1:0] m_axis_tkeep,
    // BRAM: Used for reading sweep waveform
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT CLK" *)  output wire        bram_clk,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT RST" *)  output wire        bram_rst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT EN" *)   output wire        bram_en,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT ADDR" *) output wire [13:0] bram_addr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT DOUT" *)  input  wire [15:0] bram_dout,
    (* X_INTERFACE_INFO = "xilinx.com:interface:bram:1.0 BRAM_PORT WE" *)   output wire [0:0]  bram_we,

    
    output wire sampling
);

    parameter REG_START_ADDR    = 4'd0; // 0x....00
    parameter REG_SWEEP_CLK_DIV_ADDR = 4'd1; // 0x....04
    parameter REG_SWEEP_LENGTH_ADDR  = 4'd2; // 0x....08
    
    reg          reg_start;         // Writing 0b1 starts radar sequence (pre acq, sweep, post acq.)
    reg [15:0]   reg_sweep_clk_div; // Sets clock divider for reading sweep memory
    reg [15:0]   reg_sweep_length;  // Number of samples to read from sweep memory
    
    //TODO : reg [4:0]   reg_decimation;

    // AXI-LITE SLAVE:  Internal signals
    reg [31:0] rdata_reg;
    reg rvalid_reg, bvalid_reg;
    reg s_axi_awready_reg, wready_reg, arready_reg;

    // Sweep Logic:  Internal signals
    reg [15:0]  sweep_addr;
    reg        clear_reg_start;
    reg [15:0]  clk_div_counter;
    
    assign s_axi_awready = s_axi_awready_reg;
    assign s_axi_wready = wready_reg;
    assign s_axi_bresp = 2'b00; // OKAY response
    assign s_axi_bvalid = bvalid_reg;
    assign s_axi_arready = arready_reg;
    assign s_axi_rdata = rdata_reg;
    assign s_axi_rresp = 2'b00; // OKAY response
    assign s_axi_rvalid = rvalid_reg;

    //  AXI-LITE SLAVE: Write address handshake
    always @(posedge clk) begin
        if (!resetn) begin
            s_axi_awready_reg <= 1'b0;
        end else if (s_axi_awvalid && !s_axi_awready_reg) begin
            s_axi_awready_reg <= 1'b1;
        end else begin
            s_axi_awready_reg <= 1'b0;
        end
    end

    //  AXI-LITE SLAVE:  Write data handler
    always @(posedge clk) begin
        if (!resetn) begin
            wready_reg <= 1'b0;
            bvalid_reg <= 1'b0;
        end else if (s_axi_wvalid && !wready_reg) begin
            wready_reg <= 1'b1;
            case (s_axi_awaddr[5:2])
                REG_START_ADDR: begin
                    if (s_axi_wstrb[0]) reg_start <= s_axi_wdata[0:0];
                end
                REG_SWEEP_CLK_DIV_ADDR: begin
                    if (s_axi_wstrb[0]) reg_sweep_clk_div[7:0] <= s_axi_wdata[7:0];
                    if (s_axi_wstrb[1]) reg_sweep_clk_div[15:8] <= s_axi_wdata[15:8];
                end
                REG_SWEEP_LENGTH_ADDR: begin
                    if (s_axi_wstrb[0]) reg_sweep_length[7:0] <= s_axi_wdata[7:0];
                    if (s_axi_wstrb[1]) reg_sweep_length[15:8] <= s_axi_wdata[15:8];
                end
                default: begin
                    // Handle invalid addresses
                end
            endcase
            bvalid_reg <= 1'b1;
        end else if (s_axi_bready && bvalid_reg) begin
            bvalid_reg <= 1'b0;
        end else begin
            wready_reg <= 1'b0;
        end
        
        // Handle Logic that can affect register values
        
        if(clear_reg_start && reg_start) begin
            reg_start <= 1'b0;
        end
    end

    // AXI-LITE SLAVE:  Read address handshake
    always @(posedge clk) begin
        if (!resetn) begin
            arready_reg <= 1'b0;
            rvalid_reg <= 1'b0;
        end else if (s_axi_arvalid && !arready_reg) begin
            arready_reg <= 1'b1;
            case (s_axi_araddr[5:2])
                REG_START_ADDR:         rdata_reg <= reg_start;
                REG_SWEEP_CLK_DIV_ADDR: rdata_reg <= reg_sweep_clk_div;
                REG_SWEEP_LENGTH_ADDR:  rdata_reg <= reg_sweep_length;
                default: rdata_reg <= 32'h00000000; // Default value
            endcase
            rvalid_reg <= 1'b1;
        end else if (s_axi_rready && rvalid_reg) begin
            rvalid_reg <= 1'b0;
        end else begin
            arready_reg <= 1'b0;
        end
    end
    

    always @(posedge clk) begin
        if (!resetn) begin
            sweep_addr <= 16'b0;
        end else if(reg_start && (reg_sweep_clk_div == clk_div_counter)) begin
            clk_div_counter <= 0;
            if(sweep_addr + 1 < reg_sweep_length) begin
                sweep_addr <= sweep_addr + 1;
            end else begin
                sweep_addr <= 16'b0;
                clear_reg_start <= 1'b1;
            end
        end else if(reg_start) begin
            clk_div_counter <= clk_div_counter + 1;
        end else if(clear_reg_start) begin
            clear_reg_start <= 1'b0;
        end
    end 
   
    assign m_axis_tdata = reg_start ? bram_dout : 16'b0;
    assign m_axis_tvalid = reg_start;
    assign m_axis_tlast = ((sweep_addr + 1) == reg_sweep_length);
    assign m_axis_tkeep = 2'b11; 
    assign bram_addr = sweep_addr[13:0];
    
   
    assign bram_we = 1'b0;
    assign bram_rst = 1'b0;
    assign bram_clk = clk;
    assign bram_en = 1'b1;
    

endmodule
