

library IEEE;
use	IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;


entity UART_pll is	
	port(
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic;        -- outclk0.clk
		locked   : out std_logic         --  locked.export
	);
end entity;



architecture rtl of UART_pll is
	constant clockHalfPeriod : time := 500 ns;
begin

	clock_gen_0 : process is
		begin
			if rst = '0' then
				outclk_0 <= '0' after clockHalfPeriod, '1' after 2*clockHalfPeriod;
			else
				outclk_0 <= '0';
			end if;
			Wait for 2*clockHalfPeriod;
	end process clock_gen_0;
	

end rtl;