library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;

library UART_pll;
use UART_pll.all;

entity UART_handler is
	port(
		clk_50			: in std_logic;
		UART_RX			: in std_logic;
		UART_TX			: out std_logic;
		
		waveNumber		: in unsigned (15 downto 0);
		waveform 		: in adcArray (0 to 999);
		FIRwaveform 	: in adcArray (0 to 999);
		
		delayUART		: out std_logic;
		trigSourceUART	: out std_logic;
		trigSlopeUART	: out std_logic;
		acquire			: out std_logic:='0'
	);
end UART_handler;

architecture rtl of UART_handler is

	signal clk_1MHz			: std_logic := '0';
	signal uart_locked		: std_logic;
	signal char					: STD_LOGIC_VECTOR (7 downto 0):="00000000";
	signal newChar				: std_logic;
	signal acq					: STD_LOGIC_VECTOR (1 downto 0) :="00";
	
	constant delayChar		: STD_LOGIC_VECTOR (7 DOWNTO 0) := "01100100"; --d
	constant trigSourceChar : STD_LOGIC_VECTOR (7 DOWNTO 0) := "01110100"; --t
	constant trigSlopeChar	: STD_LOGIC_VECTOR (7 DOWNTO 0) := "01110011"; --s

begin

	slowPll : entity UART_pll.UART_pll PORT MAP(
		refclk		=>	clk_50,
		outclk_0		=>	clk_1MHz,
		locked		=>	uart_locked,
		rst			=>	'0'
	);

	readChar : entity work.charReader  PORT MAP(
		clk			=>	clk_1MHz,
		UART_RX		=>	UART_RX,
		char			=>	char,
		newChar		=>	newChar
	);

	

	delaySwitchModule : entity work.flipSwitch PORT MAP(
		clk			=>	clk_1MHz,
		char			=>	char,
		trigChar		=>	delayChar,
		newChar		=>	newChar,
		outSig		=>	delayUART
	);
	
	trigSourceSwitchModule : entity work.flipSwitch PORT MAP(
		clk			=>	clk_1MHz,
		char			=>	char,
		trigChar		=>	trigSourceChar,
		newChar		=>	newChar,
		outSig		=>	trigSourceUART
	);

	trigSlopeSwitchModule : entity work.flipSwitch PORT MAP(
		clk			=>	clk_1MHz,
		char			=>	char,
		trigChar		=>	trigSlopeChar,
		newChar		=>	newChar,
		outSig		=>	trigSlopeUART
	);


	acqSwitch : entity work.acquireSwitch PORT MAP(
		clk				=>	clk_1MHz, 
		char				=>	char, 
		newChar			=>	newChar, 
		wavenum			=>	waveNumber, 
		acquireWave	=>	acq(0), 
		acquireFIR		=>	acq(1)
	);

	acquire <= acq(0) or acq(1);

	
	 signalOut : entity work.signalToUART PORT MAP(
		clk			=>	clk_1MHz, 
		waveform		=>	waveform, 
		FIR			=>	FIRwaveform, 
		waveNumber	=>	waveNumber, 
		acquire		=>	acq, 
		UART			=>	UART_TX
	);
	
	

end rtl;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	