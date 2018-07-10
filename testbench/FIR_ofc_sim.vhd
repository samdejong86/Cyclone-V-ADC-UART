
library IEEE;
use	IEEE.std_logic_1164.all;
use	IEEE.numeric_std.all;


entity FIR_ofc is
  port (
    clk : in STD_LOGIC;    
    reset_n : in STD_LOGIC;
    ast_sink_data : in STD_LOGIC_VECTOR(13 downto 0);
    ast_sink_valid : in STD_LOGIC;
    ast_sink_error : in STD_LOGIC_VECTOR(1 downto 0);

    ast_source_data : out STD_LOGIC_VECTOR(35 downto 0);
    ast_source_ready : in STD_LOGIC
  );
end FIR_ofc;

architecture rtl of FIR_ofc is

begin

	ast_source_data <= (35 downto 34 =>'0') & ast_sink_data & (19 downto 0 =>'0');




end rtl;