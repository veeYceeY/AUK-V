-----sd-----------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: Sat Oct  3 22:38:36 2020
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
    mem(37)<=x"123457B7";
    mem(38)<=x"67878793";
    mem(39)<=x"00F00813";
    mem(40)<=x"0F07F713";
    mem(41)<=x"0107F733";
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
    mem(53)<=x"00000013";
    mem(54)<=x"00000013";
    mem(55)<=x"00000013";
    mem(56)<=x"00000013";
    mem(57)<=x"00000013";
    mem(58)<=x"30C000EF";
    mem(59)<=x"0000006F";
    mem(60)<=x"FFDFF06F";
    mem(61)<=x"F8010113";
    mem(62)<=x"00012023";
    mem(63)<=x"00112223";
    mem(64)<=x"00212423";
    mem(65)<=x"00312623";
    mem(66)<=x"00412823";
    mem(67)<=x"00512A23";
    mem(68)<=x"00612C23";
    mem(69)<=x"00712E23";
    mem(70)<=x"02812023";
    mem(71)<=x"02912223";
    mem(72)<=x"02A12423";
    mem(73)<=x"02B12623";
    mem(74)<=x"02C12823";
    mem(75)<=x"02D12A23";
    mem(76)<=x"02E12C23";
    mem(77)<=x"02F12E23";
    mem(78)<=x"05012023";
    mem(79)<=x"05112223";
    mem(80)<=x"05212423";
    mem(81)<=x"05312623";
    mem(82)<=x"05412823";
    mem(83)<=x"05512A23";
    mem(84)<=x"05612C23";
    mem(85)<=x"05712E23";
    mem(86)<=x"07812023";
    mem(87)<=x"07912223";
    mem(88)<=x"07A12423";
    mem(89)<=x"07B12623";
    mem(90)<=x"07C12823";
    mem(91)<=x"07D12A23";
    mem(92)<=x"07E12C23";
    mem(93)<=x"07F12E23";
    mem(94)<=x"34202573";
    mem(95)<=x"341025F3";
    mem(96)<=x"00010613";
    mem(97)<=x"400000EF";
    mem(98)<=x"00012003";
    mem(99)<=x"00412083";
    mem(100)<=x"00C12183";
    mem(101)<=x"01012203";
    mem(102)<=x"01412283";
    mem(103)<=x"01812303";
    mem(104)<=x"01C12383";
    mem(105)<=x"02012403";
    mem(106)<=x"02412483";
    mem(107)<=x"02812503";
    mem(108)<=x"02C12583";
    mem(109)<=x"03012603";
    mem(110)<=x"03412683";
    mem(111)<=x"03812703";
    mem(112)<=x"03C12783";
    mem(113)<=x"04012803";
    mem(114)<=x"04412883";
    mem(115)<=x"04812903";
    mem(116)<=x"04C12983";
    mem(117)<=x"05012A03";
    mem(118)<=x"05412A83";
    mem(119)<=x"05812B03";
    mem(120)<=x"05C12B83";
    mem(121)<=x"06012C03";
    mem(122)<=x"06412C83";
    mem(123)<=x"06812D03";
    mem(124)<=x"06C12D83";
    mem(125)<=x"07012E03";
    mem(126)<=x"07412E83";
    mem(127)<=x"07812F03";
    mem(128)<=x"07C12F83";
    mem(129)<=x"08010113";
    mem(130)<=x"30200073";
    mem(131)<=x"FF010113";
    mem(132)<=x"00812623";
    mem(133)<=x"01010413";
    mem(134)<=x"FEA42A23";
    mem(135)<=x"FF442703";
    mem(136)<=x"00100793";
    mem(137)<=x"00F71863";
    mem(138)<=x"001007B7";
    mem(139)<=x"10078793";
    mem(140)<=x"0080006F";
    mem(141)<=x"00000793";
    mem(142)<=x"00078513";
    mem(143)<=x"00C12403";
    mem(144)<=x"01010113";
    mem(145)<=x"00008067";
    mem(146)<=x"FF010113";
    mem(147)<=x"00812623";
    mem(148)<=x"01010413";
    mem(149)<=x"FEA42A23";
    mem(150)<=x"FF442783";
    mem(151)<=x"00878793";
    mem(152)<=x"0007A783";
    mem(153)<=x"0017F793";
    mem(154)<=x"00078663";
    mem(155)<=x"00000793";
    mem(156)<=x"0080006F";
    mem(157)<=x"00100793";
    mem(158)<=x"00078513";
    mem(159)<=x"00C12403";
    mem(160)<=x"01010113";
    mem(161)<=x"00008067";
    mem(162)<=x"FE810113";
    mem(163)<=x"00812A23";
    mem(164)<=x"01810413";
    mem(165)<=x"FEA42A23";
    mem(166)<=x"FEB42823";
    mem(167)<=x"FEC42623";
    mem(168)<=x"FF442783";
    mem(169)<=x"00C78793";
    mem(170)<=x"01B00713";
    mem(171)<=x"00E7A023";
    mem(172)<=x"00000013";
    mem(173)<=x"01412403";
    mem(174)<=x"01810113";
    mem(175)<=x"00008067";
    mem(176)<=x"FF010113";
    mem(177)<=x"00812623";
    mem(178)<=x"01010413";
    mem(179)<=x"FEA42A23";
    mem(180)<=x"FF442783";
    mem(181)<=x"0047A783";
    mem(182)<=x"00078513";
    mem(183)<=x"00C12403";
    mem(184)<=x"01010113";
    mem(185)<=x"00008067";
    mem(186)<=x"FF010113";
    mem(187)<=x"00812623";
    mem(188)<=x"01010413";
    mem(189)<=x"FEA42A23";
    mem(190)<=x"FEB42823";
    mem(191)<=x"FF442783";
    mem(192)<=x"FF042703";
    mem(193)<=x"00E7A023";
    mem(194)<=x"00000013";
    mem(195)<=x"00C12403";
    mem(196)<=x"01010113";
    mem(197)<=x"00008067";
    mem(198)<=x"FE810113";
    mem(199)<=x"00112A23";
    mem(200)<=x"00812823";
    mem(201)<=x"01810413";
    mem(202)<=x"FEA42623";
    mem(203)<=x"FEB42423";
    mem(204)<=x"FE042A23";
    mem(205)<=x"02C0006F";
    mem(206)<=x"FF442783";
    mem(207)<=x"FE842703";
    mem(208)<=x"00F707B3";
    mem(209)<=x"0007C783";
    mem(210)<=x"00078593";
    mem(211)<=x"FEC42503";
    mem(212)<=x"F99FF0EF";
    mem(213)<=x"FF442783";
    mem(214)<=x"00178793";
    mem(215)<=x"FEF42A23";
    mem(216)<=x"FF442783";
    mem(217)<=x"FE842703";
    mem(218)<=x"00F707B3";
    mem(219)<=x"0007C783";
    mem(220)<=x"FC0794E3";
    mem(221)<=x"00000013";
    mem(222)<=x"00000013";
    mem(223)<=x"01412083";
    mem(224)<=x"01012403";
    mem(225)<=x"01810113";
    mem(226)<=x"00008067";
    mem(227)<=x"FE810113";
    mem(228)<=x"00812A23";
    mem(229)<=x"01810413";
    mem(230)<=x"FEA42623";
    mem(231)<=x"FE042A23";
    mem(232)<=x"0340006F";
    mem(233)<=x"FE042823";
    mem(234)<=x"0100006F";
    mem(235)<=x"FF042783";
    mem(236)<=x"00178793";
    mem(237)<=x"FEF42823";
    mem(238)<=x"FF042703";
    mem(239)<=x"000017B7";
    mem(240)<=x"38778793";
    mem(241)<=x"FEE7D4E3";
    mem(242)<=x"FF442783";
    mem(243)<=x"00178793";
    mem(244)<=x"FEF42A23";
    mem(245)<=x"FF442703";
    mem(246)<=x"FEC42783";
    mem(247)<=x"FCF744E3";
    mem(248)<=x"00000013";
    mem(249)<=x"00000013";
    mem(250)<=x"01412403";
    mem(251)<=x"01810113";
    mem(252)<=x"00008067";
    mem(253)<=x"FC810113";
    mem(254)<=x"02112A23";
    mem(255)<=x"02812823";
    mem(256)<=x"02912623";
    mem(257)<=x"03810413";
    mem(258)<=x"FCC40793";
    mem(259)<=x"FEF42623";
    mem(260)<=x"FD040793";
    mem(261)<=x"FEF42423";
    mem(262)<=x"FD440793";
    mem(263)<=x"FEF42223";
    mem(264)<=x"FEC42783";
    mem(265)<=x"00500713";
    mem(266)<=x"00E7A023";
    mem(267)<=x"FE842783";
    mem(268)<=x"FF600713";
    mem(269)<=x"00E7A023";
    mem(270)<=x"FEC42783";
    mem(271)<=x"0007A703";
    mem(272)<=x"FE842783";
    mem(273)<=x"0007A783";
    mem(274)<=x"40F70733";
    mem(275)<=x"FE442783";
    mem(276)<=x"00E7A023";
    mem(277)<=x"001007B7";
    mem(278)<=x"00178793";
    mem(279)<=x"FEF42023";
    mem(280)<=x"00100513";
    mem(281)<=x"DA9FF0EF";
    mem(282)<=x"FCA42E23";
    mem(283)<=x"02FAF7B7";
    mem(284)<=x"08078613";
    mem(285)<=x"000027B7";
    mem(286)<=x"58078593";
    mem(287)<=x"FDC42503";
    mem(288)<=x"E09FF0EF";
    mem(289)<=x"08600493";
    mem(290)<=x"08400093";
    mem(291)<=x"3044A073";
    mem(292)<=x"3040B073";
    mem(293)<=x"FE042783";
    mem(294)<=x"08600713";
    mem(295)<=x"00E7A023";
    mem(296)<=x"08600593";
    mem(297)<=x"FE042503";
    mem(298)<=x"0AC000EF";
    mem(299)<=x"000107B7";
    mem(300)<=x"5AC78593";
    mem(301)<=x"FDC42503";
    mem(302)<=x"E61FF0EF";
    mem(303)<=x"00A00513";
    mem(304)<=x"ECDFF0EF";
    mem(305)<=x"000107B7";
    mem(306)<=x"5C478593";
    mem(307)<=x"FDC42503";
    mem(308)<=x"E49FF0EF";
    mem(309)<=x"00A00513";
    mem(310)<=x"EB5FF0EF";
    mem(311)<=x"000107B7";
    mem(312)<=x"5DC78593";
    mem(313)<=x"FDC42503";
    mem(314)<=x"E31FF0EF";
    mem(315)<=x"00A00513";
    mem(316)<=x"E9DFF0EF";
    mem(317)<=x"000107B7";
    mem(318)<=x"5F478593";
    mem(319)<=x"FDC42503";
    mem(320)<=x"E19FF0EF";
    mem(321)<=x"00A00513";
    mem(322)<=x"E85FF0EF";
    mem(323)<=x"000107B7";
    mem(324)<=x"60C78593";
    mem(325)<=x"FDC42503";
    mem(326)<=x"E01FF0EF";
    mem(327)<=x"00A00513";
    mem(328)<=x"E6DFF0EF";
    mem(329)<=x"FDC42503";
    mem(330)<=x"D21FF0EF";
    mem(331)<=x"00050713";
    mem(332)<=x"00100793";
    mem(333)<=x"FEF718E3";
    mem(334)<=x"FDC42503";
    mem(335)<=x"D85FF0EF";
    mem(336)<=x"FCA42C23";
    mem(337)<=x"FD842583";
    mem(338)<=x"FDC42503";
    mem(339)<=x"D9DFF0EF";
    mem(340)<=x"FD5FF06F";
    mem(341)<=x"FF010113";
    mem(342)<=x"00812623";
    mem(343)<=x"01010413";
    mem(344)<=x"FEA42A23";
    mem(345)<=x"FEB42823";
    mem(346)<=x"FF442783";
    mem(347)<=x"FF042703";
    mem(348)<=x"00E7A023";
    mem(349)<=x"00000013";
    mem(350)<=x"00C12403";
    mem(351)<=x"01010113";
    mem(352)<=x"00008067";
    mem(353)<=x"FE810113";
    mem(354)<=x"00812A23";
    mem(355)<=x"01810413";
    mem(356)<=x"FEA42A23";
    mem(357)<=x"FEB42823";
    mem(358)<=x"FEC42623";
    mem(359)<=x"00000013";
    mem(360)<=x"01412403";
    mem(361)<=x"01810113";
    mem(362)<=x"00008067";
    mem(363)<=x"2D4B5541";
    mem(364)<=x"61732056";
    mem(365)<=x"48207379";
    mem(366)<=x"69696969";
    mem(367)<=x"0A0D2169";
    mem(368)<=x"00000000";
    mem(369)<=x"63656843";
    mem(370)<=x"676E696B";
    mem(371)<=x"6F6F6220";
    mem(372)<=x"6F6D2074";
    mem(373)<=x"0A0D6564";
    mem(374)<=x"00000000";
    mem(375)<=x"54524155";
    mem(376)<=x"6F6F6220";
    mem(377)<=x"65732074";
    mem(378)<=x"7463656C";
    mem(379)<=x"0A0D6465";
    mem(380)<=x"00000000";
    mem(381)<=x"64616F4C";
    mem(382)<=x"20676E69";
    mem(383)<=x"67616D49";
    mem(384)<=x"2E2E2E65";
    mem(385)<=x"0D2E2E2E";
    mem(386)<=x"0000000A";
    mem(387)<=x"746F6F42";
    mem(388)<=x"2E676E69";
    mem(389)<=x"2E2E2E2E";
    mem(390)<=x"0D2E2E2E";
    mem(391)<=x"0000000A";
end behave;
