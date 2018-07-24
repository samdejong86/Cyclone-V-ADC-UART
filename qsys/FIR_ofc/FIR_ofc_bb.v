
module FIR_ofc (
	fir_compiler_ii_0_avalon_streaming_sink_data,
	fir_compiler_ii_0_avalon_streaming_sink_valid,
	fir_compiler_ii_0_avalon_streaming_sink_error,
	fir_compiler_ii_0_avalon_streaming_source_data,
	fir_compiler_ii_0_avalon_streaming_source_valid,
	fir_compiler_ii_0_avalon_streaming_source_error,
	fir_compiler_ii_0_clk_clk,
	fir_compiler_ii_0_rst_reset_n);	

	input	[13:0]	fir_compiler_ii_0_avalon_streaming_sink_data;
	input		fir_compiler_ii_0_avalon_streaming_sink_valid;
	input	[1:0]	fir_compiler_ii_0_avalon_streaming_sink_error;
	output	[35:0]	fir_compiler_ii_0_avalon_streaming_source_data;
	output		fir_compiler_ii_0_avalon_streaming_source_valid;
	output	[1:0]	fir_compiler_ii_0_avalon_streaming_source_error;
	input		fir_compiler_ii_0_clk_clk;
	input		fir_compiler_ii_0_rst_reset_n;
endmodule
