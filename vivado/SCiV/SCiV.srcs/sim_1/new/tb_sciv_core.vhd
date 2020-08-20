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
use std.textio.all;
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

signal sc0_porta   : std_logic_vector(31 downto 0);
signal sc0_portb   : std_logic_vector(31 downto 0);

signal code_mem : mem_type;
signal data_mem : mem_type;
begin







--SC0:entity work.sciv_core 
--  Port map( 
--            i_clk             =>clk,
--            i_rst             =>rst,
--            o_data_mem_en     =>data_mem_en    ,
--            o_data_mem_we     =>data_mem_we    ,
--            o_data_mem_addr   =>data_mem_addr  ,
--            i_data_mem_data   =>data_mem_data_in  ,
--            i_data_mem_valid  =>data_mem_valid ,
--            o_data_mem_data   =>data_mem_data_out  ,
--            o_data_mem_strobe =>data_mem_strobe,
--            o_code_mem_en     =>code_mem_en    ,
--            o_code_mem_addr   =>code_mem_addr  ,
--            i_code_mem_data   =>code_mem_data  ,
--            i_code_mem_valid  =>code_mem_valid 
            
            
--  );


SC0:entity work.sciv_example_system 
  Port map( 
            i_clk        =>clk,
            i_rst        =>rst,
            i_port_a     =>sc0_porta,
            o_port_b     =>sc0_portb    
            
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
code_mem(0) <= x"00044" & "00100" & "0110111";--LUI r1,#00044000h
code_mem(1) <= x"00032" & "00101" & "0110111";--LUI r2,#00032000h
code_mem(2) <= "0000000" & "01100" &"00100" &"101" & "00100" & "0010011";--srlI R1,12
code_mem(3) <= "0000000" & "01100" &"00101" &"101" & "00101" & "0010011";--srlI R2,12
code_mem(4) <= "0000000" & "00101" &"00100" &"000" & "00011" & "0110011";--ADD r3,r1,r2
code_mem(5) <= x"0000a" & "00001" & "0110111";--LUI r1,#00044000h
code_mem(6) <= x"00003" & "00010" & "0110111";--LUI r2,#00032000h
code_mem(7) <= "0000000" & "01100" &"00001" &"101" & "00001" & "0010011";--srlI R1,12
code_mem(8) <= "0000000" & "01100" &"00010" &"101" & "00010" & "0010011";--srlI R2,12

code_mem(9) <= x"0000f" & "00100" & "0110111";--LUI r4,0x0000a000
code_mem(10)<= x"00002" & "00101" & "0110111";--LUI r5,0x00004000
code_mem(11)<= x"00001" & "00110" & "0110111";--LUI r6,0x00001000
code_mem(12)<= "0000000" & "01100" &"00100" &"101" & "00100" & "0010011";--srlI R4,12
code_mem(13)<= "0000000" & "01100" &"00101" &"101" & "00101" & "0010011";--srlI R5,12
code_mem(14) <="0000000" & "01100" &"00110" &"101" & "00110" & "0010011";--srlI R6,12
code_mem(15) <= "0100000" & "00110" &"00100" &"000" & "00100" & "0110011";--sub r4,r4,r6
code_mem(16) <= "1111111" & "00100" &"00101" &"100" & "11101" & "1100011";--blt r4,r5,-1
code_mem(17) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
code_mem(18) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
code_mem(19) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
code_mem(20) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";

code_mem(21) <= "0000000" & "00011" &"00000" &"010" & "00110" & "0100011";
code_mem(22) <= "0000000" & "00001" &"00000" &"010" & "00011" & "0100011";
code_mem(23) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(24) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(25) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(26) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(27) <= "0000000" & "00110" &"00000" &"010" & "01001" & "0000011";
code_mem(28) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(29) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(30) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(31) <= "0000000" & "00000" &"00000" &"000" & "00000" & "1100011";--beq r4,r5,-1
code_mem(32) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(33) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(34) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
code_mem(35) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";




--code_mem(21) <= x"00005" & "00100" & "0110111";--LUI r4,0x0000a000
--code_mem(22) <= x"00000" & "00101" & "0110111";--LUI r5,0x00004000
--code_mem(23) <= x"00001" & "00110" & "0110111";--LUI r6,0x00001000
--code_mem(24) <= x"00000" & "00111" & "0110111";--LUI r6,0x00001000
--code_mem(25) <= x"00000" & "01000" & "0110111";--LUI r6,0x00001000
--code_mem(24) <= "0000000" & "01100" &"00100" &"101" & "00100" & "0010011";--srlI R4,12
--code_mem(25) <= "0000000" & "01100" &"00101" &"101" & "00101" & "0010011";--srlI R5,12
--code_mem(26) <= "0000000" & "01100" &"00110" &"101" & "00110" & "0010011";--srlI R6,12
--code_mem(27) <= "0100000" & "00110" &"00100" &"000" & "00100" & "0110011";--sub r4,r4,r6
--code_mem(27) <= "0000000" & "00110" &"00100" &"000" & "01000" & "0110011";--sub r4,r4,r6
--code_mem(28) <= "1111111" & "00100" &"00101" &"100" & "11101" & "1100011";--blt r4,r5,-1
--code_mem(29) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(30) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(31) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(32) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";




----------Machine code--------------
--code_mem(0) <= x"00044" & "00001" & "0110111";--LUI r1,#00044000h
--code_mem(1) <= x"00032" & "00010" & "0110111";--LUI r2,#00032000h

--code_mem(2) <= "0000000" & "00001" &"00010" &"000" & "01000" & "0110011";--nop
--code_mem(3) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop
--code_mem(4) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop

--code_mem(5) <= "0000000" & "01100" &"00001" &"101" & "00001" & "0010011";--srlI R1,12
--code_mem(6) <= "0000000" & "01100" &"00010" &"101" & "00010" & "0010011";--srlI R2,12

--code_mem(7) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop
--code_mem(8) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop
--code_mem(9) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop

--code_mem(10) <= "0000000" & "00010" &"00001" &"000" & "00011" & "0110011";--ADD r3,r1,r2


--code_mem(11) <= x"0000f" & "00100" & "0110111";--LUI r4,0x0000a000
--code_mem(12) <= x"00001" & "00101" & "0110111";--LUI r5,0x00004000
--code_mem(13) <= x"00001" & "00110" & "0110111";--LUI r6,0x00001000


--code_mem(14) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop
--code_mem(15) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop
--code_mem(16) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop

--code_mem(17) <= "0000000" & "01100" &"00100" &"101" & "00100" & "0010011";--srlI R4,12
--code_mem(18) <= "0000000" & "01100" &"00101" &"101" & "00101" & "0010011";--srlI R5,12
--code_mem(19) <= "0000000" & "01100" &"00110" &"101" & "00110" & "0010011";--srlI R6,12

--code_mem(20) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop
--code_mem(21) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop
--code_mem(22) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";--nop

--code_mem(23) <= "0100000" & "00110" &"00100" &"000" & "00100" & "0110011";

--code_mem(24) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(25) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(26) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";


--code_mem(27) <= "1111111" & "00100" &"00101" &"100" & "10001" & "1100011";
--code_mem(28) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(29) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(30) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(31) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(32)<= x"00044" & "00001" & "0110111";
--code_mem(33)<= x"00032" & "00010" & "0110111";
--code_mem(34)<= "0000000" & "10000" &"10000" &"000" & "00011" & "0110011";
--code_mem(35)<= x"00044" & "00001" & "0110111";
--code_mem(36)<= x"00032" & "00010" & "0110111";
--code_mem(37)<= "0000000" & "10000" &"10000"&"000" & "00000" & "0110011";
--code_mem(38)<= x"00044" & "00001" & "0110111";
--code_mem(39)<= x"00032" & "00010" & "0110111";
--code_mem(40)<= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
--code_mem(41)<= x"00044" & "00001" & "0110111";
--code_mem(42)<= x"00032" & "00010" & "0110111";
--code_mem(43)<= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
----code_mem(0)<= x"00044" & "00001" & "0110111";
----code_mem(0)<= x"00044" & "00001" & "0110111";

code_mem_valid<='1';
codemem:process(clk)
begin

if rst = '1' then
    
elsif rising_edge(clk) then
    code_mem_data <= code_mem(to_integer(unsigned(code_mem_addr(31 downto 2))));
end if;

end process;

datamem: process(clk)
begin
    if rst='1' then
    
    elsif rising_edge(clk) then
        if data_mem_en = '1' then
            if data_mem_we = '1' then
                data_mem(to_integer(unsigned(data_mem_addr(31 downto 2)))) <= data_mem_data_out;
                data_mem_valid <= '0';
            else
                data_mem_data_in <= data_mem(to_integer(unsigned(data_mem_addr(31 downto 2)))); 
                data_mem_valid <= '1';
            end if;
            
        else
                data_mem_valid <= '0';
        end if;
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
