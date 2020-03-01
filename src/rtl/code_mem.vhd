library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity code_mem is
    port(
            i_address : in std_logic_vector(31 downto 0);
            o_instruction : out std_logic_vector(31 downto 0)
    );

end code_mem;

architecture behave of code_mem is
type mem_type is array(31 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;

begin

    mem(0) <= x"00000000";

    o_instruction <= mem(to_integer(unsigned((i_address))));

end behave;