module OFCMultiply(clk, OFCdata, OFCsample, PulseHeight, temp);

input clk;
input [13:0] OFCdata;
input [2:0] OFCsample;

output reg [31:0] temp;
reg [31:0] OFCcoefficients [5] = '{32'd772, 32'd134, 32'd814, 32'd277, 32'd401};
reg addOrSubtract [5] = 					 '{1,			0,			0,			0,			1};
reg [13:0] pedistal;

output reg [31:0] PulseHeight;

always @(posedge clk) begin
	
	if(OFCsample==1)begin
		pedistal=OFCdata;
		temp=0;
	end
	
	if(OFCsample>1) begin
		if(addOrSubtract[OFCsample-1]==0)
			temp=temp+(OFCdata-pedistal)*OFCcoefficients[OFCsample-1];
		else
			temp=temp-(OFCdata-pedistal)*OFCcoefficients[OFCsample-1];
	
	end
	
	if(OFCsample==5)
		PulseHeight=temp;


end


endmodule 
