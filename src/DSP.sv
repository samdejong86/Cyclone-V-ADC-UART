module DSP(
	input 				sys_clk,
	input 	[13:0]	delayedSignal,
	input					trigger,
	
	output	[13:0]	waveform[1000]
);

wire [13:0] signedSignal;
wire [35:0] OFC_FIR;
wire [13:0] unsignedFIR;

signer Sign(
	.unsign(delayedSignal),
	.sign(signedSignal)	
);

FIR_ofc FIR_filter(
	.clk(sys_clk),
	.reset_n(1'b1),
	.ast_sink_data(signedSignal),
	.ast_sink_valid(1'b1),
	
	.ast_source_data(OFC_FIR),
	.ast_source_ready(1'b1)
);

unsigner unSign(
	.sign(OFC_FIR[33:20]),
	.unsign(unsignedFIR)
);

waveformGenerator FIRwaveGen(
	.clk(sys_clk), 
	.triggerIn(trigger), 
	.signal(unsignedFIR), 
	.waveform(waveform)
	);
	


	
endmodule

