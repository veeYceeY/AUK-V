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


entity uart is
    port(
            i_clk       : in std_logic;
            i_rstn       : in std_logic;
            
            i_en        : in std_logic;

            i_parity    : in std_logic;
            i_baud_sel  : in std_logic_vector(4 downto 0);

            i_txdata    : in std_logic_vector(7 downto 0);
            i_txen      : in std_logic;
            o_txdone   : out std_logic;
            
            o_rxdata    : out std_logic_vector(7 downto 0);
            o_rxvalid   : out std_logic;

            o_tx        : out std_logic;
            i_rx        : in std_logic
    );
end uart;


architecture arch_uart of uart is
signal bd0_clk : std_logic;
signal bd0_rst : std_logic;
signal tx0_done : std_logic;

begin
TX0: entity work.uart_tx
    port map ( 
            i_clk       =>i_clk,
            i_rstn       =>i_rstn,
            i_baud_clk  =>bd0_clk,
            
            i_en        =>i_en,
            o_done      =>o_txdone,
            i_parity    => '0',
            i_txdata    =>i_txdata,
            i_txen      =>i_txen,

            o_tx        =>o_tx
    );


RX0: entity work.uart_rx
    port map (
            i_clk       =>i_clk,
            i_rstn       =>i_rstn,
            
            i_en        =>i_en,
            
            i_baud_clk  =>bd0_clk,

            i_parity    =>i_parity,

            o_rxdata    =>o_rxdata,
            o_rxvalid   =>o_rxvalid,

            i_rx        =>i_rx
    );

BD0: entity work.baud
    port map (
            i_clk       =>i_clk,
            i_rstn       =>i_rstn,

            i_baud_sel  =>i_baud_sel,

            o_clk       =>bd0_clk,
            o_rst       =>bd0_rst
            
    );



end arch_uart;