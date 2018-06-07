module delayVec(clk, ADC_IN, DelayVec);

input [13:0] ADC_IN;
input clk;


output reg [13:0] DelayVec [100];

always @(posedge clk) begin

	for(int i = 99; i > 0; i--) begin
		DelayVec[i]<=DelayVec[i-1];
	
	end
	DelayVec[0]<=ADC_IN;

end

endmodule
