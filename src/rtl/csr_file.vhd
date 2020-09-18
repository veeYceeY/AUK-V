----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: Veeyceey
-- 
-- Create Date: 24.05.2020 12:49:36
-- Design Name: 
-- Module Name: sciv_core - Behavioral
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
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;

entity csr_file is 
    port (
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            i_wr_addr : in std_logic_vector(11 downto 0);
            i_rd_addr : in std_logic_vector(11 downto 0);
            
            i_data : in std_logic_vector(31 downto 0);
            i_we : in std_logic;
            i_rd : in std_logic;
            
            i_op : in std_logic_vector(1 downto 0);
            o_data : out std_logic_vector(31 downto 0)
    );

end csr_file;

architecture behave of csr_file is
type csr_type is array(1023 downto 0) of std_logic_vector(31 downto 0);

signal mie : std_logic_vector(31 downto 0);
signal mcause : std_logic_vector(31 downto 0);
signal mepc : std_logic_vector(31 downto 0);
signal mstatus : std_logic_vector(31 downto 0);

begin
--addr<=i_wr_addr(9 downto 0);
--data <= csr(to_integer(unsigned(addr))) when i_we='1' else x"00000000";
--process(i_clk,i_rst)
--begin
--if i_rst = '1' then
--    for i in 0 to 1023 loop
--        csr(i) <= x"00000000" ;
--    end loop;
--elsif rising_edge(i_clk) then
--    if i_we = '1' then
--        if i_op="00" then
--
--        elsif i_op="01" then
--            csr(to_integer(unsigned(addr))) <= i_data ;
--        elsif i_op="11" then
--            csr(to_integer(unsigned(addr))) <= data and (not i_data) ;
--        elsif i_op="10" then
--            csr(to_integer(unsigned(addr))) <= data or i_data ;
--        end if;
--    end if;
--end if;
--
--end process;


process(i_clk,i_rst)
begin
if i_rst = '1' then
   mie<=x"00000000";
elsif rising_edge(i_clk) then
    if i_we = '1' then
      if i_wr_addr = x"304" then
        if i_op="00" then
            mie<=mie;
        elsif i_op="01" then
            mie <= i_data ;
        elsif i_op="10" then
            mie <= mie or i_data ;
        elsif i_op="11" then
            mie <= mie and (not i_data) ;
        end if;
      end if;
    end if;
end if;

end process;


process(i_clk,i_rst)
begin
if i_rst = '1' then
    mstatus<=x"00000000";
elsif rising_edge(i_clk) then
    if i_we = '1' then
      if i_wr_addr = x"300" then
        if i_op="00" then
            mstatus<=mstatus;
        elsif i_op="01" then
            mstatus <= i_data ;
        elsif i_op="10" then
            mstatus <= mstatus or i_data ;
        elsif i_op="11" then
            mstatus <= mstatus and (not i_data) ;
        end if;
      end if;
    end if;
end if;

end process;




process(i_clk,i_rst)
begin
if i_rst = '1' then
    mepc<=x"00000000";
elsif rising_edge(i_clk) then
    if i_we = '1' then
      if i_wr_addr = x"341" then
        if i_op="00" then
            mepc<=mie;
        elsif i_op="01" then
            mepc <= i_data ;
        elsif i_op="10" then
            mepc <= mepc or i_data ;
        elsif i_op="11" then
            mepc <= mepc and (not i_data) ;
        end if;
      end if;
    end if;
end if;

end process;




process(i_clk,i_rst)
begin
if i_rst = '1' then
  mcause<=x"00000000";
elsif rising_edge(i_clk) then
    if i_we = '1' then
      if i_wr_addr = x"342" then
        if i_op="00" then
            mcause<=mcause;
        elsif i_op="01" then
            mcause <= i_data ;
        elsif i_op="10" then
            mcause <= mcause or i_data ;
        elsif i_op="11" then
            mcause <= mcause and (not i_data) ;
        end if;
      end if;
    end if;
end if;

end process;







--csr(to_integer(unsigned(i_wb_addr))) <= i_wb_data when rising_edge(i_clk);

o_data <=   mie         when i_rd='1' and i_rd_addr = x"304" else
            mstatus     when i_rd='1' and i_rd_addr = x"300" else
            mepc        when i_rd='1' and i_rd_addr = x"341" else
            mcause      when i_rd='1' and i_rd_addr = x"342" else
            x"00000000";

end behave;







