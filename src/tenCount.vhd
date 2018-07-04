library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tenCount is
	port(
		clk		: in std_logic;
		input		: in unsigned (15 downto 0);
		output	: out unsigned (3 downto 0)
	);
end tenCount;

architecture rtl of tenCount is

	signal intermed : unsigned (15 downto 0);

begin

	tenProc : process(clk) is
	begin
		if rising_edge(clk) then
			intermed <= input mod 10;
			output <= intermed(3 downto 0);
		end if;	
	end process tenProc;



end rtl;