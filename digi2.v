module binToHex(in, out);

input [3:0] in;
output [6:0] out;

reg[6:0] out;
reg [6:0] a;


always @(in) begin

	if (in==1)
			a=6;
	else if (in==2)
			a=91;
	else if (in==3)
			a=79;
	else if (in==4)
			a=102;
	else if (in==5)
			a=109;
	else if (in==6)
			a=125;
	else if (in==7)
			a=7;
	else if (in==8)
			a=127;
	else if (in==9)
			a=111;
	else if (in==10)
			a=119;
	else if (in==11)
			a=124;
	else if (in==12)
			a=57;
	else if (in==13)
			a=94;
	else if (in==14)
			a=121;
	else if (in==15)
			a=113;			
	else 
			a=63;
	
	

	out=~a;


end

endmodule
