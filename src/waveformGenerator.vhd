--This module generates a waveform

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.my_types_pkg.all;

entity waveformGenerator is
	port(
		signal_in 	: in unsigned (13 DOWNTO 0);
		triggerIn 	: in std_logic;
		clk			: in std_logic;
		waveNumber	: out unsigned (15 DOWNTO 0) :=to_unsigned(0, 16);
		waveform 	: out adcArray (0 to 999)
	);
end waveformGenerator;

architecture rtl of waveformGenerator is

begin
	waveformProc 			: process(clk) is
	variable waveNumBuf 	: unsigned (15 DOWNTO 0) :=to_unsigned(0, 16);
	variable counter 		: natural range 0 to 1000:=0;

	begin

		if rising_edge(clk) then
			if ( triggerIn='1' ) or not (counter = 0) then --start generating a waveform when trigger goes high, continue after the counter is started
				waveform(counter) <= signal_in;
				counter := counter+1;
			else
				counter :=0;
			end if;
			
			if counter=1000 then
				counter :=0;  --reset counter
				waveNumBuf := waveNumBuf + 1 ;  --increment the waveform counter
			end if;
		end if;
		waveNumber<=waveNumBuf;
		
	end process waveformProc;
end rtl;
