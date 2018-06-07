module unsigner(unsign, sign);

input signed [13:0] sign;
output reg       [13:0] unsign;
reg [13:0] pedistal=14'b10000000000000;

always @* begin
  unsign = sign+pedistal;
end

endmodule
