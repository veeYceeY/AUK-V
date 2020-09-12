

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mpi_reg is
    port(
            i_clk       : in std_logic;
            i_rstn       : in std_logic;

            i_wea       : in std_logic;
            i_waddr     : in std_logic_vector(31 downto 0); 
            i_wdata     : in std_logic_vector(31 downto 0);

            i_rea       : in std_logic;
            i_raddr     : in std_logic_vector(31 downto 0);
            o_rdata     : out std_logic_vector(31 downto 0);

            i_rxdata    : in std_logic_vector(7 downto 0);
            i_rxdrdy    : in std_logic;

            o_txdata    : out std_logic_vector(7 downto 0);
            o_txen      : out std_logic;
            i_txdone   : in std_logic;

            o_uart_en   : out std_logic;
            o_parity    : out std_logic;
            o_baud      : out std_logic_vector(4 downto 0)

    );
end mpi_reg;


architecture arch_mpi_reg of mpi_reg is

    type t_mem is array(3 downto 0) of std_logic_vector(31 downto 0);
    signal mem : t_mem;
    signal clr_drdy : std_logic;
    signal tx_data_write : std_logic;
    signal rdata : std_logic_vector(31 downto 0);
    signal tx_en : std_logic;
    signal cfg0 : std_logic_vector(31 downto 0);
    signal status : std_logic_vector(31 downto 0);
    signal tx_data : std_logic_vector(31 downto 0);

    signal mem0 : std_logic_vector(31 downto 0);
    signal mem1 : std_logic_vector(31 downto 0);
    signal mem2 : std_logic_vector(31 downto 0);
    signal mem3 : std_logic_vector(31 downto 0);
    signal txdone1 : std_logic;
    signal txdone0 : std_logic;
    signal txdone_lth : std_logic;

begin

    clr_drdy        <= '1' when i_raddr = x"00000002" and i_rea = '1' else '0';
    tx_data_write   <= '1' when i_waddr = x"00000003" and i_wea = '1' else '0';

    mem0 <= mem(0);
    mem1 <= mem(1);
    mem2 <= mem(2);
    mem3 <= mem(3);
  
    process(i_clk,i_rstn)
    begin
        if i_rstn = '0' then
    
        elsif rising_edge(i_clk) then
            txdone0 <= i_txdone;
            txdone1 <= txdone0;
        end if;
    end process;
    txdone_lth <= '1' when txdone1 = '1' and txdone0 = '0' else '0';

    process(i_clk,i_rstn)
    begin
        if i_rstn = '0' then
    
            mem(0)<=(others=>'0');
            mem(1)<=(others=>'0');
            mem(2)<=(others=>'0');
            mem(3)<=(others=>'0');

        elsif rising_edge(i_clk) then
            if i_rxdrdy = '1' then
                mem(1)<= mem(1) or x"00000001";
                mem(2)<= x"000000" & i_rxdata;
            elsif clr_drdy = '1' then
                mem(1)<= mem(1) and x"fffffffe";
            else
                if i_wea = '1' then
                    mem(to_integer(unsigned(i_waddr))) <= i_wdata;
                end if;
            end if;
        end if;
    end process;

    process(i_clk,i_rstn)
    begin
        if i_rstn = '0' then
    
        elsif rising_edge(i_clk) then
            if i_rea = '1' then
                rdata <= mem(to_integer(unsigned(i_raddr)));
            end if;
        end if;
    end process;

    
    process(i_clk,i_rstn)
    begin
        if i_rstn = '0' then
            tx_en <= '0';
        elsif rising_edge(i_clk) then
            if  tx_data_write ='1' then
                tx_en <= '1';
            elsif txdone_lth = '1' then
                tx_en <= '0';
            end if;
        end if;
    end process;

    cfg0    <= mem(0);
    status  <= mem(1);
    tx_data <= mem(3);

    o_rdata <= rdata;
    o_parity    <= cfg0(0);
    o_uart_en   <= cfg0(1);
    o_baud      <= cfg0(6 downto 2);
    o_txen     <= tx_en;
    o_txdata <= tx_data(7 downto 0);
end arch_mpi_reg;