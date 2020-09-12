

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;



entity sciv_base_system_axi is
    port(
        i_clk : in std_logic;
        i_rst : in std_logic;

        o_clk        : out std_logic;
        o_rst_n      : out std_logic;
                
        o_axi_araddr : out std_logic_vector(31 downto 0);
        o_axi_arvalid: out std_logic;
        i_axi_arready: in std_logic;
        i_axi_rdata  : in std_logic_vector(31 downto 0);
        i_axi_rvalid : in std_logic;
        o_axi_rready: out std_logic;
        i_axi_rresp  : in std_logic_vector(1 downto 0);
        o_axi_awaddr : out std_logic_vector(31 downto 0);
        o_axi_awvalid: out std_logic;
        i_axi_awready: in std_logic;
        o_axi_wdata  : out std_logic_vector(31 downto 0);
        i_axi_wvalid : in std_logic;
        o_axi_wstrb  : out std_logic_vector(7 downto 0);
        i_axi_wready : in std_logic;
        i_axi_bresp  : in std_logic_vector(1 downto 0);
        i_axi_bvalid : in std_logic;
        o_axi_bready : out std_logic
        
    );

end sciv_base_system_axi;

architecture beh of sciv_base_system_axi is




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


begin

SC0:entity work.sciv_core_axi 
Port map( 
          i_clk             =>i_clk,
          i_rst_n           =>i_rst,
          o_clk             => o_clk,
          o_rst             => o_rst_n,
          o_axi_araddr      =>o_axi_araddr ,
          o_axi_arvalid     =>o_axi_arvalid,
          i_axi_arready     =>i_axi_arready,
          i_axi_rdata       =>i_axi_rdata  ,
          i_axi_rvalid      =>i_axi_rvalid ,
          o_axi_rready      =>o_axi_rready ,
          i_axi_rresp       =>i_axi_rresp  ,
          o_axi_awaddr      =>o_axi_awaddr ,
          o_axi_awvalid     =>o_axi_awvalid,
          i_axi_awready     =>i_axi_awready,
          o_axi_wdata       =>o_axi_wdata  ,
          i_axi_wvalid      =>i_axi_wvalid ,
          o_axi_wstrb       =>o_axi_wstrb  ,
          i_axi_wready      =>i_axi_wready ,
          i_axi_bresp       =>i_axi_bresp  ,
          i_axi_bvalid      =>i_axi_bvalid ,
          o_axi_bready      =>o_axi_bready ,
          o_code_mem_en     =>sc0_code_mem_en    ,
          o_code_mem_addr   =>sc0_code_mem_addr  ,
          i_code_mem_data   =>cm0_code_mem_data  ,
          i_code_mem_valid  =>cm0_code_mem_valid 
          
          
);

CM0:entity work.code_mem
port map(
        i_clk    => i_clk,
        i_rst    => i_rst,
        
        i_en         =>sc0_code_mem_en,
        i_addr    =>sc0_code_mem_addr,
        o_data       =>cm0_code_mem_data,
        o_valid      =>cm0_code_mem_valid
);
            



end beh;