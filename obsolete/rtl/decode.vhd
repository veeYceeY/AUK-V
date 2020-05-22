library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity decode is
    port (
            
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            i_instruction : in std_logic_vector(31 downto 0);
            
            o_rd : out std_logic_vector(4 downto 0);
            o_rs1 : out std_logic_vector(4 downto 0);
            o_rs2 : out std_logic_vector(4 downto 0);
            
            o_immediate : out std_logic_vector(31 downto 0);
            o_op_type : out std_logic_vector(6 downto 0);
            o_fn_type : out std_logic_vector(8 downto 0)
            
            
    );
end decode;

architecture behave of decode is
--alias opcode is instr (6 downto 0);
--alias rd is instr(11 downto 7);
--alias funct3 is instr (14 downto 12);
--alias rs1 is instr (19 downto 15);
--alias rs2 is instr (24 downto 20);
--alias funct7 is instr(31 downto 25);

--alias imm_i is instr(31 downto 20);
--alias imm_s is instr(31 downto 25)&instr(11 downto 7);

signal instr : std_logic_vector(31 downto 0);
signal op : std_logic_vector(6 downto 0);
signal rd : std_logic_vector(4 downto 0);
signal rs1 : std_logic_vector(4 downto 0);
signal rs2 : std_logic_vector(4 downto 0);
signal funct3 : std_logic_vector(2 downto 0);
signal funct7 : std_logic_vector(6 downto 0);
signal imm_i : std_logic_vector(31 downto 0);
signal imm_s : std_logic_vector(31 downto 0);
signal imm_u : std_logic_vector(31 downto 0);
signal imm_b : std_logic_vector(31 downto 0);
signal imm_j : std_logic_vector(31  downto 0);
signal immu_i : std_logic_vector(31 downto 0);
signal immu_s : std_logic_vector(31 downto 0);
signal immu_u : std_logic_vector(31 downto 0);
signal immu_b : std_logic_vector(31 downto 0);
signal immu_j : std_logic_vector(31  downto 0);

signal op_decoded  : std_logic_vector(11 downto 0);

-------------r_type---------------------
alias op_alu      is op_decoded(0);
-------------i_type---------------------
alias op_jalr     is op_decoded(1);
alias op_load     is op_decoded(2);
alias op_alu_imm  is op_decoded(3);
alias op_system   is op_decoded(4);
-------------s_type---------------------
alias op_store    is op_decoded(5);
-------------u_type---------------------
alias op_lui      is op_decoded(6);
alias op_auipc    is op_decoded(7);
-------------b_type---------------------
alias op_branch   is op_decoded(8);
-------------j_type---------------------
alias op_jal      is op_decoded(9);
-------------x_type---------------------
alias op_fence    is op_decoded(10);

alias op_illegal   is op_decoded(11);

signal fn : std_logic_vector(3 downto 0);
signal fn_decoded : std_logic_vector(8 downto 0);
signal immediate : std_logic_vector(31 downto 0);
signal immediate_s : std_logic_vector(31 downto 0);
signal immediate_u : std_logic_vector(31 downto 0);

signal r_type : std_logic;
signal i_type : std_logic;
signal s_type : std_logic;
signal u_type : std_logic;
signal b_type : std_logic;
signal j_type : std_logic;
signal x_type : std_logic;


signal unsigned_type : std_logic;

begin
instr <= i_instruction;

op <= instr(6 downto 0);
rd <= instr(11 downto 7);
funct3 <= instr(14 downto 12);
rs1 <= instr(19 downto 15);
rs2 <= instr(24 downto 20);
funct7 <= instr(31 downto 25);
imm_i <=    x"00000" & instr(31 downto 20)                                                                when instr(31) = '0' else    
            x"fffff" & instr(31 downto 20);
imm_s <=    x"00000" & instr(31 downto 25) & instr(11 downto 7)                                           when instr(31) = '0' else    
            x"fffff" & instr(31 downto 25) & instr(11 downto 7);
imm_u <=    instr(31 downto 12) & x"000";
imm_b <=    "000" & x"0000" & instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'       when instr(31) = '0' else    
            "111" & x"ffff" & instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';
imm_j <=    "000" & x"00" & instr(31 )  & instr(19 downto 12) & instr(20) & instr( 30 downto 21)  & '0'   when instr(31) = '0' else    
            "111" & x"ff" & instr(31 )  & instr(19 downto 12) & instr(20) & instr( 30 downto 21)  & '0';

immu_i <=    x"00000" & instr(31 downto 20);
immu_s <=    x"00000" & instr(31 downto 25) & instr(11 downto 7) ;
immu_u <=    x"000" & instr(31 downto 12);
immu_b <=    "000" & x"0000" & instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';
immu_j <=    "000" & x"00" & instr(31 )  & instr(19 downto 12) & instr(20) & instr( 30 downto 21)  & '0';



