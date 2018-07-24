library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--my custom modules
library work;
use work.my_types_pkg.all;

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
	
	signal sinkError			: STD_LOGIC_VECTOR (1 downto 0) :="00";
	
	component FIR_ofc is
        port (
            fir_compiler_ii_0_avalon_streaming_sink_data    : in  std_logic_vector(13 downto 0) := (others => 'X'); -- data
            fir_compiler_ii_0_avalon_streaming_sink_valid   : in  std_logic                     := 'X';             -- valid
            fir_compiler_ii_0_avalon_streaming_sink_error   : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- error
            fir_compiler_ii_0_avalon_streaming_source_data  : out std_logic_vector(35 downto 0);                    -- data
            fir_compiler_ii_0_avalon_streaming_source_valid : out std_logic;                                        -- valid
            fir_compiler_ii_0_avalon_streaming_source_error : out std_logic_vector(1 downto 0);                     -- error
            fir_compiler_ii_0_clk_clk                       : in  std_logic                     := 'X';             -- clk
            fir_compiler_ii_0_rst_reset_n                   : in  std_logic                     := 'X'              -- reset_n
        );
    end component FIR_ofc;

begin

	Sign : entity work.signer PORT MAP (
		unsign=>delayedSignal,
		sign=>signedSignal	
	);

	
	
    FIR_filter : component FIR_ofc
        port map (
            fir_compiler_ii_0_avalon_streaming_sink_data    => std_logic_vector(signedSignal),   
            fir_compiler_ii_0_avalon_streaming_sink_valid   => '1',  
            fir_compiler_ii_0_avalon_streaming_sink_error   => sinkError,
            fir_compiler_ii_0_avalon_streaming_source_data  => OFC_FIR_vec, 
            --fir_compiler_ii_0_avalon_streaming_source_valid => '1', 
            --fir_compiler_ii_0_avalon_streaming_source_error => CONNECTED_TO_fir_compiler_ii_0_avalon_streaming_source_error, 
            fir_compiler_ii_0_clk_clk                       => sys_clk,  
            fir_compiler_ii_0_rst_reset_n                   => '1'      
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