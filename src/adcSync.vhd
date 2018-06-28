--This module synchronizes the ADC

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adc_sync is
	port(
		sys_clk	: in std_logic;
		DCO		: in std_logic;
		ADCin		: in unsigned (13 DOWNTO 0);
		ADCout	: out unsigned (13 DOWNTO 0)
		);
end adc_sync;

architecture rtl of adc_sync is

	signal per_a2da_d :unsigned (13 DOWNTO 0);


begin

DCOproc : process(DCO) is
	begin
		if rising_edge(DCO) then
			per_a2da_d	<= ADCin;
		end if;
end process DCOproc;

CLKproc : process(sys_clk) is
	begin
		if rising_edge(sys_clk) then
			ADCout	<= per_a2da_d;
		end if;
end process CLKproc;

end rtl;

