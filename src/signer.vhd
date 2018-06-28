library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signer is
	port(
	unsign		: in unsigned (13 DOWNTO 0);
	sign			: out signed (13 DOWNTO 0)
	);
end signer;

architecture rtl of signer is

	constant pedistal :unsigned (13 DOWNTO 0) := to_unsigned(8192, 14);

begin

	sign <= signed(unsign) - signed(pedistal);



end rtl;