//delays the signam by 6 clock ticks. creates a waveform 32 samples long from the delayed waveform
module signalOutWaveform(clk, triggerIn, signal, result, longTrigger, pulseHeight, counter);

input [13:0] signal;
input triggerIn;
input clk;
output reg [13:0] result;
output reg longTrigger;
output reg [10:0] counter=0;


output reg [13:0] pulseHeight;
reg [13:0] tempPulse;
reg [13:0] pedistal=0;

always @(posedge clk) begin

	if(triggerIn==1||(counter!=0)) begin  //if a trigger is recieved, start the counter, and keep counting after trigger = 0
		counter <= counter + 6'b1;
		result = signal;
		longTrigger<=1;
		if(tempPulse<signal)
			tempPulse<=signal;		
	end
	else begin	
		result = 0;
		counter <= 0;		
		pedistal<=signal;
		longTrigger<=0;
		tempPulse<=0;
	end
		
	if(counter==30)
		pulseHeight=tempPulse-pedistal;  //output the pulseheight
	
	if(counter==499)
		counter<=0;
	
	
end



endmodule
