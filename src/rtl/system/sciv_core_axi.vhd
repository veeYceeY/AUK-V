

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;



entity sciv_core_axi is
    port(
        i_clk : in std_logic;
        i_rst_n : in std_logic;

        o_clk    : out std_logic;
        o_rst    : out std_logic;
        
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
        o_axi_bready : out std_logic;
        
        
        o_code_mem_en     : out std_logic;
        o_code_mem_addr   : out std_logic_vector(31 downto 0);
        i_code_mem_data   : in std_logic_vector(31 downto 0);
        i_code_mem_valid  : in std_logic
    );

end sciv_core_axi;

architecture beh of sciv_core_axi is

signal rst_p        : std_logic;
signal sc0_en        : std_logic;
signal sc0_we        : std_logic;
signal sc0_addr      : std_logic_vector(31 downto 0);
signal sc0_data      : std_logic_vector(31 downto 0);
signal sc0_strobe    : std_logic_vector(3 downto 0);
signal axm0_data     : std_logic_vector(31 downto 0); 
signal axm0_valid     : std_logic; 
begin


AXM0: entity work.m_axilite 
    port map (
            i_aclk         => i_clk,
            i_arst_n       => i_rst_n,
            i_en           => sc0_en    ,
            i_we           => sc0_we    ,
            i_raddr        => sc0_addr  ,
            i_waddr        => sc0_addr  ,
            i_data         => sc0_data,
            i_strobe       => sc0_strobe ,
            o_valid        => axm0_valid  ,
            o_data         => axm0_data  ,
            o_axi_araddr   => o_axi_araddr ,
            o_axi_arvalid  => o_axi_arvalid,
            i_axi_arready  => i_axi_arready,
            i_axi_rdata    => i_axi_rdata  ,
            i_axi_rvalid   => i_axi_rvalid ,
            o_axi_rready   => o_axi_rready ,
            i_axi_rresp    => i_axi_rresp  ,
            o_axi_awaddr   => o_axi_awaddr ,
            o_axi_awvalid  => o_axi_awvalid,
            i_axi_awready  => i_axi_awready,
            o_axi_wdata    => o_axi_wdata  ,
            i_axi_wvalid   => i_axi_wvalid ,
            o_axi_wstrb    => o_axi_wstrb  ,
            i_axi_wready   => i_axi_wready ,
            i_axi_bresp    => i_axi_bresp  ,
            i_axi_bvalid   => i_axi_bvalid ,
            o_axi_bready   => o_axi_bready 
            
    );



--AXM1: entity work.m_axilite 
--    port map (
--            i_aclk         => i_clk,
--            i_arst_n       => i_rst_n,
--            i_en           => sc0_en    ,
--            i_we           => sc0_we    ,
--            i_raddr        => sc0_addr  ,
--            i_waddr        => sc0_addr  ,
--            i_data         => sc0_data,
--            i_strobe       => sc0_strobe ,
--            o_valid        => axm0_valid  ,
--            o_data         => axm0_data  ,
--            o_axi_araddr   => o_axi_araddr ,
--            o_axi_arvalid  => o_axi_arvalid,
--            i_axi_arready  => i_axi_arready,
--            i_axi_rdata    => i_axi_rdata  ,
--            i_axi_rvalid   => i_axi_rvalid ,
--            i_axi_rresp    => i_axi_rresp  ,
--            o_axi_awaddr   => o_axi_awaddr ,
--            o_axi_awvalid  => o_axi_awvalid,
--            i_axi_awready  => i_axi_awready,
--            o_axi_wdata    => o_axi_wdata  ,
--            i_axi_wvalid   => i_axi_wvalid ,
--            o_axi_wstrb    => o_axi_wstrb  ,
--            i_axi_wready   => i_axi_wready ,
--            i_axi_bresp    => i_axi_bresp  ,
--            i_axi_bvalid   => i_axi_bvalid ,
--            o_axi_bready   => o_axi_bready 
            
--    );




rst_p <= not i_rst_n;



SC0:entity work.sciv_core 
Port map( 
          i_clk             =>i_clk,
          i_rst             =>rst_p,

          o_data_mem_en     =>sc0_en    ,
          o_data_mem_we     =>sc0_we    ,
          o_data_mem_addr   =>sc0_addr  ,
          i_data_mem_data   =>axm0_data  ,
          i_data_mem_valid  =>axm0_valid ,
          o_data_mem_data   =>sc0_data  ,
          o_data_mem_strobe =>sc0_strobe,

          o_code_mem_en     =>o_code_mem_en    ,
          o_code_mem_addr   =>o_code_mem_addr  ,
          i_code_mem_data   =>i_code_mem_data  ,
          i_code_mem_valid  =>i_code_mem_valid 
          
          
);


            
o_clk <= i_clk;
o_rst <= i_rst_n;




end beh;