----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: Veeyceey
-- 
-- Design Name: 
-- Module Name: 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity native_uart is
    port(
            i_clk       : in std_logic;
            i_rstn       : in std_logic;

            i_en       : in std_logic;
            i_we       : in std_logic;
            i_addr     : in std_logic_vector(31 downto 0); 
            i_data     : in std_logic_vector(31 downto 0);
            o_rdata     : out std_logic_vector(31 downto 0);

            o_tx        : out std_logic;
            i_rx        : in std_logic
    );
end native_uart;


architecture arch_native_uart of native_uart is

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



CFG0: entity work.native_reg
port map ( 
        i_clk       =>i_clk,
        i_rstn       =>i_rstn,

        i_en       =>i_en,
        i_addr     =>i_addr, 
        i_data     =>i_data,
        i_we       =>i_we,
        o_data     =>o_data,

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



end arch_native_uart;