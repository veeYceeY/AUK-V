----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: Veeyceey
-- 
-- Design Name: 
-- Module Name:
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
use ieee.numeric_std.all;

entity baud is
    port(
            i_clk       : in std_logic;
            i_rstn       : in std_logic;

            --i_en        : in std_logic;
            
            i_baud_sel  : in std_logic_vector(31 downto 0);

            o_clk       : out std_logic;
            o_rst       : out std_logic
            
    );
end baud;


architecture arch_baud of baud is

    signal count : std_logic_vector(31 downto 0);
    signal rst0 : std_logic;
    signal rst1 : std_logic;
    signal clk : std_logic;
begin

process(i_clk,i_rstn)
begin
    if i_rstn = '1' then
        count<=(others=>'0');
        clk<='0';
    elsif rising_edge(i_clk) then
        if count < i_baud_sel then
            count <= count+'1';
            clk<='0';
        else
            count <= (others=>'0');
            clk <= '1';
        end if;
    end if;

end process;

--clk <= count(to_integer(unsigned(i_baud_sel)));

process(clk,i_rstn)
begin
    if i_rstn = '1' then
        rst0 <= '1';
        rst1 <= '1';
    elsif rising_edge(clk) then
        rst0 <= i_rstn;
        rst1 <= rst0;
    end if;

end process;
o_clk <= clk;
o_rst <= i_rstn;

end arch_baud;