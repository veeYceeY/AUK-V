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
    
elsif rising_edge(i_clk) then
    if i_we = '1' then
        sfr(to_integer(unsigned(i_wb_addr))) <= i_wb_data ;
    end if;
end if;

end process;


--sfr(to_integer(unsigned(i_wb_addr))) <= i_wb_data when rising_edge(i_clk);

o_rs1 <= sfr(to_integer(unsigned(i_rs1_addr)));
o_rs2 <= sfr(to_integer(unsigned(i_rs2_addr)));

end behave;