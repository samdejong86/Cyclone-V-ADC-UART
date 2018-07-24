library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;

entity ADC2UART_top is
	port(
		clk_50					: in std_logic;
		
		delaySwitch				: in std_logic;
		triggerSlopeSwitch	: in std_logic;
		triggerSwitch			: in std_logic;
		
		AD_SCLK					: out std_logic;
		AD_SDIO					: out std_logic;
		
		ADA_DCO					: in std_logic;
		ADA_OE					: out std_logic;
		ADA_SPI_CS				: out std_logic;
		
		ADB_DCO					: in std_logic;
		ADB_OE					: out std_logic;
		ADB_SPI_CS				: out std_logic;
		
		ADC_DA					: in unsigned 			(13 DOWNTO 0);
		ADC_DB					: in unsigned 			(13 DOWNTO 0);
		
		FPGA_CLK_A_N			: out std_logic;
		FPGA_CLK_A_P			: out std_logic;
		FPGA_CLK_B_N			: out std_logic;
		FPGA_CLK_B_P			: out std_logic;
		

		
		hex0						: out unsigned (6 DOWNTO 0);
		hex1						: out unsigned (6 DOWNTO 0);
		hex2						: out unsigned (6 DOWNTO 0);
		hex3						: out unsigned (6 DOWNTO 0);

		led						: out unsigned (3 DOWNTO 0);
		
		UART_RX					: in std_logic;
		UART_TX					: out std_logic
	);
end ADC2UART_top;

architecture rtl of ADC2UART_top is 

	--adc pll signals
	signal reset_n 						: std_logic;
	signal sys_clk 						: std_logic;
	signal sys_clk_90deg 				: std_logic;
	signal sys_clk_180deg 				: std_logic;
	signal sys_clk_270deg 				: std_logic;
	signal pll_locked 					: std_logic;


	--synced adc signals
	signal ADC_A 							: unsigned (13 DOWNTO 0):=to_unsigned(0, 14);
	signal ADC_B 							: unsigned (13 DOWNTO 0):=to_unsigned(0, 14);	
	
	signal trigSlope						: std_logic:='1';
	signal trigSource						: std_logic:='1';
	signal delay							: std_logic:='0';
	
	signal waveNumber						: unsigned (15 downto 0):=to_unsigned(0, 16);
	signal waveform						: adcArray (0 to 999);
	signal FIRwaveform					: adcArray (0 to 999);
	
	signal trigSlopeUART					: std_logic:='0';
	signal trigSourceUART				: std_logic:='0';
	signal delayUART						: std_logic:='0';
	
	signal acquire							: std_logic:='0';

	component lpm_pll is
        port (
            pll_0_locked_export : out std_logic;        -- export
            pll_0_outclk0_clk   : out std_logic;        -- clk
            pll_0_outclk1_clk   : out std_logic;        -- clk
            pll_0_outclk2_clk   : out std_logic;        -- clk
            pll_0_outclk3_clk   : out std_logic;        -- clk
            pll_0_refclk_clk    : in  std_logic := 'X'; -- clk
            pll_0_reset_reset   : in  std_logic := 'X'  -- reset
        );
    end component lpm_pll;
	
	
begin

	--setup the ADC
	ADA_OE <= '0';
	ADB_OE <= '0';
	AD_SCLK <= '0';
	AD_SDIO <= '1';
	ADA_SPI_CS <= '1';
	ADB_SPI_CS <= '1';

	--apply the ADC clocks
	FPGA_CLK_A_P <=  sys_clk_180deg;
	FPGA_CLK_A_N <= not sys_clk_180deg;
	FPGA_CLK_B_P <=  sys_clk_270deg;
	FPGA_CLK_B_N <= not sys_clk_270deg;	

	reset_n <= '0';


   adc_pll_inst : component lpm_pll
        port map (
            pll_0_locked_export => pll_locked, --  pll_0_locked.export
            pll_0_outclk0_clk   => sys_clk,   -- pll_0_outclk0.clk
            pll_0_outclk1_clk   => sys_clk_90deg,   -- pll_0_outclk1.clk
            pll_0_outclk2_clk   => sys_clk_180deg,   -- pll_0_outclk2.clk
            pll_0_outclk3_clk   => sys_clk_270deg,   -- pll_0_outclk3.clk
            pll_0_refclk_clk    => clk_50,    --  pll_0_refclk.clk
            pll_0_reset_reset   =>  acquire   --   pll_0_reset.reset
        );	

	
	--sync for channel a
	sync_a : entity work.adc_sync PORT MAP (
		sys_clk 		=> sys_clk,
		DCO 			=> ADA_DCO, 
		ADCin 		=> ADC_DA, 
		ADCout 		=> ADC_A	
	);
	
	--sync for channel b
	sync_b : entity work.adc_sync PORT MAP (
		sys_clk 		=> sys_clk,
		DCO 			=> ADB_DCO, 
		ADCin 		=> ADC_DB, 
		ADCout 		=> ADC_B	
	);


	ADC_handle : entity work.ADC_handler PORT MAP (
		sys_clk		=> sys_clk,
		ADC_A			=> ADC_A,
		ADC_B			=> ADC_B,
		trigSlope 	=> trigSlope,
		trigSource 	=> trigSource,
		delay 		=> delay,
		
		waveNumber 	=> waveNumber,
		waveform 	=> waveform,
		FIRwaveform => FIRwaveform		
	);



	UART_handle : entity work.UART_handler PORT MAP(
		clk_50 				=> clk_50,
		UART_RX				=> UART_RX,
		UART_TX 				=> UART_TX,
		
		waveNumber 			=> waveNumber,
		waveform				=> waveform,
		FIRwaveform 		=> FIRwaveform,	
		
		delayUART 			=> delayUART,
		trigSourceUART 	=> trigSourceUART,
		trigSlopeUART 		=> trigSlopeUART,
		acquire 				=> acquire
	);
	
	
	ledCounter : entity work.tenCount PORT MAP (
		clk 		=> sys_clk,
		input 	=> waveNumber,
		output 	=> led
	
	);

	delay <= delayUART or delaySwitch;
	trigSlope <= trigSlopeUART or triggerSlopeSwitch;
	trigSource <= trigSourceUART or triggerSwitch;


	binCounter : entity work.bin2dec PORT MAP (
		clk 		=> sys_clk,
		input 	=> waveNumber,
		d1	=> hex0,
		d2	=> hex1,
		d3	=> hex2,
		d4	=> hex3	
	);

end rtl;













