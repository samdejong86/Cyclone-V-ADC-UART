module bin2dec (in, d0, d1, d2, d3, d4, d5, d6, d7, d8, d9);

input [31:0] in;
output [6:0] d0;
output [6:0] d1;
output [6:0] d2;
output [6:0] d3;
output [6:0] d4;
output [6:0] d5;
output [6:0] d6;
output [6:0] d7;
output [6:0] d8;
output [6:0] d9;

reg [31:0] num;
reg [4:0] i;
reg [31:0] digit;
reg [6:0] thisDigit;

always @(in) begin
	num=in;
	i=0;
	
	thisDigit=63;
	d0=~thisDigit;
	d1=~thisDigit;
	d2=~thisDigit;
	d3=~thisDigit;
	d4=~thisDigit;
	d5=~thisDigit;
	d6=~thisDigit;
	d7=~thisDigit;
	d8=~thisDigit;
	d9=~thisDigit;
	
	
	
	
	
	while (num >= 1) begin
		digit = num % 10;
		
		if (digit==1)
			thisDigit=6;
		else if (digit==2)
			thisDigit=91;
		else if (digit==3)
			thisDigit=79;
		else if (digit==4)
			thisDigit=102;
		else if (digit==5)
			thisDigit=109;
		else if (digit==6)
			thisDigit=125;
		else if (digit==7)
			thisDigit=7;
		else if (digit==8)
			thisDigit=127;
		else if (digit==9)
			thisDigit=111;
		else if(digit==0)
			thisDigit=63;
		
		if (i==0)
			d0=~thisDigit;
		else if (i==1)
			d1=~thisDigit;
		else if (i==2)
			d2=~thisDigit;
		else if (i==3)
			d3=~thisDigit;
		else if (i==4)
			d4=~thisDigit;
		else if (i==5)
			d5=~thisDigit;
		else if (i==6)
			d6=~thisDigit;
		else if (i==7)
			d7=~thisDigit;
		else if (i==8)
			d8=~thisDigit;
		else if (i==9)
			d9=~thisDigit;
		
		
		if (i==10)
			break;
		
		i = i + 1;
		num = num / 10;
		
		
	end
	

	
end

endmodule

