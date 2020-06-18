----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.05.2020 10:06:14
-- Design Name: 
-- Module Name: memory - Behavioral
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
--use ieee.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
     Port ( 
                i_clk : in std_logic;
                i_rst : in std_logic;
                
                i_en : in std_logic;
                i_we : in std_logic;
                i_addr : in std_logic_vector(31 downto 0);
                i_data : in std_logic_vector(31 downto 0);
                i_strobe : in std_logic_vector(3 downto 0);
                o_data : out std_logic_vector(31 downto 0);
                o_valid : out std_logic;
                
                i_periph_addr : std_logic_vector(7 downto 0);
                o_periph_data : std_logic_vector(7 downto 0)
     );
end memory;

architecture Behavioral of memory is
type mem_type is array(16 downto 0) of std_logic_vector(7 downto 0);
signal mem : mem_type;

begin

    process(i_clk,i_rst)
    begin
    
        if i_rst = '1' then
        
        
        elsif rising_edge(i_clk) then
            if i_en = '1' then
                if i_we='0' then
                    if i_strobe = "1111" then
                        o_data<= mem(to_integer(unsigned(i_addr))) & mem(to_integer(unsigned(i_addr))-1) & mem(to_integer(unsigned(i_addr))-2) & mem(to_integer(unsigned(i_addr))-3) ;
                    elsif i_strobe="0111" then
                        o_data<= x"00" & mem(to_integer(unsigned(i_addr))) & mem(to_integer(unsigned(i_addr))-1) & mem(to_integer(unsigned(i_addr))-2) ;
                    elsif i_strobe="0011" then
                        o_data<= x"00" & x"00" & mem(to_integer(unsigned(i_addr))) & mem(to_integer(unsigned(i_addr))-1) ;
                    elsif i_strobe="0001" then
                        o_data<= x"00" & x"00" & x"00" & mem(to_integer(unsigned(i_addr)));
                    end if;
                else
                    if i_strobe = "1111" then
                        mem(to_integer(unsigned(i_addr))) <= i_data(31 downto 24);
                        mem(to_integer(unsigned(i_addr))-1) <= i_data(23 downto 16);
                        mem(to_integer(unsigned(i_addr))-2) <= i_data(15 downto 8);
                        mem(to_integer(unsigned(i_addr))-3) <= i_data(7 downto 0);
                    elsif i_strobe = "0111" then
                        mem(to_integer(unsigned(i_addr))) <= i_data(23 downto 16);
                        mem(to_integer(unsigned(i_addr))-1) <= i_data(15 downto 8);
                        mem(to_integer(unsigned(i_addr))-2) <= i_data(7 downto 0);
                    elsif i_strobe = "0011" then
                        mem(to_integer(unsigned(i_addr))) <= i_data(15 downto 8);
                        mem(to_integer(unsigned(i_addr))-1) <= i_data(7 downto 0);
                    elsif i_strobe = "0001" then
                        mem(to_integer(unsigned(i_addr))) <= i_data(7 downto 0);
                    end if;
                end if;
            end if;
        end if;
    
    
    end process;
o_valid<='1';
end Behavioral;
