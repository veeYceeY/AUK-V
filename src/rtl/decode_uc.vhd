----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: veeYceeY
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
            
            o_uc_addr      : out std_logic_vector(7 downto 0);
            i_data      : in std_logic_vector(31 downto 0);
            
            --i_stall     : in std_logic;
            --i_br_en     : in std_logic;
            --i_br_addr   : in std_logic_vector(31 downto 0);
            
            o_src1_addr : out std_logic_vector(4 downto 0);
            o_src2_addr : out std_logic_vector(4 downto 0);
            i_src1      : in std_logic_vector(31 downto 0);
            i_src2      : in std_logic_vector(31 downto 0);
            
            
            o_rs1        : out std_logic_vector(31 downto 0);
            o_rs2        : out std_logic_vector(31 downto 0);
            o_imm        : out std_logic_vector(31 downto 0);
            o_pc         : out std_logic_vector(31 downto 0);
            
            o_op1_sel    : out std_logic_vector(1 downto 0);
            o_op2_sel    : out std_logic_vector(1 downto 0);
            
            o_br_en      : out std_logic;
            o_br_type    : out std_logic_vector(2 downto 0);
            o_br_addr_sel : out std_logic;

            o_alu_opsel  : out std_logic_vector(3 downto 0);
            o_op_sign    : out std_logic;
            o_exe_res_sel : out std_logic_vector(1 downto 0);

            o_mem_store_type : out std_logic_vector(1 downto 0);
            o_mem_load_type: out std_logic_vector(2 downto 0);
            o_wb_en      : out std_logic;
            o_wb_reg     : out std_logic_vector(4 downto 0);
            o_wb_data_sel: out std_logic;
            o_mem_en     : out std_logic;
            o_mem_we     : out std_logic;
            --o_mem_addr   : out std_logic_vector(31 downto 0);
            o_mem_data   : out std_logic_vector(31 downto 0)
            
            
            
    );

end entity;


architecture behave of decode_uc is 

signal instr : std_logic_vector(31 downto 0);
signal imm : std_logic_vector(31 downto 0);

signal funct : std_logic_vector(3 downto 0);
signal opcode : std_logic_vector(6 downto 0);
signal funct3 : std_logic_vector(2 downto 0);
signal funct7 : std_logic_vector(6 downto 0);
signal rs1 : std_logic_vector(4 downto 0);
signal rs2 : std_logic_vector(4 downto 0);
signal imms_u : std_logic_vector(31 downto 0);
signal imms_i : std_logic_vector(31 downto 0);
signal imms_j : std_logic_vector(31 downto 0);
signal imms_b : std_logic_vector(31 downto 0);
signal imms_s : std_logic_vector(31 downto 0);

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

signal rd : std_logic_vector(4 downto 0);

signal uc_addr : std_logic_vector(7 downto 0);


signal uc : std_logic_vector(31 downto 0);

signal store_type       : std_logic_vector(1 downto 0);
signal wb_we            : std_logic;
signal wb_data_sel      : std_logic;
signal mem_en           : std_logic;
signal mem_we           : std_logic;
signal mem_load_type    : std_logic_vector(2 downto 0);
signal br_en            : std_logic;
signal br_type          : std_logic_vector(2 downto 0);
signal br_addr_sel      : std_logic;
signal exe_res_sel      : std_logic_vector(1 downto 0);
signal alu_op_sel       : std_logic_vector(3 downto 0);
signal op2_sel          : std_logic_vector(1 downto 0);
signal op1_sel          : std_logic_vector(1 downto 0);
signal imm_sel          : std_logic_vector(1 downto 0);
signal op_sign          : std_logic;


begin
instr<= i_instr;

opcode <= instr(6 downto 0);
rd <= instr(11 downto 7);
funct3 <= instr(14 downto 12);
rs1 <= instr(19 downto 15);
rs2 <= instr(24 downto 20);
funct7 <= instr(31 downto 25);
imms_i <=    x"00000" & instr(31 downto 20)                                                                when instr(31) = '0' else    
            x"fffff" & instr(31 downto 20);
