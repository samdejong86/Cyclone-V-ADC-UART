library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;


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
	
	component UART_pll is
        port (
            uart_pll_locked_export : out std_logic;        -- export
            uart_pll_outclk0_clk   : out std_logic;        -- clk
            uart_pll_refclk_clk    : in  std_logic := 'X'; -- clk
            uart_pll_reset_reset   : in  std_logic := 'X'  -- reset
        );
    end component UART_pll;

begin

	slowPll : component UART_pll
		port map (
			uart_pll_locked_export => uart_locked, --  uart_pll_locked.export
         uart_pll_outclk0_clk   => clk_1MHz,   -- uart_pll_outclk0.clk
         uart_pll_refclk_clk    => clk_50,    --  uart_pll_refclk.clk
         uart_pll_reset_reset   => '0'    --   uart_pll_reset.reset
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	