module flipSwitch(clk, char, trigChar, newChar, out);

input clk;
input [7:0] char;
input [7:0] trigChar;
input newChar;
output reg out;




always @(posedge clk) begin

	if(char==trigChar&&newChar==1)
		out=1;
	else
		out=0;




end

endmodule
