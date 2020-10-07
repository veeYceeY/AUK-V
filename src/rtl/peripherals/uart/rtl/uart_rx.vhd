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


entity uart_rx is
    port(
            i_clk       : in std_logic;
            i_rstn       : in std_logic;
            i_baud_clk  : in std_logic;

            i_en        : in std_logic;

            i_parity    : in std_logic;

            o_rxdata    : out std_logic_vector(7 downto 0);
            o_rxvalid   : out std_logic;

            i_rx        : in std_logic
    );
end uart_rx;

architecture arch_uart_rx of uart_rx is
    type t_state is (st_idle,st_start,st_data,st_parity,st_stop);
    signal rx_state : t_state;
    signal rx_buff : std_logic_vector(7 downto 0);
    signal err : std_logic;
    signal rx_valid : std_logic;
    signal rx_cdc0: std_logic;
    signal rx_cdc1: std_logic;
    signal rx_valid_cdc0: std_logic;
    signal rx_valid_cdc1: std_logic;
    signal rx_data : std_logic_vector(7 downto 0);
    signal rx_data_cdc0 : std_logic_vector(7 downto 0);
    signal rx_data_cdc1 : std_logic_vector(7 downto 0);
    
    signal count : std_logic_vector(7 downto 0);
    signal parity : std_logic;
begin

process(i_baud_clk,i_rstn)
begin
    if i_rstn = '1' then
        rx_cdc0 <= '1';
        rx_cdc1 <= '1';
    elsif rising_edge(i_baud_clk) then
        rx_cdc0 <= i_rx;
        rx_cdc1 <= rx_cdc0;
    end if;
end process;

process(i_baud_clk,i_rstn)
begin
    if i_rstn = '1' then
        rx_state<= st_start;
        rx_data<= (others => '0');
        rx_buff<= (others => '0');
        count<= (others => '0');
        rx_valid<='0';
        err<='0';
    elsif rising_edge(i_baud_clk) then
        if i_en = '1' then
            case rx_state is 
        
            when st_start =>
                rx_valid <= '0';
                if rx_cdc1 = '0' then
                    rx_state <= st_data;
                    count<= x"08";
                end if;
            when st_data =>
                    if count >0 then
                        count<= count-1;
                        rx_buff<= rx_cdc1 & rx_buff(7 downto 1);
                    else
                        parity <= rx_cdc1;
                        rx_state <= st_stop;
                    end if;
            when st_parity =>
                    --parity <= rx_cdc1;
                    rx_state <= st_stop;
            when st_stop =>
                rx_state <= st_start;
                if rx_cdc1 = '1' then
                    rx_data<= rx_buff;
                    rx_valid<='1';
                else
                    err <='1';
                end if;
            when others  =>
                rx_state <= st_start;
            end case;
        end if;
    end if;
end process;


process(i_clk,i_rstn)
begin
    if i_rstn = '1' then
        rx_data_cdc0 <= (others => '0');
        rx_data_cdc1 <= (others => '0');
        rx_valid_cdc0 <= '0';
        rx_valid_cdc1 <= '0';
    elsif rising_edge(i_clk) then
        rx_data_cdc0 <= rx_data;
        rx_data_cdc1 <= rx_data_cdc0 ;
        rx_valid_cdc0 <= rx_valid;
        rx_valid_cdc1 <= rx_valid_cdc0;
    end if;
end process;



o_rxdata    <= rx_data_cdc1;
o_rxvalid   <= rx_valid_cdc1;

end arch_uart_rx;



    