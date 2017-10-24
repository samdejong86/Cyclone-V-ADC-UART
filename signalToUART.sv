// This module recieves a waveform of 32 14 bit ACS samples, and converts it to a serial format for sending to a PC.
module signalToUART(clk, waveform, acquire, UART, startStop, bitCounter, waveformCounter, byteCounter, whichByte, sample);

input [13:0] waveform [64];
input clk;
input acquire;
output reg UART;

//some debugging outputs
output reg [10:0] bitCounter=0;
output reg [10:0] waveformCounter=0;
output reg [10:0] byteCounter=0;
output reg [10:0] whichByte;
output reg [13:0] sample;
output reg startStop;

reg done;


always @(posedge clk) begin
	startStop=0;
	if(acquire==0&&done==0) begin		//send the data only when acqire is down and data has not been sent
		if(waveformCounter<64) begin  //send only 32 samples. 
			sample=waveform[waveformCounter];  //the current ADC value is a debugging output
		
			if(byteCounter==0&&bitCounter!=0) begin   	//start bit - serial bitstreams always start with a '0'
				UART=0;	     
				startStop=1;
			end
			else if(byteCounter==9) begin 					//end bit - serial bitstreams always end with a '1'
				UART=1;
				startStop=1;
			end
		
			//sending 3 bytes:
			else if(whichByte==0) begin
					if(byteCounter>6)
						UART=0;
					else
						UART=waveform[waveformCounter][byteCounter+7];  //first byte is bits 8-13 of the ADC value
			end
			else if(whichByte==1)
					UART=waveform[waveformCounter][byteCounter-1];  //second byte is bits 0-7 of the ADC value
			else if(whichByte==2) begin                           
				UART=waveformCounter[byteCounter-1];				//third byte is the time (or array index)
			end
			else 
				UART=0;
		
		end
			
		
		else 
			done=1;   //the waveform has been sent
			
		bitCounter<=bitCounter+11'b1;;					//increment the bit counter
		waveformCounter<=bitCounter/(11'd30);		//0-32 - waveform index 7'b11110 = 30  
		byteCounter<=(bitCounter%11'd30)%11'd10;  //0-9 - counts the bits in the current byte. 7'b1010=10
		whichByte<=bitCounter%11'd30/11'd10;  		//0-2 - counts the bytes in the current waveform.
	end
	else if(acquire==1) begin	//when acqure goes to 1, reset variables
		done=0;
		bitCounter<=0;
		waveformCounter<=0;
		byteCounter<=0;
		whichByte<=0;
		UART=1;
	end
	else begin		
		bitCounter<=0;
		waveformCounter<=0;
		byteCounter<=0;
		whichByte<=0;
		UART=1;
	end
		
		
end


endmodule 