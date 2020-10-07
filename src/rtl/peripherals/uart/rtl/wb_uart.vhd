library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;




entity wb_uart is
    port(
            i_clk : std_logic;
            i_rst : std_logic;
            
            i_s_wb: in t_out_wb_master;
            o_s_wb: out t_in_wb_master;
            
            o_tx : out std_logic;
            i_rx : in std_logic
    );
end wb_uart;

architecture beh of wb_uart is 
signal wren : std_logic;
signal rden : std_logic;
signal fifowren : std_logic;
signal fiforden : std_logic;
signal rstn : std_logic;
signal addr : std_logic_vector(1 downto 0);
signal rxdata : std_logic_vector(7 downto 0);
signal txdata : std_logic_vector(7 downto 0);
signal status : std_logic_vector(31 downto 0);
signal bauddiv : std_logic_vector(31 downto 0);
signal tx_full : std_logic;
signal rx_full : std_logic;
signal tx_empty : std_logic;
signal rx_empty : std_logic;
begin

wren<= i_s_wb.stb and i_s_wb.cyc and i_s_wb.we ;
rden<= i_s_wb.stb and i_s_wb.cyc and (not i_s_wb.we) ;
rstn<= not i_rst;
addr<= i_s_wb.addr(3 downto 2);
fifowren<= '1' when addr = "01" and rising_edge(i_clk);
fiforden<= '1' when addr = "00" and rising_edge(i_clk);
process(i_clk,i_rst)
begin
    if i_rst= '1' then
        fifowren<= '0';
    elsif rising_edge(i_clk) then
        if wren='1' and addr = "01" then
            fifowren<= '1';
        else
            fifowren<= '0';
        end if;
        if rden='1' and addr = "00" then
            fiforden<= '1';
        else
            fiforden<= '0';
        end if;
    end if;
end process;

process(i_clk,i_rst)
begin
    if i_rst= '1' then
        
    elsif rising_edge(i_clk) then
        if wren='1' then
            if addr = "01" then
                txdata<= i_s_wb.data(7 downto 0);
            elsif addr = "10" then
                bauddiv<= i_s_wb.data;
            end if;
        end if;
    end if;
end process;
UART0: entity work.uart 
    port map(
            i_clk      =>i_clk,
            i_rstn     =>i_rst,
            i_en       =>'1',
            i_parity   =>'0',
            i_baud_sel =>bauddiv,
            i_txdata   =>txdata,
            i_tx_wren  =>fifowren,
            o_tx_full  =>tx_full,
            o_tx_empty =>tx_empty,
            i_rx_rden  =>fiforden,
            o_rxdata   =>rxdata,
            o_rx_full  =>rx_full,
            o_rx_empty =>rx_empty,
            o_tx       =>o_tx,
            i_rx       =>i_rx
    );

status<=x"0000000" & tx_full & tx_empty & rx_full & rx_empty;
process(addr,rden,rxdata,status)
begin
    if rden='1' then
        if addr = "00" then
            o_s_wb.data <= x"000000" & rxdata;
        elsif addr = "11" then
            o_s_wb.data <= status;
        end if;
    end if;
end process;

o_s_wb.ack<= i_s_wb.stb and i_s_wb.cyc;

end beh;
