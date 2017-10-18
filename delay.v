module delay(clk, ADC_IN, Delay6, Delay5, Delay4, Delay3, Delay2, Delay1);

input [13:0] ADC_IN;
input clk;


output reg [13:0] Delay6;
output reg [13:0] Delay5;
output reg [13:0] Delay4;
output reg [13:0] Delay3;
output reg [13:0] Delay2;
output reg [13:0] Delay1;

always @(posedge clk) begin

	Delay6<=Delay5;
	Delay5<=Delay4;
	Delay4<=Delay3;
	Delay3<=Delay2;
	Delay2<=Delay1;
	Delay1<=ADC_IN;
	
end

endmodule