imms_s <=    x"00000" & instr(31 downto 25) & instr(11 downto 7)                                           when instr(31) = '0' else    
            x"fffff" & instr(31 downto 25) & instr(11 downto 7);
imms_u <=    instr(31 downto 12) & x"000";
imms_b <=    "000" & x"0000" & instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'       when instr(31) = '0' else    
            "111" & x"ffff" & instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';
imms_j <=    "000" & x"00" & instr(31 )  & instr(19 downto 12) & instr(20) & instr( 30 downto 21)  & '0'   when instr(31) = '0' else    
            "111" & x"ff" & instr(31 )  & instr(19 downto 12) & instr(20) & instr( 30 downto 21)  & '0';

immu_i <=    x"00000" & instr(31 downto 20);
immu_s <=    x"00000" & instr(31 downto 25) & instr(11 downto 7) ;
immu_u <=    x"000" & instr(31 downto 12);
immu_b <=    "000" & x"0000" & instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0';
immu_j <=    "000" & x"00" & instr(31 )  & instr(19 downto 12) & instr(20) & instr( 30 downto 21)  & '0';
o_uc_addr        <= uc_addr;
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
exe_res_sel      <=uc(15 downto 14);
alu_op_sel       <=uc(19 downto 16);
op2_sel          <=uc(21 downto 20);
op1_sel          <=uc(23 downto 22);
imm_sel          <=uc(25 downto 24);
op_sign          <=uc(26);

o_src1_addr     <= rs1;
o_src2_addr     <= rs2;
o_rs1           <= (others =>'0') when i_rst = '1' else i_src1 when rising_edge(i_clk);
o_rs2           <= (others =>'0') when i_rst = '1' else i_src2 when rising_edge(i_clk);
o_imm           <= (others =>'0') when i_rst = '1' else imm         when rising_edge(i_clk);
o_pc            <= (others =>'0') when i_rst = '1' else i_pc        when rising_edge(i_clk);
o_op1_sel       <= (others =>'0') when i_rst = '1' else op1_sel     when rising_edge(i_clk);
o_op2_sel       <= (others =>'0') when i_rst = '1' else op2_sel     when rising_edge(i_clk);
o_br_en         <= '0' when i_rst = '1' else br_en       when rising_edge(i_clk);
o_br_type       <= (others =>'0') when i_rst = '1' else br_type     when rising_edge(i_clk);
o_br_addr_sel   <= '0' when i_rst = '1' else br_addr_sel when rising_edge(i_clk);
o_alu_opsel     <= (others =>'0') when i_rst = '1' else alu_op_sel  when rising_edge(i_clk);
o_exe_res_sel   <= (others =>'0') when i_rst = '1' else exe_res_sel when rising_edge(i_clk);
o_mem_store_type<= (others =>'0') when i_rst = '1' else store_type  when rising_edge(i_clk);
o_mem_load_type <= (others =>'0') when i_rst = '1' else mem_load_type  when rising_edge(i_clk);
o_wb_en         <= '0' when i_rst = '1' else wb_we when rising_edge(i_clk);
o_wb_reg        <= (others =>'0') when i_rst = '1' else rd when rising_edge(i_clk);
o_wb_data_sel   <= '0' when i_rst = '1' else wb_data_sel when rising_edge(i_clk);
o_mem_en        <= '0' when i_rst = '1' else mem_en      when rising_edge(i_clk);
o_mem_we        <= '0' when i_rst = '1' else mem_we      when rising_edge(i_clk);
--o_mem_addr      <= imm         when rising_edge(i_clk);
o_mem_data      <= (others =>'0') when i_rst = '1' else i_src2      when rising_edge(i_clk);
o_op_sign        <= '0' when i_rst = '1' else op_sign when rising_edge(i_clk);
imm_u <= imms_u when op_sign = '0' else immu_u;
imm_i <= imms_i when op_sign = '0' else immu_i;
imm_j <= imms_j when op_sign = '0' else immu_j;
imm_b <= imms_b when op_sign = '0' else immu_b;
imm_s <= imms_s when op_sign = '0' else immu_s;


