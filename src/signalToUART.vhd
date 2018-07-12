library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;


entity signalToUART is
	port(
		waveform		: in adcArray (0 to 999);
		FIR			: in adcArray (0 to 999);
		waveNumber		: in unsigned (15 downto 0);
		clk			: in std_logic;
		acquire			: in STD_LOGIC_VECTOR (1 downto 0);
	
		UART			: out std_logic
	);
end signalToUART;

architecture rtl of signalToUART is
	
	signal startStop			: std_logic;
	signal done				: std_logic;
	signal waveformCounter2	                : unsigned(15 downto 0):=to_unsigned(0,16);
	
	signal bitCounter 			: integer :=0;
	signal waveformCounter 	                : integer :=0;
	signal byteCounter			: integer :=0;
	signal whichByte			: integer :=9999;
	signal temp				: integer :=0;
	signal waveSample			: unsigned(7 downto 0):=to_unsigned(0,8);
	
begin

  chooseByte : process(clk) is
  begin
    if rising_edge(clk) then
      if ((acquire="01") or (acquire="10")) and not (done = '1') then   
        if (waveformCounter<1000) then 
          waveformCounter2<=to_unsigned(waveformCounter,16);
          --regular waveform and first half of FIR
          if(acquire="01") or ((acquire="10") and (waveformCounter<500)) then
            if (whichByte=0) then
              waveSample <= resize(waveform(waveformCounter)(13 downto 8),8);
            elsif (whichByte=1) then
              waveSample<=waveform(waveformCounter)(7 downto 0);
            elsif (whichByte=2) then
              waveSample<=waveformCounter2(7 downto 0);
            end if;  
          --second half of FIR
          elsif (acquire="10") and (waveformCounter>=500) then
            if (whichByte=0) then
              waveSample <= resize(FIR(waveformCounter)(13 downto 8),8);
            elsif (whichByte=1) then
              waveSample<=FIR(waveformCounter)(7 downto 0);
            elsif (whichByte=2) then
              waveSample<=waveformCounter2(7 downto 0);
            end if; 
          end if;
        --wave number
        elsif (waveformCounter=1000) then
          if (whichByte=0) then
            waveSample<=waveNumber(15 downto 8);
          elsif (whichByte=1) then
            waveSample<=waveNumber(7 downto 0);
          end if;
          
        else
          done<='1';	
        end if;
        
        bitCounter<=bitCounter+1;
        waveformCounter<=bitCounter/(30);
        waveformCounter2<=to_unsigned(waveformCounter,16);
        temp <= (bitCounter mod 30);
        byteCounter<= temp mod 10;
        whichByte<=  temp/10; 
        
      elsif (acquire="00") then
        done<='0';
        bitCounter<=0;
        waveformCounter<=0;
        byteCounter<=0;
        whichByte<=9999;
      else
        bitCounter<=0;
        waveformCounter<=0;
        byteCounter<=0;
        whichByte<=9999;
      end if;
      
		
    end if;
	
  end process chooseByte;


  sendByte : process(clk) is
  begin
    if rising_edge(clk) then 
      if ((acquire="01") or (acquire="10")) then
        --if byteCounter = 0 or byteCounter = 10 or byteCounter=11 then
        --  UART<='1';
        --els
		  if byteCounter = 1 and not (bitCounter = 1) then 
          UART<='0';
        elsif byteCounter >= 2 and byteCounter <= 9 then
          UART<=waveSample(byteCounter-2);
		  else 
			 UART<='1';
        end if;
      else
        UART<='1';
      end if;
      
    end if;
  end process sendByte;



end rtl;
