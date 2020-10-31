

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

use work.pkg_aukv.all;


entity sciv_core_wb is
    port(
        i_clk : in std_logic;
        i_rst : in std_logic;

        o_clk    : out std_logic;
        o_rst    : out std_logic;
        
        i_irq : in std_logic;
        o_ack    : out std_logic;

        i_wb  : in t_in_wb_master;
        o_wb  : out t_out_wb_master
    );

end sciv_core_wb;

architecture beh of sciv_core_wb is

signal rst_p        : std_logic;
signal sc0_en        : std_logic;
signal sc0_we        : std_logic;
signal sc0_addr      : std_logic_vector(31 downto 0);
signal sc0_data      : std_logic_vector(31 downto 0);
signal sc0_strobe    : std_logic_vector(3 downto 0);

signal sc0_c_en        : std_logic;
signal sc0_c_addr      : std_logic_vector(31 downto 0);

signal wbdm0_data     : std_logic_vector(31 downto 0); 
signal wbdm0_valid     : std_logic; 
signal wbdm1_data     : std_logic_vector(31 downto 0); 
signal wbdm1_valid     : std_logic; 
signal wbdm0_o_wb     : t_out_wb_master;
signal wbdm1_o_wb     : t_out_wb_master;
signal wbar0_m1_o_wb    : t_in_wb_master;
signal wbar0_m0_o_wb    : t_in_wb_master;

signal ch0_req        : std_logic;
signal ch0_addr      : std_logic_vector(31 downto 0);
signal ch0_data     : std_logic_vector(31 downto 0); 
signal ch0_ack     : std_logic; 
begin

    SC0:entity work.sciv_core 
    Port map( 
              i_clk             =>i_clk,
              i_rst             =>i_rst,
    
              i_irq             =>i_irq,
              o_ack             =>o_ack,
              
              o_data_mem_en     =>sc0_en    ,
              o_data_mem_we     =>sc0_we    ,
              o_data_mem_addr   =>sc0_addr  ,
              i_data_mem_data   =>wbdm1_data  ,
              i_data_mem_valid  =>wbdm1_valid ,
              o_data_mem_data   =>sc0_data  ,
              o_data_mem_strobe =>sc0_strobe,
    
              o_code_mem_en     =>sc0_c_en    ,
              o_code_mem_addr   =>sc0_c_addr  ,
              i_code_mem_data   =>ch0_data  ,
              i_code_mem_valid  =>ch0_ack 
              
              
    );
    CH0: entity work.cache
    port map(
            i_clk => i_clk,
            i_rst => i_rst,
            i_req => sc0_c_en,
            i_addr=> sc0_c_addr,
            o_data=> ch0_data,
            o_ack => ch0_ack,
            o_req => ch0_req,
            o_addr=> ch0_addr,
            i_data=> wbdm0_data,
            i_ack => wbdm0_valid
            
    );
    

    WBDM0: entity work.wb_master 
    port map (
            i_clk         => i_clk,
            i_rst         => i_rst,
            i_en           => ch0_req    ,
            i_we           => '0'    ,
            i_addr         => ch0_addr  ,
            i_data         => x"00000000",
            i_strobe       => "1111" ,
            o_valid        => wbdm0_valid  ,
            o_data         => wbdm0_data  ,
            o_wb           => wbdm0_o_wb,
            i_wb           => wbar0_m0_o_wb
            
    );

    WBDM1: entity work.wb_master 
    port map (
            i_clk         => i_clk,
            i_rst       => i_rst,
            i_en           => sc0_en    ,
            i_we           => sc0_we    ,
            i_addr         => sc0_addr  ,
            i_data         => sc0_data,
            i_strobe       => sc0_strobe,
            o_valid        => wbdm1_valid,
            o_data         => wbdm1_data,
            o_wb           => wbdm1_o_wb,
            i_wb           => wbar0_m1_o_wb
            
    );

    WBAR0: entity work.wb_arbiter 
        port map(
                i_clk    =>i_clk,
                i_rst    =>i_rst,
                o_m0_wb  =>wbar0_m0_o_wb,
                i_m0_wb  =>wbdm0_o_wb,
                o_m1_wb  =>wbar0_m1_o_wb,
                i_m1_wb  =>wbdm1_o_wb,
                i_s_wb   =>i_wb ,
                o_s_wb   =>o_wb 
        );  

            
o_clk <= i_clk;
o_rst <= i_rst;




end beh;