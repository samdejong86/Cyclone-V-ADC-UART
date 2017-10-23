module pedistal(movingAverage, trigger, pedistal);

input [13:0] movingAverage;
input trigger;
output reg [13:0] pedistal;

always @(posedge trigger) begin
	pedistal <= movingAverage;
end

endmodule
	