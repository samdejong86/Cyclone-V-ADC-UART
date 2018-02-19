module waveformGenerator(clk, triggerIn, signal, waveform, waveNumber);


input [13:0] signal;
input triggerIn;
input clk;

reg [10:0] counter=0;
output reg [15:0] waveNumber=0;

output reg [13:0] waveform [500];

reg lastTrig=0;

always @(posedge clk) begin

	if((triggerIn==1&&lastTrig==1)||(counter!=0)) begin  //if a trigger is recieved, start the counter, and keep counting after trigger = 0
		counter <= counter + 6'b1;
		waveform[counter] = signal; //fill the waveform
	end
	else begin	
		counter <= 0;
	end

	if(counter==499) begin
		counter<=0;
		waveNumber = waveNumber+1;
	end

	lastTrig=triggerIn;

end


endmodule
