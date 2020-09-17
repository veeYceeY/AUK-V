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


entity code_mem is
    port(
            i_en : in std_logic;
            i_addr : in std_logic_vector(31 downto 0);
            o_data : out std_logic_vector(31 downto 0);
            o_valid: out std_logic
    );
end code_mem;
architecture behave of code_mem is
attribute rom_style : string;
type mem_type is array(1023 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
begin


    o_data <= mem(to_integer(unsigned(( i_addr(31 downto 2)))));
    o_valid<='1';


    mem(0)<=x"00000033";
    mem(1)<=x"00000033";
    mem(2)<=x"00000033";
    mem(3)<=x"00000033";
    mem(4)<=x"00000033";
    mem(5)<=x"00000033";
    mem(6)<=x"00800137";
    mem(7)<=x"7FF10113";
    mem(8)<=x"008000EF";
    mem(9)<=x"0000006F";
    mem(10)<=x"FD010113";
    mem(11)<=x"02112623";
    mem(12)<=x"02812423";
    mem(13)<=x"03010413";
    mem(14)<=x"08600093";
    mem(15)<=x"FD040793";
    mem(16)<=x"FEF42423";
    mem(17)<=x"FD440793";
    mem(18)<=x"FEF42223";
    mem(19)<=x"FD840793";
    mem(20)<=x"FEF42023";
    mem(21)<=x"FE842783";
    mem(22)<=x"00500713";
    mem(23)<=x"00E7A023";
    mem(24)<=x"FE442783";
    mem(25)<=x"FF600713";
    mem(26)<=x"00E7A023";
    mem(27)<=x"FE842783";
    mem(28)<=x"0007A703";
    mem(29)<=x"FE442783";
    mem(30)<=x"0007A783";
    mem(31)<=x"00F70733";
    mem(32)<=x"FE042783";
    mem(33)<=x"00E7A023";
    mem(34)<=x"001007B7";
    mem(35)<=x"00178793";
    mem(36)<=x"FCF42E23";
    mem(37)<=x"FDC42783";
    mem(38)<=x"08600713";
    mem(39)<=x"00E7A023";
    mem(40)<=x"3040A073";
    mem(41)<=x"08400093";
    mem(42)<=x"00000013";
    mem(43)<=x"00000013";
    mem(44)<=x"00000013";
    mem(45)<=x"00000013";
    mem(46)<=x"00000013";
    mem(47)<=x"00000013";
    mem(48)<=x"3040B073";
    mem(49)<=x"F9C00793";
    mem(50)<=x"FEF42A23";
    mem(51)<=x"0100006F";
    mem(52)<=x"FF442783";
    mem(53)<=x"00178793";
    mem(54)<=x"FEF42A23";
    mem(55)<=x"FF442703";
    mem(56)<=x"06300793";
    mem(57)<=x"FEE7D6E3";
    mem(58)<=x"04500593";
    mem(59)<=x"FDC42503";
    mem(60)<=x"060000EF";
    mem(61)<=x"FE042823";
    mem(62)<=x"0100006F";
    mem(63)<=x"FF042783";
    mem(64)<=x"00178793";
    mem(65)<=x"FEF42823";
    mem(66)<=x"FF042703";
    mem(67)<=x"0C700793";
    mem(68)<=x"FEE7D6E3";
    mem(69)<=x"07600593";
    mem(70)<=x"FDC42503";
    mem(71)<=x"034000EF";
    mem(72)<=x"FE042623";
    mem(73)<=x"0100006F";
    mem(74)<=x"FEC42783";
    mem(75)<=x"00178793";
    mem(76)<=x"FEF42623";
    mem(77)<=x"FEC42703";
    mem(78)<=x"12B00793";
    mem(79)<=x"FEE7D6E3";
    mem(80)<=x"0E300593";
    mem(81)<=x"FDC42503";
    mem(82)<=x"008000EF";
    mem(83)<=x"F79FF06F";
    mem(84)<=x"FF010113";
    mem(85)<=x"00812623";
    mem(86)<=x"01010413";
    mem(87)<=x"FEA42A23";
    mem(88)<=x"FEB42823";
    mem(89)<=x"FF442783";
    mem(90)<=x"FF042703";
    mem(91)<=x"00E7A023";
    mem(92)<=x"00000013";
    mem(93)<=x"00C12403";
    mem(94)<=x"01010113";
    mem(95)<=x"00008067";
end behave;
