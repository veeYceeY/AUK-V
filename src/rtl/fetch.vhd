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
                i_evec_addr : in std_logic_vector(31 downto 0);
                i_branch_en : in std_logic;
                i_exception : in std_logic;
                
                o_en: out std_logic;
                o_addr : out std_logic_vector(31 downto 0);
                i_data : std_logic_vector(31 downto 0);
                i_valid: std_logic;
                
                o_pc : out std_logic_vector(31 downto 0);
                o_instr : out std_logic_vector(31 downto 0);
                o_instr_valid : out std_logic
        );

end fetch;

architecture fetch_no_bp of fetch is 
signal pc : std_logic_vector(31 downto 0);
signal instr : std_logic_vector(31 downto 0);
signal exception_d1 : std_logic;
signal exception_lth : std_logic;
signal en : std_logic;
signal start : std_logic;
signal flush : std_logic;
signal valid_d1 : std_logic;
signal valid_buff : std_logic;

begin


process(i_clk,i_rst)
begin
if i_rst = '1' then
    exception_d1<='0';
    valid_d1<='0';
elsif rising_edge(i_clk) then
    --pc<=i_pc;
   exception_d1 <= i_exception;
   valid_d1<=i_valid or valid_buff;
end if;
end process;

exception_lth<= (not exception_d1) and i_exception;

o_en<= en and (not i_stall);
--o_en<= not i_rst;

process(i_clk,i_rst)
begin
if i_rst = '1' then
    --pc <= x"000001f8";
    --pc <= x"000000D8";--54
    --pc <= x"00010018";
            start<='0';
                en<='0';
elsif rising_edge(i_clk) then
    --if  i_stall='0' then     ---Ignoring stall may cause issue where latency is largr
        if start = '0' then
            en<='1';
            start<='1';
        else
            if i_valid = '1' or (valid_buff='1' and i_stall='0') then
                en<='1';
            else
                en<='0';
            end if; 
        end if;
    --end if;
end if;
end process;

process(i_clk,i_rst)
begin
if i_rst = '1' then
    valid_buff <= '0';
elsif rising_edge(i_clk) then
    if i_stall='1' then
        if i_valid = '1' then
            valid_buff <= '1';
        end if;
    else
        valid_buff <= '0';
    end if;
end if;
end process;


process(i_clk,i_rst)
begin
if i_rst = '1' then
    --pc <= x"000001f8";
    --pc <= x"000000D8";--54
    pc <= x"00010018";
            flush<='0';
elsif rising_edge(i_clk) then
    if  i_stall='0' then
        if exception_lth = '1' then 
            flush<='1';
            pc<= i_evec_addr;
        elsif i_branch_en = '1' then
            flush<='1';
            pc <= i_branch_addr;
        elsif (i_valid='1' or valid_buff='1') and flush = '0' then
            --flush<='0';
            pc <= pc+4;
        elsif valid_d1='1' then
            flush<='0';
        end if;
    end if;
end if;
end process;
o_addr <= pc;
instr <= i_data when (i_valid='1' or valid_buff='1') and flush = '0' else x"00000033";
o_instr<=instr;
o_instr_valid<=i_valid and (not flush);
o_pc <= pc;
--o_instr_valid <= i_valid;
--o_pc <= (others =>'0') when i_rst = '1' else pc when rising_edge(i_clk);
--process(i_clk,i_rst)
--begin
--    if i_rst='1' then
--        o_pc <= x"00010018";
--        o_instr_valid<='0';
--        o_instr<=x"00000033";
--    elsif rising_edge(i_clk) then
--        if i_stall = '0' then
--            o_pc <= pc;
--            o_instr_valid<=i_valid;
--            o_instr<=instr;
--        end if;            
--    end if;
--end process;

--process(i_stall,pc,i_rst)
--begin
--    if i_rst='1' then
--        o_pc <= (others => '0');
--    else --if rising_edge(i_clk) then
--        --if i_stall = '0' then
--            o_pc <= pc;
--        --end if;            
--    end if;
--end process;


end fetch_no_bp;