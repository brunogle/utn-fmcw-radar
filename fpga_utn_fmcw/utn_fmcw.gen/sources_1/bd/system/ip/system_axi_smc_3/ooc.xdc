# aclk {FREQ_HZ 125000000 CLK_DOMAIN system_pll_0_0_clk_out1 PHASE 0.0} aclk1 {FREQ_HZ 50000000 CLK_DOMAIN system_ps_0_0_FCLK_CLK0 PHASE 0.0}
# Clock Domain: system_pll_0_0_clk_out1
create_clock -name aclk -period 8.000 [get_ports aclk]
# Clock Domain: system_ps_0_0_FCLK_CLK0
create_clock -name aclk1 -period 20.000 [get_ports aclk1]
# Generated clocks
