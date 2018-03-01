//sets acqure to 1 for 1ms (1000/1MHz) when a character is recieve from UART_RX
module acquireSwitch(UART_RX, clk, wavenum, acquireWave, acquireFIR, counter, lastwavenum, char);

input clk;
input UART_RX;
input [15:0] wavenum;
output reg acquireWave=1;
output reg acquireFIR=1;
output reg [18:0] counter=0;
output reg [15:0] lastwavenum=0;
reg [7:0] intermediateChar;
output reg [7:0] char;


always @(posedge clk) begin

	if(UART_RX==0||counter!=0) begin
		counter <= counter+11'b1;
	end
	

/*
	if((UART_RX==0||counter!=0)&&wavenum!=lastwavenum) begin
		counter <= counter+11'b1;
		acquire=0;
	end
	else 
		acquire=1;
		*/
	
	if(counter>=1&&counter<=8) begin
		intermediateChar[counter-1] = UART_RX;
	end
	if(counter==8) 
		char = intermediateChar;
	
	/*
	if(counter>8&&char==8'b01110111&&wavenum!=lastwavenum) begin
		acquire=0;
	end
	else 
		acquire=1;
	*/
	if(counter>8&&wavenum!=lastwavenum) begin
		if(char==8'b01110111) begin //wave
			acquireWave=0;
			acquireFIR=1;
		end	
		else if(char==8'b01100110) begin
			acquireFIR=0;
			acquireWave=1;
		end
	end
	
	
	if(counter>72170) begin
		counter<=0;
		lastwavenum=wavenum;
		char=0;
		acquireFIR=1;
		acquireWave=1;
	end



end

endmodule
