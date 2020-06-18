----------------------------------------------------------------------------------
-- Company: SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: 24.05.2020 13:16:11
-- Design Name: 
-- Module Name: memory_access - Behavioral
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

entity memory_access is
  Port ( 
            i_clk : std_logic;
            i_rst : std_logic;
            
            i_exe_res           : in std_logic_vector(31 downto 0);
            
            i_br_addr           : in std_logic_vector(31 downto 0);
            i_br_en             : in std_logic;
            
            i_mem_wr_data       : in std_logic_vector(31 downto 0);
            i_mem_addr          : in std_logic_vector(31 downto 0);
            i_mem_we            : in std_logic;
            i_mem_en            : in std_logic;
            i_wb_data_sel       : in std_logic;
            i_wb_reg_sel        : in std_logic_vector(4 downto 0);
            i_wb_we             : in std_logic;
            
            i_load_type         : in std_logic_vector(2 downto 0);
            i_store_type        : in std_logic_vector(1 downto 0);
            
            o_data_mem_en       : out std_logic;
            o_data_mem_we       : out std_logic;
            o_data_mem_data     : out std_logic_vector(31 downto 0);
            o_data_mem_addr     : out std_logic_vector(31 downto 0);
            o_data_mem_strobe   : out std_logic_vector(3 downto 0);
            i_data_mem_data     : in std_logic_vector(31 downto 0);
            i_data_mem_valid    : in std_logic;
            
            o_stall             : out std_logic;           
            o_br_addr           : out std_logic_vector(31 downto 0);
            o_br_en             : out std_logic;
                        
            o_wb_data           : out std_logic_vector(31 downto 0);
            o_wb_reg_sel        : out std_logic_vector(4 downto 0);
            o_wb_we             : out std_logic
            
            
  );
end memory_access;

architecture Behavioral of memory_access is


signal b_sign : std_logic_vector(7 downto 0);
signal h_sign : std_logic_vector(7 downto 0);

signal wb_data : std_logic_vector(31 downto 0);
signal mem_data_rd : std_logic_vector(31 downto 0);
signal mem_data_wr : std_logic_vector(31 downto 0);

signal mem_strobe_rd : std_logic_vector(3 downto 0);
signal mem_strobe_wr : std_logic_vector(3 downto 0);
signal mem_strobe    : std_logic_vector(3 downto 0);

signal mem_data_rd_sb : std_logic_vector(31 downto 0);
signal mem_data_rd_sh : std_logic_vector(31 downto 0);
signal mem_data_rd_sw : std_logic_vector(31 downto 0);

signal mem_data_wr_sb : std_logic_vector(31 downto 0);
signal mem_data_wr_sh : std_logic_vector(31 downto 0);
signal mem_data_wr_sw : std_logic_vector(31 downto 0);

signal mem_data_rd_ub : std_logic_vector(31 downto 0);
signal mem_data_rd_uh : std_logic_vector(31 downto 0);
signal stall : std_logic;
begin

b_sign <=   x"00" when i_data_mem_data(7) = '0' else
            x"ff";
h_sign <=   x"00" when i_data_mem_data(15) = '0' else
            x"ff";


mem_data_rd_sb <= b_sign & b_sign & b_sign & i_data_mem_data(7 downto 0);
mem_data_rd_sh <= b_sign & b_sign & i_data_mem_data(15 downto 0);
mem_data_rd_sw <= i_data_mem_data;

mem_data_rd_ub <= x"000000" & i_data_mem_data(7 downto 0);
mem_data_rd_uh <= x"0000" & i_data_mem_data(15 downto 0);

--mem_data_wr_sb <= i_mem_wr_data;

mem_data_rd <=  mem_data_rd_sb when i_load_type = x"0" else
                mem_data_rd_sh when i_load_type = x"1" else
                mem_data_rd_sw when i_load_type = x"2" else
                mem_data_rd_ub when i_load_type = x"3" else
                mem_data_rd_uh when i_load_type = x"4" else
                mem_data_rd_sw;
                
