//triggers when ADC_IN is above a set value
module trigger(ADC_IN, trigSlope, trigLevel, trigger, outPulse);

input		    [13:0]		ADC_IN;
input							trigSlope;
input		    [13:0]		trigLevel;
output reg 	 [13:0]		outPulse;
output reg		 			trigger;

//assign ADC_DB = ADC_IN;

always @(ADC_IN) begin
	//positive trigger
	if(trigSlope == 1) begin
		if(ADC_IN>trigLevel) begin
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
		if(ADC_IN<trigLevel) begin
			trigger <= 1;
			outPulse = (ADC_IN-14'd8000)*14'd10;
		end
	
		else begin
			trigger <= 0;
			outPulse = 0;
		end
	
	end
	
	

end
endmodule
