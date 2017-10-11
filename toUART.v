module toUART(clk, send, dataOut, dataIn);

input send;
input clk;
input [7:0] dataIn;
output reg dataOut;
reg [4:0] counter=0;
reg sent;



always @(posedge clk) begin

	
	if(send==1||(counter<=31&&counter>5)) begin
		counter <= counter + 1;
	end
	else begin	
		counter <= 0;
		sent<=0;
	end
	
	if(sent==0) begin
	if(counter==1)
		dataOut<=0;
	else if(counter==2)
		dataOut<=dataIn[0];
	else if(counter==3)		
		dataOut<=dataIn[1];
	else if(counter==4)
		dataOut<=dataIn[2];		
	else if(counter==5)
		dataOut<=dataIn[3];		
	else if(counter==6)
		dataOut<=dataIn[4];	
	else if(counter==7)
		dataOut<=dataIn[5];
	else if(counter==8)
		dataOut<=dataIn[6];	
	else if(counter==9)
		dataOut<=dataIn[7];
	else if(counter>9) begin
		dataOut<=1;
		sent<=1;
	end
	else
		dataOut<=1;
	
	end
	else
		dataOut<=1;
		
end



endmodule
