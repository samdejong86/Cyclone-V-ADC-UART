module signer(unsign, pedistal, sign);

output reg signed [13:0] sign;
input        [13:0] unsign;
input [13:0] pedistal;

always @* begin
  sign = unsign-pedistal;
end

endmodule
