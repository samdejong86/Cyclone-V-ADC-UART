	component lpm_pll is
		port (
			pll_0_locked_export : out std_logic;        -- export
			pll_0_outclk0_clk   : out std_logic;        -- clk
			pll_0_outclk1_clk   : out std_logic;        -- clk
			pll_0_outclk2_clk   : out std_logic;        -- clk
			pll_0_outclk3_clk   : out std_logic;        -- clk
			pll_0_refclk_clk    : in  std_logic := 'X'; -- clk
			pll_0_reset_reset   : in  std_logic := 'X'  -- reset
		);
	end component lpm_pll;

	u0 : component lpm_pll
		port map (
			pll_0_locked_export => CONNECTED_TO_pll_0_locked_export, --  pll_0_locked.export
			pll_0_outclk0_clk   => CONNECTED_TO_pll_0_outclk0_clk,   -- pll_0_outclk0.clk
			pll_0_outclk1_clk   => CONNECTED_TO_pll_0_outclk1_clk,   -- pll_0_outclk1.clk
			pll_0_outclk2_clk   => CONNECTED_TO_pll_0_outclk2_clk,   -- pll_0_outclk2.clk
			pll_0_outclk3_clk   => CONNECTED_TO_pll_0_outclk3_clk,   -- pll_0_outclk3.clk
			pll_0_refclk_clk    => CONNECTED_TO_pll_0_refclk_clk,    --  pll_0_refclk.clk
			pll_0_reset_reset   => CONNECTED_TO_pll_0_reset_reset    --   pll_0_reset.reset
		);

