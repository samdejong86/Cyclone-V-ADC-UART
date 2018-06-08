module UART_handler(
	input 				clk_50,

	input					UART_RX,
	output				UART_TX,
	
	input		[15:0]	waveNumber,
	
	input		[13:0]	waveform[1000],
	input		[13:0]	FIRwaveform[1000],
	
	output 				delayUART,
	output 				trigSourceUART,
	output 				trigSlopeUART,
	output				acquire

);



wire clk_1MHz;
wire uart_locked;

UART_pll	slowPll(
		.refclk(clk_50),
		.outclk_0(clk_1MHz),
		.locked(uart_locked),
		.rst(1'b0)
);
	

wire [7:0] char;
wire newChar;


charReader readChar(
	.clk(clk_1MHz),
	.UART_RX(UART_RX),
	.char(char),
	.newChar(newChar)
);

reg [7:0] delayChar  = 8'b01100100;       // 'd'
reg [7:0] trigSourceChar = 8'b01110100;	// 't'
reg [7:0] trigSlopeChar = 8'b01110011;		// 's'



flipSwitch   delaySwitchModule(
	.clk(clk_1MHz),
	.char(char),
	.trigChar(delayChar),
	.newChar(newChar),
	.out(delayUART)
);
	
flipSwitch   trigSourceSwitchModule(
	.clk(clk_1MHz),
	.char(char),
	.trigChar(trigSourceChar),
	.newChar(newChar),
	.out(trigSourceUART)
);

flipSwitch   trigSlopeSwitchModule(
	.clk(clk_1MHz),
	.char(char),
	.trigChar(trigSlopeChar),
	.newChar(newChar),
	.out(trigSlopeUART)
);


wire [1:0] acq;

acquireSwitch  acqSwitch(
	.clk(clk_1MHz), 
	.char(char), 
	.newChar(newChar), 
	.wavenum(waveNumber), 
	.acquireWave(acq[0]), 
	.acquireFIR(acq[1])
);

assign acquire = acq[0] || acq[1];

signalToUART signalOut(
	.clk(clk_1MHz), 
	.waveform(waveform), 
	.FIR(FIRwaveform), 
	.waveNumber(waveNumber), 
	.acquire(acq), 
	.UART(UART_TX)
);








endmodule 