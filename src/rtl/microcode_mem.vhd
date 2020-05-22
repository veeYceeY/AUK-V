----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2020 14:55:58
-- Design Name: 
-- Module Name: microcode_mem - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity microcode_mem is
  Port (
        i_addr : in std_logic_vector(5 downto 0);
        o_code : out std_logic_vector(25 downto 0)
        );
  
end microcode_mem;

architecture Behavioral of microcode_mem is
type type_mem is array(64 downto 0) of std_logic_vector(25 downto 0);
signal u_mem : type_mem;
begin

u_mem(0 )  <= "10000100000000000000000100";
u_mem(1 )  <= "10000110000000000000000100";
u_mem(2 )  <= "11000100000111001000000100";
u_mem(3 )  <= "11100100000111001000000100";
u_mem(4 )  <= "11100100000100001000000000";
u_mem(5 )  <= "11100100000100011000000000";
u_mem(6 )  <= "11100100000100101000000000";
u_mem(7 )  <= "11100100000100111000000000";
u_mem(8 )  <= "01100100000100101000000000";
u_mem(9 )  <= "01100100000100111000000000";
u_mem(10)  <= "10100100000000000000011100";
u_mem(11)  <= "10100100000000000001011100";
u_mem(12)  <= "10100100000000000010011100";
u_mem(13)  <= "00100100000000000011011100";
u_mem(14)  <= "00100100000000000100011100";
u_mem(15)  <= "11100100000000000000110000";
u_mem(16)  <= "11100100000000000000110001";
u_mem(17)  <= "11100100000000000000110010";
u_mem(18)  <= "10100100000000000000000100";
u_mem(19)  <= "10100100001000000000000100";
u_mem(20)  <= "00100100001000000000000100";
u_mem(21)  <= "00100100010000000000000100";
u_mem(22)  <= "00100100011000000000000100";
u_mem(23)  <= "00100100100000000000000100";
u_mem(24)  <= "00100100101000000000000100";
u_mem(25)  <= "00100100110000000000000100";
u_mem(26)  <= "00100100111000000000000100";
u_mem(27)  <= "00000100000000000000000100";
u_mem(28)  <= "00000100001000000000000100";
u_mem(29)  <= "00000100101000000000000100";
u_mem(30)  <= "00000100000000000000000100";
u_mem(31)  <= "10000100000000000000000100";
u_mem(32)  <= "00000100010000000000000100";
u_mem(33)  <= "00000100110000000000000100";
u_mem(34)  <= "00000100111000000000000100";
u_mem(35)  <= "00000100100000000000000100";
u_mem(36)  <= "00000100011000000000000100";
u_mem(37)  <= "00000000000000000000000000";
u_mem(38)  <= "00000000000000000000000000";
u_mem(39)  <= "00000000000000000000000000";
u_mem(40)  <= "00000000000000000000000000";
   

end Behavioral;
