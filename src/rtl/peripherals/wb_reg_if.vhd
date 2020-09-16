library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


use work.pkg_aukv.all;

entity wb_reg_if is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            i_reg0   : in std_logic_vector(31 downto 0);
            o_reg0   : out std_logic_vector(31 downto 0);

            o_m_wb  : out t_in_wb_master;
            i_m_wb  : in t_out_wb_master
            
    );

end wb_reg_if;

architecture behave of wb_reg_if is
type mem_type is array(1 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(0 downto 0);
begin
    addr(0) <= i_m_wb.addr(0);
        data <= mem(to_integer(unsigned((addr)))) when i_m_wb.stb='1'  and i_m_wb.cyc='1' else (others => '0');
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            mem(0) <= (others=>'0');
            mem(1) <= (others=>'0');
        elsif rising_edge(i_clk) then
            if i_m_wb.we = '1' and i_m_wb.stb='1' and i_m_wb.cyc='1'then
                if i_m_wb.sel = "0001" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 8) & i_m_wb.data(7 downto 0);
                elsif i_m_wb.sel = "0011" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 16) & i_m_wb.data(15 downto 0);
                elsif i_m_wb.sel = "0111" then
                    mem(to_integer(unsigned(addr))) <= data(31 downto 24) & i_m_wb.data(23 downto 0);
                elsif i_m_wb.sel = "1111" then
                    mem(to_integer(unsigned(addr))) <= i_m_wb.data;
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

    o_m_wb.data <= mem(to_integer(unsigned((addr)))) when  i_m_wb.stb='1'  and i_m_wb.cyc='1' and rising_edge(i_clk);
    o_m_wb.ack <= i_m_wb.stb and i_m_wb.cyc when rising_edge(i_clk);

    o_reg0 <= mem(1);
end behave;