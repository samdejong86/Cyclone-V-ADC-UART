module waveformGenerator(clk, triggerIn, signal, waveform, waveNumber);


input [13:0] signal;
input triggerIn;
input clk;

reg [10:0] counter=0;
output reg [15:0] waveNumber=0;

output reg [13:0] waveform [1000];

always @(posedge clk) begin

	if(triggerIn==1||(counter!=0)) begin  //if a trigger is recieved, start the counter, and keep counting after trigger = 0
		counter <= counter + 6'b1;
		waveform[counter] = signal; //fill the waveform
	end
	else begin	
		counter <= 0;
	end

	if(counter==999) begin
		counter<=0;
		waveNumber = waveNumber+15'd1;
	end


end


endmodule
