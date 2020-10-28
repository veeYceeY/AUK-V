-----sd-----------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: Tue Oct 27 22:23:21 2020
-- Design Name: 
-- Module Name: wb_oc_rom
-- Project Name: AUK-V 
-- Target Devices: 
-- Tool Versions: 
-- Description: On chip ROM with wishbone interface 
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


entity wb_oc_rom is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;
            o_m_wb  : out t_in_wb_master;
            i_m_wb  : in t_out_wb_master
    );
end wb_oc_rom;
architecture behave of wb_oc_rom is
attribute rom_style : string;
type mem_type is array(1023 downto 0) of std_logic_vector(31 downto 0);
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(13 downto 0);
signal mem : mem_type;
signal byte_addr : std_logic_vector(1 downto 0);
signal sel : std_logic_vector(3 downto 0);
begin


    addr <= i_m_wb.addr(15 downto 2)  ;
    sel <= i_m_wb.sel;
    byte_addr <= i_m_wb.addr(1 downto 0)  ;
    data <= mem(to_integer(unsigned((addr)))) when i_m_wb.stb='1'  and i_m_wb.cyc='1' else (others => '0');

    process(addr,sel,byte_addr,data)
    begin
        if sel="1111" then
            o_m_wb.data <=data;
        elsif sel="0011" then
            if byte_addr="01" then
                o_m_wb.data <=x"0000" & data(15 downto 0);
            elsif byte_addr="11" then
                o_m_wb.data <=x"0000" & data(31 downto 16);
            end if;
        elsif sel="0001" then
            if byte_addr="00" then
                o_m_wb.data <=x"000000" & data(7 downto 0);
            elsif byte_addr="01" then
                o_m_wb.data <=x"000000" & data(15 downto 8);
            elsif byte_addr="10" then
                o_m_wb.data <=x"000000" & data(23 downto 16);
            elsif byte_addr="11" then
                o_m_wb.data <=x"000000" & data(31 downto 24);
            end if;
        end if;
    end process;

    o_m_wb.ack <= i_m_wb.stb and i_m_wb.cyc ;


    mem(6)<=x"00000297";
    mem(7)<=x"01C28293";
    mem(8)<=x"30529073";
    mem(9)<=x"00800137";
    mem(10)<=x"1FC10113";
    mem(11)<=x"310000EF";
    mem(12)<=x"0000006F";
    mem(13)<=x"F8010113";
    mem(14)<=x"00012023";
    mem(15)<=x"00112223";
    mem(16)<=x"00212423";
    mem(17)<=x"00312623";
    mem(18)<=x"00412823";
    mem(19)<=x"00512A23";
    mem(20)<=x"00612C23";
    mem(21)<=x"00712E23";
    mem(22)<=x"02812023";
    mem(23)<=x"02912223";
    mem(24)<=x"02A12423";
    mem(25)<=x"02B12623";
    mem(26)<=x"02C12823";
    mem(27)<=x"02D12A23";
    mem(28)<=x"02E12C23";
    mem(29)<=x"02F12E23";
    mem(30)<=x"05012023";
    mem(31)<=x"05112223";
    mem(32)<=x"05212423";
    mem(33)<=x"05312623";
    mem(34)<=x"05412823";
    mem(35)<=x"05512A23";
    mem(36)<=x"05612C23";
    mem(37)<=x"05712E23";
    mem(38)<=x"07812023";
    mem(39)<=x"07912223";
    mem(40)<=x"07A12423";
    mem(41)<=x"07B12623";
    mem(42)<=x"07C12823";
    mem(43)<=x"07D12A23";
    mem(44)<=x"07E12C23";
    mem(45)<=x"07F12E23";
    mem(46)<=x"34202573";
    mem(47)<=x"341025F3";
    mem(48)<=x"00010613";
    mem(49)<=x"3F0000EF";
    mem(50)<=x"00012003";
    mem(51)<=x"00412083";
    mem(52)<=x"00C12183";
    mem(53)<=x"01012203";
    mem(54)<=x"01412283";
    mem(55)<=x"01812303";
    mem(56)<=x"01C12383";
    mem(57)<=x"02012403";
    mem(58)<=x"02412483";
    mem(59)<=x"02812503";
    mem(60)<=x"02C12583";
    mem(61)<=x"03012603";
    mem(62)<=x"03412683";
    mem(63)<=x"03812703";
    mem(64)<=x"03C12783";
    mem(65)<=x"04012803";
    mem(66)<=x"04412883";
    mem(67)<=x"04812903";
    mem(68)<=x"04C12983";
    mem(69)<=x"05012A03";
    mem(70)<=x"05412A83";
    mem(71)<=x"05812B03";
    mem(72)<=x"05C12B83";
    mem(73)<=x"06012C03";
    mem(74)<=x"06412C83";
    mem(75)<=x"06812D03";
    mem(76)<=x"06C12D83";
    mem(77)<=x"07012E03";
    mem(78)<=x"07412E83";
    mem(79)<=x"07812F03";
    mem(80)<=x"07C12F83";
    mem(81)<=x"08010113";
    mem(82)<=x"30200073";
    mem(83)<=x"FF010113";
    mem(84)<=x"00812623";
    mem(85)<=x"01010413";
    mem(86)<=x"FEA42A23";
    mem(87)<=x"FF442703";
    mem(88)<=x"00100793";
    mem(89)<=x"00F71863";
    mem(90)<=x"001007B7";
    mem(91)<=x"10078793";
    mem(92)<=x"0080006F";
    mem(93)<=x"00000793";
    mem(94)<=x"00078513";
    mem(95)<=x"00C12403";
    mem(96)<=x"01010113";
    mem(97)<=x"00008067";
    mem(98)<=x"FF010113";
    mem(99)<=x"00812623";
    mem(100)<=x"01010413";
    mem(101)<=x"FEA42A23";
    mem(102)<=x"FF442783";
    mem(103)<=x"00878793";
    mem(104)<=x"0007A783";
    mem(105)<=x"0017F713";
    mem(106)<=x"00100793";
    mem(107)<=x"00F71663";
    mem(108)<=x"00000793";
    mem(109)<=x"0080006F";
    mem(110)<=x"00100793";
    mem(111)<=x"00078513";
    mem(112)<=x"00C12403";
    mem(113)<=x"01010113";
    mem(114)<=x"00008067";
    mem(115)<=x"FE810113";
    mem(116)<=x"00812A23";
    mem(117)<=x"01810413";
    mem(118)<=x"FEA42A23";
    mem(119)<=x"FEB42823";
    mem(120)<=x"FEC42623";
    mem(121)<=x"FF442783";
    mem(122)<=x"00C78793";
    mem(123)<=x"01600713";
    mem(124)<=x"00E7A023";
    mem(125)<=x"00000013";
    mem(126)<=x"01412403";
    mem(127)<=x"01810113";
    mem(128)<=x"00008067";
    mem(129)<=x"FF010113";
    mem(130)<=x"00812623";
    mem(131)<=x"01010413";
    mem(132)<=x"FEA42A23";
    mem(133)<=x"FF442783";
    mem(134)<=x"00478793";
    mem(135)<=x"0007A783";
    mem(136)<=x"00078513";
    mem(137)<=x"00C12403";
    mem(138)<=x"01010113";
    mem(139)<=x"00008067";
    mem(140)<=x"FF010113";
    mem(141)<=x"00812623";
    mem(142)<=x"01010413";
    mem(143)<=x"FEA42A23";
    mem(144)<=x"FEB42823";
    mem(145)<=x"FF442783";
    mem(146)<=x"FF042703";
    mem(147)<=x"00E7A023";
    mem(148)<=x"00000013";
    mem(149)<=x"00C12403";
    mem(150)<=x"01010113";
    mem(151)<=x"00008067";
    mem(152)<=x"FE810113";
    mem(153)<=x"00112A23";
    mem(154)<=x"00812823";
    mem(155)<=x"01810413";
    mem(156)<=x"FEA42623";
    mem(157)<=x"FEB42423";
    mem(158)<=x"FE042A23";
    mem(159)<=x"02C0006F";
    mem(160)<=x"FF442783";
    mem(161)<=x"FE842703";
    mem(162)<=x"00F707B3";
    mem(163)<=x"0007C783";
    mem(164)<=x"00078593";
    mem(165)<=x"FEC42503";
    mem(166)<=x"F99FF0EF";
    mem(167)<=x"FF442783";
    mem(168)<=x"00178793";
    mem(169)<=x"FEF42A23";
    mem(170)<=x"FF442783";
    mem(171)<=x"FE842703";
    mem(172)<=x"00F707B3";
    mem(173)<=x"0007C783";
    mem(174)<=x"FC0794E3";
    mem(175)<=x"00000013";
    mem(176)<=x"00000013";
    mem(177)<=x"01412083";
    mem(178)<=x"01012403";
    mem(179)<=x"01810113";
    mem(180)<=x"00008067";
    mem(181)<=x"FE810113";
    mem(182)<=x"00812A23";
    mem(183)<=x"01810413";
    mem(184)<=x"FEA42623";
    mem(185)<=x"FE042A23";
    mem(186)<=x"0340006F";
    mem(187)<=x"FE042823";
    mem(188)<=x"0100006F";
    mem(189)<=x"FF042783";
    mem(190)<=x"00178793";
    mem(191)<=x"FEF42823";
    mem(192)<=x"FF042703";
    mem(193)<=x"000017B7";
    mem(194)<=x"38778793";
    mem(195)<=x"FEE7D4E3";
    mem(196)<=x"FF442783";
    mem(197)<=x"00178793";
    mem(198)<=x"FEF42A23";
    mem(199)<=x"FF442703";
    mem(200)<=x"FEC42783";
    mem(201)<=x"FCF744E3";
    mem(202)<=x"00000013";
    mem(203)<=x"00000013";
    mem(204)<=x"01412403";
    mem(205)<=x"01810113";
    mem(206)<=x"00008067";
    mem(207)<=x"FC810113";
    mem(208)<=x"02112A23";
    mem(209)<=x"02812823";
    mem(210)<=x"02912623";
    mem(211)<=x"03810413";
    mem(212)<=x"FCC40793";
    mem(213)<=x"FEF42623";
    mem(214)<=x"FD040793";
    mem(215)<=x"FEF42423";
    mem(216)<=x"FD440793";
    mem(217)<=x"FEF42223";
    mem(218)<=x"FEC42783";
    mem(219)<=x"00500713";
    mem(220)<=x"00E7A023";
    mem(221)<=x"FE842783";
    mem(222)<=x"FF600713";
    mem(223)<=x"00E7A023";
    mem(224)<=x"FEC42783";
    mem(225)<=x"0007A703";
    mem(226)<=x"FE842783";
    mem(227)<=x"0007A783";
    mem(228)<=x"40F70733";
    mem(229)<=x"FE442783";
    mem(230)<=x"00E7A023";
    mem(231)<=x"001007B7";
    mem(232)<=x"00478793";
    mem(233)<=x"FEF42023";
    mem(234)<=x"00100513";
    mem(235)<=x"DA1FF0EF";
    mem(236)<=x"FCA42E23";
    mem(237)<=x"02FAF7B7";
    mem(238)<=x"08078613";
    mem(239)<=x"000027B7";
    mem(240)<=x"58078593";
    mem(241)<=x"FDC42503";
    mem(242)<=x"E05FF0EF";
    mem(243)<=x"08600493";
    mem(244)<=x"08400093";
    mem(245)<=x"3044A073";
    mem(246)<=x"3040B073";
    mem(247)<=x"FE042783";
    mem(248)<=x"08600713";
    mem(249)<=x"00E7A023";
    mem(250)<=x"08600593";
    mem(251)<=x"FE042503";
    mem(252)<=x"094000EF";
    mem(253)<=x"000107B7";
    mem(254)<=x"4DC78593";
    mem(255)<=x"FDC42503";
    mem(256)<=x"E61FF0EF";
    mem(257)<=x"FDC42503";
    mem(258)<=x"D81FF0EF";
    mem(259)<=x"00050713";
    mem(260)<=x"00100793";
    mem(261)<=x"FEF718E3";
    mem(262)<=x"FDC42503";
    mem(263)<=x"DE9FF0EF";
    mem(264)<=x"FCA42C23";
    mem(265)<=x"FD842583";
    mem(266)<=x"FDC42503";
    mem(267)<=x"E05FF0EF";
    mem(268)<=x"FD842703";
    mem(269)<=x"07200793";
    mem(270)<=x"00F71A63";
    mem(271)<=x"00600593";
    mem(272)<=x"FE042503";
    mem(273)<=x"040000EF";
    mem(274)<=x"FBDFF06F";
    mem(275)<=x"FD842703";
    mem(276)<=x"06700793";
    mem(277)<=x"00F71A63";
    mem(278)<=x"00500593";
    mem(279)<=x"FE042503";
    mem(280)<=x"024000EF";
    mem(281)<=x"FA1FF06F";
    mem(282)<=x"FD842703";
    mem(283)<=x"06200793";
    mem(284)<=x"F8F71AE3";
    mem(285)<=x"00300593";
    mem(286)<=x"FE042503";
    mem(287)<=x"008000EF";
    mem(288)<=x"F85FF06F";
    mem(289)<=x"FF010113";
    mem(290)<=x"00812623";
    mem(291)<=x"01010413";
    mem(292)<=x"FEA42A23";
    mem(293)<=x"FEB42823";
    mem(294)<=x"FF442783";
    mem(295)<=x"FF042703";
    mem(296)<=x"00E7A023";
    mem(297)<=x"00000013";
    mem(298)<=x"00C12403";
    mem(299)<=x"01010113";
    mem(300)<=x"00008067";
    mem(301)<=x"FE810113";
    mem(302)<=x"00812A23";
    mem(303)<=x"01810413";
    mem(304)<=x"FEA42A23";
    mem(305)<=x"FEB42823";
    mem(306)<=x"FEC42623";
    mem(307)<=x"00000013";
    mem(308)<=x"01412403";
    mem(309)<=x"01810113";
    mem(310)<=x"00008067";
    mem(311)<=x"2D4B5541";
    mem(312)<=x"61732056";
    mem(313)<=x"48207379";
    mem(314)<=x"69696969";
    mem(315)<=x"0A0D2169";
    mem(316)<=x"00000000";
end behave;
