-----sd-----------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: Fri Oct  2 19:12:03 2020
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
    mem(25)<=x"020207B7";
    mem(26)<=x"20278793";
    mem(27)<=x"02F12423";
    mem(28)<=x"030307B7";
    mem(29)<=x"30378793";
    mem(30)<=x"02F11423";
    mem(31)<=x"040407B7";
    mem(32)<=x"40478793";
    mem(33)<=x"02F10423";
    mem(34)<=x"02814783";
    mem(35)<=x"02815783";
    mem(36)<=x"02812783";
    mem(37)<=x"00000013";
    mem(38)<=x"00000013";
    mem(39)<=x"00000013";
    mem(40)<=x"00000013";
    mem(41)<=x"00000013";
    mem(42)<=x"00000013";
    mem(43)<=x"00000013";
    mem(44)<=x"00000013";
    mem(45)<=x"00000013";
    mem(46)<=x"00000013";
    mem(47)<=x"00000013";
    mem(48)<=x"00000013";
    mem(49)<=x"00000013";
    mem(50)<=x"00000013";
    mem(51)<=x"00000013";
    mem(52)<=x"00000013";
    mem(53)<=x"124000EF";
    mem(54)<=x"0000006F";
    mem(55)<=x"FFDFF06F";
    mem(56)<=x"F8010113";
    mem(57)<=x"00012023";
    mem(58)<=x"00112223";
    mem(59)<=x"00212423";
    mem(60)<=x"00312623";
    mem(61)<=x"00412823";
    mem(62)<=x"00512A23";
    mem(63)<=x"00612C23";
    mem(64)<=x"00712E23";
    mem(65)<=x"02812023";
    mem(66)<=x"02912223";
    mem(67)<=x"02A12423";
    mem(68)<=x"02B12623";
    mem(69)<=x"02C12823";
    mem(70)<=x"02D12A23";
    mem(71)<=x"02E12C23";
    mem(72)<=x"02F12E23";
    mem(73)<=x"05012023";
    mem(74)<=x"05112223";
    mem(75)<=x"05212423";
    mem(76)<=x"05312623";
    mem(77)<=x"05412823";
    mem(78)<=x"05512A23";
    mem(79)<=x"05612C23";
    mem(80)<=x"05712E23";
    mem(81)<=x"07812023";
    mem(82)<=x"07912223";
    mem(83)<=x"07A12423";
    mem(84)<=x"07B12623";
    mem(85)<=x"07C12823";
    mem(86)<=x"07D12A23";
    mem(87)<=x"07E12C23";
    mem(88)<=x"07F12E23";
    mem(89)<=x"34202573";
    mem(90)<=x"341025F3";
    mem(91)<=x"00010613";
    mem(92)<=x"358000EF";
    mem(93)<=x"00012003";
    mem(94)<=x"00412083";
    mem(95)<=x"00C12183";
    mem(96)<=x"01012203";
    mem(97)<=x"01412283";
    mem(98)<=x"01812303";
    mem(99)<=x"01C12383";
    mem(100)<=x"02012403";
    mem(101)<=x"02412483";
    mem(102)<=x"02812503";
    mem(103)<=x"02C12583";
    mem(104)<=x"03012603";
    mem(105)<=x"03412683";
    mem(106)<=x"03812703";
    mem(107)<=x"03C12783";
    mem(108)<=x"04012803";
    mem(109)<=x"04412883";
    mem(110)<=x"04812903";
    mem(111)<=x"04C12983";
    mem(112)<=x"05012A03";
    mem(113)<=x"05412A83";
    mem(114)<=x"05812B03";
    mem(115)<=x"05C12B83";
    mem(116)<=x"06012C03";
    mem(117)<=x"06412C83";
    mem(118)<=x"06812D03";
    mem(119)<=x"06C12D83";
    mem(120)<=x"07012E03";
    mem(121)<=x"07412E83";
    mem(122)<=x"07812F03";
    mem(123)<=x"07C12F83";
    mem(124)<=x"08010113";
    mem(125)<=x"30200073";
    mem(126)<=x"FC010113";
    mem(127)<=x"02112E23";
    mem(128)<=x"02812C23";
    mem(129)<=x"02912A23";
    mem(130)<=x"04010413";
    mem(131)<=x"FC440793";
    mem(132)<=x"FEF42023";
    mem(133)<=x"FC840793";
    mem(134)<=x"FCF42E23";
    mem(135)<=x"FCC40793";
    mem(136)<=x"FCF42C23";
    mem(137)<=x"FE042783";
    mem(138)<=x"00500713";
    mem(139)<=x"00E7A023";
    mem(140)<=x"FDC42783";
    mem(141)<=x"FF600713";
    mem(142)<=x"00E7A023";
    mem(143)<=x"FE042783";
    mem(144)<=x"0007A703";
    mem(145)<=x"FDC42783";
    mem(146)<=x"0007A783";
    mem(147)<=x"40F70733";
    mem(148)<=x"FD842783";
    mem(149)<=x"00E7A023";
    mem(150)<=x"001007B7";
    mem(151)<=x"00178793";
    mem(152)<=x"FCF42A23";
    mem(153)<=x"00100513";
    mem(154)<=x"120000EF";
    mem(155)<=x"FCA42823";
    mem(156)<=x"02FAF7B7";
    mem(157)<=x"08078613";
    mem(158)<=x"000027B7";
    mem(159)<=x"58078593";
    mem(160)<=x"FD042503";
    mem(161)<=x"140000EF";
    mem(162)<=x"08600493";
    mem(163)<=x"08400093";
    mem(164)<=x"3044A073";
    mem(165)<=x"3040B073";
    mem(166)<=x"FD442783";
    mem(167)<=x"08600713";
    mem(168)<=x"00E7A023";
    mem(169)<=x"08600593";
    mem(170)<=x"FD442503";
    mem(171)<=x"0AC000EF";
    mem(172)<=x"FF600793";
    mem(173)<=x"FEF42623";
    mem(174)<=x"0100006F";
    mem(175)<=x"FEC42783";
    mem(176)<=x"00178793";
    mem(177)<=x"FEF42623";
    mem(178)<=x"FEC42703";
    mem(179)<=x"0007A7B7";
    mem(180)<=x"11F78793";
    mem(181)<=x"FEE7D4E3";
    mem(182)<=x"04500593";
    mem(183)<=x"FD442503";
    mem(184)<=x"078000EF";
    mem(185)<=x"FE042423";
    mem(186)<=x"0100006F";
    mem(187)<=x"FE842783";
    mem(188)<=x"00178793";
    mem(189)<=x"FEF42423";
    mem(190)<=x"FE842703";
    mem(191)<=x"000AB7B7";
    mem(192)<=x"E5F78793";
    mem(193)<=x"FEE7D4E3";
    mem(194)<=x"07600593";
    mem(195)<=x"FD442503";
    mem(196)<=x"048000EF";
    mem(197)<=x"FE042223";
    mem(198)<=x"0100006F";
    mem(199)<=x"FE442783";
    mem(200)<=x"00178793";
    mem(201)<=x"FEF42223";
    mem(202)<=x"FE442703";
    mem(203)<=x"000C37B7";
    mem(204)<=x"4FF78793";
    mem(205)<=x"FEE7D4E3";
    mem(206)<=x"0E300593";
    mem(207)<=x"FD442503";
    mem(208)<=x"018000EF";
    mem(209)<=x"000107B7";
    mem(210)<=x"5C078593";
    mem(211)<=x"FD042503";
    mem(212)<=x"104000EF";
    mem(213)<=x"F5DFF06F";
    mem(214)<=x"FF010113";
    mem(215)<=x"00812623";
    mem(216)<=x"01010413";
    mem(217)<=x"FEA42A23";
    mem(218)<=x"FEB42823";
    mem(219)<=x"FF442783";
    mem(220)<=x"FF042703";
    mem(221)<=x"00E7A023";
    mem(222)<=x"00000013";
    mem(223)<=x"00C12403";
    mem(224)<=x"01010113";
    mem(225)<=x"00008067";
    mem(226)<=x"FF010113";
    mem(227)<=x"00812623";
    mem(228)<=x"01010413";
    mem(229)<=x"FEA42A23";
    mem(230)<=x"FF442703";
    mem(231)<=x"00100793";
    mem(232)<=x"00F71863";
    mem(233)<=x"001007B7";
    mem(234)<=x"10078793";
    mem(235)<=x"0080006F";
    mem(236)<=x"00000793";
    mem(237)<=x"00078513";
    mem(238)<=x"00C12403";
    mem(239)<=x"01010113";
    mem(240)<=x"00008067";
    mem(241)<=x"FE810113";
    mem(242)<=x"00812A23";
    mem(243)<=x"01810413";
    mem(244)<=x"FEA42A23";
    mem(245)<=x"FEB42823";
    mem(246)<=x"FEC42623";
    mem(247)<=x"FF442783";
    mem(248)<=x"00C78793";
    mem(249)<=x"01B00713";
    mem(250)<=x"00E7A023";
    mem(251)<=x"00000013";
    mem(252)<=x"01412403";
    mem(253)<=x"01810113";
    mem(254)<=x"00008067";
    mem(255)<=x"FF010113";
    mem(256)<=x"00812623";
    mem(257)<=x"01010413";
    mem(258)<=x"FEA42A23";
    mem(259)<=x"FF442783";
    mem(260)<=x"0047A783";
    mem(261)<=x"00078513";
    mem(262)<=x"00C12403";
    mem(263)<=x"01010113";
    mem(264)<=x"00008067";
    mem(265)<=x"FF010113";
    mem(266)<=x"00812623";
    mem(267)<=x"01010413";
    mem(268)<=x"FEA42A23";
    mem(269)<=x"FEB42823";
    mem(270)<=x"FF442783";
    mem(271)<=x"FF042703";
    mem(272)<=x"00E7A023";
    mem(273)<=x"00000013";
    mem(274)<=x"00C12403";
    mem(275)<=x"01010113";
    mem(276)<=x"00008067";
    mem(277)<=x"FE810113";
    mem(278)<=x"00112A23";
    mem(279)<=x"00812823";
    mem(280)<=x"01810413";
    mem(281)<=x"FEA42623";
    mem(282)<=x"FEB42423";
    mem(283)<=x"FE042A23";
    mem(284)<=x"02C0006F";
    mem(285)<=x"FF442783";
    mem(286)<=x"FE842703";
    mem(287)<=x"00F707B3";
    mem(288)<=x"0007C783";
    mem(289)<=x"00078593";
    mem(290)<=x"FEC42503";
    mem(291)<=x"F99FF0EF";
    mem(292)<=x"FF442783";
    mem(293)<=x"00178793";
    mem(294)<=x"FEF42A23";
    mem(295)<=x"FF442783";
    mem(296)<=x"FE842703";
    mem(297)<=x"00F707B3";
    mem(298)<=x"0007C783";
    mem(299)<=x"FC0794E3";
    mem(300)<=x"00000013";
    mem(301)<=x"00000013";
    mem(302)<=x"01412083";
    mem(303)<=x"01012403";
    mem(304)<=x"01810113";
    mem(305)<=x"00008067";
    mem(306)<=x"FE810113";
    mem(307)<=x"00812A23";
    mem(308)<=x"01810413";
    mem(309)<=x"FEA42A23";
    mem(310)<=x"FEB42823";
    mem(311)<=x"FEC42623";
    mem(312)<=x"00000013";
    mem(313)<=x"01412403";
    mem(314)<=x"01810113";
    mem(315)<=x"00008067";
    mem(316)<=x"FE810113";
    mem(317)<=x"00812A23";
    mem(318)<=x"01810413";
    mem(319)<=x"FEA42623";
    mem(320)<=x"FEB42423";
    mem(321)<=x"FE042A23";
    mem(322)<=x"FE042823";
    mem(323)<=x"FE042A23";
    mem(324)<=x"0200006F";
    mem(325)<=x"FF042703";
    mem(326)<=x"FE842783";
    mem(327)<=x"00F707B3";
    mem(328)<=x"FEF42823";
    mem(329)<=x"FF442783";
    mem(330)<=x"00178793";
    mem(331)<=x"FEF42A23";
    mem(332)<=x"FF442703";
    mem(333)<=x"FEC42783";
    mem(334)<=x"FCF74EE3";
    mem(335)<=x"FF042783";
    mem(336)<=x"00078513";
    mem(337)<=x"01412403";
    mem(338)<=x"01810113";
    mem(339)<=x"00008067";
    mem(340)<=x"FE810113";
    mem(341)<=x"00812A23";
    mem(342)<=x"01810413";
    mem(343)<=x"FEA42623";
    mem(344)<=x"FEB42423";
    mem(345)<=x"FE042A23";
    mem(346)<=x"FE042823";
    mem(347)<=x"FE842783";
    mem(348)<=x"00079663";
    mem(349)<=x"00000793";
    mem(350)<=x"0380006F";
    mem(351)<=x"FEC42783";
    mem(352)<=x"FEF42A23";
    mem(353)<=x"0200006F";
    mem(354)<=x"FF042783";
    mem(355)<=x"00178793";
    mem(356)<=x"FEF42823";
    mem(357)<=x"FF442703";
    mem(358)<=x"FE842783";
    mem(359)<=x"40F707B3";
    mem(360)<=x"FEF42A23";
    mem(361)<=x"FF442783";
    mem(362)<=x"FEF040E3";
    mem(363)<=x"FF042783";
    mem(364)<=x"00078513";
    mem(365)<=x"01412403";
    mem(366)<=x"01810113";
    mem(367)<=x"00008067";
    mem(368)<=x"2D4B5541";
    mem(369)<=x"61732056";
    mem(370)<=x"48207379";
    mem(371)<=x"69696969";
    mem(372)<=x"0A0D2169";
    mem(373)<=x"00000000";
end behave;
