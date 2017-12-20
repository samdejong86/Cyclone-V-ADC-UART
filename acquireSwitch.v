//sets acqure to 1 for 1ms (1000/1MHz) when a character is recieve from UART_RX
module acquireSwitch(UART_RX, clk, acquire, counter);

input clk;
input UART_RX;
output reg acquire;
output reg [18:0] counter=0;


always @(posedge clk) begin

	if(UART_RX==0||counter!=0) begin
		counter <= counter+11'b1;
		acquire=0;
	end
	else 
		acquire=1;
	
	if(counter>18040)
		counter<=0;




end

endmodule
