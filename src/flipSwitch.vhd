library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flipSwitch is
	port(
		clk			: in std_logic;
		char			: in STD_LOGIC_VECTOR (7 DOWNTO 0);
		trigChar		: in STD_LOGIC_VECTOR (7 DOWNTO 0);
		newChar		: in std_logic;
		outSig		: out std_logic
	);
end flipSwitch;

architecture rtl of flipSwitch is

	signal temp : std_logic;
	signal tempOut : std_logic:='0';
	
begin
	flipSwitchProc : process(clk) is
	begin
		if rising_edge(clk) then
			if (char = trigChar) and (newChar='0') then
				temp<='1';
			else
				temp<='0';
			end if;
		end if;
	end process flipSwitchProc;

	flipflop : process(temp) is
	begin
		if rising_edge(temp) then
			tempOut<=not tempOut;
		end if;
	end process flipflop;

	outSig<=tempOut;


end rtl;