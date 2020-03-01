library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity fetch is 
        port (
                i_clk : in std_logic;
                i_rst : in std_logic;
                
                i_branch_addr : in std_logic_vector(31 downto 0);
                i_branch_en : in std_logic;
                
                o_addr : out std_logic_vector(31 downto 0)
        );

end fetch;

architecture fetch_no_bp of fetch is 
signal pc : std_logic_vector(7 downto 0);
begin

process(i_clk,i_rst)
begin
if i_rst = '1' then
    
elsif rising_edge(i_clk) then
    if i_branch_en = '1' then
        pc <= i_branch_addr;
    else
        pc <= pc+1;
    end if;
end if;
end process;

end fetch_no_bp;