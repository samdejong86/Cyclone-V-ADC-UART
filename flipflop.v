module flipflop(in, out);

input in;
output reg out=0;

always @(posedge in) begin

	out=~out;

end

endmodule
