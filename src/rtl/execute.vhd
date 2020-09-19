----------------------------------------------------------------------------------
-- Company: SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: 24.04.2020 14:55:58
-- Design Name: 
-- Module Name: microcode_mem - Behavioral
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



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity execute is 

    port(
            i_clk           : in std_logic;
            i_rst           : in std_logic;
            
            i_stall           : in std_logic;
            
            i_rs1           : in std_logic_vector(31 downto 0);
            i_rs2           : in std_logic_vector(31 downto 0);
            
            i_fw_ee           : in std_logic_vector(31 downto 0);
            i_fw_me           : in std_logic_vector(31 downto 0);
            i_fw_we           : in std_logic_vector(31 downto 0);
            
            i_imm           : in std_logic_vector(31 downto 0);
            i_pc            : in std_logic_vector(31 downto 0);
            
            i_rs1_fwsel     : in std_logic_vector(1 downto 0);
            i_rs2_fwsel     : in std_logic_vector(1 downto 0);
            
            i_cmp_op1sel       : in std_logic;
            i_op1_sel       : in std_logic_vector(1 downto 0);
            i_op2_sel       : in std_logic_vector(1 downto 0);
            i_signed_op     : in std_logic;

            i_alu_sel       : in std_logic_vector(3 downto 0);
            i_res_sel       : in std_logic_vector(1 downto 0);

            i_br_addr_sel   : in std_logic;
            i_br_type_sel   : in std_logic_vector(2 downto 0);
            i_br_en         : in std_logic;
            
            
            i_mem_wr_data   : in std_logic_vector(31 downto 0);
            i_mem_we        : in std_logic;
            i_mem_en        : in std_logic;
            
            i_load_type     : in std_logic_vector(2 downto 0);
            i_store_type    : in std_logic_vector(1 downto 0);
            
            i_wb_data_sel   : in std_logic;
            i_wb_reg_sel    : in std_logic_vector(4 downto 0);
            i_wb_we         : in std_logic;
            
            o_exe_res       : out std_logic_vector(31 downto 0);
            
            o_br_addr       : out std_logic_vector(31 downto 0);
            o_br_en         : out std_logic;
            
            o_mem_wr_data   : out std_logic_vector(31 downto 0);
            o_mem_addr      : out std_logic_vector(31 downto 0);
            o_mem_we        : out std_logic;
            o_mem_en        : out std_logic;
            
            o_wb_data_sel   : out std_logic;
            o_wb_reg_sel    : out std_logic_vector(4 downto 0);
            o_wb_we         : out std_logic;
            
            o_load_type     : out std_logic_vector(2 downto 0);
            o_store_type     : out std_logic_vector(1 downto 0);
            
            i_csr_sel       : in std_logic;
            i_csr_rd        : in std_logic;
            i_csr_we        : in std_logic;
            --i_csr_wr_data  : in std_logic_vector(31 downto 0);
            i_csr_wr_addr   : in std_logic_vector(11 downto 0);
            i_csr_rd_addr   : in std_logic_vector(11 downto 0);
            i_csr_op        : in std_logic_vector(1 downto 0);
            
            --o_csr_sel       : out std_logic;
            o_csr_rd        : out std_logic;
            o_csr_we        : out std_logic;
            o_csr_wr_data   : out std_logic_vector(31 downto 0);
            o_csr_wr_addr   : out std_logic_vector(11 downto 0);
            o_csr_rd_addr   : out std_logic_vector(11 downto 0);
            o_csr_op        : out std_logic_vector(1 downto 0);
            i_csr_rd_data   : in std_logic_vector(31 downto 0)
            
            
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
    signal mem_we : std_logic;
    
    signal alu0_lt : std_logic;
    signal alu0_ge : std_logic;
    signal alu0_eq : std_logic;
    signal alu0_ne : std_logic;
    
    signal cp0_lt : std_logic;
    signal cp0_ge : std_logic;
    signal cp0_eq : std_logic;
    signal cp0_ne : std_logic;

    signal ZERO32 : std_logic_vector(31 downto 0);
    signal FOUR32 : std_logic_vector(31 downto 0);
    signal cmp_result : std_logic;
    signal br_en : std_logic;
    signal set_result : std_logic_vector(31 downto 0);
    signal next_instr_addr : std_logic_vector(31 downto 0);
    signal branch_addr : std_logic_vector(31 downto 0);
    signal exe_result : std_logic_vector(31 downto 0);
    signal rs1 : std_logic_vector(31 downto 0);
    signal rs2 : std_logic_vector(31 downto 0);
    signal cmp_op1 : std_logic_vector(31 downto 0);
    signal mem_data : std_logic_vector(31 downto 0);
    signal csr_wr_data : std_logic_vector(31 downto 0);
    signal wb_data : std_logic_vector(31 downto 0);
    
begin



--process(i_clk,i_rst)
--begin
--    if i_rst = '1' then
--    
--        o_csr_rd        <='0'       ;
--        o_csr_we        <='0'        ;
--        o_csr_wr_data   <=(others => '0')     ;
--        o_csr_wr_addr   <=(others => '0')     ;
--        o_csr_rd_addr   <=(others => '0')     ;
--        o_csr_op        <=(others => '0')          ;
--       
--        
--    elsif rising_edge(i_clk) then
--        if i_stall='0' then
--           --o_csr_sel       <=i_csr_sel       ;
--            o_csr_rd        <=i_csr_rd        ;
--            o_csr_we        <=i_csr_we        ;
--            o_csr_wr_data   <=rs1   ;
--            o_csr_wr_addr   <=i_csr_wr_addr   ;
--            o_csr_rd_addr   <=i_csr_rd_addr   ;
--            o_csr_op        <=i_csr_op        ;
--        end if;
--        
--    end if;
--end process;

o_csr_rd        <=i_csr_rd        ;
o_csr_we        <=i_csr_we        ;
o_csr_wr_data   <=rs1   ;
o_csr_wr_addr   <=i_csr_wr_addr   ;
o_csr_rd_addr   <=i_csr_rd_addr   ;
o_csr_op        <=i_csr_op        ;








wb_data <= i_csr_rd_data when i_csr_sel ='1' else exe_result;



rs1 <=  i_rs1 when i_rs1_fwsel = "00"  else
        i_fw_ee when i_rs1_fwsel = "01" else
        i_fw_me when i_rs1_fwsel = "10" else
        i_fw_we;
rs2 <=  i_rs2 when i_rs2_fwsel = "00"  else
        i_fw_ee when i_rs2_fwsel = "01" else
        i_fw_me when i_rs2_fwsel = "10" else
        i_fw_we;

ZERO32    <= x"00000000";
FOUR32    <= x"00000004";
operand1  <= rs1 when i_op1_sel= "00" else
             rs2 when i_op1_sel= "01" else
             i_pc  when i_op1_sel = "10" else
             ZERO32 when i_op1_sel = "11";

operand2  <= rs2 when i_op2_sel= "00" else
             rs1 when i_op2_sel= "01" else
             i_imm when i_op2_sel= "10" else
             ZERO32 when i_op2_sel= "11";
             
             
cmp_op1 <= rs2 when i_cmp_op1sel='0' else i_imm; 



ALU0: entity work.alu
  Port map (
            i_clk       => i_clk,
            i_rst       => i_rst,
                       
            i_operation => i_alu_sel,
                        
            i_rs1       => operand1,
            i_rs2       => operand2,
                        
            o_rd        => alu0_result
            --o_ov        => alu0_ov
   );
CP0: entity work.comp
port map(
            i_a => rs1,
            i_b => cmp_op1,
            i_s => i_signed_op,
            o_lt => cp0_lt,
            o_ge => cp0_ge,
            o_eq => cp0_eq,
            o_ne => cp0_ne
);

cmp_result <=   cp0_eq when i_br_type_sel = "000" else 
                cp0_ne when i_br_type_sel = "001" else
                cp0_lt when i_br_type_sel = "010" else
                cp0_ge when i_br_type_sel = "011" else
                '1'    when i_br_type_sel = "100" else 
                '0';

set_result <= x"0000000" & "000" & cmp_result;

next_instr_addr <= i_pc+FOUR32;

branch_addr <=  i_csr_rd_data when i_csr_sel ='1' else
                alu0_result when i_br_addr_sel = '0' else
                i_imm;

exe_result  <=  alu0_result when i_res_sel = "00" else
                set_result  when i_res_sel = "10" else
                next_instr_addr;
                
mem_address <=  alu0_result;

br_en<= cmp_result and i_br_en;


mem_data <=  i_mem_wr_data when i_rs2_fwsel = "00"  else
        i_fw_ee when i_rs2_fwsel = "01" else
        i_fw_me when i_rs2_fwsel = "10" else
        i_fw_we;

--o_br_addr       <= (others => '0')  when i_rst = '1' else branch_addr       when rising_edge(i_clk);
--o_br_en         <= '0'              when i_rst = '1' else br_en             when rising_edge(i_clk);
--o_exe_res       <= (others => '0')  when i_rst = '1' else exe_result        when rising_edge(i_clk);
--o_mem_wr_data   <= (others => '0')  when i_rst = '1' else i_mem_wr_data     when rising_edge(i_clk);
--o_mem_addr      <= (others => '0')  when i_rst = '1' else mem_address       when rising_edge(i_clk);
--o_mem_we        <= '0'              when i_rst = '1' else i_mem_we          when rising_edge(i_clk);          
--o_wb_data_sel   <= '0'              when i_rst = '1' else i_wb_data_sel     when rising_edge(i_clk);
--o_wb_reg_sel    <= (others => '0')  when i_rst = '1' else i_wb_reg_sel      when rising_edge(i_clk);
--o_wb_we         <= '0'              when i_rst = '1' else i_wb_we           when rising_edge(i_clk);
--o_mem_en        <= '0'              when i_rst = '1' else i_mem_en          when rising_edge(i_clk);         
--o_load_type     <= (others => '0')  when i_rst = '1' else i_load_type       when rising_edge(i_clk);
--o_store_type    <= (others => '0')  when i_rst = '1' else i_store_type      when rising_edge(i_clk);

process(i_clk,i_rst)
begin
    if i_rst = '1' then
    
        o_br_addr       <= (others => '0')   ;
        o_br_en         <= '0'               ;
        o_exe_res       <= (others => '0')   ;
        o_mem_wr_data   <= (others => '0')   ;
        o_mem_addr      <= (others => '0')   ;
        o_mem_we        <= '0'               ;
        o_wb_data_sel   <= '0'               ;
        o_wb_reg_sel    <= (others => '0')   ;
        o_wb_we         <= '0'               ;
        o_mem_en        <= '0'               ;
        o_load_type     <= (others => '0')   ;
        o_store_type    <= (others => '0')   ;
        
    elsif rising_edge(i_clk) then
        if i_stall='0' then
            o_br_addr       <= branch_addr     ;
            o_br_en         <= br_en           ;
            o_exe_res       <= wb_data      ;
            o_mem_wr_data   <= mem_data   ;
            o_mem_addr      <= mem_address     ;
            o_mem_we        <= i_mem_we        ;
            o_wb_data_sel   <= i_wb_data_sel   ;
            o_wb_reg_sel    <= i_wb_reg_sel    ;
            o_wb_we         <= i_wb_we         ;
            o_mem_en        <= i_mem_en        ;
            o_load_type     <= i_load_type     ;
            o_store_type    <= i_store_type    ;
        end if;
        
    end if;
end process;



end behave;
