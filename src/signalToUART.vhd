library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;


entity signalToUART is
	port(
		waveform			: in adcArray (0 to 999);
		FIR				: in adcArray (0 to 999);
		waveNumber		: in unsigned (15 downto 0);
		clk				: in std_logic;
		acquire			: in STD_LOGIC_VECTOR (1 downto 0);
	
		UART				: out std_logic
	);
end signalToUART;

architecture rtl of signalToUART is
	
	signal startStop			: std_logic;
	signal done					: std_logic;
	signal waveformCounter2	: unsigned(15 downto 0):=to_unsigned(0,16);
	
	signal bitCounter 			: integer :=0;
	signal waveformCounter 	: integer :=0;
	signal byteCounter			: integer :=0;
	signal whichByte			: integer :=0;
	signal temp				: integer :=0;
	signal waveSample			: unsigned(7 downto 0):=to_unsigned(0,8);
	
begin

	signalToUARTProc : process(clk) is
	begin
		if rising_edge(clk) then
			startstop<='0';
			if ((acquire="01") or (acquire="10")) and not (done = '1') then   --level 1
				if (waveformCounter<1000) then --level 2.1
					waveformCounter2<=to_unsigned(waveformCounter,16);
                                        if(acquire="01") or ((acquire="10") and (waveformCounter<500)) then  
						if (byteCounter=0) then --level 3.1
							UART<='0';
							startStop<='1';
						elsif (byteCounter=9) or (byteCounter=10) or (byteCounter=11) then
							UART<='1';
							startStop<='1';
						elsif (whichByte=0) then
                                                  waveSample <= resize(waveform(waveformCounter)(13 downto 8),8);
                                                  if byteCounter+7<14  then
                                                    UART<=waveform(waveformCounter)(byteCounter+7);
                                                  else
                                                    UART<='0';
                                                  end if;

						elsif (whichByte=1) then
                                                  waveSample<=waveform(waveformCounter)(7 downto 0);
                                                  UART<=waveform(waveformCounter)(byteCounter-1);
						elsif (whichByte=2) then
                                                  waveSample<=waveformCounter2(7 downto 0);
                                                  UART<=waveformCounter2(byteCounter-1);
						else
							UART<='0';
						end if;  --end level 3
					elsif (acquire="10") and (waveformCounter>=500) then --level 3.2
						if (byteCounter=0) then
							UART<='0';
							startStop<='1';
						elsif (byteCounter=9) or (byteCounter=10) or (byteCounter=11) then
							UART<='1';
							startStop<='1';
						elsif (whichByte=0) then
                                                  waveSample <= resize(waveform(waveformCounter)(13 downto 8),8);
                                                  if byteCounter+7<14  then
                                                    UART<=waveform(waveformCounter)(byteCounter+7);
                                                  else
                                                    UART<='0';
                                                  end if;
                                                elsif (whichByte=1) then
                                                  waveSample<=waveform(waveformCounter)(7 downto 0);
                                                  UART<=FIR(waveformCounter-500)(byteCounter-1);
						elsif (whichByte=2) then
                                                  waveSample<=waveformCounter2(7 downto 0);
                                                  UART<=waveformCounter2(byteCounter-1);
						else 
							UART<='0';
						end if; --end level 3.2
					end if;
				elsif (waveformCounter=1000) then
					if (byteCounter=0) then
						UART<='0';
						startStop<='1';
					elsif (byteCounter=9) or (byteCounter=10) or (byteCounter=11) then	
						UART<='1';
						startStop<='1';	
					elsif (whichByte=0) then
						--UART<=waveNumber(byteCounter+7);
					elsif (whichByte=1) then
						--UART<=waveNumber(byteCounter-1);
					end if;
				
				else
					done<='1';	
				end if;
			
				bitCounter<=bitCounter+1;
				waveformCounter<=bitCounter/(36);
				waveformCounter2<=to_unsigned(waveformCounter,16);
				temp <= (bitCounter mod 36);
				byteCounter<= temp mod 12;
				whichByte<=  temp/12;
		
			elsif (acquire="00") then
				done<='0';
				bitCounter<=0;
				waveformCounter<=0;
				byteCounter<=0;
				whichByte<=0;
				UART<='1';
			else
				bitCounter<=0;
				waveformCounter<=0;
				byteCounter<=0;
				whichByte<=0;
				UART<='1';
			end if;
			
			
		
		
		
		end if;
	
	end process signalToUARTProc;





end rtl;
