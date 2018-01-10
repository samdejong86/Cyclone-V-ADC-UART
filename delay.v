module delay(clk, ADC_IN, DelayT, DelayS, DelayR, DelayQ, DelayP, DelayO, DelayN, DelayM, DelayL, DelayK, DelayJ, DelayI, DelayH, DelayG, DelayF, DelayE, DelayD, DelayC, DelayB, DelayA);

input [13:0] ADC_IN;
input clk;


output reg [13:0] DelayT;
output reg [13:0] DelayS;
output reg [13:0] DelayR;
output reg [13:0] DelayQ;
output reg [13:0] DelayP				;
output reg [13:0] DelayO;
output reg [13:0] DelayN;
output reg [13:0] DelayM;
output reg [13:0] DelayL;
output reg [13:0] DelayK;
output reg [13:0] DelayJ;
output reg [13:0] DelayI;
output reg [13:0] DelayH;
output reg [13:0] DelayG;
output reg [13:0] DelayF;
output reg [13:0] DelayE;
output reg [13:0] DelayD;
output reg [13:0] DelayC;
output reg [13:0] DelayB;
output reg [13:0] DelayA;

always @(posedge clk) begin


	DelayT<=DelayS;
	DelayS<=DelayR;
	DelayR<=DelayQ;
	DelayQ<=DelayP;
	DelayP<=DelayO;
	DelayO<=DelayN;
	DelayN<=DelayM;
	DelayM<=DelayL;
	DelayL<=DelayK;
	DelayK<=DelayJ;
	DelayJ<=DelayI;
	DelayI<=DelayH;
	DelayH<=DelayG;
	DelayG<=DelayF;
	DelayF<=DelayE;
	DelayE<=DelayD;
	DelayD<=DelayC;
	DelayC<=DelayB;
	DelayB<=DelayA;
	DelayA<=ADC_IN;
	
end

endmodule
