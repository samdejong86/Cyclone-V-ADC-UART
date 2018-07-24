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

	u0 : component FIR_ofc
		port map (
			fir_compiler_ii_0_avalon_streaming_sink_data    => CONNECTED_TO_fir_compiler_ii_0_avalon_streaming_sink_data,    --   fir_compiler_ii_0_avalon_streaming_sink.data
			fir_compiler_ii_0_avalon_streaming_sink_valid   => CONNECTED_TO_fir_compiler_ii_0_avalon_streaming_sink_valid,   --                                          .valid
			fir_compiler_ii_0_avalon_streaming_sink_error   => CONNECTED_TO_fir_compiler_ii_0_avalon_streaming_sink_error,   --                                          .error
			fir_compiler_ii_0_avalon_streaming_source_data  => CONNECTED_TO_fir_compiler_ii_0_avalon_streaming_source_data,  -- fir_compiler_ii_0_avalon_streaming_source.data
			fir_compiler_ii_0_avalon_streaming_source_valid => CONNECTED_TO_fir_compiler_ii_0_avalon_streaming_source_valid, --                                          .valid
			fir_compiler_ii_0_avalon_streaming_source_error => CONNECTED_TO_fir_compiler_ii_0_avalon_streaming_source_error, --                                          .error
			fir_compiler_ii_0_clk_clk                       => CONNECTED_TO_fir_compiler_ii_0_clk_clk,                       --                     fir_compiler_ii_0_clk.clk
			fir_compiler_ii_0_rst_reset_n                   => CONNECTED_TO_fir_compiler_ii_0_rst_reset_n                    --                     fir_compiler_ii_0_rst.reset_n
		);

