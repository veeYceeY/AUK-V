----------------------------------------------------------------------------------
-- Company: SCiMOS
-- Engineer: veeYceY
-- 
-- Create Date: 24.05.2020 16:09:52
-- Design Name: 
-- Module Name: write_back - Behavioral
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

entity write_back is
  Port (
            i_clk       : in std_logic;
            i_rst       : in std_logic;
            
            i_br_addr   : in std_logic_vector(31 downto 0);
            i_br_en     : in std_logic;
                
            i_wb_data   : in std_logic_vector(31 downto 0);
            i_wb_reg_sel: in std_logic_vector(4 downto 0);
            i_wb_we     : in std_logic;
            
                        
            o_wb_data   : out std_logic_vector(31 downto 0);
            o_wb_reg_sel: out std_logic_vector(4 downto 0);
            o_wb_we     : out std_logic;
    
            o_br_addr   : out std_logic_vector(31 downto 0);
            o_br_en     : out std_logic
                        
   );
end write_back;

architecture Behavioral of write_back is

begin

--o_wb_data    <= (others =>'0')  when i_rst = '1' else i_wb_data    when rising_edge(i_clk);
--o_wb_reg_sel <= (others =>'0')  when i_rst = '1' else i_wb_reg_sel when rising_edge(i_clk);
--o_wb_we      <= '0'             when i_rst = '1' else i_wb_we      when rising_edge(i_clk); 
--o_br_addr    <= (others =>'0')  when i_rst = '1' else i_br_addr    when rising_edge(i_clk);
--o_br_en      <= '0'             when i_rst = '1' else i_br_en      when rising_edge(i_clk);


process(i_clk,i_rst)
begin
    if i_rst = '1' then
    
        o_wb_data    <= (others =>'0')   ;
        o_wb_reg_sel <= (others =>'0')   ;
        o_wb_we      <= '0'              ;
        o_br_addr    <= (others =>'0')   ;
        o_br_en      <= '0'              ;
        
    elsif rising_edge(i_clk) then
    
        o_wb_data    <= i_wb_data      ;
        o_wb_reg_sel <= i_wb_reg_sel   ;
        o_wb_we      <= i_wb_we        ;
        o_br_addr    <= i_br_addr      ;
        o_br_en      <= i_br_en        ;
        
    end if;
end process;





end Behavioral;

