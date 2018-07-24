
module UART_pll (
	uart_pll_locked_export,
	uart_pll_outclk0_clk,
	uart_pll_refclk_clk,
	uart_pll_reset_reset);	

	output		uart_pll_locked_export;
	output		uart_pll_outclk0_clk;
	input		uart_pll_refclk_clk;
	input		uart_pll_reset_reset;
endmodule
