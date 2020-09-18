----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: Veeyceey
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sciv_core is
  Port ( 
            i_clk             : in std_logic;
            i_rst             : in std_logic;
            
            
            o_data_mem_en     : out std_logic;
            o_data_mem_we     : out std_logic;
            o_data_mem_addr   : out std_logic_vector(31 downto 0);
            i_data_mem_data   : in std_logic_vector(31 downto 0);
            i_data_mem_valid  : in std_logic;
            o_data_mem_data   : out std_logic_vector(31 downto 0);
            o_data_mem_strobe : out std_logic_vector(3 downto 0);
            
            o_code_mem_en     : out std_logic;
            o_code_mem_addr   : out std_logic_vector(31 downto 0);
            i_code_mem_data   : in std_logic_vector(31 downto 0);
            i_code_mem_valid  : in std_logic
            
            
  );
end sciv_core;

architecture Behavioral of sciv_core is
signal ma0_stall : std_logic;

signal wb0_branch_addr : std_logic_vector(31 downto 0);
signal wb0_branch_en : std_logic;

signal fe0_pc : std_logic_vector(31 downto 0);
signal fe0_instr : std_logic_vector(31 downto 0);

signal de0_rs1_addr : std_logic_vector(4 downto 0);
signal de0_rs2_addr : std_logic_vector(4 downto 0);

signal rf0_rs1: std_logic_vector(31 downto 0);
signal rf0_rs2: std_logic_vector(31 downto 0);



signal de0_rs1: std_logic_Vector(31 downto 0);
signal de0_rs2: std_logic_Vector(31 downto 0);         
signal de0_imm: std_logic_Vector(31 downto 0);         
signal de0_pc: std_logic_Vector(31 downto 0);          
signal de0_op1_sel: std_logic_Vector(1 downto 0);     
signal de0_op2_sel: std_logic_Vector(1 downto 0);
signal de0_br_en: std_logic;      
signal de0_br_type: std_logic_Vector(2 downto 0);     
signal de0_br_addr_sel: std_logic; 
signal de0_alu_opsel: std_logic_Vector(3 downto 0);   
signal de0_op_sign : std_logic;
signal de0_exe_res_sel: std_logic_vector(1 downto 0); 
signal de0_mem_store_type: std_logic_Vector(1 downto 0);
signal de0_mem_load_type: std_logic_Vector(2 downto 0);
signal de0_wb_en: std_logic;       
signal de0_wb_reg: std_logic_Vector(4 downto 0);      
signal de0_wb_data_sel: std_logic; 
signal de0_mem_en: std_logic;      
signal de0_mem_we: std_logic;      
signal de0_mem_data: std_logic_Vector(31 downto 0);     

signal ex0_exe_res : std_logic_vector(31 downto 0);
signal ex0_br_addr : std_logic_vector(31 downto 0);
signal ex0_br_en : std_logic;
signal ex0_mem_wr_data : std_logic_vector(31 downto 0);
signal ex0_mem_addr    : std_logic_vector(31 downto 0);
signal ex0_mem_we      : std_logic;
signal ex0_mem_en      : std_logic;
signal ex0_wb_data_sel : std_logic;
signal ex0_wb_reg_sel  : std_logic_vector(4 downto 0);
signal ex0_wb_we       : std_logic;
signal ex0_load_type   : std_logic_vector(2 downto 0);
signal ex0_store_type   : std_logic_vector(1 downto 0);

signal ma0_br_addr : std_logic_vector(31 downto 0);
signal ma0_br_en: std_logic;
signal ma0_wb_data: std_logic_vector(31 downto 0);
signal ma0_wb_reg_sel: std_logic_vector(4 downto 0);
signal ma0_wb_we: std_logic;


signal wb0_wb_data: std_logic_vector(31 downto 0);
signal wb0_wb_reg_sel: std_logic_vector(4 downto 0);
signal wb0_wb_we: std_logic;
signal wb0_br_addr: std_logic_vector(31 downto 0);
signal wb0_br_en: std_logic;

--signal wb0_rs1: std_logic_vector(31 downto 0);
--signal wb0_rs2: std_logic_vector(31 downto 0);

signal de0_rs1_fwsel : std_logic_vector(1 downto 0);
signal de0_rs2_fwsel : std_logic_vector(1 downto 0);
signal de0_cmp_op1sel : std_logic;
signal fetch_stall : std_logic;
signal de0_stall : std_logic;

