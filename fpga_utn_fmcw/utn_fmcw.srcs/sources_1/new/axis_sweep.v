`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 05:15:37 PM
// Design Name: 
// Module Name: axis_sweep
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


module axis_sweep #
(
  parameter integer DATA_WIDTH = 14
)
(

    input  wire         ACLK,
    input  wire         ARESETN,

    // AXI LITE SLAVE: Used for configuration
    // Write Address Channel
    input  wire [8:0]   S_AXI_AWADDR,
    input  wire         S_AXI_AWVALID,
    output wire         S_AXI_AWREADY,
    // Write Data Channel
    input  wire [31:0]  S_AXI_WDATA,
    input  wire [3:0]   S_AXI_WSTRB,
    input  wire         S_AXI_WVALID,
    output wire         S_AXI_WREADY,
    // Write Response Channel
    output wire [1:0]   S_AXI_BRESP,
    output wire         S_AXI_BVALID,
    input  wire         S_AXI_BREADY,
    
    // Read Address Channel
    input  wire [5:0]   S_AXI_ARADDR,
    input  wire         S_AXI_ARVALID,
    output reg          S_AXI_ARREADY,

    // Read Data Channel
    output reg  [31:0]  S_AXI_RDATA,
    output reg  [1:0]   S_AXI_RRESP,
    output reg          S_AXI_RVALID,
    input  wire         S_AXI_RREADY,
       
    // AXI STREAM MASTER: Used for signal output
    output wire [31:0] M_AXIS_TDATA,
    output wire M_AXIS_TVALID,
    input  wire M_AXIS_TREADY
    );
    
    // Configuration Registers
    reg [31:0] cfg_min_val;
    reg [31:0] cfg_max_val;
    reg [31:0] cfg_clk_div;
    
    // AXI LITE SLAVE: Internal Signals & Registers
    reg awready_reg;
    reg wready_reg;
    reg bvalid_reg;
    reg [1:0] bresp_reg;

    // AXI LITE SLAVE: Assign handshake
    assign S_AXI_AWREADY = awready_reg;
    assign S_AXI_WREADY  = wready_reg;
    assign S_AXI_BVALID  = bvalid_reg;
    assign S_AXI_BRESP   = bresp_reg;

    // AXI LITE SLAVE: Write Strobe Mask
    wire [31:0] wstrb_mask = {
    {8{S_AXI_WSTRB[3]}},
    {8{S_AXI_WSTRB[2]}},
    {8{S_AXI_WSTRB[1]}},
    {8{S_AXI_WSTRB[0]}}
    };

    // AXI LITE SLAVE READ LOGIC
    always @(posedge ACLK) begin
        if (!ARESETN) begin
            awready_reg <= 0;
            wready_reg  <= 0;
            bvalid_reg  <= 0;
            bresp_reg   <= 2'b00;
            cfg_min_val     <= 32'b0;
            cfg_max_val     <= 32'b0;
            cfg_clk_div     <= 32'b0;
            
        end else begin
            // Accept address
            if (!awready_reg && S_AXI_AWVALID)
                awready_reg <= 1'b1;
            else
                awready_reg <= 1'b0;

            // Accept data
            if (!wready_reg && S_AXI_WVALID)
                wready_reg <= 1'b1;
            else
                wready_reg <= 1'b0;

            // Write to register
            if (S_AXI_AWVALID && S_AXI_WVALID && awready_reg && wready_reg) begin
            case (S_AXI_AWADDR[5:2])
                4'd0: cfg_min_val <= (S_AXI_WDATA & wstrb_mask) | (cfg_min_val & ~wstrb_mask);
                4'd1: cfg_max_val <= (S_AXI_WDATA & wstrb_mask) | (cfg_max_val & ~wstrb_mask);
                4'd2: cfg_clk_div <= (S_AXI_WDATA & wstrb_mask) | (cfg_clk_div & ~wstrb_mask);
                default: ;
            endcase
                bvalid_reg <= 1'b1;
                bresp_reg  <= 2'b00; // OKAY
            end else if (bvalid_reg && S_AXI_BREADY) begin
                bvalid_reg <= 1'b0;
            end
        end
    end
    
    // AXI LITE SLAVE WRITE LOGIC    
    always @(posedge ACLK) begin
        if (!ARESETN) begin
            S_AXI_ARREADY <= 0;
            S_AXI_RVALID  <= 0;
            S_AXI_RDATA   <= 0;
            S_AXI_RRESP   <= 2'b00;
        end else begin
            // Address handshake
            if (!S_AXI_ARREADY && S_AXI_ARVALID) begin
                S_AXI_ARREADY <= 1;
            end else begin
                S_AXI_ARREADY <= 0;
            end

            // Perform read
            if (S_AXI_ARVALID && S_AXI_ARREADY) begin
                case (S_AXI_ARADDR[5:2])
                    4'd0: S_AXI_RDATA <= cfg_min_val;
                    4'd1: S_AXI_RDATA <= cfg_max_val;
                    4'd2: S_AXI_RDATA <= cfg_clk_div;
                    default: S_AXI_RDATA <= 32'hDEADBEEF;
                endcase
                S_AXI_RVALID <= 1;
                S_AXI_RRESP  <= 2'b00; // OKAY
            end else if (S_AXI_RVALID && S_AXI_RREADY) begin
                S_AXI_RVALID <= 0;
            end
        end
    end
    
    
    // Sweep Generator
    reg [31:0] clk_div_count;
    reg signed [DATA_WIDTH-1:0] sweep_out;
    reg sweep_valid;
    
    
    always @(posedge ACLK) begin
        if (!ARESETN) begin
            clk_div_count <= 0;
            sweep_out <= 0;
        end else begin
            if (clk_div_count < cfg_clk_div) begin
                clk_div_count <= clk_div_count + 1;
            end else begin
                clk_div_count <= 0;
                if(sweep_out < $signed(cfg_max_val[DATA_WIDTH-1:0])) begin
                    sweep_out <= sweep_out + 1;
                end else begin
                    sweep_out <= cfg_min_val;
                end
            end
        end
    end 
    
    assign M_AXIS_TDATA  = sweep_out;
    assign M_AXIS_TVALID = 1'b1;
endmodule
