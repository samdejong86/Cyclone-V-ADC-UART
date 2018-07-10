

library IEEE;
use	IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;


entity lpm_pll is	
	port(
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic :='1';        -- outclk0.clk
		outclk_1 : out std_logic :='1';        -- outclk1.clk
		outclk_2 : out std_logic :='1';        -- outclk2.clk
		outclk_3 : out std_logic :='1';        -- outclk3.clk
		locked   : out std_logic         --  locked.export
	);
end entity;


architecture rtl of lpm_pll is
	constant clockHalfPeriod : time := 20 ns;
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

	clock_gen_1 : process is
		begin	
			Wait for 0.5*clockHalfPeriod;
			if rst = '0' then
				outclk_1 <= '0' after clockHalfPeriod, '1' after 2*clockHalfPeriod;
			else
				outclk_1 <= '0';
			end if;
			Wait for 1.5*clockHalfPeriod;
	end process clock_gen_1;

	clock_gen_2 : process is
		begin	
			Wait for 1*clockHalfPeriod;
			if rst = '0' then
				outclk_2 <= '0' after clockHalfPeriod, '1' after 2*clockHalfPeriod;
			else
				outclk_2 <= '0';
			end if;
			Wait for 1*clockHalfPeriod;
	end process clock_gen_2;

	clock_gen_3 : process is
		begin	
			Wait for 1.5*clockHalfPeriod;
			if rst = '0' then
				outclk_3 <= '0' after clockHalfPeriod, '1' after 2*clockHalfPeriod;
			else
				outclk_3 <= '0';
			end if;
			Wait for 0.5*clockHalfPeriod;
	end process clock_gen_3;



end rtl;