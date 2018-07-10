library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;


entity acquireSwitch is
	port(
		clk			: in std_logic;
		char			: in STD_LOGIC_VECTOR (7 downto 0);
		newChar		: in std_logic;
		wavenum		: in unsigned (15 downto 0);
		
		acquireWave : out std_logic:='0';
		acquireFIR	: out std_logic:='0'
	);
end acquireSwitch;
		
architecture rtl of acquireSwitch is

	signal lastwavenum : unsigned(15 downto 0):=to_unsigned(99, 16);

begin

	acquireProc : process(clk) is
	variable counter 		: natural range 0 to 36049:=0;
	begin
		if rising_edge(clk) then
			if (newChar='1') or not (counter=0) then
				counter:=counter+1;
			end if;
			
			if not (counter=0) and (counter < 36049) and not (wavenum = lastwavenum) then
				if (char="01110111") then
					acquireWave<='1';
					acquireFIR<='0';
				elsif (char = "01101001") then
					acquireWave<='0';
					acquireFIR<='1';
				end if;				
			end if;
	
			if (counter >=36049) then
				counter:=0;
				lastwavenum<=wavenum;
				acquireFIR<='0';
				acquireWave<='0';
			
			end if;
		
			
		end if;
	end process acquireProc;





end rtl;
