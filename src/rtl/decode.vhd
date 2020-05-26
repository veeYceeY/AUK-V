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


library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity decode is
    port (
            i_clk           : in std_logic;
            i_rst           : in std_logic;
            
            i_instr         : in std_logic_vector(31 downto 0);
            i_pc            : in std_logic_vector(31 downto 0);
            
            --o_uc_addr      : out std_logic_vector(7 downto 0);
            --i_data      : in std_logic_vector(31 downto 0);
            
            --i_stall     : in std_logic;
            --i_br_en     : in std_logic;
            --i_br_addr   : in std_logic_vector(31 downto 0);
            
            o_src1_addr     : out std_logic_vector(4 downto 0);
            o_src2_addr     : out std_logic_vector(4 downto 0);
            i_src1          : in std_logic_vector(31 downto 0);
            i_src2          : in std_logic_vector(31 downto 0);
            
            
            o_rs1           : out std_logic_vector(31 downto 0);
            o_rs2           : out std_logic_vector(31 downto 0);
            o_imm           : out std_logic_vector(31 downto 0);
            o_pc            : out std_logic_vector(31 downto 0);
            
            o_op1_sel       : out std_logic_vector(1 downto 0);
            o_op2_sel       : out std_logic_vector(1 downto 0);
            
            o_br_en         : out std_logic;
            o_br_type       : out std_logic_vector(2 downto 0);
            o_br_addr_sel   : out std_logic;

            o_alu_opsel     : out std_logic_vector(3 downto 0);
            o_op_sign       : out std_logic;
            o_exe_res_sel   : out std_logic_vector(1 downto 0);

            o_mem_store_type: out std_logic_vector(1 downto 0);
            o_mem_load_type : out std_logic_vector(2 downto 0);
            o_wb_en         : out std_logic;
            o_wb_reg        : out std_logic_vector(4 downto 0);
            o_wb_data_sel   : out std_logic;
            o_mem_en        : out std_logic;
            o_mem_we        : out std_logic;
            --o_mem_addr   : out std_logic_vector(31 downto 0);
            o_mem_data      : out std_logic_vector(31 downto 0)
            
            
            
    );

end entity;


architecture behave of decode is 

signal uc_addr : std_logic_vector(7 downto 0);
signal data : std_logic_vector(31 downto 0);

begin

DU0: entity work.decode_uc
    port map(
            i_clk             => i_clk           ,
            i_rst             => i_rst           , 
                                
            i_instr           => i_instr         ,
            i_pc              => i_pc            ,
                                
            o_uc_addr         => uc_addr       ,
            i_data            => data          ,
                                
            --i_stall         => --i_stall       ,
            --i_br_en         => --i_br_en       ,
            --i_br_addr       => --i_br_addr     ,
                                
            o_src1_addr       => o_src1_addr     ,
            o_src2_addr       => o_src2_addr     ,
            i_src1            => i_src1          ,
            i_src2            => i_src2          ,
                                
                               
            o_rs1             => o_rs1           ,
            o_rs2             => o_rs2           ,
            o_imm             => o_imm           ,
            o_pc              => o_pc            ,
                                
            o_op1_sel         => o_op1_sel       ,
            o_op2_sel         => o_op2_sel       ,
                                
            o_br_en           => o_br_en         ,
            o_br_type         => o_br_type       ,
            o_br_addr_sel     => o_br_addr_sel   ,
                                
            o_alu_opsel       => o_alu_opsel     ,
            o_op_sign         => o_op_sign       ,                    
            o_exe_res_sel     => o_exe_res_sel   ,
                                
            o_mem_store_type  => o_mem_store_type    ,
            o_mem_load_type   => o_mem_load_type ,
            o_wb_en           => o_wb_en         ,
            o_wb_reg          => o_wb_reg        ,
            o_wb_data_sel     => o_wb_data_sel    ,
            o_mem_en          => o_mem_en        ,
            o_mem_we          => o_mem_we        ,
            --o_mem_addr      => --o_mem_addr    ,
            o_mem_data        => o_mem_data      
           
            
            
    );
MC0: entity work.microcode_mem  
  Port map (
        i_addr => uc_addr,
        o_code => data
        );



end behave;