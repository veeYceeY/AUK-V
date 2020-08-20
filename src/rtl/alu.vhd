----------------------------------------------------------------------------------
-- Company: SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: 24.04.2020 14:55:58
-- Design Name: 
-- Module Name: microcode_mem - Behavioral
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

entity alu is
  Port (
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            i_operation : in std_logic_vector(3 downto 0);
            
            i_rs1 : in std_logic_vector(31 downto 0);
            i_rs2 : in std_logic_vector(31 downto 0);
            
            o_rd  : out std_logic_vector(31 downto 0)
            --o_ov : out std_logic
   );
end alu;

architecture Behavioral of alu is

signal result : std_logic_vector(31 downto 0);
signal sum : std_logic_vector(31 downto 0);
signal dif : std_logic_vector(31 downto 0);
signal anded : std_logic_vector(31 downto 0);
signal ored : std_logic_vector(31 downto 0);
signal xored : std_logic_vector(31 downto 0);
signal shiftleft : std_logic_vector(31 downto 0);
signal shiftright_logic : std_logic_vector(31 downto 0);
signal shiftright_arith : std_logic_vector(31 downto 0);
signal zero : std_logic_vector(31 downto 0);
signal sign : std_logic_vector(31 downto 0);
signal shamt : integer;
signal s_lt : std_logic;
signal s_ge : std_logic;
signal s_eq : std_logic;
signal s_ne : std_logic;

signal ref : std_logic_vector(31 downto 0);

begin

shamt <= to_integer(unsigned(i_rs2(4 downto 0)));

sum   <= i_rs1 + i_rs2;
dif   <= i_rs1 - i_rs2;
ored  <= (i_rs1 or i_rs2);
anded <= (i_rs1 and i_rs2);
xored <= (i_rs1 xor i_rs2);

zero <= x"00000000";
sign <= x"00000000" when i_rs1(31) = '0' else x"00000000";
ref <= zero when i_rs1(31)='0' else sign;
--shiftleft <= i_rs1((31-1) downto 0 )   & zero((1-1) downto 0) when shamt=1 else 
--shiftright_logic <= zero(shamt-1 downto 0) & i_rs1((31) downto shamt);
--shiftright_arith <= sign(shamt-1 downto 0) & i_rs1((31) downto shamt);

--shiftleft <= x"00000000";
--shiftright_logic <= x"00000000";
--shiftright_arith <= x"00000000";


shiftleft <= i_rs1((31-0) downto 0 )                           when shamt=0 else 
             i_rs1((31-1) downto 0 )   & zero((1-1) downto 0)  when shamt=1 else 
             i_rs1((31-2) downto 0 )   & zero((2-1) downto 0)  when shamt=2 else 
             i_rs1((31-3) downto 0 )   & zero((3-1) downto 0)  when shamt=3 else 
             i_rs1((31-4) downto 0 )   & zero((4-1) downto 0)  when shamt=4 else 
             i_rs1((31-5) downto 0 )   & zero((5-1) downto 0)  when shamt=5 else 
             i_rs1((31-6) downto 0 )   & zero((6-1) downto 0)  when shamt=6 else 
             i_rs1((31-7) downto 0 )   & zero((7-1) downto 0)  when shamt=7 else 
             i_rs1((31-8) downto 0 )   & zero((8-1) downto 0)  when shamt=8 else 
             i_rs1((31-9) downto 0 )   & zero((9-1) downto 0)  when shamt=9 else 
             i_rs1((31-10) downto 0 )  & zero((10-1) downto 0) when shamt=10 else 
             i_rs1((31-11) downto 0 )  & zero((11-1) downto 0) when shamt=11 else 
             i_rs1((31-12) downto 0 )  & zero((12-1) downto 0) when shamt=12 else 
             i_rs1((31-13) downto 0 )  & zero((13-1) downto 0) when shamt=13 else 
             i_rs1((31-14) downto 0 )  & zero((14-1) downto 0) when shamt=14 else 
             i_rs1((31-15) downto 0 )  & zero((15-1) downto 0) when shamt=15 else 
             i_rs1((31-16) downto 0 )  & zero((16-1) downto 0) when shamt=16 else 
             i_rs1((31-17) downto 0 )  & zero((17-1) downto 0) when shamt=17 else 
             i_rs1((31-18) downto 0 )  & zero((18-1) downto 0) when shamt=18 else 
             i_rs1((31-19) downto 0 )  & zero((19-1) downto 0) when shamt=19 else 
             i_rs1((31-20) downto 0 )  & zero((20-1) downto 0) when shamt=20 else 
             i_rs1((31-21) downto 0 )  & zero((21-1) downto 0) when shamt=21 else 
             i_rs1((31-22) downto 0 )  & zero((22-1) downto 0) when shamt=22 else 
             i_rs1((31-23) downto 0 )  & zero((23-1) downto 0) when shamt=23 else 
             i_rs1((31-24) downto 0 )  & zero((24-1) downto 0) when shamt=24 else 
             i_rs1((31-25) downto 0 )  & zero((25-1) downto 0) when shamt=25 else 
             i_rs1((31-26) downto 0 )  & zero((26-1) downto 0) when shamt=26 else 
             i_rs1((31-27) downto 0 )  & zero((27-1) downto 0) when shamt=27 else 
             i_rs1((31-28) downto 0 )  & zero((28-1) downto 0) when shamt=28 else 
             i_rs1((31-29) downto 0 )  & zero((29-1) downto 0) when shamt=29 else 
             i_rs1((31-30) downto 0 )  & zero((30-1) downto 0) when shamt=30 else 
             i_rs1((31-31) downto 0 )  & zero((31-1) downto 0) when shamt=31 ;
             
             
