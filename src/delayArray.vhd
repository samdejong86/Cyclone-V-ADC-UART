--This module contains the definition of an array of ADC values

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package my_types_pkg is
  type adcArray is array (natural range <>) of unsigned(13 downto 0);
end package;