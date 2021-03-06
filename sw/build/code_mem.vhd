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
    mem(7)<=x"1FC10113";
    mem(8)<=x"0D000713";
    mem(9)<=x"00170713";
    mem(10)<=x"0C000093";
    mem(11)<=x"00E12023";
    mem(12)<=x"00012783";
    mem(13)<=x"00178793";
    mem(14)<=x"FEF12E23";
    mem(15)<=x"FFC12703";
    mem(16)<=x"FEE12C23";
    mem(17)<=x"FC810113";
    mem(18)<=x"02112A23";
    mem(19)<=x"02112823";
    mem(20)<=x"02E12623";
    mem(21)<=x"03810413";
    mem(22)<=x"FC840793";
    mem(23)<=x"FEF42023";
    mem(24)<=x"FCC40793";
    mem(25)<=x"00000013";
    mem(26)<=x"00000013";
    mem(27)<=x"00000013";
    mem(28)<=x"00000013";
    mem(29)<=x"00000013";
    mem(30)<=x"00000013";
    mem(31)<=x"00000013";
    mem(32)<=x"00000013";
    mem(33)<=x"00000013";
    mem(34)<=x"00000013";
    mem(35)<=x"00000013";
    mem(36)<=x"00000013";
    mem(37)<=x"00000013";
    mem(38)<=x"00000013";
    mem(39)<=x"00000013";
    mem(40)<=x"00000013";
    mem(41)<=x"124000EF";
    mem(42)<=x"0000006F";
    mem(43)<=x"FFDFF06F";
    mem(44)<=x"F8010113";
    mem(45)<=x"00012023";
    mem(46)<=x"00112223";
    mem(47)<=x"00212423";
    mem(48)<=x"00312623";
    mem(49)<=x"00412823";
    mem(50)<=x"00512A23";
    mem(51)<=x"00612C23";
    mem(52)<=x"00712E23";
    mem(53)<=x"02812023";
    mem(54)<=x"02912223";
    mem(55)<=x"02A12423";
    mem(56)<=x"02B12623";
    mem(57)<=x"02C12823";
    mem(58)<=x"02D12A23";
    mem(59)<=x"02E12C23";
    mem(60)<=x"02F12E23";
    mem(61)<=x"05012023";
    mem(62)<=x"05112223";
    mem(63)<=x"05212423";
    mem(64)<=x"05312623";
    mem(65)<=x"05412823";
    mem(66)<=x"05512A23";
    mem(67)<=x"05612C23";
    mem(68)<=x"05712E23";
    mem(69)<=x"07812023";
    mem(70)<=x"07912223";
    mem(71)<=x"07A12423";
    mem(72)<=x"07B12623";
    mem(73)<=x"07C12823";
    mem(74)<=x"07D12A23";
    mem(75)<=x"07E12C23";
    mem(76)<=x"07F12E23";
    mem(77)<=x"34202573";
    mem(78)<=x"341025F3";
    mem(79)<=x"00010613";
    mem(80)<=x"1E4000EF";
    mem(81)<=x"00012003";
    mem(82)<=x"00412083";
    mem(83)<=x"00C12183";
    mem(84)<=x"01012203";
    mem(85)<=x"01412283";
    mem(86)<=x"01812303";
    mem(87)<=x"01C12383";
    mem(88)<=x"02012403";
    mem(89)<=x"02412483";
    mem(90)<=x"02812503";
    mem(91)<=x"02C12583";
    mem(92)<=x"03012603";
    mem(93)<=x"03412683";
    mem(94)<=x"03812703";
    mem(95)<=x"03C12783";
    mem(96)<=x"04012803";
    mem(97)<=x"04412883";
    mem(98)<=x"04812903";
    mem(99)<=x"04C12983";
    mem(100)<=x"05012A03";
    mem(101)<=x"05412A83";
    mem(102)<=x"05812B03";
    mem(103)<=x"05C12B83";
    mem(104)<=x"06012C03";
    mem(105)<=x"06412C83";
    mem(106)<=x"06812D03";
    mem(107)<=x"06C12D83";
    mem(108)<=x"07012E03";
    mem(109)<=x"07412E83";
    mem(110)<=x"07812F03";
    mem(111)<=x"07C12F83";
    mem(112)<=x"08010113";
    mem(113)<=x"30200073";
    mem(114)<=x"FC810113";
    mem(115)<=x"02112A23";
    mem(116)<=x"02812823";
    mem(117)<=x"02912623";
    mem(118)<=x"03810413";
    mem(119)<=x"FC840793";
    mem(120)<=x"FEF42023";
    mem(121)<=x"FCC40793";
    mem(122)<=x"FCF42E23";
    mem(123)<=x"FD040793";
    mem(124)<=x"FCF42C23";
    mem(125)<=x"FE042783";
    mem(126)<=x"00500713";
    mem(127)<=x"00E7A023";
    mem(128)<=x"FDC42783";
    mem(129)<=x"FF600713";
    mem(130)<=x"00E7A023";
    mem(131)<=x"FE042783";
    mem(132)<=x"0007A703";
    mem(133)<=x"FDC42783";
    mem(134)<=x"0007A783";
    mem(135)<=x"00F70733";
    mem(136)<=x"FD842783";
    mem(137)<=x"00E7A023";
    mem(138)<=x"001007B7";
    mem(139)<=x"00178793";
    mem(140)<=x"FCF42A23";
    mem(141)<=x"FD442783";
    mem(142)<=x"08600713";
    mem(143)<=x"00E7A023";
    mem(144)<=x"08600593";
    mem(145)<=x"FD442503";
    mem(146)<=x"0AC000EF";
    mem(147)<=x"08600493";
    mem(148)<=x"08400093";
    mem(149)<=x"3044A073";
    mem(150)<=x"3040B073";
    mem(151)<=x"FF600793";
    mem(152)<=x"FEF42623";
    mem(153)<=x"0100006F";
    mem(154)<=x"FEC42783";
    mem(155)<=x"00178793";
    mem(156)<=x"FEF42623";
    mem(157)<=x"FEC42703";
    mem(158)<=x"0007A7B7";
    mem(159)<=x"11F78793";
    mem(160)<=x"FEE7D4E3";
    mem(161)<=x"04500593";
    mem(162)<=x"FD442503";
    mem(163)<=x"068000EF";
    mem(164)<=x"FE042423";
    mem(165)<=x"0100006F";
    mem(166)<=x"FE842783";
    mem(167)<=x"00178793";
    mem(168)<=x"FEF42423";
    mem(169)<=x"FE842703";
    mem(170)<=x"000AB7B7";
    mem(171)<=x"E5F78793";
    mem(172)<=x"FEE7D4E3";
    mem(173)<=x"07600593";
    mem(174)<=x"FD442503";
    mem(175)<=x"038000EF";
    mem(176)<=x"FE042223";
    mem(177)<=x"0100006F";
    mem(178)<=x"FE442783";
    mem(179)<=x"00178793";
    mem(180)<=x"FEF42223";
    mem(181)<=x"FE442703";
    mem(182)<=x"000C37B7";
    mem(183)<=x"4FF78793";
    mem(184)<=x"FEE7D4E3";
    mem(185)<=x"0E300593";
    mem(186)<=x"FD442503";
    mem(187)<=x"008000EF";
    mem(188)<=x"F6DFF06F";
    mem(189)<=x"FF010113";
    mem(190)<=x"00812623";
    mem(191)<=x"01010413";
    mem(192)<=x"FEA42A23";
    mem(193)<=x"FEB42823";
    mem(194)<=x"FF442783";
    mem(195)<=x"FF042703";
    mem(196)<=x"00E7A023";
    mem(197)<=x"00000013";
    mem(198)<=x"00C12403";
    mem(199)<=x"01010113";
    mem(200)<=x"00008067";
    mem(201)<=x"FE810113";
    mem(202)<=x"00812A23";
    mem(203)<=x"01810413";
    mem(204)<=x"FEA42A23";
    mem(205)<=x"FEB42823";
    mem(206)<=x"FEC42623";
    mem(207)<=x"00000013";
    mem(208)<=x"01412403";
    mem(209)<=x"01810113";
    mem(210)<=x"00008067";
end behave;
