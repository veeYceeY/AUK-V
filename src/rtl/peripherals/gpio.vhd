library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity gpio is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            i_en     : in std_logic;
            i_we     : in std_logic;
            i_addr   : in std_logic_vector(31 downto 0);
            i_data   : in std_logic_vector(31 downto 0);
            i_strobe : in std_logic_vector(3 downto 0);
            o_valid  : out std_logic;
            o_data   : out std_logic_vector(31 downto 0);

            i_port_a: in std_logic_vector(31 downto 0);
            o_port_b: out std_logic_vector(31 downto 0)
            
    );

end gpio;

architecture behave of gpio is
type mem_type is array(7 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
signal data : std_logic_vector(31 downto 0);
begin
  
    ri0:entity work.reg_if 
        port map(
                i_clk    => i_clk,
                i_rst    => i_rst,
    
                i_en     => i_en     ,
                i_we     => i_we     ,
                i_addr   => i_addr   ,
                i_data   => i_data   ,
                i_strobe => i_strobe ,
                o_valid  => o_valid  ,
                o_data   => o_data   ,
    
                i_reg0   =>i_port_a  ,
                o_reg0   =>o_port_b
                
        );
end behave;