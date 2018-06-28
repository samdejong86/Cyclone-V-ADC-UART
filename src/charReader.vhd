library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity charReader is
	port(
		clk		: in std_logic;
		UART_RX	: in std_logic;
		char		: out STD_LOGIC_VECTOR (7 DOWNTO 0);
		newChar	: out std_logic
	);
end charReader;

architecture rtl of charReader is

	signal intermediateChar : STD_LOGIC_VECTOR (7 DOWNTO 0);

begin 

	charReadProc : process(clk) is
	variable counter : natural range 0 to 7 :=0;
	begin
		if rising_edge(clk) then
			if (UART_RX = '0') and not (counter = 0) then
				counter := counter+1;
			end if;
			
			if (counter>=1) and (counter <= 8) then
				intermediateChar(counter-1)<=UART_RX;
			end if;
			
			if counter = 8 then
				char <= intermediateChar;
				newChar<='1';
			else
				newChar<='0';
			end if;
	
		end if;
	
	end process charReadProc;



end rtl;