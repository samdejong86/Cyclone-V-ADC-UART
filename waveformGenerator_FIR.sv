module FIRwaveformGenerator(clk, triggerIn, FIR, FIRwaveform, FIRwaveNumber);


input [13:0] FIR;
input triggerIn;
input clk;

reg [10:0] counter=0;
output reg [15:0] FIRwaveNumber=0;

output reg [13:0] FIRwaveform [500];

always @(posedge clk) begin

	if(triggerIn==1||(counter!=0)) begin  //if a trigger is recieved, start the counter, and keep counting after trigger = 0
		counter <= counter + 6'b1;
		
		if(counter<=499) begin
			FIRwaveform[counter] = FIR+14'b10000000000000;
		end
	end
	else begin	
		counter <= 0;
	end

	if(counter==499) begin
		counter<=0;
		FIRwaveNumber = FIRwaveNumber+15'd1;
	end


end


endmodule
