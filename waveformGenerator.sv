module waveformGenerator(clk, triggerIn, signal, waveform);


input [13:0] signal;
input triggerIn;
input clk;

reg [5:0] counter=0;

output reg [13:0] waveform [32];

always @(posedge clk) begin

	if(triggerIn==1||(counter!=0)) begin  //if a trigger is recieved, start the counter, and keep counting after trigger = 0
		counter <= counter + 6'b1;
		waveform[counter] = signal; //fill the waveform
	end
	else begin	
		counter <= 0;
	end

	if(counter==31)
		counter<=0;



end


endmodule
