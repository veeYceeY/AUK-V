

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity mpi_uart is
    port(
            i_clk       : in std_logic;
            i_rstn       : in std_logic;

            i_wea       : in std_logic;
            i_waddr     : in std_logic_vector(31 downto 0); 
            i_wdata     : in std_logic_vector(31 downto 0);

            i_rea       : in std_logic;
            i_raddr     : in std_logic_vector(31 downto 0);
            o_rdata     : out std_logic_vector(31 downto 0);

            o_tx        : out std_logic;
            i_rx        : in std_logic
    );
end mpi_uart;


architecture arch_mpi_uart of mpi_uart is

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



CFG0: entity work.mpi_reg
port map ( 
        i_clk       =>i_clk,
        i_rstn       =>i_rstn,

        i_wea       =>i_wea,
        i_waddr     =>i_waddr, 
        i_wdata     =>i_wdata,

        i_rea       =>i_rea,
        i_raddr     =>i_raddr,
        o_rdata     =>o_rdata,

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
    i_clk       =>i_clk,
    i_rstn       =>i_rstn,

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



end arch_mpi_uart;