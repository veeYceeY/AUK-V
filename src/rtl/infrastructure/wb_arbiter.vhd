library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;

entity wb_arbiter is
    port (
            i_clk    : in std_logic;
            i_rst    : in std_logic;
            
            o_m0_wb  : out t_in_wb_master;
            i_m0_wb  : in t_out_wb_master;

            o_m1_wb  : out t_in_wb_master;
            i_m1_wb  : in t_out_wb_master;

            i_s_wb  : in t_in_wb_master;
            o_s_wb  : out t_out_wb_master
    );

end wb_arbiter;

architecture behave of wb_arbiter is 
type t_state is (IDLE,M0_ACTIVE,M1_ACTIVE);
signal state: t_state;
begin

    process(i_clk,i_rst)
    begin
        if i_rst = '1' then
            state <=IDLE;
        elsif rising_edge(i_clk) then
            case state is 

            when IDLE =>
                if i_m1_wb.cyc = '1' then
                    state <= M1_ACTIVE;
                elsif i_m0_wb.cyc = '1' then
                    state <= M0_ACTIVE;
                end if;
            when M0_ACTIVE =>
                if i_m0_wb.cyc = '0' then
                    state <= IDLE;
                end if;
            when M1_ACTIVE =>
            if i_m1_wb.cyc = '0' then
                state <= IDLE;
            end if;
            end case;
        end if;
    end process;
    
    process(state,i_m0_wb,i_m1_wb,i_s_wb)
    begin
        case state is 

        when IDLE =>
        o_m0_wb <= idle_in_wb_master;
        o_m1_wb <= idle_in_wb_master;
        o_s_wb <= idle_out_wb_master;
        when M0_ACTIVE =>
        o_m0_wb <= i_s_wb;
        o_m1_wb <= idle_in_wb_master;
        o_s_wb  <=i_m0_wb;
        when M1_ACTIVE =>
        o_m1_wb <= i_s_wb;
        o_m0_wb <= idle_in_wb_master;
        o_s_wb  <=i_m1_wb;
        end case;
    end process;
end behave;