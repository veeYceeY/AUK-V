library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity alu is
  Port (
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            i_operation : in std_logic_vector(9 downto 0);
            
            i_rs1 : in std_logic_vector(31 downto 0);
            i_rs2 : in std_logic_vector(31 downto 0);
            
            o_rd  : out std_logic_vector(31 downto 0);
            o_ov : out std_logic
   );
end alu;

architecture Behavioral of alu is

signal result : std_logic_vector(32 downto 0);
signal sum : std_logic_vector(32 downto 0);
signal dif : std_logic_vector(32 downto 0);
signal anded : std_logic_vector(32 downto 0);
signal ored : std_logic_vector(32 downto 0);
signal xored : std_logic_vector(32 downto 0);
signal shiftleft : std_logic_vector(32 downto 0);
signal shiftright_logic : std_logic_vector(32 downto 0);
signal shiftright_arith : std_logic_vector(32 downto 0);
signal zero : std_logic_vector(31 downto 0);
signal sign : std_logic_vector(31 downto 0);
signal shamt : integer;
begin

shamt <= to_integer(unsigned(i_rs2(4 downto 0)));

sum   <= i_rs1 + i_rs2;
dif   <= i_rs1 - i_rs2;
ored  <= '0' &(i_rs1 or i_rs2);
anded <= '0' &(i_rs1 and i_rs2);
xored <= '0' &(i_rs1 xor i_rs2);

zero <= x"00000000";
sign <= x"00000000" when i_rs1(31) = '0' else x"ffffffff";

shiftleft <= i_rs1((31-shamt) downto 0 ) & zero(shamt-1 downto 0);
shiftright_logic <= zero(shamt-1 downto 0) & i_rs1((31) downto shamt);
shiftright_arith <= sign(shamt-1 downto 0) & i_rs1((31) downto shamt);





result <=   sum        when i_operation = "0000000001" else
            dif        when i_operation = "0000000010" else
            ored       when i_operation = "0000000100" else
            anded      when i_operation = "0000001000" else
            xored      when i_operation = "0000010000" else
            shiftleft  when i_operation = "0000100000" else
            shiftright_arith when i_operation = "0001000000" else
            shiftright_logic when i_operation = "0010000000" else
            dif        when i_operation = "0100000000" else
            dif        when i_operation = "1000000000" else
            x"00000000";
--o_rd <= (others => '0') when i_rst= '1' else result(31 downto 0) when rising_edge(i_clk);
--o_ov <=  '0' when i_rst = '1' else result(32) when rising_edge(i_clk);
o_rd <= (others => '0') when i_rst= '1' else result(31 downto 0);
o_ov <=  '0' when i_rst = '1' else result(32);
end Behavioral;
