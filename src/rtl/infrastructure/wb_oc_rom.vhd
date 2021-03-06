-----sd-----------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: Fri Nov 20 23:54:29 2020
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
type mem_type is array(1623 downto 0) of std_logic_vector(31 downto 0);
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
    mem(11)<=x"4A4000EF";
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
    mem(49)<=x"668000EF";
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
    mem(83)<=x"FE010113";
    mem(84)<=x"00812E23";
    mem(85)<=x"02010413";
    mem(86)<=x"FEA42623";
    mem(87)<=x"FEC42703";
    mem(88)<=x"00100793";
    mem(89)<=x"00F71863";
    mem(90)<=x"001007B7";
    mem(91)<=x"10078793";
    mem(92)<=x"0080006F";
    mem(93)<=x"00000793";
    mem(94)<=x"00078513";
    mem(95)<=x"01C12403";
    mem(96)<=x"02010113";
    mem(97)<=x"00008067";
    mem(98)<=x"FE010113";
    mem(99)<=x"00812E23";
    mem(100)<=x"02010413";
    mem(101)<=x"FEA42623";
    mem(102)<=x"FEC42783";
    mem(103)<=x"00878793";
    mem(104)<=x"0007A783";
    mem(105)<=x"0017F713";
    mem(106)<=x"00100793";
    mem(107)<=x"00F71663";
    mem(108)<=x"00000793";
    mem(109)<=x"0080006F";
    mem(110)<=x"00100793";
    mem(111)<=x"00078513";
    mem(112)<=x"01C12403";
    mem(113)<=x"02010113";
    mem(114)<=x"00008067";
    mem(115)<=x"FE010113";
    mem(116)<=x"00812E23";
    mem(117)<=x"02010413";
    mem(118)<=x"FEA42623";
    mem(119)<=x"FEB42423";
    mem(120)<=x"FEC42223";
    mem(121)<=x"FEC42783";
    mem(122)<=x"00C78793";
    mem(123)<=x"01600713";
    mem(124)<=x"00E7A023";
    mem(125)<=x"00000013";
    mem(126)<=x"01C12403";
    mem(127)<=x"02010113";
    mem(128)<=x"00008067";
    mem(129)<=x"FE010113";
    mem(130)<=x"00812E23";
    mem(131)<=x"02010413";
    mem(132)<=x"FEA42623";
    mem(133)<=x"FEC42783";
    mem(134)<=x"00478793";
    mem(135)<=x"0007A783";
    mem(136)<=x"00078513";
    mem(137)<=x"01C12403";
    mem(138)<=x"02010113";
    mem(139)<=x"00008067";
    mem(140)<=x"FE010113";
    mem(141)<=x"00812E23";
    mem(142)<=x"02010413";
    mem(143)<=x"FEA42623";
    mem(144)<=x"FEB42423";
    mem(145)<=x"FEC42783";
    mem(146)<=x"FE842703";
    mem(147)<=x"00E7A023";
    mem(148)<=x"00000013";
    mem(149)<=x"01C12403";
    mem(150)<=x"02010113";
    mem(151)<=x"00008067";
    mem(152)<=x"FD010113";
    mem(153)<=x"02112623";
    mem(154)<=x"02812423";
    mem(155)<=x"03010413";
    mem(156)<=x"FCA42E23";
    mem(157)<=x"FCB42C23";
    mem(158)<=x"FE042623";
    mem(159)<=x"02C0006F";
    mem(160)<=x"FEC42783";
    mem(161)<=x"FD842703";
    mem(162)<=x"00F707B3";
    mem(163)<=x"0007C783";
    mem(164)<=x"00078593";
    mem(165)<=x"FDC42503";
    mem(166)<=x"F99FF0EF";
    mem(167)<=x"FEC42783";
    mem(168)<=x"00178793";
    mem(169)<=x"FEF42623";
    mem(170)<=x"FEC42783";
    mem(171)<=x"FD842703";
    mem(172)<=x"00F707B3";
    mem(173)<=x"0007C783";
    mem(174)<=x"FC0794E3";
    mem(175)<=x"00000013";
    mem(176)<=x"00000013";
    mem(177)<=x"02C12083";
    mem(178)<=x"02812403";
    mem(179)<=x"03010113";
    mem(180)<=x"00008067";
    mem(181)<=x"FD010113";
    mem(182)<=x"02812623";
    mem(183)<=x"03010413";
    mem(184)<=x"FCA42E23";
    mem(185)<=x"FE042623";
    mem(186)<=x"0340006F";
    mem(187)<=x"FE042423";
    mem(188)<=x"0100006F";
    mem(189)<=x"FE842783";
    mem(190)<=x"00178793";
    mem(191)<=x"FEF42423";
    mem(192)<=x"FE842703";
    mem(193)<=x"000017B7";
    mem(194)<=x"38778793";
    mem(195)<=x"FEE7D4E3";
    mem(196)<=x"FEC42783";
    mem(197)<=x"00178793";
    mem(198)<=x"FEF42623";
    mem(199)<=x"FEC42703";
    mem(200)<=x"FDC42783";
    mem(201)<=x"FCF744E3";
    mem(202)<=x"00000013";
    mem(203)<=x"00000013";
    mem(204)<=x"02C12403";
    mem(205)<=x"03010113";
    mem(206)<=x"00008067";
    mem(207)<=x"FE010113";
    mem(208)<=x"00812E23";
    mem(209)<=x"02010413";
    mem(210)<=x"FEA42623";
    mem(211)<=x"FEC42703";
    mem(212)<=x"00100793";
    mem(213)<=x"00F71863";
    mem(214)<=x"001007B7";
    mem(215)<=x"20078793";
    mem(216)<=x"0080006F";
    mem(217)<=x"00000793";
    mem(218)<=x"00078513";
    mem(219)<=x"01C12403";
    mem(220)<=x"02010113";
    mem(221)<=x"00008067";
    mem(222)<=x"FE010113";
    mem(223)<=x"00812E23";
    mem(224)<=x"02010413";
    mem(225)<=x"FEA42623";
    mem(226)<=x"FEC42783";
    mem(227)<=x"0007A783";
    mem(228)<=x"0017F713";
    mem(229)<=x"00100793";
    mem(230)<=x"00F71663";
    mem(231)<=x"00000793";
    mem(232)<=x"0080006F";
    mem(233)<=x"00100793";
    mem(234)<=x"00078513";
    mem(235)<=x"01C12403";
    mem(236)<=x"02010113";
    mem(237)<=x"00008067";
    mem(238)<=x"FE010113";
    mem(239)<=x"00812E23";
    mem(240)<=x"02010413";
    mem(241)<=x"FEA42623";
    mem(242)<=x"FEB42423";
    mem(243)<=x"FEC42783";
    mem(244)<=x"00878793";
    mem(245)<=x"FE842703";
    mem(246)<=x"00E7A023";
    mem(247)<=x"00000013";
    mem(248)<=x"01C12403";
    mem(249)<=x"02010113";
    mem(250)<=x"00008067";
    mem(251)<=x"FE010113";
    mem(252)<=x"00812E23";
    mem(253)<=x"02010413";
    mem(254)<=x"FEA42623";
    mem(255)<=x"FEC42783";
    mem(256)<=x"00478793";
    mem(257)<=x"0007A703";
    mem(258)<=x"FEC42783";
    mem(259)<=x"00478793";
    mem(260)<=x"00176713";
    mem(261)<=x"00E7A023";
    mem(262)<=x"00000013";
    mem(263)<=x"01C12403";
    mem(264)<=x"02010113";
    mem(265)<=x"00008067";
    mem(266)<=x"FE010113";
    mem(267)<=x"00812E23";
    mem(268)<=x"02010413";
    mem(269)<=x"FEA42623";
    mem(270)<=x"FEC42783";
    mem(271)<=x"00478793";
    mem(272)<=x"0007A783";
    mem(273)<=x"FFE7E713";
    mem(274)<=x"FEC42783";
    mem(275)<=x"00478793";
    mem(276)<=x"00E7A023";
    mem(277)<=x"00000013";
    mem(278)<=x"01C12403";
    mem(279)<=x"02010113";
    mem(280)<=x"00008067";
    mem(281)<=x"FE010113";
    mem(282)<=x"00812E23";
    mem(283)<=x"02010413";
    mem(284)<=x"FEA42623";
    mem(285)<=x"FEC42783";
    mem(286)<=x"00478793";
    mem(287)<=x"00F00713";
    mem(288)<=x"00E7A023";
    mem(289)<=x"00000013";
    mem(290)<=x"01C12403";
    mem(291)<=x"02010113";
    mem(292)<=x"00008067";
    mem(293)<=x"FE010113";
    mem(294)<=x"00812E23";
    mem(295)<=x"02010413";
    mem(296)<=x"FEA42623";
    mem(297)<=x"FEC42783";
    mem(298)<=x"00478793";
    mem(299)<=x"0007A703";
    mem(300)<=x"FEC42783";
    mem(301)<=x"00478793";
    mem(302)<=x"FF077713";
    mem(303)<=x"00E7A023";
    mem(304)<=x"00000013";
    mem(305)<=x"01C12403";
    mem(306)<=x"02010113";
    mem(307)<=x"00008067";
    mem(308)<=x"FC010113";
    mem(309)<=x"02112E23";
    mem(310)<=x"02812C23";
    mem(311)<=x"04010413";
    mem(312)<=x"FD840793";
    mem(313)<=x"FEF42623";
    mem(314)<=x"FDC40793";
    mem(315)<=x"FEF42423";
    mem(316)<=x"FE040793";
    mem(317)<=x"FEF42223";
    mem(318)<=x"FEC42783";
    mem(319)<=x"00500713";
    mem(320)<=x"00E7A023";
    mem(321)<=x"FE842783";
    mem(322)<=x"FF600713";
    mem(323)<=x"00E7A023";
    mem(324)<=x"FEC42783";
    mem(325)<=x"0007A703";
    mem(326)<=x"FE842783";
    mem(327)<=x"0007A783";
    mem(328)<=x"00078593";
    mem(329)<=x"00070513";
    mem(330)<=x"25C000EF";
    mem(331)<=x"00050793";
    mem(332)<=x"00078713";
    mem(333)<=x"FE442783";
    mem(334)<=x"00E7A023";
    mem(335)<=x"FE842783";
    mem(336)<=x"0007A703";
    mem(337)<=x"FEC42783";
    mem(338)<=x"0007A783";
    mem(339)<=x"00078593";
    mem(340)<=x"00070513";
    mem(341)<=x"254000EF";
    mem(342)<=x"00050793";
    mem(343)<=x"00078713";
    mem(344)<=x"FE442783";
    mem(345)<=x"00E7A023";
    mem(346)<=x"00100513";
    mem(347)<=x"DD1FF0EF";
    mem(348)<=x"00050713";
    mem(349)<=x"008007B7";
    mem(350)<=x"00E7A423";
    mem(351)<=x"008007B7";
    mem(352)<=x"0087A703";
    mem(353)<=x"013137B7";
    mem(354)<=x"D0078593";
    mem(355)<=x"00070513";
    mem(356)<=x"E29FF0EF";
    mem(357)<=x"008007B7";
    mem(358)<=x"0087A783";
    mem(359)<=x"00078513";
    mem(360)<=x"EC5FF0EF";
    mem(361)<=x"008007B7";
    mem(362)<=x"00100737";
    mem(363)<=x"00470713";
    mem(364)<=x"00E7A023";
    mem(365)<=x"00100513";
    mem(366)<=x"B95FF0EF";
    mem(367)<=x"00050713";
    mem(368)<=x"008007B7";
    mem(369)<=x"00E7A223";
    mem(370)<=x"008007B7";
    mem(371)<=x"0047A703";
    mem(372)<=x"02FAF7B7";
    mem(373)<=x"08078613";
    mem(374)<=x"000027B7";
    mem(375)<=x"58078593";
    mem(376)<=x"00070513";
    mem(377)<=x"BE9FF0EF";
    mem(378)<=x"08600793";
    mem(379)<=x"FCF42823";
    mem(380)<=x"08400793";
    mem(381)<=x"FCF42623";
    mem(382)<=x"FD042783";
    mem(383)<=x"3047A073";
    mem(384)<=x"FCC42783";
    mem(385)<=x"3047B073";
    mem(386)<=x"008007B7";
    mem(387)<=x"0007A783";
    mem(388)<=x"08600713";
    mem(389)<=x"00E7A023";
    mem(390)<=x"008007B7";
    mem(391)<=x"0007A783";
    mem(392)<=x"08600593";
    mem(393)<=x"00078513";
    mem(394)<=x"0D4000EF";
    mem(395)<=x"008007B7";
    mem(396)<=x"0047A703";
    mem(397)<=x"000117B7";
    mem(398)<=x"85C78593";
    mem(399)<=x"00070513";
    mem(400)<=x"C21FF0EF";
    mem(401)<=x"008007B7";
    mem(402)<=x"0047A783";
    mem(403)<=x"00078513";
    mem(404)<=x"B39FF0EF";
    mem(405)<=x"00050713";
    mem(406)<=x"00100793";
    mem(407)<=x"FEF714E3";
    mem(408)<=x"008007B7";
    mem(409)<=x"0047A783";
    mem(410)<=x"00078513";
    mem(411)<=x"B99FF0EF";
    mem(412)<=x"00050793";
    mem(413)<=x"FCF42A23";
    mem(414)<=x"008007B7";
    mem(415)<=x"0047A783";
    mem(416)<=x"FD442703";
    mem(417)<=x"00070593";
    mem(418)<=x"00078513";
    mem(419)<=x"BA5FF0EF";
    mem(420)<=x"FD442703";
    mem(421)<=x"07200793";
    mem(422)<=x"00F71E63";
    mem(423)<=x"008007B7";
    mem(424)<=x"0007A783";
    mem(425)<=x"00600593";
    mem(426)<=x"00078513";
    mem(427)<=x"050000EF";
    mem(428)<=x"F95FF06F";
    mem(429)<=x"FD442703";
    mem(430)<=x"06700793";
    mem(431)<=x"00F71E63";
    mem(432)<=x"008007B7";
    mem(433)<=x"0007A783";
    mem(434)<=x"00500593";
    mem(435)<=x"00078513";
    mem(436)<=x"02C000EF";
    mem(437)<=x"F71FF06F";
    mem(438)<=x"FD442703";
    mem(439)<=x"06200793";
    mem(440)<=x"F6F712E3";
    mem(441)<=x"008007B7";
    mem(442)<=x"0007A783";
    mem(443)<=x"00300593";
    mem(444)<=x"00078513";
    mem(445)<=x"008000EF";
    mem(446)<=x"F4DFF06F";
    mem(447)<=x"FE010113";
    mem(448)<=x"00812E23";
    mem(449)<=x"02010413";
    mem(450)<=x"FEA42623";
    mem(451)<=x"FEB42423";
    mem(452)<=x"FEC42783";
    mem(453)<=x"FE842703";
    mem(454)<=x"00E7A023";
    mem(455)<=x"00000013";
    mem(456)<=x"01C12403";
    mem(457)<=x"02010113";
    mem(458)<=x"00008067";
    mem(459)<=x"FE010113";
    mem(460)<=x"00812E23";
    mem(461)<=x"02010413";
    mem(462)<=x"FEA42623";
    mem(463)<=x"FEB42423";
    mem(464)<=x"FEC42223";
    mem(465)<=x"008007B7";
    mem(466)<=x"0007A783";
    mem(467)<=x"0007A783";
    mem(468)<=x"00079C63";
    mem(469)<=x"008007B7";
    mem(470)<=x"0007A783";
    mem(471)<=x"0FF00713";
    mem(472)<=x"00E7A023";
    mem(473)<=x"0100006F";
    mem(474)<=x"008007B7";
    mem(475)<=x"0007A783";
    mem(476)<=x"0007A023";
    mem(477)<=x"00000013";
    mem(478)<=x"01C12403";
    mem(479)<=x"02010113";
    mem(480)<=x"00008067";
    mem(481)<=x"00050613";
    mem(482)<=x"00000513";
    mem(483)<=x"0015F693";
    mem(484)<=x"00068463";
    mem(485)<=x"00C50533";
    mem(486)<=x"0015D593";
    mem(487)<=x"00161613";
    mem(488)<=x"FE0596E3";
    mem(489)<=x"00008067";
    mem(490)<=x"06054063";
    mem(491)<=x"0605C663";
    mem(492)<=x"00058613";
    mem(493)<=x"00050593";
    mem(494)<=x"FFF00513";
    mem(495)<=x"02060C63";
    mem(496)<=x"00100693";
    mem(497)<=x"00B67A63";
    mem(498)<=x"00C05863";
    mem(499)<=x"00161613";
    mem(500)<=x"00169693";
    mem(501)<=x"FEB66AE3";
    mem(502)<=x"00000513";
    mem(503)<=x"00C5E663";
    mem(504)<=x"40C585B3";
    mem(505)<=x"00D56533";
    mem(506)<=x"0016D693";
    mem(507)<=x"00165613";
    mem(508)<=x"FE0696E3";
    mem(509)<=x"00008067";
    mem(510)<=x"00008293";
    mem(511)<=x"FB5FF0EF";
    mem(512)<=x"00058513";
    mem(513)<=x"00028067";
    mem(514)<=x"40A00533";
    mem(515)<=x"00B04863";
    mem(516)<=x"40B005B3";
    mem(517)<=x"F9DFF06F";
    mem(518)<=x"40B005B3";
    mem(519)<=x"00008293";
    mem(520)<=x"F91FF0EF";
    mem(521)<=x"40A00533";
    mem(522)<=x"00028067";
    mem(523)<=x"00008293";
    mem(524)<=x"0005CA63";
    mem(525)<=x"00054C63";
    mem(526)<=x"F79FF0EF";
    mem(527)<=x"00058513";
    mem(528)<=x"00028067";
    mem(529)<=x"40B005B3";
    mem(530)<=x"FE0558E3";
    mem(531)<=x"40A00533";
    mem(532)<=x"F61FF0EF";
    mem(533)<=x"40B00533";
    mem(534)<=x"00028067";
    mem(535)<=x"2D4B5541";
    mem(536)<=x"61732056";
    mem(537)<=x"48207379";
    mem(538)<=x"69696969";
    mem(539)<=x"0A0D2169";
    mem(540)<=x"00000000";
end behave;
