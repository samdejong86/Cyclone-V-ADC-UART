library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;

library lpm_pll;
use lpm_pll.all;

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
	signal ADC_A 							: unsigned (13 DOWNTO 0);
	signal ADC_B 							: unsigned (13 DOWNTO 0);	
	
	signal trigSlope						: std_logic;
	signal trigSource						: std_logic;
	signal delay							: std_logic;
	
	signal waveNumber						: unsigned (15 downto 0);
	signal waveform						: adcArray (0 to 999);
	signal FIRwaveform					: adcArray (0 to 999);
	
	signal trigSlopeUART					: std_logic;
	signal trigSourceUART				: std_logic;
	signal delayUART						: std_logic;
	
	signal acquire							: std_logic;
	
	
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

	--initialize the adc pll
	adc_pll_inst : entity lpm_pll.lpm_pll PORT MAP (
		refclk 		=>	clk_50,
		outclk_0 	=> sys_clk,
		outclk_1 	=> sys_clk_90deg,
		outclk_2 	=> sys_clk_180deg,
		outclk_3 	=> sys_clk_270deg,
		locked 		=> pll_locked,
		rst 			=> acquire
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




end rtl;