shiftright_logic <=                       i_rs1((31-0) downto 0 )      when shamt=0 else 
                    zero((1-1) downto 0)  & i_rs1((31) downto  1)   when shamt=1 else 
                    zero((2-1) downto 0)  & i_rs1((31) downto  2)   when shamt=2 else 
                    zero((3-1) downto 0)  & i_rs1((31) downto  3)   when shamt=3 else 
                    zero((4-1) downto 0)  & i_rs1((31) downto  4)   when shamt=4 else 
                    zero((5-1) downto 0)  & i_rs1((31) downto  5)   when shamt=5 else 
                    zero((6-1) downto 0)  & i_rs1((31) downto  6)   when shamt=6 else 
                    zero((7-1) downto 0)  & i_rs1((31) downto  7)   when shamt=7 else 
                    zero((8-1) downto 0)  & i_rs1((31) downto  8)   when shamt=8 else 
                    zero((9-1) downto 0)  & i_rs1((31) downto  9)   when shamt=9 else 
                    zero((10-1) downto 0) & i_rs1((31) downto 10)  when shamt=10 else 
                    zero((11-1) downto 0) & i_rs1((31) downto 11)  when shamt=11 else 
                    zero((12-1) downto 0) & i_rs1((31) downto 12)  when shamt=12 else 
                    zero((13-1) downto 0) & i_rs1((31) downto 13)  when shamt=13 else 
                    zero((14-1) downto 0) & i_rs1((31) downto 14)  when shamt=14 else 
                    zero((15-1) downto 0) & i_rs1((31) downto 15)  when shamt=15 else 
                    zero((16-1) downto 0) & i_rs1((31) downto 16)  when shamt=16 else 
                    zero((17-1) downto 0) & i_rs1((31) downto 17)  when shamt=17 else 
                    zero((18-1) downto 0) & i_rs1((31) downto 18)  when shamt=18 else 
                    zero((19-1) downto 0) & i_rs1((31) downto 19)  when shamt=19 else 
                    zero((20-1) downto 0) & i_rs1((31) downto 20)  when shamt=20 else 
                    zero((21-1) downto 0) & i_rs1((31) downto 21)  when shamt=21 else 
                    zero((22-1) downto 0) & i_rs1((31) downto 22)  when shamt=22 else 
                    zero((23-1) downto 0) & i_rs1((31) downto 23)  when shamt=23 else 
                    zero((24-1) downto 0) & i_rs1((31) downto 24)  when shamt=24 else 
                    zero((25-1) downto 0) & i_rs1((31) downto 25)  when shamt=25 else 
                    zero((26-1) downto 0) & i_rs1((31) downto 26)  when shamt=26 else 
                    zero((27-1) downto 0) & i_rs1((31) downto 27)  when shamt=27 else 
                    zero((28-1) downto 0) & i_rs1((31) downto 28)  when shamt=28 else 
                    zero((29-1) downto 0) & i_rs1((31) downto 29)  when shamt=29 else 
                    zero((30-1) downto 0) & i_rs1((31) downto 30)  when shamt=30 else 
                    zero((31-1) downto 0) & i_rs1((31) downto 31)  when shamt=31 ;
             
