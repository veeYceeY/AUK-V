

-- 00  :    status   :  overflow
-- 01  :    ctrl     :  interrupt_en,repeat,en
-- 10  :    count_limit   :  count_limit



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;

entity wb_timer is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            o_irq    : out std_logic;
            i_ack    : in std_logic;

            o_m_wb  : out t_in_wb_master;
            i_m_wb  : in t_out_wb_master
    );

end wb_timer;

architecture behave of wb_timer is

attribute rom_style : string;
type mem_type is array(3 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
attribute rom_style of mem : signal is "block";
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(1 downto 0);
signal byte_addr : std_logic_vector(1 downto 0);
signal sel : std_logic_vector(3 downto 0);
signal perm : std_logic_vector(1 downto 0);
signal status : std_logic_vector(31 downto 0);
signal ctrl : std_logic_vector(31 downto 0);--"interrupt_en"
signal count_limit : std_logic_vector(31 downto 0);
signal count : std_logic_vector(31 downto 0);
alias en : std_logic is ctrl(3);
alias irq_en : std_logic is ctrl(2);
alias repeat : std_logic is ctrl(1);
alias start : std_logic is ctrl(0);
signal irq : std_logic;

begin


    perm<= "10" when addr=x"0000000" else "11";

    addr <= i_m_wb.addr(3 downto 2)  ;
    byte_addr <= i_m_wb.addr(1 downto 0)  ;
    sel <= i_m_wb.sel;
    data <= mem(to_integer(unsigned((addr)))) when i_m_wb.stb='1'  and i_m_wb.cyc='1' else (others => '0');
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            mem(0) <= (others => '0');
            mem(1) <= (others => '0');
            mem(2) <= (others => '0');
        elsif rising_edge(i_clk) then
            if perm(0)='1' then 
                if i_m_wb.we = '1' and i_m_wb.stb='1' and i_m_wb.cyc='1' then
                    if i_m_wb.sel = "0001" then
                        --mem(to_integer(unsigned(addr))) <= data(31 downto 8) & i_m_wb.data(7 downto 0);
                        if byte_addr="00" then
                            mem(to_integer(unsigned(addr))) <= data(31 downto 8) & i_m_wb.data(7 downto 0);
                        elsif byte_addr="01" then
                            mem(to_integer(unsigned(addr))) <= data(31 downto 16) & i_m_wb.data(7 downto 0) & data(7 downto 0) ;
                        elsif byte_addr="10" then
                            mem(to_integer(unsigned(addr))) <= data(31 downto 24) & i_m_wb.data(7 downto 0) & data(15 downto 0) ;
                        elsif byte_addr="11" then
                            mem(to_integer(unsigned(addr))) <= i_m_wb.data(7 downto 0) & data(23 downto 0) ;
                        end if;
                    elsif i_m_wb.sel = "0011" then
                        mem(to_integer(unsigned(addr))) <= data(31 downto 16) & i_m_wb.data(15 downto 0);
                        if byte_addr="01" then
                            mem(to_integer(unsigned(addr))) <= data(31 downto 16) & i_m_wb.data(15 downto 0);
                        elsif byte_addr="11" then
                            mem(to_integer(unsigned(addr))) <= i_m_wb.data(15 downto 0) & data(15 downto 0);
                        end if;
                    elsif i_m_wb.sel = "1111" then
                        mem(to_integer(unsigned(addr))) <= i_m_wb.data;
                    else
                    mem(to_integer(unsigned(addr))) <= data;
                    end if;
                end if;

            else
                mem(0) <= status;
            end if;

        end if;
    end process;

    process(addr,sel,byte_addr,data)
    begin
        if sel="1111" then
            o_m_wb.data <=data;
        elsif sel="0011" then
            if byte_addr="01" then
                o_m_wb.data <=x"0000" & data(15 downto 0);
            elsif byte_addr="11" then
                o_m_wb.data <=x"0000" & data(31 downto 16);
            end if;
        elsif sel="0001" then
            if byte_addr="00" then
                o_m_wb.data <=x"000000" & data(7 downto 0);
            elsif byte_addr="01" then
                o_m_wb.data <=x"000000" & data(15 downto 8);
            elsif byte_addr="10" then
                o_m_wb.data <=x"000000" & data(23 downto 16);
            elsif byte_addr="11" then
                o_m_wb.data <=x"000000" & data(31 downto 24);
            end if;
        end if;
    end process;
    
    --o_m_wb.data <= mem(to_integer(unsigned((addr)))) when  i_m_wb.stb='1'  and i_m_wb.cyc='1';-- and rising_edge(i_clk);
    o_m_wb.ack <= i_m_wb.stb and i_m_wb.cyc;-- when rising_edge(i_clk);


    ctrl<= mem(1);
    count_limit<= mem(2);
    status(0)<= '1' when count = count_limit  and en = '1' else '0';
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            count<=x"ffffffff" ;
        elsif rising_edge(i_clk) then
            if en = '1' then
                if count<count_limit then
                    count<=count+'1';
                else
                    if start='1' or repeat='1' then
                        count<=x"00000000" ;
                    end if;
                end if;
            end if;
        end if;
    end process;
 
    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            irq<='0';
        elsif rising_edge(i_clk) then
            if irq='0' then
                if count=count_limit-1 and irq_en='1' then
                    irq<='1';
                end if;
            else
                if i_ack='1' then
                    irq<='0';
                end if;
            end if;
        end if;
    end process;
 
    o_irq <= irq; 

end behave;