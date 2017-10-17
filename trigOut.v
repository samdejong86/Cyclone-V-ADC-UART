module trigOut(clk, triggerOut);

input clk;
output reg [13:0] triggerOut;
reg [2:0] count;

always @(posedge clk) begin
	
	if(count==0)
		triggerOut=10000;
	else 
		triggerOut=0;


	count <= count+2'b1;

end

endmodule
