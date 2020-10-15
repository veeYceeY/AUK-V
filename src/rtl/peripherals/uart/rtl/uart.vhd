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
            i_baud_sel  : in std_logic_vector(31 downto 0);

            i_txdata    : in std_logic_vector(7 downto 0);
            i_tx_wren      : in std_logic;
            o_tx_full   : out std_logic;
            o_tx_empty   : out std_logic;
            
            i_rx_rden      : in std_logic;
            o_rxdata    : out std_logic_vector(7 downto 0);
            o_rx_full   : out std_logic;
            o_rx_empty   : out std_logic;

            o_tx        : out std_logic;
            i_rx        : in std_logic
    );
end uart;


architecture arch_uart of uart is
signal bd0_clk : std_logic;
signal bd0_rst : std_logic;
signal tx0_done : std_logic;
signal bd0_txdone : std_logic;
signal txf0_tx_empty : std_logic;
signal rx0_rxvalid : std_logic;
signal txf0_txdata : std_logic_vector(7 downto 0);
signal rxf0_rxdata : std_logic_vector(7 downto 0);
signal rx0_rxdata : std_logic_vector(7 downto 0);
signal tx_drdy : std_logic;
signal rx_clk : std_logic;
signal tx_clk : std_logic;
begin



    TXF0:entity work.fifo   
   
        port map (
            i_wrclk => i_clk,
            i_wrrst => i_rstn,
            i_wren  => i_tx_wren,
            i_wrdata=> i_txdata,
            o_full  => o_tx_full,
    
            i_rdclk => tx_clk,
            i_rdrst => bd0_rst,
            i_rden  => bd0_txdone,
            o_rddata=> txf0_txdata,
            o_empty => txf0_tx_empty
        );
    o_tx_empty <= txf0_tx_empty;
    tx_drdy <= '0' when i_rstn='1' else  not (txf0_tx_empty) and bd0_txdone when rising_edge(tx_clk);
    RXF0:entity work.fifo   
    
        port map (
            i_wrclk => rx_clk,
            i_wrrst => bd0_rst,
            i_wren  => rx0_rxvalid,
            i_wrdata=> rx0_rxdata,
            o_full  => o_rx_full,
    
            i_rdclk => i_clk,
            i_rdrst => i_rstn,
            i_rden  => i_rx_rden,
            o_rddata=> o_rxdata,
            o_empty => o_rx_empty
        );
    
TX0: entity work.uart_tx
    port map ( 
            i_clk       =>i_clk,
            i_rstn       =>i_rstn,
            i_baud_clk  =>bd0_clk,
            o_clk  =>tx_clk,
            
            i_en        =>i_en,
            o_done      =>bd0_txdone,
            i_parity    => '0',
            i_txdata    =>txf0_txdata,
            i_txen      =>tx_drdy,

            o_tx        =>o_tx
    );


RX0: entity work.uart_rx
    port map (
            i_clk       =>i_clk,
            i_rstn       =>i_rstn,
            
            i_en        =>i_en,
            
            i_baud_clk  =>bd0_clk,
            o_clk  =>rx_clk,

            i_parity    =>i_parity,

            o_rxdata    =>rx0_rxdata,
            o_rxvalid   =>rx0_rxvalid,

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