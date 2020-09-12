

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity axi_reg is
    port (
    ----------------SYS----------------------------
        i_aclk        : in std_logic;
        i_aresetn     : in std_logic;
    ---------------READ----------------------------
        --Read Address channel
        i_araddr      : in std_logic_vector(31 downto 0);
        i_arprot      : in std_logic_vector(2 downto 0);
        i_arvalid     : in std_logic;
        o_arready     : out std_logic;
        --read data channel
        o_rdata       : out std_logic_vector(31 downto 0);
        o_rresp       : out std_logic_vector(1 downto 0);
        o_rvalid      : out std_logic;
        i_rready      : out std_logic;
    --------------WRITE----------------------------
        --Write address channel
        i_awaddr      : in std_logic_vector(31 downto 0);
        i_awprot      : in std_logic_vector(2 downto 0);
        i_awvalid     : in std_logic;
        o_awready     : out std_logic;
        --Write data channel
        i_wdata       : in std_logic_vector(31 downto 0);
        i_wstrb       : in std_logic_vector(3 downto 0);
        o_wready      : out std_logic;
        i_wvalid      : in std_logic;
    -------------RESP-------------------------------
        --Write response
        o_bresp       : out std_logic_vector(1 downto 0);
        o_bvalid      : out std_logic;
        o_bready      : out std_logic;
    --------------------UART IF-------------------
        i_rxdata    : in std_logic_vector(7 downto 0);
        i_rxdrdy    : in std_logic;

        o_txdata    : out std_logic_vector(7 downto 0);
        o_txen      : out std_logic;
        i_txdone   : in std_logic;

        o_uart_en   : out std_logic;
        o_parity    : out std_logic;
        o_baud      : out std_logic_vector(4 downto 0)
    );
end axi_reg;


architecture arch_axi_reg of axi_reg is

    type t_mem is array(3 downto 0) of std_logic_vector(31 downto 0);
    signal mem : t_mem;
    signal cfg0 : std_logic_vector(31 downto 0);
    signal status : std_logic_vector(31 downto 0);
    signal tx_data : std_logic_vector(31 downto 0);

    signal mem0 : std_logic_vector(31 downto 0);
    signal mem1 : std_logic_vector(31 downto 0);
    signal mem2 : std_logic_vector(31 downto 0);
    signal mem3 : std_logic_vector(31 downto 0);
    signal rdata : std_logic_vector(31 downto 0);
    signal txdone1 : std_logic;
    signal txdone0 : std_logic;
    signal txdone_lth : std_logic;
    signal tx_en : std_logic;
    signal wea : std_logic;
    signal rea : std_logic;
    signal ready : std_logic;
    signal bvalid : std_logic;
    signal clr_drdy : std_logic;
    signal tx_data_write : std_logic;
    signal rvalid : std_logic;

begin
    rea <= i_arvalid;
    wea <= i_awvalid and i_wvalid;
    ready <= '1' when i_rxdrdy = '0' and clr_drdy = '0' else '0';
    clr_drdy        <= '1' when i_araddr = x"00000002" and rea = '1' else '0';
    tx_data_write   <= '1' when i_awaddr = x"00000003" and wea = '1' else '0';

    mem0 <= mem(0);
    mem1 <= mem(1);
    mem2 <= mem(2);
    mem3 <= mem(3);
  
    process(i_aclk,i_aresetn)
    begin
        if i_aresetn = '0' then
    
        elsif rising_edge(i_aclk) then
            txdone0 <= i_txdone;
            txdone1 <= txdone0;
        end if;
    end process;
    txdone_lth <= '1' when txdone1 = '1' and txdone0 = '0' else '0';

    process(i_aclk,i_aresetn)
    begin
        if i_aresetn = '0' then
            mem(0)<=(others=>'0');
            mem(1)<=(others=>'0');
            mem(2)<=(others=>'0');
            mem(3)<=(others=>'0');
        elsif rising_edge(i_aclk) then
            if i_rxdrdy = '1' then
                mem(1)<= mem(1) or x"00000001";
                mem(2)<= x"000000" & i_rxdata;
            elsif clr_drdy = '1' then
                mem(1)<= mem(1) and x"fffffffe";
            else
                if wea = '1' then
                    mem(to_integer(unsigned(i_awaddr))) <= i_wdata;
                end if;
            end if;
        end if;
    end process;

    process(i_aclk,i_aresetn)
    begin
        if i_aresetn = '0' then
    
        elsif rising_edge(i_aclk) then
            if rea = '1' then
                rdata <= mem(to_integer(unsigned(i_araddr)));
            end if;
        end if;
    end process;

    
    process(i_aclk,i_aresetn)
    begin
        if i_aresetn = '0' then
            tx_en <= '0';
        elsif rising_edge(i_aclk) then
            if  tx_data_write ='1' then
                tx_en <= '1';
            elsif txdone_lth = '1' then
                tx_en <= '0';
            end if;
        end if;
    end process;

    
    process(i_aclk,i_aresetn)
    begin
        if i_aresetn = '0' then
            rvalid<= '0';
            bvalid<= '0';
        elsif rising_edge(i_aclk) then
            rvalid<= rea;
            bvalid<= wea;
        end if;
    end process;

    cfg0    <= mem(0);
    status  <= mem(1);
    tx_data <= mem(3);


    o_awready <= ready;
    o_wready <= ready;

    o_arready <= '1';

    o_bresp       <= "00";
    o_bvalid      <= bvalid;
    o_bready      <= ready;
    o_rresp       <= "00";


    o_rdata <= rdata;
    o_parity    <= cfg0(0);
    o_uart_en   <= cfg0(1);
    o_baud      <= cfg0(6 downto 2);
    o_txen     <= tx_en;
    o_txdata <= tx_data(7 downto 0);
end arch_axi_reg;