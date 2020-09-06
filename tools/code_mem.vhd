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
    mem(6)<=x"07C00113";
    mem(7)<=x"008000EF";
    mem(8)<=x"0000006F";
    mem(9)<=x"FD810113";
    mem(10)<=x"02112223";
    mem(11)<=x"02812023";
    mem(12)<=x"02810413";
    mem(13)<=x"07000793";
    mem(14)<=x"FEF42423";
    mem(15)<=x"07400793";
    mem(16)<=x"FEF42223";
    mem(17)<=x"07800793";
    mem(18)<=x"FEF42023";
    mem(19)<=x"FE842783";
    mem(20)<=x"00500713";
    mem(21)<=x"00E7A023";
    mem(22)<=x"FE442783";
    mem(23)<=x"00A00713";
    mem(24)<=x"00E7A023";
    mem(25)<=x"FE842783";
    mem(26)<=x"0007A703";
    mem(27)<=x"FE442783";
    mem(28)<=x"0007A783";
    mem(29)<=x"00F70733";
    mem(30)<=x"FE042783";
    mem(31)<=x"00E7A023";
    mem(32)<=x"000017B7";
    mem(33)<=x"00178793";
    mem(34)<=x"FCF42E23";
    mem(35)<=x"FDC42783";
    mem(36)<=x"08600713";
    mem(37)<=x"00E7A023";
    mem(38)<=x"FE042A23";
    mem(39)<=x"0100006F";
    mem(40)<=x"FF442783";
    mem(41)<=x"00178793";
    mem(42)<=x"FEF42A23";
    mem(43)<=x"FF442703";
    mem(44)<=x"0C700793";
    mem(45)<=x"FEE7D6E3";
    mem(46)<=x"04500593";
    mem(47)<=x"FDC42503";
    mem(48)<=x"060000EF";
    mem(49)<=x"FE042823";
    mem(50)<=x"0100006F";
    mem(51)<=x"FF042783";
    mem(52)<=x"00178793";
    mem(53)<=x"FEF42823";
    mem(54)<=x"FF042703";
    mem(55)<=x"12B00793";
    mem(56)<=x"FEE7D6E3";
    mem(57)<=x"07600593";
    mem(58)<=x"FDC42503";
    mem(59)<=x"034000EF";
    mem(60)<=x"FE042623";
    mem(61)<=x"0100006F";
    mem(62)<=x"FEC42783";
    mem(63)<=x"00178793";
    mem(64)<=x"FEF42623";
    mem(65)<=x"FEC42703";
    mem(66)<=x"0C700793";
    mem(67)<=x"FEE7D6E3";
    mem(68)<=x"0E300593";
    mem(69)<=x"FDC42503";
    mem(70)<=x"008000EF";
    mem(71)<=x"F7DFF06F";
    mem(72)<=x"FF010113";
    mem(73)<=x"00812623";
    mem(74)<=x"01010413";
    mem(75)<=x"FEA42A23";
    mem(76)<=x"FEB42823";
    mem(77)<=x"FF442783";
    mem(78)<=x"FF042703";
    mem(79)<=x"00E7A023";
    mem(80)<=x"00000013";
    mem(81)<=x"00C12403";
    mem(82)<=x"01010113";
    mem(83)<=x"00008067";
end behave;
