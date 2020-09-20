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
    mem(6)<=x"00000297";
    mem(7)<=x"01828293";
    mem(8)<=x"00800137";
    mem(9)<=x"7FF10113";
    mem(10)<=x"120000EF";
    mem(11)<=x"0000006F";
    mem(12)<=x"F8010113";
    mem(13)<=x"00012023";
    mem(14)<=x"00112223";
    mem(15)<=x"00212423";
    mem(16)<=x"00312623";
    mem(17)<=x"00412823";
    mem(18)<=x"00512A23";
    mem(19)<=x"00612C23";
    mem(20)<=x"00712E23";
    mem(21)<=x"02812023";
    mem(22)<=x"02912223";
    mem(23)<=x"02A12423";
    mem(24)<=x"02B12623";
    mem(25)<=x"02C12823";
    mem(26)<=x"02D12A23";
    mem(27)<=x"02E12C23";
    mem(28)<=x"02F12E23";
    mem(29)<=x"05012023";
    mem(30)<=x"05112223";
    mem(31)<=x"05212423";
    mem(32)<=x"05312623";
    mem(33)<=x"05412823";
    mem(34)<=x"05512A23";
    mem(35)<=x"05612C23";
    mem(36)<=x"05712E23";
    mem(37)<=x"07812023";
    mem(38)<=x"07912223";
    mem(39)<=x"07A12423";
    mem(40)<=x"07B12623";
    mem(41)<=x"07C12823";
    mem(42)<=x"07D12A23";
    mem(43)<=x"07E12C23";
    mem(44)<=x"07F12E23";
    mem(45)<=x"34202573";
    mem(46)<=x"341025F3";
    mem(47)<=x"00010613";
    mem(48)<=x"1D0000EF";
    mem(49)<=x"00012003";
    mem(50)<=x"00412083";
    mem(51)<=x"00C12183";
    mem(52)<=x"01012203";
    mem(53)<=x"01412283";
    mem(54)<=x"01812303";
    mem(55)<=x"01C12383";
    mem(56)<=x"02012403";
    mem(57)<=x"02412483";
    mem(58)<=x"02812503";
    mem(59)<=x"02C12583";
    mem(60)<=x"03012603";
    mem(61)<=x"03412683";
    mem(62)<=x"03812703";
    mem(63)<=x"03C12783";
    mem(64)<=x"04012803";
    mem(65)<=x"04412883";
    mem(66)<=x"04812903";
    mem(67)<=x"04C12983";
    mem(68)<=x"05012A03";
    mem(69)<=x"05412A83";
    mem(70)<=x"05812B03";
    mem(71)<=x"05C12B83";
    mem(72)<=x"06012C03";
    mem(73)<=x"06412C83";
    mem(74)<=x"06812D03";
    mem(75)<=x"06C12D83";
    mem(76)<=x"07012E03";
    mem(77)<=x"07412E83";
    mem(78)<=x"07812F03";
    mem(79)<=x"07C12F83";
    mem(80)<=x"08010113";
    mem(81)<=x"30200073";
    mem(82)<=x"FD010113";
    mem(83)<=x"02112623";
    mem(84)<=x"02812423";
    mem(85)<=x"03010413";
    mem(86)<=x"FD040793";
    mem(87)<=x"FEF42423";
    mem(88)<=x"FD440793";
    mem(89)<=x"FEF42223";
    mem(90)<=x"FD840793";
    mem(91)<=x"FEF42023";
    mem(92)<=x"FE842783";
    mem(93)<=x"00500713";
    mem(94)<=x"00E7A023";
    mem(95)<=x"FE442783";
    mem(96)<=x"FF600713";
    mem(97)<=x"00E7A023";
    mem(98)<=x"FE842783";
    mem(99)<=x"0007A703";
    mem(100)<=x"FE442783";
    mem(101)<=x"0007A783";
    mem(102)<=x"00F70733";
    mem(103)<=x"FE042783";
    mem(104)<=x"00E7A023";
    mem(105)<=x"001007B7";
    mem(106)<=x"00178793";
    mem(107)<=x"FCF42E23";
    mem(108)<=x"FDC42783";
    mem(109)<=x"08600713";
    mem(110)<=x"00E7A023";
    mem(111)<=x"08600593";
    mem(112)<=x"FDC42503";
    mem(113)<=x"09C000EF";
    mem(114)<=x"F9C00793";
    mem(115)<=x"FEF42A23";
    mem(116)<=x"0100006F";
    mem(117)<=x"FF442783";
    mem(118)<=x"00178793";
    mem(119)<=x"FEF42A23";
    mem(120)<=x"FF442703";
    mem(121)<=x"000187B7";
    mem(122)<=x"69F78793";
    mem(123)<=x"FEE7D4E3";
    mem(124)<=x"04500593";
    mem(125)<=x"FDC42503";
    mem(126)<=x"068000EF";
    mem(127)<=x"FE042823";
    mem(128)<=x"0100006F";
    mem(129)<=x"FF042783";
    mem(130)<=x"00178793";
    mem(131)<=x"FEF42823";
    mem(132)<=x"FF042703";
    mem(133)<=x"000317B7";
    mem(134)<=x"D3F78793";
    mem(135)<=x"FEE7D4E3";
    mem(136)<=x"07600593";
    mem(137)<=x"FDC42503";
    mem(138)<=x"038000EF";
    mem(139)<=x"FE042623";
    mem(140)<=x"0100006F";
    mem(141)<=x"FEC42783";
    mem(142)<=x"00178793";
    mem(143)<=x"FEF42623";
    mem(144)<=x"FEC42703";
    mem(145)<=x"000497B7";
    mem(146)<=x"3DF78793";
    mem(147)<=x"FEE7D4E3";
    mem(148)<=x"0E300593";
    mem(149)<=x"FDC42503";
    mem(150)<=x"008000EF";
    mem(151)<=x"F6DFF06F";
    mem(152)<=x"FF010113";
    mem(153)<=x"00812623";
    mem(154)<=x"01010413";
    mem(155)<=x"FEA42A23";
    mem(156)<=x"FEB42823";
    mem(157)<=x"FF442783";
    mem(158)<=x"FF042703";
    mem(159)<=x"00E7A023";
    mem(160)<=x"00000013";
    mem(161)<=x"00C12403";
    mem(162)<=x"01010113";
    mem(163)<=x"00008067";
    mem(164)<=x"FE810113";
    mem(165)<=x"00812A23";
    mem(166)<=x"01810413";
    mem(167)<=x"FEA42A23";
    mem(168)<=x"FEB42823";
    mem(169)<=x"FEC42623";
    mem(170)<=x"00000013";
    mem(171)<=x"01412403";
    mem(172)<=x"01810113";
    mem(173)<=x"00008067";
end behave;
