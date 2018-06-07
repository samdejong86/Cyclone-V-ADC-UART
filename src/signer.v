module signer(unsign, sign);

output reg signed [13:0] sign;
input        [13:0] unsign;
reg [13:0] pedistal=14'b10000000000000;

always @* begin
  sign = unsign-pedistal;
end

endmodule
