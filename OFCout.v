module OFCout(clk, counter, FIR, PulseHeight);

input clk;
input [6:0] counter;
input signed [35:0] FIR;
reg unsigned [35:0] FIR2;
output reg unsigned [15:0] PulseHeight;

always @(posedge clk) begin
	FIR2=FIR;
	if(counter==14)
		PulseHeight=FIR2>>20;


end

endmodule
