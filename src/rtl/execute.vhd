library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity execute is 

    port(
            i_clk : in std_logic;
            i_rst : in std_logic;
            
            i_rs1 : in std_logic_vector(31 downto 0);
            i_rs2 : in std_logic_vector(31 downto 0);
            i_imm : in std_logic_vector(31 downto 0);
            i_pc  : in std_logic_vector(31 downto 0);
            
            i_op_type : in std_logic_vector(6 downto 0);
            i_operation : in std_logic_vector(9 downto 0);
            
            o_branch_pc : out std_logic_vector(31 downto 0);
            
            o_wb_data : out std_logic_vector(31 downto 0);
            o_wb_addr: out std_logic_vector(4 downto 0);
            o_wb_en : out std_logic;
            
            o_mem_we   : out std_logic;
            o_mem_addr : out std_logic_vector(31 downto 0);
            o_mem_data : out std_logic_vector(31 downto 0);
            i_mem_data : in std_logic_vector(31 downto 0)
            
    );

end execute;


architecture behave of execute is
    signal operand1 : std_logic_vector(31 downto 0);
    signal operand2 : std_logic_vector(31 downto 0);
    signal alu0_result : std_logic_vector(31 downto 0);
    signal set_res : std_logic_vector(31 downto 0);
    signal branch_res : std_logic_vector(31 downto 0);
    signal branch_address : std_logic_vector(31 downto 0);
    signal mem_address : std_logic_vector(31 downto 0);
    signal rd : std_logic_vector(31 downto 0);
    signal alu0_ov : std_logic;
    signal imm_type : std_logic;
    signal equ : std_logic;
    signal lt : std_logic;
    signal gt : std_logic;
    signal gte : std_logic;
    signal cmp : std_logic;
    signal mem_we : std_logic;
begin


operand2 <= i_imm when imm_type = '1' else i_rs2;

operand1 <= i_rs1;


ALU0: entity work.alu
  Port map (
            i_clk       => i_clk,
            i_rst       => i_rst,
                       
            i_operation   => i_operation,
                        
            i_rs1       => operand1,
            i_rs2       => operand2,
                        
            o_rd        => alu0_result,
            o_ov        => alu0_ov
   );


equ <= '1'when alu0_result = x"00000000"else '0';
lt <= '1'when alu0_result > x"00000000"else '0';
gt <= '1'when alu0_result < x"00000000"else '0';
gte <= gt or equ;

cmp        <=   equ when i_operation = "000000000" else
                lt  when i_operation = "000000000" else
                gt  when i_operation = "000000000" else
                gte when i_operation = "000000000" else
                '0';
set_res <= "0000000" & "000" & cmp;



branch_res <=   i_imm         when i_op_type = "0000000" else
                alu0_result   when i_op_type = "0000000" else
                i_pc;

rd <=   alu0_result     when i_op_type = "0000000" else
        set_res         when i_op_type = "0000000" else
        i_pc              when i_op_type = "0000000" else
        i_mem_data       when i_op_type = "0000000" else
        x"00000000";
mem_address <=  i_imm when i_op_type = "0000000" else
                alu0_result when i_op_type = "0000000" else
                x"00000000";
mem_we <=   '1' when i_op_type = "0000000" else
            '0';

end behave;