imm <=  imm_u when imm_sel = x"0" else
        imm_i when imm_sel = x"1" else
        imm_j when imm_sel = x"2" else
        imm_b when imm_sel = x"3" else
        imm_s when imm_sel = x"4" ;
        

process(opcode,funct3,funct7) 
begin
    if opcode = "0110111" then
        uc_addr <= x"01";
    elsif opcode = "0010111" then
        uc_addr <= x"02";
    elsif opcode = "1101111" then
        uc_addr <= x"03";
    elsif opcode = "1100111" then
        uc_addr <= x"04";
    elsif opcode = "1100011" then
            if funct3 = "000" then
                uc_addr <= x"05";
            elsif funct3 = "001" then
                uc_addr <= x"06";
            elsif funct3 = "100" then
                uc_addr <= x"07";
            elsif funct3 = "101" then
                uc_addr <= x"08";
            elsif funct3 = "110" then
                uc_addr <= x"09";
            elsif funct3 = "111" then
                uc_addr <= x"0a";
            end if;
    elsif opcode = x"0000011" then
            if funct3 = "000" then
                uc_addr <= x"0b";
            elsif funct3 = "001" then
                uc_addr <= x"0c";
            elsif funct3 = "010" then
                uc_addr <= x"0d";
            elsif funct3 = "100" then
                uc_addr <= x"0e";
            elsif funct3 = "101" then
                uc_addr <= x"0f";
            end if;
    elsif opcode = "0100011" then
            if funct3 = "000" then
                uc_addr <= x"10";
            elsif funct3 = "001" then
                uc_addr <= x"11";
            elsif funct3 = "010" then
                uc_addr <= x"12";
            end if;
    elsif opcode = "0010011" then
            if funct7(5) = '0' then
                if funct3 = "000" then
                    uc_addr <= x"13";
                elsif funct3 = "001" then
                    uc_addr <= x"19";
                elsif funct3 = "010" then
                    uc_addr <= x"14";
                elsif funct3 = "011" then
                    uc_addr <= x"15";
                elsif funct3 = "100" then
                    uc_addr <= x"16";
                elsif funct3 = "101" then
                    uc_addr <= x"20";
                elsif funct3 = x"110" then
                    uc_addr <= x"17";
                elsif funct3 = "111" then
                    uc_addr <= x"18";
                end if;
             else
                if funct3 = x"101" then
                    uc_addr <= x"1b";
                end if;
             end if;
    elsif opcode = "0110011" then
            if funct7(5) = '0' then
                if funct3 = "000" then
                    uc_addr <= x"1c";
                elsif funct3 = "001" then
                    uc_addr <= x"1e";
                elsif funct3 = "010" then
                    uc_addr <= x"1f";
                elsif funct3 = "011" then
                    uc_addr <= x"20";
                elsif funct3 = "100" then
                    uc_addr <= x"21";
                elsif funct3 = "101" then
                    uc_addr <= x"22";
                elsif funct3 = "110" then
                    uc_addr <= x"24";
                elsif funct3 = "111" then
                    uc_addr <= x"25";
                end if;
             else
                if funct3 = "000" then
                    uc_addr <= x"1d";
                elsif funct3 = "101" then
                    uc_addr <= x"23";
                end if;
             end if;
    elsif opcode = "0001111" then
            if funct3 = "000" then
                uc_addr <= x"26";
            elsif funct3 = "001" then
                uc_addr <= x"27";
            end if;
    elsif opcode = "1110011" then
            if imm_i(0) = '0' then
                uc_addr <= x"28";
            else
                uc_addr <= x"29";
            end if;
    end if;
end process;



end behave;