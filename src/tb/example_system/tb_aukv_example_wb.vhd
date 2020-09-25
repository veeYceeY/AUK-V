
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_aukv_example_wb is
--  Port ( );
end tb_aukv_example_wb;

architecture Behavioral of tb_aukv_example_wb is

type mem_type is array(63 downto 0) of std_logic_vector(31 downto 0);
signal clk             : std_logic;
signal rst             : std_logic;
signal data_mem_en     : std_logic;
signal data_mem_we     : std_logic;
signal data_mem_addr   : std_logic_vector(31 downto 0);
signal data_mem_data_in   : std_logic_vector(31 downto 0);
signal data_mem_valid  : std_logic;
signal data_mem_data_out   : std_logic_vector(31 downto 0);
signal data_mem_strobe : std_logic_vector(3 downto 0);
signal code_mem_en     : std_logic;
signal code_mem_addr   : std_logic_vector(31 downto 0);
signal code_mem_data   : std_logic_vector(31 downto 0);
signal code_mem_valid  : std_logic;

signal sc0_porta   : std_logic_vector(31 downto 0);
signal sc0_portb   : std_logic_vector(2 downto 0);

signal code_mem : mem_type;
signal data_mem : mem_type;
begin







--SC0:entity work.sciv_core 
--  Port map( 
--            i_clk             =>clk,
--            i_rst             =>rst,
--            o_data_mem_en     =>data_mem_en    ,
--            o_data_mem_we     =>data_mem_we    ,
--            o_data_mem_addr   =>data_mem_addr  ,
--            i_data_mem_data   =>data_mem_data_in  ,
--            i_data_mem_valid  =>data_mem_valid ,
--            o_data_mem_data   =>data_mem_data_out  ,
--            o_data_mem_strobe =>data_mem_strobe,
--            o_code_mem_en     =>code_mem_en    ,
--            o_code_mem_addr   =>code_mem_addr  ,
--            i_code_mem_data   =>code_mem_data  ,
--            i_code_mem_valid  =>code_mem_valid 
            
            
--  );


SC0:entity work.sciv_example_wb 
  Port map( 
            i_clk        =>clk,
            i_rst        =>rst,
            i_port_a     =>sc0_porta,
            o_port_b     =>sc0_portb    
            
  );

process
begin
    clk<='0';
    wait for 5 ns;
    clk<='1';
    wait for 5 ns;
    
end process;

--instruction samples
--
--      LUI     Rd,Immediate
--      AUIPC   Rd,O00set
--      JAL     Rd,O00set
--      JALR    Rd,Rs1,O00set
--      BEQ     Rs1,Rs2,O00set
--      LB      Rd,O00fset(Rs1)
--      SB      Rs2,O00set(Rs1)
--      ADDI    Rd,Rs1,Immediate
--      ADD     Rd,Rs1,Rs2
--      
--      
--      
--      
--      
--   

process
begin
    rst<= '1';
    wait for 100 ns;
    rst<='0';
    wait for 50000000 ns;
    std.env.finish;
end process;



end Behavioral;
