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
 
entity csr_file is 
    port (
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            i_rd_addr : in std_logic_vector(11 downto 0);
            
            i_wb_data : in std_logic_vector(31 downto 0);
            i_wb_addr : in std_logic_vector(11 downto 0);
            i_we : in std_logic;
            
            o_rs1 : out std_logic_vector(31 downto 0);
            o_rs2 : out std_logic_vector(31 downto 0)
    );

end csr_file;

architecture behave of csr_file is
type csr_type is array(31 downto 0) of std_logic_vector(31 downto 0);

signal csr : csr_type;
begin

process(i_clk,i_rst)
begin
if i_rst = '1' then
    csr(0) <= x"00000000" ;
    csr(1) <= x"00000000" ;
    csr(1) <= x"00000000" ;
    csr(2) <= x"00000000" ;
    csr(3) <= x"00000000" ;
    csr(4) <= x"00000000" ;
    csr(5) <= x"00000000" ;
    csr(6) <= x"00000000" ;
    csr(7) <= x"00000000" ;
    csr(8) <= x"00000000" ;
    csr(9) <= x"00000000" ;
    csr(10) <= x"00000000" ;
    csr(11) <= x"00000000" ;
    csr(12) <= x"00000000" ;
    csr(13) <= x"00000000" ;
    csr(14) <= x"00000000" ;
    csr(15) <= x"00000000" ;
    csr(16) <= x"00000000" ;
    csr(17) <= x"00000000" ;
    csr(18) <= x"00000000" ;
    csr(19) <= x"00000000" ;
    csr(20) <= x"00000000" ;
    csr(21) <= x"00000000" ;
    csr(22) <= x"00000000" ;
    csr(23) <= x"00000000" ;
    csr(24) <= x"00000000" ;
    csr(25) <= x"00000000" ;
    csr(26) <= x"00000000" ;
    csr(27) <= x"00000000" ;
    csr(28) <= x"00000000" ;
    csr(29) <= x"00000000" ;
    csr(30) <= x"00000000" ;
    csr(31) <= x"00000000" ;
elsif rising_edge(i_clk) then
    if i_we = '1' then
        if i_wb_addr="00000" then
            csr(to_integer(unsigned(i_wb_addr))) <= x"00000000" ;
        else
            csr(to_integer(unsigned(i_wb_addr))) <= i_wb_data ;
        end if;
    end if;
end if;

end process;


--csr(to_integer(unsigned(i_wb_addr))) <= i_wb_data when rising_edge(i_clk);

o_rs1 <= csr(to_integer(unsigned(i_rd_addr)));

end behave;