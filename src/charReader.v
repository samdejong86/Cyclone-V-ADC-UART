module charReader(clk, UART_RX, char, newChar);

input clk;
input UART_RX;

output reg [7:0] char;
reg [4:0] counter=0;
reg [7:0] intermediateChar;
output reg newChar=0;

always @(posedge clk) begin

	if(UART_RX==0||counter!=0) begin
		counter <= counter+5'b1;
	end
	
	if(counter>=1&&counter<=8) begin
		intermediateChar[counter-1] = UART_RX;
	end
	
	if(counter==8) begin
		char = intermediateChar;
		newChar=1;
		//counter<=0;			
	end

	if(counter==9) begin
		newChar=0;
		counter<=0;
	end
	


end

endmodule
