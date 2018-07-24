	component UART_pll is
		port (
			uart_pll_locked_export : out std_logic;        -- export
			uart_pll_outclk0_clk   : out std_logic;        -- clk
			uart_pll_refclk_clk    : in  std_logic := 'X'; -- clk
			uart_pll_reset_reset   : in  std_logic := 'X'  -- reset
		);
	end component UART_pll;

	u0 : component UART_pll
		port map (
			uart_pll_locked_export => CONNECTED_TO_uart_pll_locked_export, --  uart_pll_locked.export
			uart_pll_outclk0_clk   => CONNECTED_TO_uart_pll_outclk0_clk,   -- uart_pll_outclk0.clk
			uart_pll_refclk_clk    => CONNECTED_TO_uart_pll_refclk_clk,    --  uart_pll_refclk.clk
			uart_pll_reset_reset   => CONNECTED_TO_uart_pll_reset_reset    --   uart_pll_reset.reset
		);

