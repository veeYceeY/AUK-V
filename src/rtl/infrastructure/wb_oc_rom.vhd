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
signal mem : mem_type;
attribute rom_style of mem : signal is "block";
signal data : std_logic_vector(31 downto 0);
signal addr : std_logic_vector(13 downto 0);
begin
    addr <= i_m_wb.addr(15 downto 2)  ;
    data <= mem(to_integer(unsigned((addr)))) when i_m_wb.stb='1'  and i_m_wb.cyc='1' else (others => '0');
 
    o_m_wb.data <= mem(to_integer(unsigned((addr)))) when  i_m_wb.stb='1'  and i_m_wb.cyc='1' and rising_edge(i_clk);
    o_m_wb.ack <= i_m_wb.stb and i_m_wb.cyc when rising_edge(i_clk);


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
    mem(14)<=x"FD040793";
    mem(15)<=x"FEF42423";
    mem(16)<=x"FD440793";
    mem(17)<=x"FEF42223";
    mem(18)<=x"FD840793";
    mem(19)<=x"FEF42023";
    mem(20)<=x"FE842783";
    mem(21)<=x"00500713";
    mem(22)<=x"00E7A023";
    mem(23)<=x"FE442783";
    mem(24)<=x"FF600713";
    mem(25)<=x"00E7A023";
    mem(26)<=x"FE842783";
    mem(27)<=x"0007A703";
    mem(28)<=x"FE442783";
    mem(29)<=x"0007A783";
    mem(30)<=x"00F70733";
    mem(31)<=x"FE042783";
    mem(32)<=x"00E7A023";
    mem(33)<=x"001007B7";
    mem(34)<=x"00178793";
    mem(35)<=x"FCF42E23";
    mem(36)<=x"FDC42783";
    mem(37)<=x"08600713";
    mem(38)<=x"00E7A023";
    mem(39)<=x"F9C00793";
    mem(40)<=x"FEF42A23";
    mem(41)<=x"0100006F";
    mem(42)<=x"FF442783";
    mem(43)<=x"00178793";
    mem(44)<=x"FEF42A23";
    mem(45)<=x"FF442703";
    mem(46)<=x"06300793";
    mem(47)<=x"FEE7D6E3";
    mem(48)<=x"04500593";
    mem(49)<=x"FDC42503";
    mem(50)<=x"060000EF";
    mem(51)<=x"FE042823";
    mem(52)<=x"0100006F";
    mem(53)<=x"FF042783";
    mem(54)<=x"00178793";
    mem(55)<=x"FEF42823";
    mem(56)<=x"FF042703";
    mem(57)<=x"0C700793";
    mem(58)<=x"FEE7D6E3";
    mem(59)<=x"07600593";
    mem(60)<=x"FDC42503";
    mem(61)<=x"034000EF";
    mem(62)<=x"FE042623";
    mem(63)<=x"0100006F";
    mem(64)<=x"FEC42783";
    mem(65)<=x"00178793";
    mem(66)<=x"FEF42623";
    mem(67)<=x"FEC42703";
    mem(68)<=x"12B00793";
    mem(69)<=x"FEE7D6E3";
    mem(70)<=x"0E300593";
    mem(71)<=x"FDC42503";
    mem(72)<=x"008000EF";
    mem(73)<=x"F79FF06F";
    mem(74)<=x"FF010113";
    mem(75)<=x"00812623";
    mem(76)<=x"01010413";
    mem(77)<=x"FEA42A23";
    mem(78)<=x"FEB42823";
    mem(79)<=x"FF442783";
    mem(80)<=x"FF042703";
    mem(81)<=x"00E7A023";
    mem(82)<=x"00000013";
    mem(83)<=x"00C12403";
    mem(84)<=x"01010113";
    mem(85)<=x"00008067";

end behave;