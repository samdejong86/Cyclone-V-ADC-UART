module OFCalculator(clk, triggerIn, signal,  PulseHeight, temp, OFCdata, outTrig);


input triggerIn;
input clk;
input [13:0] signal;

output reg [15:0] PulseHeight;
output reg outTrig;

reg [2:0] counter=0;

output reg [13:0] OFCdata;
reg [2:0] OFCsample;

output reg [31:0] temp;
reg [31:0] OFCcoefficients [5] = '{32'd809500, 32'd140508, 32'd853540, 32'd290454, 32'd420478}; //OFC coefficients, left shifted by 20 bits
reg addOrSubtract [5] = 					'{1'b1,		  1'b0,		  1'b0,		  1'b0,		  1'b1};
reg [13:0] pedistal;

always @(posedge clk) begin

	if(triggerIn==1||(counter>0&&counter<5)) begin  //if a trigger is recieved, start the counter, and keep counting after trigger = 0
		counter <= counter + 6'b1;
		OFCdata=signal;
		OFCsample=OFCsample+3'b1;
		outTrig<=1;
	end
	else begin	
		counter<=0;	
		OFCdata=0;
		OFCsample=0;
		outTrig<=0;
	end

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
		PulseHeight=temp>>20;

	
	
	
end

endmodule
