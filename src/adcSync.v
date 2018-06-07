module adcSync(sys_clk, DCO, ADCin, ADCout);

input 					sys_clk;
input 					DCO;
input 		[13:0]	ADCin;
output reg 	[13:0] 	ADCout;
reg 			[13:0] 	per_a2da_d;

always @(posedge DCO)
begin
		per_a2da_d	<= ADCin;
end

always @(posedge sys_clk)
begin
		ADCout	<= per_a2da_d;
			
end

endmodule 