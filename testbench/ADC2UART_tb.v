`timescale 1 ns / 100 ps

module ADC2UART_tb();

	reg 				clk_50;
	
	reg 				delaySwitch;
	reg 				triggerSlopeSwitch;
	reg 				triggerSwitch;
	
	wire 				AD_SCLK;
	wire 				AD_SDIO;
	
	reg 				ADA_DCO;
	wire 				ADA_OE;
	wire				ADA_SPI_CS;
	
	reg 				ADB_DCO;
	wire 				ADB_OE;
	wire				ADB_SPI_CS;	
	
	reg		[13:0]	ADC_DA;
	reg		[13:0]	ADC_DB;
	

	wire				FPGA_CLK_A_N;
	wire				FPGA_CLK_A_P;
	wire				FPGA_CLK_B_N;
	wire				FPGA_CLK_B_P;
	
	wire	[6:0]		hex0;
	wire	[6:0]		hex1;
	wire	[6:0]		hex2;
	wire	[6:0]		hex3;
	
	wire	[3:0]		led;
	
	reg				UART_RX;
	wire				UART_TX;
	
	
ADC2UART_top ADC2UART(
	.clk_50(clk_50),
	
	.delaySwitch(delaySwitch),
	.triggerSlopeSwitch(triggerSlopeSwitch),
	.triggerSwitch(triggerSwitch),
	
	.AD_SCLK(AD_SCLK),
	.AD_SDIO(AD_SDIO),
	
	.ADA_DCO(ADA_DCO),
	.ADA_OE(ADA_OE),
	.ADA_SPI_CS(ADA_SPI_CS),
	
	.ADB_DCO(ADB_DCO),
	.ADB_OE(ADB_OE),
	.ADB_SPI_CS(ADB_SPI_CS),	
	
	.ADC_DA(ADC_DA),
	.ADC_DB(ADC_DB),
	

	.FPGA_CLK_A_N(FPGA_CLK_A_N),
	.FPGA_CLK_A_P(FPGA_CLK_A_P),
	.FPGA_CLK_B_N(FPGA_CLK_B_N),
	.FPGA_CLK_B_P(FPGA_CLK_B_P),
	
	.hex0(hex0),
	.hex1(hex1),
	.hex2(hex2),
	.hex3(hex3),
	
	.led(led),
	
	.UART_RX(UART_RX),
	.UART_TX(UART_TX)	
);
	
//assign ADA_DCO = FPGA_CLK_A_N;
//assign ADB_DCO = FPGA_CLK_B_N;
	
always
	#10 clk_50 = ~clk_50;

always
begin
	#12.5 ADA_DCO = ~ADA_DCO;
	ADB_DCO = ~ADB_DCO;
end
	
	
initial
begin
	clk_50=1'b0;	
	ADA_DCO=1'b0;
	ADB_DCO=1'b0;

	ADC_DB=14'd8054;
	ADC_DA=14'd0;

	delaySwitch=1'b0;
	triggerSlopeSwitch=1'b0;
	triggerSwitch=1'b0;

	UART_RX=1'b1;
	
	@(posedge clk_50);
#25 ADC_DB=14'd8062;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8051;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8042;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8070;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8053;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8050;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8055;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8072;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8062;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8050;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8072;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8073;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8056;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8051;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8061;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8063;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8078;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8079;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8067;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd11054;
ADC_DA=14'd16383;

@(posedge clk_50);
#25 ADC_DB=14'd13843;
ADC_DA=14'd16383;

@(posedge clk_50);
#25 ADC_DB=14'd11721;
ADC_DA=14'd16383;

@(posedge clk_50);
#25 ADC_DB=14'd9367;
ADC_DA=14'd16383;

@(posedge clk_50);
#25 ADC_DB=14'd8148;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7690;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7545;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7456;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7443;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7439;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7477;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7495;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7518;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7561;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7591;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7636;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7655;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7652;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7700;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7711;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7727;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7749;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7770;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7799;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7780;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7812;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7828;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7841;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7848;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7872;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7887;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7894;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7916;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7919;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7931;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7945;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7959;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7948;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8003;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd7998;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8006;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8020;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8040;
ADC_DA=14'd0;

@(posedge clk_50);
#25 ADC_DB=14'd8043;
ADC_DA=14'd0;

      
        #10             
        $display($time, "<< Simulation Complete >>");
        $stop;
        

	
end

endmodule	
	
	
	
	
	
	
	
	
	