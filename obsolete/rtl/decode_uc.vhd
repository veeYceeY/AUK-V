 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity decode_uc is
    port (
            i_clk       : in std_logic;
            i_rst       : in std_logic;
            
            i_instr     : in std_logic_vector(31 downto 0);
            i_pc        : in std_logic_vector(31 downto 0);
            
            o_addr      : out std_logic_vector(5 downto 0);
            i_data      : in std_logic_vector(31 downto 0);
            
            i_stall     : in std_logic;
            i_br_en     : in std_logic;
            i_br_addr   : in std_logic_vector(31 downto 0);
            
            
            o_rs1       : out std_logic_vector(31 downto 0);
            o_rs2       : out std_logic_vector(31 downto 0);
            o_imm       : out std_logic_vector(31 downto 0);
            o_pc        : out std_logic_vector(31 downto 0);
            
            o_op1_sel   : out std_logic_vector(31 downto 0);
            o_op2_sel   : out std_logic_vector(31 downto 0);
            
            o_br_en     : out std_logic;
            o_br_type   : out std_logic;
            o_br_addr_sel : out std_logic;
            
            o_exe_res_sel : out std_logic_vector(1 downto 0);
            
            o_wb_en     : out std_logic;
            o_wb_reg    : out std_logic_vector(31 downto 0);
            
            o_mem_en    : out std_logic;
            o_mem_we    : out std_logic;
            o_mem_addr  : out std_logic_vector(31 downto 0);
            o_mem_data  : out std_logic_vector(31 downto 0)
            
            
            
    );

end entity;


architecture behave of decode_uc is 

signal instr : std_logic_vector(31 downto 0);
signal funct : std_logic_vector(3 downto 0);
signal opcode : std_logic_vector(6 downto 0);
signal funct3 : std_logic_vector(2 downto 0);
signal funct7 : std_logic_vector(6 downto 0);
signal rs1 : std_logic_vector(4 downto 0);
signal rs2 : std_logic_vector(4 downto 0);
signal imm_u : std_logic_vector(31 downto 0);
signal imm_i : std_logic_vector(31 downto 0);
signal imm_j : std_logic_vector(31 downto 0);
signal imm_b : std_logic_vector(31 downto 0);
signal imm_s : std_logic_vector(31 downto 0);

signal immu_u : std_logic_vector(31 downto 0);
signal immu_i : std_logic_vector(31 downto 0);
signal immu_j : std_logic_vector(31 downto 0);
signal immu_b : std_logic_vector(31 downto 0);
signal immu_s : std_logic_vector(31 downto 0);

signal rd : std_logic_vector(31 downto 0);

signal uc_addr : std_logic_vector(5 downto 0);
begin


opcode <= instr(6 downto 0);
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



process(opcode) 
begin
    if opcode = "0000000" or opcode = "0000000" or opcode = "0000000" then
    begin
        uc_addr<= "000000";
    end if;
end process;



end behave;