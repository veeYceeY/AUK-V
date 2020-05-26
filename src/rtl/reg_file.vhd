----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: Veeyceey
-- 
-- Create Date: 24.05.2020 12:49:36
-- Design Name: 
-- Module Name: sciv_core - Behavioral
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



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
entity reg_file is 
    port (
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            i_rs1_addr : in std_logic_vector(4 downto 0);
            i_rs2_addr : in std_logic_vector(4 downto 0);
            
            i_wb_data : in std_logic_vector(31 downto 0);
            i_wb_addr : in std_logic_vector(4 downto 0);
            i_we : in std_logic;
            
            o_rs1 : out std_logic_vector(31 downto 0);
            o_rs2 : out std_logic_vector(31 downto 0)
    );

end reg_file;

architecture behave of reg_file is
type sfr_type is array(31 downto 0) of std_logic_vector(31 downto 0);

signal sfr : sfr_type;
begin

process(i_clk,i_rst)
begin
if i_rst = '1' then
    sfr(0) <= x"00000000" ;
    sfr(1) <= x"00000000" ;
    sfr(1) <= x"00000000" ;
    sfr(2) <= x"00000000" ;
    sfr(3) <= x"00000000" ;
    sfr(4) <= x"00000000" ;
    sfr(5) <= x"00000000" ;
    sfr(6) <= x"00000000" ;
    sfr(7) <= x"00000000" ;
    sfr(8) <= x"00000000" ;
    sfr(9) <= x"00000000" ;
    sfr(10) <= x"00000000" ;
    sfr(11) <= x"00000000" ;
    sfr(12) <= x"00000000" ;
    sfr(13) <= x"00000000" ;
    sfr(14) <= x"00000000" ;
    sfr(15) <= x"00000000" ;
    sfr(16) <= x"00000000" ;
    sfr(17) <= x"00000000" ;
    sfr(18) <= x"00000000" ;
    sfr(19) <= x"00000000" ;
    sfr(20) <= x"00000000" ;
    sfr(21) <= x"00000000" ;
    sfr(22) <= x"00000000" ;
    sfr(23) <= x"00000000" ;
    sfr(24) <= x"00000000" ;
    sfr(25) <= x"00000000" ;
    sfr(26) <= x"00000000" ;
    sfr(27) <= x"00000000" ;
    sfr(28) <= x"00000000" ;
    sfr(29) <= x"00000000" ;
    sfr(30) <= x"00000000" ;
    sfr(31) <= x"00000000" ;
elsif rising_edge(i_clk) then
    if i_we = '1' then
        if i_wb_addr="00000" then
            sfr(to_integer(unsigned(i_wb_addr))) <= x"00000000" ;
        else
            sfr(to_integer(unsigned(i_wb_addr))) <= i_wb_data ;
        end if;
    end if;
end if;

end process;


--sfr(to_integer(unsigned(i_wb_addr))) <= i_wb_data when rising_edge(i_clk);

o_rs1 <= sfr(to_integer(unsigned(i_rs1_addr)));
o_rs2 <= sfr(to_integer(unsigned(i_rs2_addr)));

end behave;