signal de0_csr_sel   : std_logic;
signal de0_csr_we    : std_logic;
signal de0_csr_rd    : std_logic;
signal de0_csr_data  : std_logic_vector(31 downto 0);
signal de0_csr_wr_addr  : std_logic_vector(11 downto 0);
signal de0_csr_rd_addr  : std_logic_vector(11 downto 0);
signal de0_csr_op    : std_logic_vector(1 downto 0);
signal csr0_csr_data  : std_logic_vector(31 downto 0);



begin

--ma0_stall<= '0';
o_code_mem_en<='1';

fetch_stall <= de0_stall or ma0_stall;


FE0: entity work.fetch  
        port map (
                i_clk           =>i_clk,
                i_rst           =>i_rst,
                                
                i_stall         =>fetch_stall,
                i_branch_addr   =>ma0_br_addr,
                i_branch_en     =>ma0_br_en,  
                                 
                o_addr          =>o_code_mem_addr,
                i_data          =>i_code_mem_data,
                i_valid         =>i_code_mem_valid,
                o_pc            =>fe0_pc,
                o_instr         =>fe0_instr
        );
DE0: entity work.decode_uc
    port map (
            i_clk           =>i_clk,
            i_rst           =>i_rst,
            i_stall         =>ma0_stall,
            
            i_instr         =>fe0_instr,
            i_pc            =>fe0_pc,

            o_src1_addr     =>de0_rs1_addr,
            o_src2_addr     =>de0_rs2_addr,
            i_src1          =>rf0_rs1,
            i_src2          =>rf0_rs2,
            
        o_uc_addr         => open       ,
        i_data            => x"00000000"          ,
                        
            
            o_rs1           =>de0_rs1,
            o_rs2           =>de0_rs2,
            o_imm           =>de0_imm,
            o_pc            =>de0_pc,
            
            o_rs1_fwsel     =>de0_rs1_fwsel,
            o_rs2_fwsel     =>de0_rs2_fwsel,
            
            o_cmp_op1sel    =>de0_cmp_op1sel,
            o_op1_sel       =>de0_op1_sel,
            o_op2_sel       =>de0_op2_sel,
                            
            o_br_en         =>de0_br_en,
            o_br_type       =>de0_br_type,
            --o_br_addr_sel   =>de0_br_addr_sel,
            
            o_alu_opsel     =>de0_alu_opsel,
            o_op_sign       =>de0_op_sign,
            o_exe_res_sel   =>de0_exe_res_sel,
            
            o_mem_store_type=>de0_mem_store_type,
            o_mem_load_type =>de0_mem_load_type,
            o_wb_en         =>de0_wb_en,
            o_wb_reg        =>de0_wb_reg,
            o_wb_data_sel   =>de0_wb_data_sel,
            o_mem_en        =>de0_mem_en,
            o_mem_we        =>de0_mem_we,
            --o_mem_addr   :=>
            o_mem_data      =>de0_mem_data,
            o_stall           =>de0_stall,

        o_csr_sel       => de0_csr_sel   ,
        o_csr_we        => de0_csr_we    ,
        o_csr_rd        => de0_csr_rd    ,
        o_csr_data      => de0_csr_data  ,
        o_csr_wr_addr      => de0_csr_wr_addr,
        o_csr_rd_addr      => de0_csr_rd_addr,
        o_csr_op        => de0_csr_op    ,
        i_csr_data        => csr0_csr_data    
      
            
    );



    csr0: entity work.csr_file  
    port map(
            i_clk       =>i_clk,
            i_rst       =>i_rst,
            
            i_rd_addr   =>de0_csr_rd_addr,
            i_wr_addr   =>de0_csr_wr_addr,
                        
            i_data      =>de0_csr_data,
            i_we        =>de0_csr_we,
            i_rd        =>de0_csr_rd,
                        
            i_op        =>de0_csr_op,
            o_data      =>csr0_csr_data
    );








