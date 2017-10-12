//delays the signam by 6 clock ticks. creates a waveform 32 samples long from the delayed waveform
module signalOutWaveform(clk, ADC_IN, triggerIn, result, longTrigger, pulseHeight, waveform);

input [13:0] ADC_IN;
input triggerIn;
input clk;
output reg [13:0] result;
output reg longTrigger;
reg [5:0] counter=0;

reg [13:0] Delay0;
reg [13:0] Delay1;
reg [13:0] Delay2;
reg [13:0] Delay3;
reg [13:0] Delay4;
reg [13:0] Delay5;

output reg [31:0] pulseHeight;
reg [13:0] tempPulse;
reg [13:0] pedistal;

output reg [13:0] waveform [32];



always @(posedge clk) begin

	//delays the signal by 6 clock ticks
	Delay0<=Delay1;
	Delay1<=Delay2;
	Delay2<=Delay3;
	Delay3<=Delay4;
	Delay4<=Delay5;
	Delay5<=ADC_IN;


	if(triggerIn==1||(counter!=0)) begin  //if a trigger is recieved, start the counter, and keep counting after trigger = 0
		counter <= counter + 6'b1;
		result = Delay0;
		waveform[counter] = Delay0; //fill the waveform
	end
	else begin	
		result = 0;
		counter <= 0;
	end
	
	
	if(triggerIn==1||counter!=0) //output from when the trigger goes to 1 to when the counter resets to 0
		longTrigger<=1;
	else
		longTrigger<=0;
		
	if(longTrigger==0)begin //get the pedistal
		tempPulse<=0;
		pedistal<=Delay0;
	end
	else begin  //get the highest sample in the long trigger window
		if(tempPulse<Delay0)
			tempPulse<=Delay0;
	end

	
	if(counter==30)
		pulseHeight=tempPulse-pedistal;  //output the pulseheight
	
	if(counter==31)
		counter<=0;
	
	
end



endmodule
