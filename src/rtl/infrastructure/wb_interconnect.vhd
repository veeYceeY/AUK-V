library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;


entity wb_interconnect is
    port (
            i_clk    : in std_logic;
            i_rst    : in std_logic;
            
            o_m_wb  : out t_in_wb_master;
            i_m_wb  : in t_out_wb_master;

            i_s0_wb  : in t_in_wb_master;
            o_s0_wb  : out t_out_wb_master;

            i_s1_wb  : in t_in_wb_master;
            o_s1_wb  : out t_out_wb_master;

            i_s2_wb  : in t_in_wb_master;
            o_s2_wb  : out t_out_wb_master;

            i_s3_wb  : in t_in_wb_master;
            o_s3_wb  : out t_out_wb_master;

            i_s4_wb  : in t_in_wb_master;
            o_s4_wb  : out t_out_wb_master;

            i_s5_wb  : in t_in_wb_master;
            o_s5_wb  : out t_out_wb_master
    );

end wb_interconnect;

architecture behave of wb_interconnect is 
signal busy: std_logic;
type t_periph is (DEBUG,ROM,GPIO,RAM,S3,S4);
signal periph : t_periph;
begin
--    o_m_wb<=i_s1_wb;
--    o_s1_wb<=i_m_wb;
    process(i_m_wb,i_s0_wb,i_s1_wb,i_s2_wb,i_s3_wb,i_s4_wb,i_s5_wb)
    begin
        if i_rst = '1' then
            busy <= '0';
        else --if rising_edge(i_clk) then
--            if busy = '0' then
--                if i_m_wb.cyc ='1' then
--                    busy <= '1';
                    if i_m_wb.addr <x"00010000" then -- Debug-s0
                        periph<=DEBUG;
                        o_m_wb<=i_s0_wb;

                        o_s0_wb.addr<=i_m_wb.addr;
                        o_s0_wb.sel <=i_m_wb.sel;
                        o_s0_wb.cyc <=i_m_wb.cyc;
                        o_s0_wb.stb <=i_m_wb.stb;
                        o_s0_wb.we  <=i_m_wb.we;
                        o_s0_wb.data<=i_m_wb.data;

--                        o_s1_wb<=idle_out_wb_master;
--                        o_s2_wb<=idle_out_wb_master;
--                        o_s3_wb<=idle_out_wb_master;
--                        o_s4_wb<=idle_out_wb_master;
--                        o_s5_wb<=idle_out_wb_master;
                    elsif i_m_wb.addr<x"00100000" then -- OCM-s1
                        periph<=ROM;
                        o_m_wb<=i_s1_wb;
--                        o_m_wb.data<=i_s1_wb.data;
--                        o_m_wb.ack<=i_s1_wb.ack;
                        o_s1_wb.addr<=i_m_wb.addr-x"00010000";
                        o_s1_wb.sel <=i_m_wb.sel;
                        o_s1_wb.cyc <=i_m_wb.cyc;
                        o_s1_wb.stb <=i_m_wb.stb;
                        o_s1_wb.we  <=i_m_wb.we;
                        o_s1_wb.data<=i_m_wb.data;

--                        o_s0_wb<=idle_out_wb_master;
--                        o_s2_wb<=idle_out_wb_master;
--                        o_s3_wb<=idle_out_wb_master;
--                        o_s4_wb<=idle_out_wb_master;
--                        o_s5_wb<=idle_out_wb_master;
                    elsif i_m_wb.addr<x"00800000" then -- periph-
                        if i_m_wb.addr<x"00100100" then --s2
                            periph<=GPIO;
                            o_m_wb<=i_s2_wb;

                            o_s2_wb.addr<=i_m_wb.addr-x"00100000";
                            o_s2_wb.sel <=i_m_wb.sel;
                            o_s2_wb.cyc <=i_m_wb.cyc;
                            o_s2_wb.stb <=i_m_wb.stb;
                            o_s2_wb.we  <=i_m_wb.we;
                            o_s2_wb.data<=i_m_wb.data;
    
--                            o_s0_wb<=idle_out_wb_master;
--                            o_s1_wb<=idle_out_wb_master;
--                            o_s3_wb<=idle_out_wb_master;
--                            o_s4_wb<=idle_out_wb_master;
--                            o_s5_wb<=idle_out_wb_master;
                        elsif i_m_wb.addr<x"00100200" then --s3
                            periph<=S3;
                            o_m_wb<=i_s3_wb;

                            o_s3_wb.addr<=i_m_wb.addr-x"00100100";
                            o_s3_wb.sel <=i_m_wb.sel;
                            o_s3_wb.cyc <=i_m_wb.cyc;
                            o_s3_wb.stb <=i_m_wb.stb;
                            o_s3_wb.we  <=i_m_wb.we;
                            o_s3_wb.data<=i_m_wb.data;
    
--                            o_s0_wb<=idle_out_wb_master;
--                            o_s1_wb<=idle_out_wb_master;
--                            o_s2_wb<=idle_out_wb_master;
--                            o_s4_wb<=idle_out_wb_master;
--                            o_s5_wb<=idle_out_wb_master;
                        else --s4
                            periph<=S4;
                            o_m_wb<=i_s4_wb;

                            o_s4_wb.addr<=i_m_wb.addr-x"00100200";
                            o_s4_wb.sel <=i_m_wb.sel;
                            o_s4_wb.cyc <=i_m_wb.cyc;
                            o_s4_wb.stb <=i_m_wb.stb;
                            o_s4_wb.we  <=i_m_wb.we;
                            o_s4_wb.data<=i_m_wb.data;
    
--                            o_s0_wb<=idle_out_wb_master;
--                            o_s1_wb<=idle_out_wb_master;
--                            o_s2_wb<=idle_out_wb_master;
--                            o_s3_wb<=idle_out_wb_master;
--                            o_s5_wb<=idle_out_wb_master;
                        end if;
                    else --if i_m_wb.addr(31 downto 16)<x"2000" then -- system memory --s5
                        periph<=RAM;
                        o_m_wb<=i_s5_wb;

                        o_s5_wb.addr<=i_m_wb.addr-x"00800000";
                        o_s5_wb.sel <=i_m_wb.sel;
                        o_s5_wb.cyc <=i_m_wb.cyc;
                        o_s5_wb.stb <=i_m_wb.stb;
                        o_s5_wb.we  <=i_m_wb.we;
                        o_s5_wb.data<=i_m_wb.data;

--                        o_s0_wb<=idle_out_wb_master;
--                        o_s1_wb<=idle_out_wb_master;
--                        o_s2_wb<=idle_out_wb_master;
--                        o_s3_wb<=idle_out_wb_master;
--                        o_s4_wb<=idle_out_wb_master;
--                    end if;
                end if;
--            else
--                if i_m_wb.cyc ='0' then
--                    busy <= '0';
--                    --o_m_wb<=idle_in_wb_master;
--                end if;
--           end if;
        end if;
    end process;
end behave;