library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unsigner is
	port(
	sign			: in signed (13 DOWNTO 0);
	unsign		: out unsigned (13 DOWNTO 0)
	);
end unsigner;

architecture rtl of unsigner is

	constant pedistal :unsigned (13 DOWNTO 0) := to_unsigned(8192, 14);

begin

	unsign <= unsigned(sign) + pedistal;



end rtl;