op_lui     <= '1' when op = "0110111" else '0';
op_auipc   <= '1' when op = "0110111" else '0';
op_jal     <= '1' when op = "0110111" else '0';
op_jalr    <= '1' when op = "0110111" else '0';
op_branch  <= '1' when op = "0110111" else '0';
op_load    <= '1' when op = "0110111" else '0';
op_store   <= '1' when op = "0110111" else '0';
op_alu_imm <= '1' when op = "0110111" else '0';
op_alu     <= '1' when op = "0110111" else '0';
op_fence   <= '1' when op = "0110111" else '0';
op_system  <= '1' when op = "0110111" else '0';

op_illegal <= '1' when op_decoded = "000000000000" else '0';

fn <= funct7 (6) & funct3;

fn_decoded <=  '0' & x"01" when fn = x"0" else
               '0' & x"02" when fn = x"1" else
               '0' & x"04" when fn = x"2" else
               '0' & x"08" when fn = x"3" else
               '0' & x"10" when fn = x"4" else
               '0' & x"20" when fn = x"5" else
               '0' & x"40" when fn = x"6" else
               '0' & x"80" when fn = x"7" else
               '1' & x"00" when fn = x"8" else
               '0' & x"00" ;




r_type <= op_alu;
i_type <= '1' when op_jalr = '1' or op_load = '1' or op_system= '1' else '0';
s_type <= '1' when op_store = '1' else '0';                               
u_type <= '1' when op_lui ='1' or op_auipc = '1' else '0';
b_type <= '1' when op_branch = '1' else '0';                            
j_type <= '1' when op_jal = '1' else '0';
x_type <= '1' when op_fence ='1' else '0';

immediate_s <=    imm_i when i_type= '1' else
                imm_s when s_type = '1' else 
                imm_u when u_type = '1' else
                imm_b when b_type = '1' else
                imm_j when j_type = '1' else
                (others => '0' );
immediate_u <=    imm_i when i_type= '1' else
                immu_s when s_type = '1' else 
                immu_u when u_type = '1' else
                immu_b when b_type = '1' else
                immu_j when j_type = '1' else
                (others => '0' );
                
unsigned_type <= '1' when (op_lui='1' or op_auipc='1' or (op_branch='1' and (fn = "0110" or fn = "0111")) or (op_load='1' and (fn = "0100" or fn = "0101")) or (op_alu_imm='1' and (fn = "0011" )) or (op_alu='1' and (fn = "0011" )) or op_fence='1' or op_system='1')   else '0';
                
immediate <= immediate_u when unsigned_type='1' else immediate_s; 
--o_lui     <= '0' when i_rst = '1'else op_lui      when rising_edge(i_clk)    ;
--o_auipc   <= '0' when i_rst = '1'else op_auipc    when rising_edge(i_clk) ;
--o_jal     <= '0' when i_rst = '1'else op_jal      when rising_edge(i_clk) ;
--o_jalr    <= '0' when i_rst = '1'else op_jalr     when rising_edge(i_clk) ;
--o_branch  <= '0' when i_rst = '1'else op_branch   when rising_edge(i_clk) ;
--o_load    <= '0' when i_rst = '1'else op_load     when rising_edge(i_clk) ;
--o_store   <= '0' when i_rst = '1'else op_store    when rising_edge(i_clk) ;
--o_alu_imm <= '0' when i_rst = '1'else op_alu_imm  when rising_edge(i_clk) ;
--o_alu     <= '0' when i_rst = '1'else op_alu      when rising_edge(i_clk) ;
--o_fence   <= '0' when i_rst = '1'else op_fence    when rising_edge(i_clk) ;
--o_system  <= '0' when i_rst = '1'else op_system   when rising_edge(i_clk) ;
--o_illegal <= '0' when i_rst = '1'else op_illegal  when rising_edge(i_clk) ;









o_op_type <= (others => '0') when i_rst = '1' else r_type & i_type & s_type & u_type & b_type & j_type & x_type when rising_edge(i_clk);

o_fn_type <= (others =>'0') when i_rst = '1'else fn_decoded when rising_edge(i_clk);

o_rd <= (others =>'0') when i_rst = '1'else rd when rising_edge(i_clk);
o_rs1 <= (others =>'0') when i_rst = '1'else rs1 when rising_edge(i_clk);
o_rs2 <= (others =>'0') when i_rst = '1'else rs2 when rising_edge(i_clk);
o_immediate<= (others =>'0') when i_rst = '1'else immediate when rising_edge(i_clk);
--o_immediate_u<= (others =>'0') when i_rst = '1'else immediate_u when rising_edge(i_clk);

end behave;
