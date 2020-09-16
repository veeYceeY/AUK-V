library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;


entity wb_master is
    port (
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            i_en     : in std_logic;
            i_we     : in std_logic;
            i_addr   : in std_logic_vector(31 downto 0);
            i_data   : in std_logic_vector(31 downto 0);
            i_strobe : in std_logic_vector(3 downto 0);
            o_valid  : out std_logic;
            o_data   : out std_logic_vector(31 downto 0);

            i_wb  : in t_in_wb_master;
            o_wb  : out t_out_wb_master
    );

end entity;

architecture behave of wb_master is 
type t_state is (ST_IDLE,ST_RD_ACK_WAIT,ST_WR_ACK_WAIT);
signal state : t_state;
signal r_ack: std_logic;
begin

    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            state <= ST_IDLE;
            o_wb.addr <= (others=>'0');
            o_wb.data <= (others=>'0');
            o_wb.sel <= "0000";
            o_wb.cyc <= '0';
            o_wb.stb <= '0';
            o_wb.we <= '0';
        elsif rising_edge(i_clk) then
            case state is 
                when ST_IDLE =>
                    if i_en ='1' and i_we ='1' then
                        o_wb.addr <= i_addr;
                        o_wb.data <= i_data;
                        o_wb.sel <= i_strobe;
                        o_wb.cyc <= '1';
                        o_wb.stb <= '1';
                        o_wb.we <= '1';
                        state<=ST_WR_ACK_WAIT;
                    elsif i_en ='1' and i_we ='0' then
                        o_wb.addr <= i_addr;
                        --o_wb.data <= i_data;
                        o_wb.sel <= i_strobe;
                        o_wb.cyc <= '1';
                        o_wb.stb <= '1';
                        o_wb.we <= '0';
                        state<=ST_RD_ACK_WAIT;
                    end if;
                    r_ack<='0';
                when ST_RD_ACK_WAIT =>
                    if i_wb.ack = '1' then
                        o_data <= i_wb.data;
                        o_wb.cyc <= '0';
                        o_wb.stb <= '0';
                        r_ack<='1';
                        state <= ST_IDLE;
                    end if;
                when ST_WR_ACK_WAIT =>
                    if i_wb.ack = '1' then
                        o_data <= i_wb.data;
                        o_wb.cyc <= '0';
                        o_wb.stb <= '0';
                        o_wb.we <= '0';
                        r_ack<='1';
                        state <= ST_IDLE;
                    end if;
            end case;
        end if;
    end process;
o_valid <= r_ack;
end behave;