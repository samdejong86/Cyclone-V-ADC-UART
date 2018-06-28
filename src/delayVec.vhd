--This module generates an array of delayed signals

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.my_types_pkg.all;


entity delayVec is 
	port(
		clk			: in std_logic;
		ADC_IN		: in unsigned (13 DOWNTO 0);
		DelayVec		: out adcArray (0 to 99)
	);
end delayVec;

architecture rtl of delayVec is
	signal localDelay : adcArray (0 to 99);

	
begin
	delayProc : process(clk) is
	begin
		if rising_edge(clk) then
			for I in 1 to 99 loop
				localDelay(I)<=localDelay(I-1); --set each entry equal to the one before it
			end loop;
			localDelay(0)<=ADC_IN;  --the 0th entry has no delay
		end if;
	end process delayProc;
	
DelayVec <= localDelay;

end rtl;