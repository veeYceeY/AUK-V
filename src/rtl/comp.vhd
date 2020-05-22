----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.04.2020 14:19:25
-- Design Name: 
-- Module Name: comp - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comp is
  Port (
            i_a : in std_logic_vector(31 downto 0);
            i_b : in std_logic_vector(31 downto 0);
            i_s : in std_logic;
            o_lt: out std_logic;
            o_ge: out std_logic;
            o_eq: out std_logic;
            o_ne: out std_logic
   );
end comp;

architecture Behavioral of comp is
signal a_s : signed(31 downto 0);
signal b_s : signed(31 downto 0);
signal a_u : unsigned(31 downto 0);
signal b_u : unsigned(31 downto 0);
signal lt_u : std_logic;
signal ge_u : std_logic;
signal eq_u : std_logic;
signal ne_u : std_logic;
signal lt_s : std_logic;
signal ge_s : std_logic;
signal eq_s : std_logic;
signal ne_s : std_logic;
begin

a_s <= signed(i_a);
b_s <= signed(i_b);
a_u <= unsigned(i_a);
b_u <= unsigned(i_b);

lt_u <= '1' when a_u < b_u else '0';
ge_u <= not lt_u;
eq_u <= '1' when a_u = b_u else '0';
ne_u <= not eq_u;

lt_s <= '1' when a_s < b_s else '0';
ge_s <= not lt_s;
eq_s <= '1' when a_s = b_s else '0';
ne_s <= not eq_s;


o_lt <= lt_s when i_s='1' else lt_u;
o_ge <= ge_s when i_s='1' else ge_u;
o_eq <= eq_s when i_s='1' else eq_u;
o_ne <= ne_s when i_s='1' else ne_u;

end Behavioral;
