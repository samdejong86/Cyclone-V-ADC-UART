// This module recieves a waveform of 32 14 bit ACS samples, and converts it to a serial format for sending to a PC.
module signalToUART(clk, waveform, FIR, waveNumber, acquire, UART, waveformCounter);

input [13:0] waveform [1000];
input [13:0] FIR [1000];
input [15:0] waveNumber;
input clk;
input [1:0] acquire;
output reg UART;

//some debugging outputs
reg [17:0] bitCounter=0;
output reg [17:0] waveformCounter=0;
reg [17:0] waveformCounter2=0;
reg [17:0] byteCounter=0;
reg [17:0] whichByte;
//reg [13:0] sample;
reg startStop;

reg done;


always @(posedge clk) begin
	startStop=0;
	if((acquire==2'b01||acquire==2'b10)&&done==0) begin		//send the data only when acqire is down and data has not been sent
		if(waveformCounter<1000) begin  //send only 32 samples. 
			//sample=waveform[waveformCounter];  //the current ADC value is a debugging output
			waveformCounter2 = waveformCounter+18'd1;	
		

		
			if(acquire==2'b01||(acquire==2'b10&&waveformCounter<500))begin 
				if(byteCounter==0) begin   	//start bit - serial bitstreams always start with a '0'
					UART=0;	     
					startStop=1;
				end
				else if(byteCounter==9||byteCounter==10||byteCounter==11) begin 					//end bit - serial bitstreams always end with a '1'
					UART=1;
					startStop=1;
				end
			
				else if(whichByte==0) begin
						UART=waveform[waveformCounter][byteCounter+7];  //first byte is bits 8-13 of the ADC value
				end
				else if(whichByte==1) begin
						UART=waveform[waveformCounter][byteCounter-1];  //second byte is bits 0-7 of the ADC value
				end
				else if(whichByte==2) begin
					UART=waveformCounter2[byteCounter-1];				//third byte is the time (or array index)
				end
				else 
					UART=0;
			end
			else if(acquire==2'b10&&waveformCounter>=500) begin
				if(byteCounter==0) begin   	//start bit - serial bitstreams always start with a '0'
					UART=0;	     
					startStop=1;
				end
				else if(byteCounter==9||byteCounter==10||byteCounter==11) begin 					//end bit - serial bitstreams always end with a '1'
					UART=1;
					startStop=1;
				end
			
				else 
				if(whichByte==0) begin
						UART=FIR[waveformCounter-500][byteCounter+7];  //first byte is bits 8-13 of the ADC value
				end
				else if(whichByte==1) begin
						UART=FIR[waveformCounter-500][byteCounter-1];  //second byte is bits 0-7 of the ADC value
				end
				else if(whichByte==2) begin
					UART=waveformCounter2[byteCounter-1];				//third byte is the time (or array index)
				end
				else 
					UART=0;
			end
			
		
		end
		else if(waveformCounter==1000) begin
			if(byteCounter==0) begin   	//start bit - serial bitstreams always start with a '0'
				UART=0;	     
				startStop=1;
			end
			else if(byteCounter==9||byteCounter==10||byteCounter==11) begin 					//end bit - serial bitstreams always end with a '1'
				UART=1;
				startStop=1;
			end
			else if(whichByte==0) begin
						UART=waveNumber[byteCounter+7];;  //first byte is bits 8-13 of the ADC value
			end
			else if(whichByte==1) begin
						UART=waveNumber[byteCounter-1];;  //second byte is bits 0-7 of the ADC value
			end
			
		
		
		end
		
		else 
			done=1;   //the waveform has been sent
			
		bitCounter=bitCounter+11'b1;;					//increment the bit counter
		waveformCounter=bitCounter/(11'd36);		//0-32 - waveform index 7'b11110 = 30  
		byteCounter=(bitCounter%11'd36)%11'd12;  //0-9 - counts the bits in the current byte. 7'b1010=10
		whichByte=bitCounter%11'd36/11'd12;  		//0-2 - counts the bytes in the current waveform.
	end
	else if(acquire==2'b00) begin	//when acqure goes to 1, reset variables
		done=0;
		bitCounter=0;
		waveformCounter=0;
		byteCounter=0;
		whichByte=0;
		UART=1;
	end
	else begin		
		bitCounter=0;
		waveformCounter=0;
		byteCounter=0;
		whichByte=0;
		UART=1;
	end
		
		
end


endmodule 