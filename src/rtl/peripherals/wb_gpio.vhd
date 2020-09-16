library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use work.pkg_aukv.all;



entity wb_gpio is
    port(
            i_clk    : in std_logic;
            i_rst    : in std_logic;

            o_m_wb  : out t_in_wb_master;
            i_m_wb  : in t_out_wb_master;

            i_port_a: in std_logic_vector(31 downto 0);
            o_port_b: out std_logic_vector(31 downto 0)
            
    );

end wb_gpio;

architecture behave of wb_gpio is
type mem_type is array(7 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;
signal data : std_logic_vector(31 downto 0);
begin
  
    ri0:entity work.wb_reg_if 
        port map(
                i_clk    => i_clk,
                i_rst    => i_rst,
                o_m_wb   => o_m_wb,
                i_m_wb   => i_m_wb,
                i_reg0   =>i_port_a ,
                o_reg0   =>o_port_b
                
        );
end behave;