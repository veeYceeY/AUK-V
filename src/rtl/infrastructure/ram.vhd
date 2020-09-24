library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity ram is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            i_en     : in std_logic;
            i_we     : in std_logic;
            i_addr   : in std_logic_vector(31 downto 0);
            i_data   : in std_logic_vector(31 downto 0);
            i_strobe : in std_logic_vector(3 downto 0);
            o_valid  : out std_logic;
            o_data   : out std_logic_vector(31 downto 0)
    );

end ram;

architecture behave of ram is

attribute rom_style : string;
type mem_type is array(127 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
attribute rom_style of mem : signal is "block";
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(29 downto 0);
begin
    addr <= i_addr(31 downto 2)  ;
    --data <= mem(to_integer(unsigned((addr))));
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            for i in 0 to 31 loop
                mem(i) <= (others => '0');
            end loop;
        elsif rising_edge(i_clk) then
            if i_we = '1' and i_en ='1' then
                if i_strobe = "0001" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 8) & i_data(7 downto 0);
                elsif i_strobe = "0011" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 16) & i_data(15 downto 0);
                elsif i_strobe = "0111" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 24) & i_data(23 downto 0);
                elsif i_strobe = "1111" then
                    mem(to_integer(unsigned(addr))) <= i_data;
                end if;
            end if;
        end if;
    end process;

    o_data <= mem(to_integer(unsigned((addr)))) when i_en ='1' and i_we= '0' and rising_edge(i_clk);
    o_valid <= i_en when rising_edge(i_clk); --and  (not i_we) when rising_edge(i_clk);
end behave;