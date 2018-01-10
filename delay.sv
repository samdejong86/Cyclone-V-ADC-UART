module delayVec(clk, ADC_IN, Delay);

input [13:0] ADC_IN;
input clk;


output reg [13:0] Delay [100];

always @(posedge clk) begin

	for(int i = 99; i > 0; i--) begin
		Delay[i]<=Delay[i-1];
	
	end
	Delay[0]<=ADC_IN;

end

endmodule