shiftright_arith <=                       i_rs1((31-0) downto 0 )      when shamt=0 else 
                    sign((1-1) downto 0)  & i_rs1((31) downto  1)   when shamt=1 else 
                    sign((2-1) downto 0)  & i_rs1((31) downto  2)   when shamt=2 else 
                    sign((3-1) downto 0)  & i_rs1((31) downto  3)   when shamt=3 else 
                    sign((4-1) downto 0)  & i_rs1((31) downto  4)   when shamt=4 else 
                    sign((5-1) downto 0)  & i_rs1((31) downto  5)   when shamt=5 else 
                    sign((6-1) downto 0)  & i_rs1((31) downto  6)   when shamt=6 else 
                    sign((7-1) downto 0)  & i_rs1((31) downto  7)   when shamt=7 else 
                    sign((8-1) downto 0)  & i_rs1((31) downto  8)   when shamt=8 else 
                    sign((9-1) downto 0)  & i_rs1((31) downto  9)   when shamt=9 else 
                    sign((10-1) downto 0) & i_rs1((31) downto 10)  when shamt=10 else 
                    sign((11-1) downto 0) & i_rs1((31) downto 11)  when shamt=11 else 
                    sign((12-1) downto 0) & i_rs1((31) downto 12)  when shamt=12 else 
                    sign((13-1) downto 0) & i_rs1((31) downto 13)  when shamt=13 else 
                    sign((14-1) downto 0) & i_rs1((31) downto 14)  when shamt=14 else 
                    sign((15-1) downto 0) & i_rs1((31) downto 15)  when shamt=15 else 
                    sign((16-1) downto 0) & i_rs1((31) downto 16)  when shamt=16 else 
                    sign((17-1) downto 0) & i_rs1((31) downto 17)  when shamt=17 else 
                    sign((18-1) downto 0) & i_rs1((31) downto 18)  when shamt=18 else 
                    sign((19-1) downto 0) & i_rs1((31) downto 19)  when shamt=19 else 
                    sign((20-1) downto 0) & i_rs1((31) downto 20)  when shamt=20 else 
                    sign((21-1) downto 0) & i_rs1((31) downto 21)  when shamt=21 else 
                    sign((22-1) downto 0) & i_rs1((31) downto 22)  when shamt=22 else 
                    sign((23-1) downto 0) & i_rs1((31) downto 23)  when shamt=23 else 
                    sign((24-1) downto 0) & i_rs1((31) downto 24)  when shamt=24 else 
                    sign((25-1) downto 0) & i_rs1((31) downto 25)  when shamt=25 else 
                    sign((26-1) downto 0) & i_rs1((31) downto 26)  when shamt=26 else 
                    sign((27-1) downto 0) & i_rs1((31) downto 27)  when shamt=27 else 
                    sign((28-1) downto 0) & i_rs1((31) downto 28)  when shamt=28 else 
                    sign((29-1) downto 0) & i_rs1((31) downto 29)  when shamt=29 else 
                    sign((30-1) downto 0) & i_rs1((31) downto 30)  when shamt=30 else 
                    sign((31-1) downto 0) & i_rs1((31) downto 31)  when shamt=31 ;

--s_eq<= '1' when i_rs1 = i_rs2 else '0';
--s_ne<= not s_eq;
--s_lt <= '1' when i_rs2 < i_rs1 else '0';
--s_ge <= not s_lt;



result <=   sum                 when i_operation = x"0" else
            dif                 when i_operation = x"1" else
            ored                when i_operation = x"2" else
            anded               when i_operation = x"3" else
            xored               when i_operation = x"4" else
            shiftleft           when i_operation = x"5" else
            shiftright_arith    when i_operation = x"6" else
            shiftright_logic    when i_operation = x"7" ;
--o_rd <= (others => '0') when i_rst= '1' else result(31 downto 0) when rising_edge(i_clk);
--o_ov <=  '0' when i_rst = '1' else result(32) when rising_edge(i_clk);
o_rd <= (others => '0') when i_rst= '1' else result(31 downto 0);
--o_ov <=  '0' when i_rst = '1' else result(32);

end Behavioral;
