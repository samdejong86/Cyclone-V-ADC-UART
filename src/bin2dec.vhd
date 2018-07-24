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
		d4			: out unsigned(6 downto 0)
	);
end bin2dec;

architecture rtl of bin2dec is 


begin

	bin2decProc : process(input) is
	variable digit	    : integer:=0;
	variable thisDigit  : integer:=64;
	variable num2	    : integer;
	variable i	    : integer:=0;
          
	begin
			num2:=to_integer(input);
			i:=0;
			
			thisDigit:=64;
			
			d0<=to_unsigned(thisDigit,7);
			d1<=to_unsigned(thisDigit,7);
			d2<=to_unsigned(thisDigit,7);
			d3<=to_unsigned(thisDigit,7);
			d4<=to_unsigned(thisDigit,7);
		
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
					d0<=to_unsigned(thisDigit,7);
				elsif i=1 then
					d1<=to_unsigned(thisDigit,7);
				elsif i=2 then
					d2<=to_unsigned(thisDigit,7);
				elsif i=3 then
					d3<=to_unsigned(thisDigit,7);
				elsif i=4 then
					d4<=to_unsigned(thisDigit,7);
				end if;			

	
				if i=5 then
					exit;
				end if;
				
				i:=i+1;
				num2:=num2/10;
			
			end loop;
		
	end process bin2decProc;


end rtl;
