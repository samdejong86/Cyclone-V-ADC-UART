module flipSwitch(clk, char, trigChar, newChar, out);

input clk;
input [7:0] char;
input [7:0] trigChar;
input newChar;

reg temp;

output reg out;




always @(posedge clk) begin

	if(char==trigChar&&newChar==1)
		temp=1;
	else
		temp=0;
end

always @(posedge temp) begin

	out=~out;

end



endmodule
