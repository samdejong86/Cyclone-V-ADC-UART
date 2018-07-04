library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;

library FIR_ofc;
use FIR_ofc.all;


entity DSP is
	port(
		sys_clk			: in std_logic;
		delayedSignal	: in unsigned (13 downto 0);
		trigger			: in std_logic;
		waveform			: out adcArray (0 to 999)
	);
end DSP;

architecture rtl of DSP is

	signal unsignedFIR		: unsigned (13 downto 0);
	signal signedSignal		: signed (13 downto 0);
	signal OFC_FIR_vec		: STD_LOGIC_VECTOR (35 downto 0);
	signal OFC_FIR				: signed (35 downto 0);

begin

	Sign : entity work.signer PORT MAP (
		unsign=>delayedSignal,
		sign=>signedSignal	
	);

	FIR_filter : entity FIR_ofc.FIR_ofc PORT MAP (
		clk=>sys_clk,
		reset_n=>'1',
		ast_sink_data=>std_logic_vector(signedSignal),
		ast_sink_valid=>'1',
	
		ast_source_data=>OFC_FIR_vec,
		ast_source_ready=>'1'
	);

	OFC_FIR <= signed(OFC_FIR_vec);
	
	unSign : entity work.unsigner PORT MAP (
		sign=>OFC_FIR(33 downto 20),
		unsign=>unsignedFIR
	);

	FIRwaveGen : entity work.waveformGenerator PORT MAP (
		clk=>sys_clk, 
		triggerIn=>trigger, 
		signal_in=>unsignedFIR, 
		waveform=>waveform
	);
	

end rtl;