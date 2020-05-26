--RIsc V instruction decoder with microcode memory
--Must be changed to hard coded decoder after debugging
 
 
 
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


signal uc : std_logic_vector(25 downto 0);

signal store_type       : std_logic_vector(1 downto 0);
signal wb_we            : std_logic;
signal wb_data_sel      : std_logic;
signal mem_en           : std_logic;
signal mem_we           : std_logic;
signal mem_load_type    : std_logic_vector(2 downto 0);
signal br_en            : std_logic;
signal br_type          : std_logic_vector(2 downto 0);
signal br_addr_sel      : std_logic;
signal exe_result_sel   : std_logic;
signal alu_op_sel       : std_logic_vector(3 downto 0);
signal op2_sel          : std_logic_vector(1 downto 0);
signal op1_sel          : std_logic_vector(1 downto 0);
signal imm_sel          : std_logic_vector(1 downto 0);
signal op_sign          : std_logic;


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

uc               <= i_data;
store_type       <=uc(1 downto 0);
wb_we            <=uc(2);
wb_data_sel      <=uc(3);
mem_en           <=uc(4);
mem_we           <=uc(5);
mem_load_type    <=uc(8 downto 6);
br_en            <=uc(9);
br_type          <=uc(12 downto 10);
br_addr_sel      <=uc(13);
exe_result_sel   <=uc(14);
alu_op_sel       <=uc(18 downto 15);
op2_sel          <=uc(20 downto 19);
op1_sel          <=uc(22 downto 21);
imm_sel          <=uc(24 downto 23);
op_sign          <=uc(25);

process(opcode) 
begin
    if opcode = x"37" then
        uc_addr <= x"00";
    elsif opcode = x"17" then
        uc_addr <= x"01";
    elsif opcode <= x"6f" then
        uc_addr <= x"02";
    elsif opcode = x"67" then
        uc_addr <= x"03";
    elsif opcode = x"63" then
            if funct3 = x"0" then
                uc_addr <= x"04";
            elsif funct3 = x"1" then
                uc_addr <= x"05";
            elsif funct3 = x"4" then
                uc_addr <= x"06";
            elsif funct3 = x"5" then
                uc_addr <= x"07";
            elsif funct3 = x"6" then
                uc_addr <= x"08";
            elsif funct3 = x"7" then
                uc_addr <= x"09";
            end if;
    elsif opcode = x"03" then
            if funct3 = x"0" then
                uc_addr <= x"0A";
            elsif funct3 = x"1" then
                uc_addr <= x"0B";
            elsif funct3 = x"2" then
                uc_addr <= x"0C";
            elsif funct3 = x"4" then
                uc_addr <= x"0D";
            elsif funct3 = x"5" then
                uc_addr <= x"0E";
            end if;
    elsif opcode = x"23" then
            if funct3 = x"0" then
                uc_addr <= x"0F";
            elsif funct3 = x"1" then
                uc_addr <= x"10";
            elsif funct3 = x"2" then
                uc_addr <= x"11";
            end if;
    elsif opcode = x"13" then
            if funct7(5) = '0' then
                if funct3 = x"0" then
                    uc_addr <= x"12";
                elsif funct3 = x"1" then
                    uc_addr <= x"13";
                elsif funct3 = x"2" then
                    uc_addr <= x"14";
                elsif funct3 = x"4" then
                    uc_addr <= x"15";
                elsif funct3 = x"5" then
                    uc_addr <= x"16";
                elsif funct3 = x"6" then
                    uc_addr <= x"17";
                elsif funct3 = x"7" then
                    uc_addr <= x"18";
                end if;
             else
                if funct3 = x"5" then
                    uc_addr <= x"04";
                end if;
             end if;
    elsif opcode = x"33" then
            if funct7(5) = '0' then
                if funct3 = x"0" then
                    uc_addr <= x"19";
                elsif funct3 = x"1" then
                    uc_addr <= x"1A";
                elsif funct3 = x"2" then
                    uc_addr <= x"1B";
                elsif funct3 = x"3" then
                    uc_addr <= x"1C";
                elsif funct3 = x"4" then
                    uc_addr <= x"1D";
                elsif funct3 = x"5" then
                    uc_addr <= x"1E";
                elsif funct3 = x"6" then
                    uc_addr <= x"1F";
                elsif funct3 = x"7" then
                    uc_addr <= x"20";
                end if;
             else
                if funct3 = x"0" then
                    uc_addr <= x"21";
                elsif funct3 = x"5" then
                    uc_addr <= x"22";
                end if;
             end if;
    elsif opcode = x"0F" then
            if funct3 = x"0" then
                uc_addr <= x"23";
            elsif funct3 = x"1" then
                uc_addr <= x"24";
            end if;
    elsif opcode = x"73" then
            if imm_i(0) = '0' then
                uc_addr <= x"25";
            else
                uc_addr <= x"26";
            end if;
    end if;
end process;



end behave;