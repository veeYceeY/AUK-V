library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;

entity wb_oc_ram is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            o_m_wb  : out t_in_wb_master;
            i_m_wb  : in t_out_wb_master
    );

end wb_oc_ram;

architecture behave of wb_oc_ram is

attribute rom_style : string;
type mem_type is array(127 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
attribute rom_style of mem : signal is "block";
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(13 downto 0);
begin
    addr <= "0000"&i_m_wb.addr(11 downto 2)  ;
    data <= mem(to_integer(unsigned((addr)))) when i_m_wb.stb='1'  and i_m_wb.cyc='1' else (others => '0');
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            for i in 0 to 127 loop
                mem(i) <= (others => '0');
            end loop;
        elsif rising_edge(i_clk) then
            if i_m_wb.we = '1' and i_m_wb.stb='1' and i_m_wb.cyc='1' then
                if i_m_wb.sel = "0001" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 8) & i_m_wb.data(7 downto 0);
                elsif i_m_wb.sel = "0011" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 16) & i_m_wb.data(15 downto 0);
                elsif i_m_wb.sel = "0111" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 24) & i_m_wb.data(23 downto 0);
                elsif i_m_wb.sel = "1111" then
                    mem(to_integer(unsigned(addr))) <= i_m_wb.data;
                else
                mem(to_integer(unsigned(addr))) <= data;
                end if;
            end if;
        end if;
    end process;

    o_m_wb.data <= mem(to_integer(unsigned((addr)))) when  i_m_wb.stb='1'  and i_m_wb.cyc='1';-- and rising_edge(i_clk);
    o_m_wb.ack <= i_m_wb.stb and i_m_wb.cyc;-- when rising_edge(i_clk);
end behave;