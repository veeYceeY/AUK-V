

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;





entity sciv_example_native is
    port(
        i_clk : in std_logic;
        i_rst : in std_logic;


        i_port_a: in std_logic_vector(31 downto 0);
        o_port_b: out std_logic_vector(2 downto 0)
    );

end sciv_example_native;

architecture beh of sciv_example_native is


signal sc0_en        : std_logic;
signal sc0_we        : std_logic;
signal sc0_addr      : std_logic_vector(31 downto 0);
signal sc0_data_out  : std_logic_vector(31 downto 0);
signal sc0_strobe    : std_logic_vector(3 downto 0);

signal sc0_code_mem_addr : std_logic_vector(31 downto 0);
signal sc0_code_mem_en : std_logic;
signal cm0_code_mem_data : std_logic_vector(31 downto 0);
signal cm0_code_mem_valid: std_logic;

signal mc0_data_in : std_logic_vector(31 downto 0);
signal mc0_valid: std_logic;

signal rm0_gpio_data : std_logic_vector(31 downto 0);
signal rm0_gpio_valid: std_logic;

signal io0_gpio_data : std_logic_vector(31 downto 0);
signal io0_gpio_valid: std_logic;



signal mc0_gpio_clk     : std_logic;
signal mc0_gpio_rst     : std_logic;
signal mc0_gpio_en      : std_logic;
signal mc0_gpio_we      : std_logic;
signal mc0_gpio_addr    : std_logic_vector(31 downto 0);
signal mc0_gpio_data    : std_logic_vector(31 downto 0);
signal mc0_gpio_strobe  : std_logic_vector(3 downto 0);

signal mc0_uart_clk     : std_logic;
signal mc0_uart_rst     : std_logic;
signal mc0_uart_en      : std_logic;
signal mc0_uart_we      : std_logic;
signal mc0_uart_addr    : std_logic_vector(31 downto 0);
signal mc0_uart_data    : std_logic_vector(31 downto 0);
signal mc0_uart_strobe  : std_logic_vector(3 downto 0);
signal mc0_uart_valid   : std_logic;
signal port_b    : std_logic_vector(31 downto 0);


signal mc0_ram_clk     : std_logic;
signal mc0_ram_rst     : std_logic;
signal mc0_ram_en      : std_logic;
signal mc0_ram_we      : std_logic;
signal mc0_ram_addr    : std_logic_vector(31 downto 0);
signal mc0_ram_data    : std_logic_vector(31 downto 0);
signal mc0_ram_strobe  : std_logic_vector(3 downto 0);
signal rm0_ram_valid   : std_logic;
signal rm0_ram_data    : std_logic_vector(31 downto 0);

begin

SC0:entity work.sciv_base_system_native 
Port map( 
          i_clk             =>i_clk,
          i_rst             =>i_rst,

          o_en     =>sc0_en    ,
          o_we     =>sc0_we    ,
          o_addr   =>sc0_addr  ,
          i_data   =>mc0_data_in  ,
          i_valid  =>mc0_valid ,
          o_data   =>sc0_data_out  ,
          o_strobe =>sc0_strobe
          
          
);

MC0:entity work.native_mem_interconnect
        generic map(
                MAX_LIMIT      =>4096
        )
        port map(
                i_clk           => i_clk,
                i_rst           => i_rst,

                i_en            => sc0_en    ,
                i_we            => sc0_we    ,
                i_addr          => sc0_addr  ,
                i_data          => sc0_data_out  ,
                i_strobe        => sc0_strobe ,
                o_valid         => mc0_valid  ,
                o_data          => mc0_data_in,

                o_port0_clk       => open,
                o_port0_rst       => open,

                o_port0_en        => open    ,
                o_port0_we        => open    ,
                o_port0_addr      => open  ,
                o_port0_data      => open  ,
                o_port0_strobe    => open,
                i_port0_valid     => '0' ,
                i_port0_data      => (others=>'0')  ,

                o_port1_en     => open    ,
                o_port1_we     => open    ,
                o_port1_addr   => open  ,
                o_port1_data   => open  ,
                o_port1_strobe => open,
                i_port1_valid  => '0' ,
                i_port1_data   => (others=>'0')  ,

                o_port2_en     => mc0_gpio_en    ,
                o_port2_we     => mc0_gpio_we    ,
                o_port2_addr   => mc0_gpio_addr  ,
                o_port2_data   => mc0_gpio_data  ,
                o_port2_strobe => mc0_gpio_strobe,
                i_port2_valid  => io0_gpio_valid ,
                i_port2_data   => rm0_gpio_data  ,

                o_port3_en     => mc0_ram_en    ,
                o_port3_we     => mc0_ram_we    ,
                o_port3_addr   => mc0_ram_addr  ,
                o_port3_data   => mc0_ram_data  ,
                o_port3_strobe => mc0_ram_strobe,
                i_port3_valid  => rm0_ram_valid ,
                i_port3_data   => rm0_ram_data  
        );
 
rm0: entity work.ram
port map(
        i_clk    => i_clk,
        i_rst    => i_rst,

        i_en     => mc0_ram_en    ,
        i_we     => mc0_ram_we    ,
        i_addr   => mc0_ram_addr  ,
        i_data   => mc0_ram_data  ,
        i_strobe => mc0_ram_strobe,
        o_valid  => rm0_ram_valid ,
        o_data   => rm0_ram_data  
);
   

IO0: entity work.gpio
        port map(
                i_clk    => i_clk,
                i_rst    => i_rst,
        
                i_en     => mc0_gpio_en    ,
                i_we     => mc0_gpio_we    ,
                i_addr   => mc0_gpio_addr  ,
                i_data   => mc0_gpio_data  ,
                i_strobe => mc0_gpio_strobe,
                o_valid  => io0_gpio_valid ,
                o_data   => io0_gpio_data  ,
                i_port_a => i_port_a,
                o_port_b => port_b
        );
            

o_port_b<=port_b(2 downto 0);



end beh;
