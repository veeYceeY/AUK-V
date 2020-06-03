----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: Veeyceey
-- 
-- Create Date: 25.05.2020 11:33:00
-- Design Name: 
-- Module Name: tb_sciv_core - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_sciv_core is
--  Port ( );
end tb_sciv_core;

architecture Behavioral of tb_sciv_core is

type mem_type is array(63 downto 0) of std_logic_vector(31 downto 0);
signal clk             : std_logic;
signal rst             : std_logic;
signal data_mem_en     : std_logic;
signal data_mem_we     : std_logic;
signal data_mem_addr   : std_logic_vector(31 downto 0);
signal data_mem_data_in   : std_logic_vector(31 downto 0);
signal data_mem_valid  : std_logic;
signal data_mem_data_out   : std_logic_vector(31 downto 0);
signal data_mem_strobe : std_logic_vector(3 downto 0);
signal code_mem_en     : std_logic;
signal code_mem_addr   : std_logic_vector(31 downto 0);
signal code_mem_data   : std_logic_vector(31 downto 0);
signal code_mem_valid  : std_logic;

signal code_mem : mem_type;
begin







SC0:entity work.sciv_core 
  Port map( 
            i_clk             =>clk,
            i_rst             =>rst,
            o_data_mem_en     =>data_mem_en    ,
            o_data_mem_we     =>data_mem_we    ,
            o_data_mem_addr   =>data_mem_addr  ,
            i_data_mem_data   =>data_mem_data_in  ,
            i_data_mem_valid  =>data_mem_valid ,
            o_data_mem_data   =>data_mem_data_out  ,
            o_data_mem_strobe =>data_mem_strobe,
            o_code_mem_en     =>code_mem_en    ,
            o_code_mem_addr   =>code_mem_addr  ,
            i_code_mem_data   =>code_mem_data  ,
            i_code_mem_valid  =>code_mem_valid 
            
            
  );

process
begin
    clk<='0';
    wait for 5ns;
    clk<='1';
    wait for 5ns;
    
end process;

--instruction samples
--
--      LUI     Rd,Immediate
--      AUIPC   Rd,Offset
--      JAL     Rd,Offset
--      JALR    Rd,Rs1,Offset
--      BEQ     Rs1,Rs2,Offset
--      LB      Rd,Offfset(Rs1)
--      SB      Rs2,Offset(Rs1)
--      ADDI    Rd,Rs1,Immediate
--      ADD     Rd,Rs1,Rs2
--      
--      
--      
--      
--      
--      
--      




----------Machine code--------------
code_mem(0) <= x"00044" & "00001" & "0110111";--LUI r1,#44h
code_mem(1) <= x"00032" & "00010" & "0110111";--LUIr2,#32h

code_mem(2) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(3) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(4) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";

code_mem(5) <= "0000000" & "00010" &"00001" &"000" & "00011" & "0110011";--ADD r3,r1,r2


code_mem(6) <= x"0000a" & "00100" & "0110111";
code_mem(7) <= x"00004" & "00101" & "0110111";
code_mem(8) <= x"00001" & "00110" & "0110111";

code_mem(9) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(10) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(11) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";


code_mem(12) <= "0100000" & "00110" &"00100" &"000" & "00100" & "0110011";

code_mem(13) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(14) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(15) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";


code_mem(16) <= "1111111" & "00100" &"00101" &"100" & "10001" & "1100011";
code_mem(17) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(18) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(19) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(20) <= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(21)<= x"00044" & "00001" & "0110111";
code_mem(22)<= x"00032" & "00010" & "0110111";
code_mem(23)<= "0000000" & "00010" &"00001" &"000" & "00011" & "0110011";
code_mem(24)<= x"00044" & "00001" & "0110111";
code_mem(25)<= x"00032" & "00010" & "0110111";
code_mem(26)<= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(27)<= x"00044" & "00001" & "0110111";
code_mem(28)<= x"00032" & "00010" & "0110111";
code_mem(29)<= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
code_mem(30)<= x"00044" & "00001" & "0110111";
code_mem(31)<= x"00032" & "00010" & "0110111";
code_mem(32)<= "0000000" & "00010" &"00001" &"000" & "00000" & "0110011";
--code_mem(0)<= x"00044" & "00001" & "0110111";
--code_mem(0)<= x"00044" & "00001" & "0110111";

code_mem_valid<='1';
codemem:process(clk)
begin

if rst = '1' then
    
elsif rising_edge(clk) then
    code_mem_data <= code_mem(to_integer(unsigned(code_mem_addr(31 downto 2))));
end if;

end process;

process
begin
rst<= '1';
wait for 100ns;
rst<='0';
wait;
end process;



end Behavioral;
