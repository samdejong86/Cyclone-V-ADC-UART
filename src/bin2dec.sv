module bin2dec (clk, in, d0, d1, d2, d3, d4, d5, d6, d7, d8, d9);

input clk;
input [15:0] in;
output reg [6:0] d0;
output reg [6:0] d1;
output reg [6:0] d2;
output reg [6:0] d3;
output reg [6:0] d4;
output reg [6:0] d5;
output reg [6:0] d6;
output reg [6:0] d7;
output reg [6:0] d8;
output reg [6:0] d9;

reg [15:0] num;
reg [4:0] i;
reg [6:0] digit;
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
		digit = num % 7'd10;
		
		if (digit==1) begin
			thisDigit=6;
		end
		else if (digit==2) begin
			thisDigit=91;
		end
		else if (digit==3) begin
			thisDigit=79;			
		end
		else if (digit==4) begin
			thisDigit=102;		
		end
		else if (digit==5) begin
			thisDigit=109;		
		end
		else if (digit==6) begin
			thisDigit=125;	
		end
		else if (digit==7) begin
			thisDigit=7;		
		end
		else if (digit==8) begin
			thisDigit=127;		
		end
		else if (digit==9) begin
			thisDigit=111;		
		end
		else if(digit==0) begin
			thisDigit=63;		
		end
		
		if(i==0)
			d0=~thisDigit;
		else if(i==1)
			d1=~thisDigit;
		else if(i==2)
			d2=~thisDigit;
		else if(i==3)
			d3=~thisDigit;
		else if(i==4)
			d4=~thisDigit;
		else if(i==5)
			d5=~thisDigit;
		else if(i==6)
			d6=~thisDigit;
		else if(i==7)
			d7=~thisDigit;
		else if(i==8)
			d8=~thisDigit;
		else if(i==9)
			d9=~thisDigit;
			
		
		
		
		
		
		if (i==10)
			break;
		
		i = i + 5'b1;
		num = num / 16'd10;
		
		
	end
	

	
end

endmodule

