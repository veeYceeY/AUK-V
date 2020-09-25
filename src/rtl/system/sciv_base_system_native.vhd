

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;



entity sciv_base_system_native is
    port(
        i_clk : in std_logic;
        i_rst : in std_logic;

        o_clk    : out std_logic;
        o_rst    : out std_logic;
        o_en     : out std_logic;
        o_we     : out std_logic;
        o_addr   : out std_logic_vector(31 downto 0);
        o_data   : out std_logic_vector(31 downto 0);
        o_strobe : out std_logic_vector(3 downto 0);
        i_valid  : in std_logic;
        i_data   : in std_logic_vector(31 downto 0)
    );

end sciv_base_system_native;

architecture beh of sciv_base_system_native is




signal sc0_en        : std_logic;
signal sc0_we        : std_logic;
signal sc0_addr      : std_logic_vector(31 downto 0);
signal sc0_data_out  : std_logic_vector(31 downto 0);
signal sc0_strobe    : std_logic_vector(3 downto 0);

signal mc0_data_in   : std_logic_vector(31 downto 0);
signal mc0_valid     : std_logic;

signal sc0_code_mem_addr : std_logic_vector(31 downto 0);
signal sc0_code_mem_en : std_logic;
signal cm0_code_mem_data : std_logic_vector(31 downto 0);
signal cm0_code_mem_valid: std_logic;

signal mc0_ram_clk     : std_logic;
signal mc0_ram_rst     : std_logic;
signal mc0_ram_en      : std_logic;
signal mc0_ram_we      : std_logic;
signal mc0_ram_addr    : std_logic_vector(31 downto 0);
signal mc0_ram_data    : std_logic_vector(31 downto 0);
signal mc0_ram_strobe  : std_logic_vector(3 downto 0);
signal rm0_ram_valid   : std_logic;
signal rm0_ram_data    : std_logic_vector(31 downto 0);
signal code_address    : std_logic_vector(31 downto 0);


begin

SC0:entity work.sciv_core 
Port map( 
          i_clk             =>i_clk,
          i_rst             =>i_rst,

          o_data_mem_en     =>o_en    ,
          o_data_mem_we     =>o_we    ,
          o_data_mem_addr   =>o_addr  ,
          i_data_mem_data   =>i_data  ,
          i_data_mem_valid  =>i_valid ,
          o_data_mem_data   =>o_data  ,
          o_data_mem_strobe =>o_strobe,

          o_code_mem_en     =>sc0_code_mem_en    ,
          o_code_mem_addr   =>sc0_code_mem_addr  ,
          i_code_mem_data   =>cm0_code_mem_data  ,
          i_code_mem_valid  =>cm0_code_mem_valid 
          
          
);
code_address<= sc0_code_mem_addr-x"00010000" ;--when sc0_code_mem_addr>= x"0001000" else sc0_code_mem_addr;
CM0:entity work.code_mem
port map(
        i_clk             =>i_clk,
        i_rst             =>i_rst,

        i_en         =>sc0_code_mem_en,
        i_addr       =>code_address,
        o_data       =>cm0_code_mem_data,
        o_valid      =>cm0_code_mem_valid
);


--MC0:entity work.mem_interconnect
--        generic map(
--                MAX_LIMIT      =>4096
--        )
--        port map(
--                i_clk           => i_clk,
--                i_rst           => i_rst,
--
--                i_en            => sc0_en    ,
--                i_we            => sc0_we    ,
--                i_addr          => sc0_addr  ,
--                i_data          => sc0_data_out  ,
--                i_strobe        => sc0_strobe ,
--                o_valid         => mc0_valid  ,
--                o_data          => mc0_data_in,
--
--                o_port0_clk       => open,
--                o_port0_rst       => open,
--
--                o_port0_en        => mc0_ram_en    ,
--                o_port0_we        => mc0_ram_we    ,
--                o_port0_addr      => mc0_ram_addr  ,
--                o_port0_data      => mc0_ram_data  ,
--                o_port0_strobe    => mc0_ram_strobe,
--                i_port0_valid     => rm0_ram_valid ,
--                i_port0_data      => rm0_ram_data  ,
--
--                o_port1_clk    => open,
--                o_port1_rst    => open,
--
--
--                rm0: entity work.ram
--                port map(
--                        i_clk    => i_clk,
--                        i_rst    => i_rst,
--                
--                        i_en     => mc0_ram_en    ,
--                        i_we     => mc0_ram_we    ,
--                        i_addr   => mc0_ram_addr  ,
--                        i_data   => mc0_ram_data  ,
--                        i_strobe => mc0_ram_strobe,
--                        o_valid  => rm0_ram_valid ,
--                        o_data   => rm0_ram_data  
--                );
--                      o_port1_strobe => o_strobe,
--                i_port1_valid  => i_valid ,
--                i_port1_data   => i_data  
--        );
--
--rm0: entity work.ram
--        port map(
--                i_clk    => i_clk,
--                i_rst    => i_rst,
--        
--                i_en     => mc0_ram_en    ,
--                i_we     => mc0_ram_we    ,
--                i_addr   => mc0_ram_addr  ,
--                i_data   => mc0_ram_data  ,
--                i_strobe => mc0_ram_strobe,
--                o_valid  => rm0_ram_valid ,
--                o_data   => rm0_ram_data  
--        );
            
o_clk <= i_clk;
o_rst <= i_rst;




end beh;