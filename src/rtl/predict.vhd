----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2020 22:28:47
-- Design Name: 
-- Module Name: predict - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity predict is
port(
            i_clk           : in std_logic;
            i_rst           : in std_logic;
            
            i_branch_result : in std_logic;
            i_pc            : in std_logic_vector(31 downto 0);
            o_branch_pred   : out std_logic
            
   );
end predict;

architecture Behavioral of predict is
signal tag : std_logic_vector(31 downto 0);
signal count : std_logic_vector(1 downto 0);
begin

tag <= tag when i_branch_result = '0' else i_pc when rising_edge(i_clk); 


process(i_clk,i_rst)
begin
    if i_rst = '1' then
        count <= (others=> '0');
    elsif rising_edge(i_clk) then
        if i_branch_result = '0' then
            if count >"00" then
                count<= count-1;
            end if;
        else
            if count <"11" then
                count <= count+1;
            end if;
        end if;
    end if;
end process;

o_branch_pred <= '1' when tag = i_pc and count(1) = '1' else '0';


end Behavioral;
