module ADC2UART_top(
	
	input					clk_50,
	
	input 				delaySwitch,
	input 				triggerSlopeSwitch,
	input 				triggerSwitch,
	
	output 				AD_SCLK,
	output 				AD_SDIO,
	
	input 				ADA_DCO,
	output 				ADA_OE,
	output				ADA_SPI_CS,
	
	input 				ADB_DCO,
	output 				ADB_OE,
	output				ADB_SPI_CS,	
	
	input		[13:0]	ADC_DA,
	input		[13:0]	ADC_DB,
	

	output				FPGA_CLK_A_N,
	output				FPGA_CLK_A_P,
	output				FPGA_CLK_B_N,
	output				FPGA_CLK_B_P,
	
	output	[6:0]		hex0,
	output	[6:0]		hex1,
	output	[6:0]		hex2,
	output	[6:0]		hex3,
	
	output	[3:0]		led,
	
	input					UART_RX,
	output				UART_TX
	
	
	);
	
	
	assign ADA_OE = 1'b0;
	assign ADB_OE = 1'b0;
	assign AD_SCLK = 1'b0;
	assign AD_SDIO = 1'b1;
	assign ADA_SPI_CS = 1'b1;
	assign ADB_SPI_CS = 1'b1;
	
wire						      reset_n;
wire						      sys_clk;
wire						      sys_clk_90deg;
wire						      sys_clk_180deg;
wire						      sys_clk_270deg;
wire						      pll_locked;		
	
	

assign	FPGA_CLK_A_P	=  sys_clk_180deg;
assign	FPGA_CLK_A_N	= ~sys_clk_180deg;
assign	FPGA_CLK_B_P	=  sys_clk_270deg;
assign	FPGA_CLK_B_N	= ~sys_clk_270deg;	

//assign reset_n = 1'b0;	
	
wire acquire;
	
lpm_pll	adc_pll(
		.refclk(clk_50),
		.outclk_0(sys_clk),
		.outclk_1(sys_clk_90deg),
		.outclk_2(sys_clk_180deg),
		.outclk_3(sys_clk_270deg),
		.locked(pll_locked),
		.rst(acquire)
);
			
	
wire			[13:0]			ADC_A;
wire			[13:0]			ADC_B;		
				
		
adcSync sync_a(
	.sys_clk(sys_clk), 
	.DCO(ADA_DCO), 
	.ADCin(ADC_DA), 
	.ADCout(ADC_A)
);		
	
adcSync sync_b(
	.sys_clk(sys_clk), 
	.DCO(ADB_DCO), 
	.ADCin(ADC_DB), 
	.ADCout(ADC_B)
);			
	
	
//------------------------------------------------------------------------------------------------	
	

wire [13:0] waveform [1000];
wire [13:0] FIRwaveform[1000];
wire [15:0] waveNumber;

wire trigSlope;
wire trigSource;
wire delay;

ADC_handler ADC_handle(
	.sys_clk(sys_clk),
	
	.ADC_A(ADC_A),
	.ADC_B(ADC_B),
	
	.trigSlope(trigSlope),
	.trigSource(trigSource),
	.delay(delay),
	//.acquire(acquire),
	
	.waveform(waveform),
	.waveNumber(waveNumber),
	.FIRwaveform(FIRwaveform)
);	



//------------------------------------------------------------------------------------------------
// UART control

wire delayUART;
wire trigSourceUART;
wire trigSlopeUART;

UART_handler UART_handle(
	.clk_50(clk_50),

	.UART_RX(UART_RX),
	.UART_TX(UART_TX),
	
	.waveNumber(waveNumber),
	
	.waveform(waveform),
	.FIRwaveform(FIRwaveform),
	
	.delayUART(delayUART),
	.trigSourceUART(trigSourceUART),
	.trigSlopeUART(trigSlopeUART),
	.acquire(acquire)	
);
	
	
assign delay = delaySwitch || delayUART;
assign trigSlope = triggerSlopeSwitch || trigSlopeUART;
assign trigSource = triggerSwitch || trigSourceUART;	

	
//------------------------------------------------------------------------------------------------
// seven segment counter control	

bin2dec sevenSegCounter(
	.clk(sys_clk),
	.in(waveNumber),
	.d1(hex0),
	.d2(hex1),
	.d3(hex2),
	.d4(hex3)
);
	
tenCount legCounter(
	.clk(sys_clk),
	.in(waveNumber),
	.out(led)
);
	
	
endmodule 	
	
