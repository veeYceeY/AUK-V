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


entity fetch is 
        port (
                i_clk : in std_logic;
                i_rst : in std_logic;
                
                i_stall : in std_logic;
                i_branch_addr : in std_logic_vector(31 downto 0);
                i_branch_en : in std_logic;
                
                o_addr : out std_logic_vector(31 downto 0);
                i_data : std_logic_vector(31 downto 0);
                i_valid: std_logic;
                
                o_pc : out std_logic_vector(31 downto 0);
                o_instr : out std_logic_vector(31 downto 0)
        );

end fetch;

architecture fetch_no_bp of fetch is 
signal pc : std_logic_vector(31 downto 0);
begin

process(i_clk,i_rst)
begin
if i_rst = '1' then
    pc <= (others=> '0');
elsif rising_edge(i_clk) then
    if  i_stall='0' and i_valid='1'then
        if i_branch_en = '1' then
            pc <= i_branch_addr;
        else
            pc <= pc+4;
        end if;
    end if;
end if;
end process;
o_addr <= pc;
o_instr <= i_data;
--o_pc <= (others =>'0') when i_rst = '1' else pc when rising_edge(i_clk);
process(i_clk,i_rst)
begin
    if i_rst='1' then
        o_pc <= (others => '0');
    elsif rising_edge(i_clk) then
        if i_stall = '1' then
            o_pc <= pc;
        end if;            
    end if;
end process;
end fetch_no_bp;