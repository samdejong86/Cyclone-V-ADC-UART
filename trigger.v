//triggers when ADC_IN is above a set value
module trigger(ADC_IN, trigger, outPulse);

input		    [13:0]		ADC_IN;
output		 [13:0]		outPulse;
reg			 [13:0]     outPulse;

output		 trigger;
reg 			 trigger;
reg [31:0] multiplier = 10;

//assign ADC_DB = ADC_IN;

always @(ADC_IN) begin
	
	if(ADC_IN>8190) begin
		trigger <= 1;
		outPulse = (ADC_IN-8000)*multiplier;
	end
	
	else begin
		trigger <= 0;
		outPulse = 0;
	end
end
endmodule
