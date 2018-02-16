//triggers when ADC_IN is above a set value
module trigger(clk,ADC_IN, trigSlope, trigLevel, trigger, outPulse, lastVal);

input							clk;
input		    [13:0]		ADC_IN;
input							trigSlope;
input		    [13:0]		trigLevel;
output reg 	 [13:0]		outPulse;
output reg		 			trigger;
output reg	 [13:0]		lastVal=0;

//assign ADC_DB = ADC_IN;

always @(posedge clk) begin
	//positive trigger
	if(trigSlope == 1) begin
		if(ADC_IN>trigLevel&&ADC_IN>lastVal) begin
			trigger <= 1;
			outPulse = (ADC_IN-14'd8000)*14'd10;
		end
	
		else begin
			trigger <= 0;
			outPulse = 0;
		end
	end
	//negative trigger
	else if(trigSlope == 0) begin
		if(ADC_IN<trigLevel&&ADC_IN<lastVal) begin
			trigger <= 1;
			outPulse = (ADC_IN-14'd8000)*14'd10;
		end
	
		else begin
			trigger <= 0;
			outPulse = 0;
		end
	
	end
	
	
	lastVal<=ADC_IN;
end
endmodule
