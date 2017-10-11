//sets acqure to 1 for 1ms (1000/1MHz) when a character is recieve from UART_RX
module acquireSwitch(UART_RX, clk, acquire);

input clk;
input UART_RX;
output reg acquire;
reg [10:0] counter=0;


always @(posedge clk) begin

	if(UART_RX==0||counter!=0) begin
		counter <= counter+1;
		acquire=0;
	end
	else 
		acquire=1;

	if(counter>1000)
		counter<=0;




end

endmodule
