library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;

entity ADC_handler is 
	port(
		sys_clk		: in std_logic;
		ADC_A			: in unsigned (13 DOWNTO 0);
		ADC_B			: in unsigned (13 DOWNTO 0);
		trigSlope 	: in std_logic;
		trigSource 	: in std_logic;
		delay			: in std_logic;
		gpiotrig 	: in std_logic;
	
		waveNumber	: out unsigned (15 DOWNTO 0) :=to_unsigned(0, 16);
		waveform 	: out adcArray (0 to 999);
		FIRwaveform : out adcArray (0 to 999)
	);
end ADC_handler;
	
architecture rtl of ADC_handler is 

	signal trigger					: std_logic;
	signal trigger_self			: std_logic;
	signal trigger_ext			: std_logic;
	signal DelayVec				: adcArray (0 to 99);

	signal delayedSignal			: unsigned (13 DOWNTO 0);
	signal delayedSignal_std	: STD_LOGIC_VECTOR (13 DOWNTO 0);
	
	signal triggerLevel			: unsigned (13 DOWNTO 0);
	signal triggerLevel_std		: STD_LOGIC_VECTOR (13 DOWNTO 0);
	
	--negative and positive trigger thresholds
	constant negVal 				: STD_LOGIC_VECTOR (13 DOWNTO 0) := "01101101011000";
	constant posVal 				: STD_LOGIC_VECTOR (13 DOWNTO 0) := "10010010111000";


begin

	delayMux : entity work.ADC_Mux PORT MAP (
		data0x   => std_logic_vector(DelayVec(0)),
      data1x   => std_logic_vector(DelayVec(99)),
      sel      => delay,
      result   => delayedSignal_std
   );
	
	

	triggerSlopeMux : entity work.ADC_Mux PORT MAP (
		data0x   => std_logic_vector(negVal),
		data1x   => std_logic_vector(posVal),
		sel      => trigSlope,
		result   => triggerLevel_std
   );

	triggerLevel <= unsigned(triggerLevel_std);
	delayedSignal <= unsigned(delayedSignal_std);
	
	
	
	--create a vector of delayed signals
	delayModule : entity work.delayVec PORT MAP (
		clk 				=> sys_clk,
		ADC_IN 			=> ADC_B,
		DelayVec			=> DelayVec
	);
	
	
	trigBusModule : entity work.trigger_bus PORT MAP (
		clk 				=> sys_clk,
		ADC_IN 			=> unsigned(ADC_B), 
		trigSlope 		=> trigSlope, 
		trigLevel 		=> triggerLevel, 
		trigger 			=> trigger_self
	);
	
	trigModule : entity work.trigger PORT MAP (
		clk 				=> sys_clk,
		trig_in 			=> gpiotrig, 
		trigSlope 		=> trigSlope, 
		trigger 			=> trigger_ext
	);
	
	trigger <= trigger_self when trigSource = '0' else trigger_ext;
	
	
	--generate a waveform
	waveGen : entity work.waveformGenerator PORT MAP (
		clk 				=> sys_clk, 
		triggerIn 		=> trigger, 
		signal_in 		=> delayedSignal, 
		waveform 		=> waveform, 
		waveNumber 		=> waveNumber
	);
	
	

------------------------------------------------------------------------------------------------
--DSP

	DSP_handle : entity work.DSP PORT MAP (
		sys_clk			=>	sys_clk,
		delayedSignal	=>	delayedSignal,
		trigger			=>	trigger,	
		waveform			=>	FIRwaveform
);




end rtl;