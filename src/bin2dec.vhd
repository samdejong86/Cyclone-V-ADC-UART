library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bin2dec is 
	port(
		clk		: in std_logic;
		input		: in unsigned(15 downto 0);
		d0			: out unsigned(6 downto 0);
		d1			: out unsigned(6 downto 0);
		d2			: out unsigned(6 downto 0);
		d3			: out unsigned(6 downto 0);
		d4			: out unsigned(6 downto 0);
		d5			: out unsigned(6 downto 0);
		d6			: out unsigned(6 downto 0);
		d7			: out unsigned(6 downto 0);
		d8			: out unsigned(6 downto 0);
		d9			: out unsigned(6 downto 0)	
	);
end bin2dec;

architecture rtl of bin2dec is 

	signal number			: integer;


begin

	number<=to_integer(input);

	bin2decProc : process(clk) is
	variable digit	    : integer:=0;
	variable thisDigit  : integer:=64;
	variable num2	    : integer;
	variable i	    : integer:=0;
	variable dig0 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig1 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig2 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig3 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig4 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig5 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig6 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig7 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig8 : unsigned (6 downto 0):=to_unsigned(64,7);
	variable dig9 : unsigned (6 downto 0):=to_unsigned(64,7);
          
	begin
		if rising_edge(clk) then
			num2:=number;
			i:=0;
			
			thisDigit:=64;
			
			d0<=to_unsigned(thisDigit,7);
			d1<=to_unsigned(thisDigit,7);
			d2<=to_unsigned(thisDigit,7);
			d3<=to_unsigned(thisDigit,7);
			d4<=to_unsigned(thisDigit,7);
			d5<=to_unsigned(thisDigit,7);
			d6<=to_unsigned(thisDigit,7);
			d7<=to_unsigned(thisDigit,7);
			d8<=to_unsigned(thisDigit,7);
			d9<=to_unsigned(thisDigit,7);
		
			while i <= 10 loop
				digit:= num2 mod 10;
								
				if digit = 1 then
					thisDigit :=121;
				elsif digit = 2 then
					thisDigit := 36;
				elsif digit = 3 then
					thisDigit := 48;
				elsif digit = 4 then
					thisDigit := 25;
				elsif digit = 5 then
					thisDigit := 18;
				elsif digit = 6 then
					thisDigit := 2;
				elsif digit = 7 then
					thisDigit := 120;
				elsif digit = 8 then
					thisDigit := 0;
				elsif digit = 9 then
					thisDigit := 16;
				elsif digit = 0 then
					thisDigit := 64;
				end if;

				if i=0 then
					dig0:=to_unsigned(thisDigit,7);
				elsif i=1 then
					dig1:=to_unsigned(thisDigit,7);
				elsif i=2 then
					dig2:=to_unsigned(thisDigit,7);
				elsif i=3 then
					dig3:=to_unsigned(thisDigit,7);
				elsif i=4 then
					dig4:=to_unsigned(thisDigit,7);
				elsif i=5 then
					dig5:=to_unsigned(thisDigit,7);
				elsif i=6 then
					dig6:=to_unsigned(thisDigit,7);
				elsif i=7 then
					dig7:=to_unsigned(thisDigit,7);
				elsif i=8 then
					dig8:=to_unsigned(thisDigit,7);
				elsif i=9 then
					dig9:=to_unsigned(thisDigit,7);
				end if;			


	
				if i=10 then
					exit;
				end if;
				
				i:=i+1;
				num2:=num2/10;
			
			end loop;
		
			d0<=dig0;
			d1<=dig1;
			d2<=dig2;
			d3<=dig3;
			d4<=dig4;
			d5<=dig5;
			d6<=dig6;
			d7<=dig7;
			d8<=dig8;
			d9<=dig9;
		
		

		end if;	
	end process bin2decProc;


end rtl;
