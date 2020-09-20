library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity reg_if is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            i_en     : in std_logic;
            i_we     : in std_logic;
            i_addr   : in std_logic_vector(31 downto 0);
            i_data   : in std_logic_vector(31 downto 0);
            i_strobe : in std_logic_vector(3 downto 0);
            o_valid  : out std_logic;
            o_data   : out std_logic_vector(31 downto 0);

            i_reg0   : in std_logic_vector(31 downto 0);
            o_reg0   : out std_logic_vector(31 downto 0)
            
    );

end reg_if;

architecture behave of reg_if is
type mem_type is array(1 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(0 downto 0);
begin
    addr(0) <= i_addr(0);
    data <= mem(to_integer(unsigned((addr))));
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            mem(0) <= (others=>'0');
            mem(1) <= (others=>'0');
        elsif rising_edge(i_clk) then
            if i_we = '1' and i_en='1'then
                if i_strobe = "0001" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 8) & i_data(7 downto 0);
                elsif i_strobe = "0011" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 16) & i_data(15 downto 0);
                elsif i_strobe = "0111" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 24) & i_data(23 downto 0);
                elsif i_strobe = "1111" then
                    mem(to_integer(unsigned(addr))) <= i_data;
                else
                    --mem(to_integer(unsigned(addr))) <= data;
                end if;
                --mem(to_integer(unsigned(addr))) <= i_data;
                --o_reg0<=i_data;
            else
                mem(0) <= i_reg0;
            end if;
        end if;
    end process;

    o_data <= mem(to_integer(unsigned((addr))));

    o_valid <= i_en  when rising_edge(i_clk); --and (not i_we) when rising_edge(i_clk);
    o_reg0 <= mem(1);
end behave;