EX0: entity work.execute  

    port map( 
            i_clk           => i_clk,
            i_rst           => i_rst,
            i_stall         =>ma0_stall,
            i_rs1           =>de0_rs1,
            i_rs2           =>de0_rs2,
            
            i_fw_ee         =>ex0_exe_res,
            i_fw_me         =>ma0_wb_data,
            i_fw_we         =>wb0_wb_data,
            
            i_imm           =>de0_imm,
            i_pc            =>de0_pc,
                             
            i_rs1_fwsel     =>de0_rs1_fwsel,
            i_rs2_fwsel     =>de0_rs2_fwsel,
            
            i_cmp_op1sel    =>de0_cmp_op1sel,
            i_op1_sel       =>de0_op1_sel,
            i_op2_sel       =>de0_op2_sel,
            i_signed_op     =>de0_op_sign,
                             
            i_alu_sel       =>de0_alu_opsel,
            i_res_sel       =>de0_exe_res_sel,
                             
            i_br_addr_sel   =>'0',
            i_br_type_sel   =>de0_br_type,
            i_br_en         =>de0_br_en,
                             
                             
            i_mem_wr_data   =>de0_mem_data,
            i_mem_we        =>de0_mem_we,
            i_mem_en        =>de0_mem_en,
                             
            i_load_type     =>de0_mem_load_type,
            i_store_type     =>de0_mem_store_type,
                             
            i_wb_data_sel   =>de0_wb_data_sel,
            i_wb_reg_sel    =>de0_wb_reg,
            i_wb_we         =>de0_wb_en,
                             
            o_exe_res       =>ex0_exe_res,
            o_br_addr       =>ex0_br_addr,
            o_br_en         =>ex0_br_en        ,
            o_mem_wr_data   =>ex0_mem_wr_data  ,
            o_mem_addr      =>ex0_mem_addr     ,
            o_mem_we        =>ex0_mem_we       ,
            o_mem_en        =>ex0_mem_en,
            o_wb_data_sel   =>ex0_wb_data_sel  ,
            o_wb_reg_sel    =>ex0_wb_reg_sel   ,
            o_wb_we         =>ex0_wb_we        ,
            o_load_type     =>ex0_load_type    ,
            o_store_type    =>ex0_store_type    
            
         );

MA0: entity work.memory_access 
  Port map ( 
            i_clk               =>i_clk,
            i_rst               =>i_rst,
                        
            i_exe_res           =>ex0_exe_res,
                                
            i_br_addr           =>ex0_br_addr,
            i_br_en             =>ex0_br_en,
                                
            i_mem_wr_data       =>ex0_mem_wr_data,
            i_mem_addr          =>ex0_mem_addr,
            
            i_mem_we            =>ex0_mem_we,
            i_mem_en            =>ex0_mem_en,
            i_mem_we_p            =>de0_mem_we,
            i_mem_en_p            =>de0_mem_en,
            
            i_wb_data_sel       =>ex0_wb_data_sel,
            i_wb_reg_sel        =>ex0_wb_reg_sel,
            i_wb_we             =>ex0_wb_we,
                                
            i_load_type         =>ex0_load_type,
            i_store_type        =>ex0_store_type,
                                
            o_data_mem_en       =>o_data_mem_en,
            o_data_mem_we       =>o_data_mem_we,
            o_data_mem_addr     =>o_data_mem_addr,
            o_data_mem_strobe   =>o_data_mem_strobe,
            i_data_mem_data     =>i_data_mem_data,
            i_data_mem_valid    =>i_data_mem_valid,
            o_data_mem_data     =>o_data_mem_data,
            o_stall             =>ma0_stall,                   
            o_br_addr           =>ma0_br_addr,
            o_br_en             =>ma0_br_en,
            o_wb_data           =>ma0_wb_data,
            o_wb_reg_sel        =>ma0_wb_reg_sel,
            o_wb_we             =>ma0_wb_we
            
            
  );




WB0: entity work.write_back 
  Port map (
            i_clk       =>i_clk,
            i_rst       =>i_rst,
            
            i_stall         =>ma0_stall,
            
            i_br_addr   =>ma0_br_addr,
            i_br_en     =>ma0_br_en,
                        
            i_wb_data   =>ma0_wb_data,
            i_wb_reg_sel=>ma0_wb_reg_sel,
            i_wb_we     =>ma0_wb_we,
                        
                        
            o_wb_data   =>wb0_wb_data,
            o_wb_reg_sel=>wb0_wb_reg_sel,
            o_wb_we     =>wb0_wb_we,
            o_br_addr   =>wb0_br_addr,
            o_br_en     =>wb0_branch_en
                        
   );



RF0: entity work.reg_file  
    port map(
            i_clk       =>i_clk,
            i_rst       =>i_rst,
                        
            i_rs1_addr  =>de0_rs1_addr,
            i_rs2_addr  =>de0_rs2_addr,
                        
            i_wb_data   =>ma0_wb_data,
            i_wb_addr   =>ma0_wb_reg_sel,
            i_we        =>ma0_wb_we,
                        
            o_rs1       =>rf0_rs1,
            o_rs2       =>rf0_rs2
    );



end Behavioral;