mem_data_wr <= i_mem_wr_data;
--mem_data_wr <=  mem_data_wr_sb when i_store_type = x"0" else
--                mem_data_wr_sh when i_store_type = x"1" else
--                mem_data_wr_sw when i_store_type = x"2" else
--                mem_data_wr_sw;
                
mem_strobe_wr <= "0001" when i_store_type = x"0" else
                 "0011" when i_store_type = x"1" else
                 "1111" when i_store_type = x"2" else
                 "0000";
                 
mem_strobe_rd <= "0001" when i_load_type = x"0" else
                 "0011" when i_load_type = x"1" else
                 "1111" when i_load_type = x"2" else
                 "0001" when i_load_type = x"3" else
                 "0011" when i_load_type = x"4" else
                 "0000";
                 
wb_data <= i_exe_res when i_wb_data_sel = '0' else mem_data_rd;
mem_strobe <= mem_strobe_rd when i_mem_we = '0' else mem_strobe_wr;

stall <= not i_data_mem_valid when i_mem_we = '1';

--o_data_mem_en     <= '0'            when i_rst = '1' else i_mem_en          when rising_edge(i_clk);
--o_data_mem_we     <= '0'            when i_rst = '1' else i_mem_we          when rising_edge(i_clk);
--o_data_mem_addr   <= (others =>'0') when i_rst = '1' else i_mem_addr        when rising_edge(i_clk);
--o_data_mem_strobe <= (others =>'0') when i_rst = '1' else mem_strobe        when rising_edge(i_clk);
--o_data_mem_data   <= (others =>'0') when i_rst = '1' else mem_data_wr       when rising_edge(i_clk);
--o_stall           <= '0'            when i_rst = '1' else i_data_mem_valid  when rising_edge(i_clk);
--o_br_addr         <= (others =>'0') when i_rst = '1' else i_br_addr         when rising_edge(i_clk);
--o_br_en           <= '0'            when i_rst = '1' else i_br_en           when rising_edge(i_clk);
--o_wb_data         <= (others =>'0') when i_rst = '1' else wb_data           when rising_edge(i_clk);
--o_wb_reg_sel      <= (others =>'0') when i_rst = '1' else i_wb_reg_sel      when rising_edge(i_clk);
--o_wb_we           <= '0'            when i_rst = '1' else i_wb_we           when rising_edge(i_clk);



process(i_clk,i_rst)
begin
    if i_rst = '1' then
    
        o_data_mem_en     <= '0'              ;
        o_data_mem_we     <= '0'              ;
        o_data_mem_addr   <= (others =>'0')   ;
        o_data_mem_strobe <= (others =>'0')   ;
        o_data_mem_data   <= (others =>'0')   ;
        o_stall           <= '0'              ;
        o_br_addr         <= (others =>'0')   ;
        o_br_en           <= '0'              ;
        o_wb_data         <= (others =>'0')   ;
        o_wb_reg_sel      <= (others =>'0')   ;
        o_wb_we           <= '0'              ;
        o_wb_we           <= '0'              ;
        
    elsif rising_edge(i_clk) then
    
        o_data_mem_en     <= i_mem_en          ;
        o_data_mem_we     <= i_mem_we          ;
        o_data_mem_addr   <= i_mem_addr        ;
        o_data_mem_strobe <= mem_strobe        ;
        o_data_mem_data   <= mem_data_wr       ;
        o_stall           <= i_data_mem_valid  ;
        o_br_addr         <= i_br_addr         ;
        o_br_en           <= i_br_en           ;
        o_wb_data         <= wb_data           ;
        o_wb_reg_sel      <= i_wb_reg_sel      ;
        o_wb_we           <= i_wb_we           ;
        o_wb_we           <= i_wb_we           ;
        
    end if;
end process;


end Behavioral;
