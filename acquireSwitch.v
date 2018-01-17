//sets acqure to 1 for 1ms (1000/1MHz) when a character is recieve from UART_RX
module acquireSwitch(UART_RX, clk, wavenum, acquire, counter, lastwavenum);

input clk;
input UART_RX;
input [15:0] wavenum;
output reg acquire;
output reg [18:0] counter=0;
output reg [15:0] lastwavenum=0;


always @(posedge clk) begin

	if((UART_RX==0||counter!=0)&&wavenum!=lastwavenum) begin
		counter <= counter+11'b1;
		acquire=0;
	end
	else 
		acquire=1;
	
	if(counter>18040) begin
		counter<=0;
		lastwavenum=wavenum;
	end



end

endmodule
