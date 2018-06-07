module ADC_handler(
	input					sys_clk,
	
	input		[13:0]	ADC_A,
	input		[13:0]	ADC_B,
	
	input					trigSlope,
	input					trigSource,
	input					delay,
	input					acquire,
	
	output	[13:0]	waveform[1000],
	output	[15:0]	waveNumber,
	output	[13:0]	FIRwaveform[1000]
	
	
	
);



wire [13:0] DelayVec [100];

wire [13:0] delayedSignal;
wire [13:0] triggerLevel;
wire [13:0] trigSourceData;


ADC_Mux	delayMux (
	.data0x ( DelayVec[0] ),
	.data1x ( DelayVec[99] ),
	.sel ( delay ),
	.result ( delayedSignal )
	);
	
ADC_Mux	triggerSlopeMux (
	.data0x ( 14'd7000 ),
	.data1x ( 14'd9400 ),
	.sel ( trigSlope ),
	.result ( triggerLevel )
	);
	

wire running;

assign running = (acquire) ? 1'b0 : sys_clk;	
	
	
delayVec delayModule(
	.clk(sys_clk),
	.ADC_IN(ADC_B),
	.DelayVec(DelayVec)
);
	
	
wire [13:0] triggerBus;

ADC_Mux	triggerSourceMux (
	.data0x (ADC_A),
	.data1x (ADC_B),
	.sel ( trigSource ),
	.result ( triggerBus)
	);	
	
trigger trigModule(
	.clk(sys_clk),
	.ADC_IN(triggerBus), 
	.trigSlope(trigSlope), 
	.trigLevel(triggerLevel), 
	.trigger(trigger)
	);	
	
waveformGenerator waveGen(
	.clk(running), 
	.triggerIn(trigger), 
	.signal(delayedSignal), 
	.waveform(waveform), 
	.waveNumber(waveNumber)
	);
	
	

//------------------------------------------------------------------------------------------------
// DSP

wire [13:0] signedSignal;
wire [35:0] OFC_FIR;
wire [13:0] unsignedFIR;

signer Sign(
	.unsign(delayedSignal),
	.sign(signedSignal)	
);

FIR_ofc FIR_filter(
	.clk(sys_clk),
	.reset_n(1),
	.ast_sink_data(signedSignal),
	.ast_sink_valid(1),
	
	.ast_source_data(OFC_FIR),
	.ast_source_valid(1)
);

unsigner unSign(
	.sign(OFC_FIR[33 -: 20]),
	.unsign(unsignedFIR)
);

waveformGenerator FIRwaveGen(
	.clk(running), 
	.triggerIn(trigger), 
	.signal(unsignedFIR), 
	.waveform(FIRwaveform)
	);


	
	
	
endmodule 