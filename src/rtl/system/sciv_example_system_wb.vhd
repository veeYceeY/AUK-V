
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


use work.pkg_aukv.all;



entity sciv_example_system_wb is
    port(
        i_clk : in std_logic;
        i_rst : in std_logic;


        i_port_a: in std_logic_vector(31 downto 0);
        o_port_b: out std_logic_vector(2 downto 0)
    );

end sciv_example_system_wb;

architecture beh of sciv_example_system_wb is

  signal sc0_m_out_wb     : t_out_wb_master;
  signal axiic0_m_in_wb  : t_in_wb_master;

    signal gpio0_out_wb  : t_in_wb_master;
    signal ocr0_out_wb  : t_in_wb_master;
    signal ocm0_out_wb  : t_in_wb_master;
    signal s0_out_wb  : t_in_wb_master;
    signal s3_out_wb  : t_in_wb_master;
    signal s4_out_wb  : t_in_wb_master;
    signal axiic0_ocr0_out_wb     : t_out_wb_master;
    signal axiic0_ocm0_out_wb     : t_out_wb_master;
    signal axiic0_s0_out_wb     : t_out_wb_master;
    signal axiic0_s3_out_wb     : t_out_wb_master;
    signal axiic0_s4_out_wb     : t_out_wb_master;
    signal axiic0_gpio0_out_wb     : t_out_wb_master;
    signal gpio0_portb : std_logic_vector(31 downto 0);
    
begin


 SC0:entity work.sciv_core_wb
  port map(
      i_clk     =>i_clk,
      i_rst     =>i_rst,
      o_clk     =>open    ,
      o_rst     =>open    ,
      i_wb      =>axiic0_m_in_wb  ,
      o_wb      =>sc0_m_out_wb         
  
);

AXIIC0:entity work.wb_interconnect 
  port map(
          i_clk    => i_clk,
          i_rst    => i_rst,
          o_m_wb   => axiic0_m_in_wb,
          i_m_wb   => sc0_m_out_wb,
          i_s0_wb  => idle_in_wb_master,
          o_s0_wb  => axiic0_s0_out_wb,
          i_s1_wb  => ocr0_out_wb,
          o_s1_wb  => axiic0_ocr0_out_wb,
          i_s2_wb  => gpio0_out_wb,
          o_s2_wb  => axiic0_gpio0_out_wb,
          i_s3_wb  => idle_in_wb_master,
          o_s3_wb  => axiic0_s3_out_wb,
          i_s4_wb  => idle_in_wb_master,
          o_s4_wb  => axiic0_s4_out_wb,

          i_s5_wb  => ocm0_out_wb,
          o_s5_wb  => axiic0_ocm0_out_wb
  );



  OCM0:entity work.wb_oc_ram 
    port map(
            i_clk   => i_clk,
            i_rst   => i_rst,

            o_m_wb  => ocm0_out_wb,
            i_m_wb  => axiic0_ocm0_out_wb
    );


    OCR0:entity work.wb_oc_rom 
    port map(
            i_clk   => i_clk,
            i_rst   => i_rst,

            o_m_wb  => ocr0_out_wb,
            i_m_wb  => axiic0_ocr0_out_wb
    );



    GPIO0:entity work.wb_gpio 
    port map(
            i_clk   => i_clk,
            i_rst   => i_rst,

            o_m_wb  => gpio0_out_wb,
            i_m_wb  => axiic0_gpio0_out_wb,
            i_port_a  => i_port_a,
            o_port_b  => gpio0_portb
    );


o_port_b<=gpio0_portb(2 downto 0);



end beh;