

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity axi_uart is
    port(
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
    ------------------------------------------------

        o_tx        : out std_logic;
        i_rx        : in std_logic
    );
end axi_uart;


architecture arch_axi_uart of axi_uart is

    signal uart0_data : std_logic_vector(7 downto 0);
    signal uart0_valid : std_logic;

    signal cfg0_en      : std_logic;
    signal cfg0_parity  : std_logic;
    signal cfg0_baud : std_logic_vector(4 downto 0);

    signal cfg0_txdata  : std_logic_vector(7 downto 0);
    signal cfg0_txen    : std_logic;
    

    signal bd0_clk : std_logic;
    signal bd0_rst : std_logic;
    signal uart0_txdone : std_logic;

begin

    CFG0: entity work.axi_reg
    port map ( 
            i_aclk        =>i_aclk,
            i_aresetn     =>i_aresetn,
            i_araddr      =>i_araddr,
            i_arprot      =>i_arprot,
            i_arvalid     =>i_arvalid,
            o_arready     =>o_arready,
            o_rdata       =>o_rdata,
            o_rresp       =>o_rresp,
            o_rvalid      =>o_rvalid,
            i_rready      =>i_rready,
            i_awaddr      =>i_awaddr,
            i_awprot      =>i_awprot,
            i_awvalid     =>i_awvalid,
            o_awready     =>o_awready,
            i_wdata       =>i_wdata,
            i_wstrb       =>i_wstrb,
            o_wready      =>o_wready,
            i_wvalid      =>i_wvalid,
            o_bresp       =>o_bresp,
            o_bvalid      =>o_bvalid,
            o_bready      =>o_bready,      



            i_rxdata    =>uart0_data,
            i_rxdrdy    =>uart0_valid,
    
            o_txdata    =>cfg0_txdata,
            o_txen      =>cfg0_txen,
            i_txdone    =>uart0_txdone,
    
            o_uart_en   =>cfg0_en,
            o_parity    =>cfg0_parity,
            o_baud      =>cfg0_baud
            
    
    );


UART0: entity work.uart
port map(
    i_clk       =>i_aclk,
    i_rstn       =>i_aresetn,

    i_en        =>cfg0_en,
    i_parity    =>cfg0_parity,
    i_baud_sel  =>cfg0_baud,

    i_txdata    =>cfg0_txdata,
    i_txen      =>cfg0_txen,
    o_txdone    => uart0_txdone,
    
    o_rxdata    =>uart0_data,
    o_rxvalid   =>uart0_valid,

    o_tx        =>o_tx,
    i_rx        =>i_rx
);



end arch_axi_uart;