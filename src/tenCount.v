module tenCount(clk, in, out);

input clk;
input [15:0] in;
output reg [3:0] out;

always @(in) begin
	out = in % 10;
end

endmodule
