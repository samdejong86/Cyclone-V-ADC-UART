//sets acqure to 1 for 1ms (1000/1MHz) when a character is recieve from UART_RX
module acquireSwitch(clk, char, newChar, wavenum, acquireWave, acquireFIR);

input clk;
input [7:0] char;
input newChar;

input [15:0] wavenum;
output reg acquireWave=0;
output reg acquireFIR=0;
reg [18:0] counter=0;
reg [15:0] lastwavenum=0;


always @(posedge clk) begin

	if(newChar==1||counter!=0) begin
		counter <= counter+11'b1;
		
	end
	
	if(counter!=0&&counter<36049&&wavenum!=lastwavenum) begin
		if(char==8'b01110111) begin //wave
			acquireWave=1;
			acquireFIR=0;
		end	
		else if(char==8'b01101001) begin //wave and FIR
			acquireFIR=1;
			acquireWave=0;
		end
	end
	
	
	if(counter>=36049) begin
		counter<=0;
		lastwavenum=wavenum;
		acquireFIR=0;
		acquireWave=0;
	
	end
	

	
	/*
	
	if(counter>8&&wavenum!=lastwavenum) begin
		if(char==8'b01110111) begin //wave
			acquireWave=0;
			acquireFIR=1;
		end	
		else if(char==8'b01101001) begin //wave and FIR
			acquireFIR=0;
			acquireWave=1;
		end
	end
	
	
	if(counter>36049) begin
	end
*/


end

endmodule
