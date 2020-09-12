



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;





entity sciv_example_system_axi is
    port(
        i_clk : in std_logic;
        i_rst_n : in std_logic;


        i_port_a: in std_logic_vector(31 downto 0);
        o_port_b: out std_logic_vector(2 downto 0)
    );

end sciv_example_system_axi;

architecture beh of sciv_example_system_axi is
 
signal m_axi_araddr :  std_logic_vector(31 downto 0);
signal m_axi_arvalid:  std_logic_vector(0 downto 0);
signal m_axi_arready: std_logic_vector(0 downto 0);
signal m_axi_rdata  : std_logic_vector(31 downto 0);
signal m_axi_rvalid : std_logic_vector(0 downto 0);
signal m_axi_rready:  std_logic_vector(0 downto 0);
signal m_axi_rresp  : std_logic_vector(1 downto 0);
signal m_axi_awaddr :  std_logic_vector(31 downto 0);
signal m_axi_awvalid:  std_logic_vector(0 downto 0);
signal m_axi_awready: std_logic_vector(0 downto 0);
signal m_axi_wdata  :  std_logic_vector(31 downto 0);
signal m_axi_wvalid : std_logic_vector(0 downto 0);
signal m_axi_wstrb  :  std_logic_vector(7 downto 0);
signal m_axi_wready : std_logic_vector(0 downto 0);
signal m_axi_bresp  : std_logic_vector(1 downto 0);
signal m_axi_bvalid : std_logic_vector(0 downto 0);
signal m_axi_bready :  std_logic_vector(0 downto 0);
        
signal port_b    : std_logic_vector(31 downto 0);
COMPONENT axi_crossbar_0
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axi_awaddr  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axi_awprot  : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_awready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_wdata   : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axi_wstrb   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axi_wvalid  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_wready  : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bresp   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_bvalid  : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bready  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_araddr  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axi_arprot  : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_arready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rdata   : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    s_axi_rresp   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_rvalid  : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rready  : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_awvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_awready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_wvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_wready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_bready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_araddr : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    m_axi_arvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_arready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_rready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END COMPONENT;
COMPONENT axi_gpio_0
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr  : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata :   IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb :   IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid :  IN STD_LOGIC;
    s_axi_wready :  OUT STD_LOGIC;
    s_axi_bresp :   OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid :  OUT STD_LOGIC;
    s_axi_bready :  IN STD_LOGIC;
    s_axi_araddr :  IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata :   OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp :   OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid :  OUT STD_LOGIC;
    s_axi_rready :  IN STD_LOGIC;
    gpio_io_o :     OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

signal  s_axi_awaddr  : STD_LOGIC_VECTOR(63 DOWNTO 0);  
signal  s_axi_awprot  : STD_LOGIC_VECTOR(5 DOWNTO 0);   
signal  s_axi_awvalid : STD_LOGIC_VECTOR(1 DOWNTO 0);   
signal  s_axi_awready :  STD_LOGIC_VECTOR(1 DOWNTO 0);  
signal  s_axi_wdata   : STD_LOGIC_VECTOR(63 DOWNTO 0);  
signal  s_axi_wstrb   : STD_LOGIC_VECTOR(7 DOWNTO 0);   
signal  s_axi_wvalid  : STD_LOGIC_VECTOR(1 DOWNTO 0);   
signal  s_axi_wready  :  STD_LOGIC_VECTOR(1 DOWNTO 0);  
signal  s_axi_bresp   :  STD_LOGIC_VECTOR(3 DOWNTO 0);  
signal  s_axi_bvalid  :  STD_LOGIC_VECTOR(1 DOWNTO 0);  
signal  s_axi_bready  : STD_LOGIC_VECTOR(1 DOWNTO 0);   
signal  s_axi_araddr  : STD_LOGIC_VECTOR(63 DOWNTO 0);  
signal  s_axi_arprot  : STD_LOGIC_VECTOR(5 DOWNTO 0);   
signal  s_axi_arvalid : STD_LOGIC_VECTOR(1 DOWNTO 0);   
signal  s_axi_arready :  STD_LOGIC_VECTOR(1 DOWNTO 0);  
signal  s_axi_rdata   :  STD_LOGIC_VECTOR(63 DOWNTO 0); 
signal  s_axi_rresp   :  STD_LOGIC_VECTOR(3 DOWNTO 0);  
signal s_axi_rvalid  :  STD_LOGIC_VECTOR(1 DOWNTO 0);  
signal s_axi_rready  : STD_LOGIC_VECTOR(1 DOWNTO 0);   









signal  gpio_io_o :     STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT axi_bram_ctrl_0
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    bram_rst_a : OUT STD_LOGIC;
    bram_clk_a : OUT STD_LOGIC;
    bram_en_a : OUT STD_LOGIC;
    bram_we_a : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    bram_addr_a : OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
    bram_wrdata_a : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    bram_rddata_a : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
COMPONENT blk_mem_gen_0
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;
  signal  bram_rst_a :    STD_LOGIC;
  signal  bram_clk_a :    STD_LOGIC;
  signal  bram_en_a :     STD_LOGIC;
  signal  bram_we_a :     STD_LOGIC_VECTOR(3 DOWNTO 0);
  signal  bram_addr_a :   STD_LOGIC_VECTOR(14 DOWNTO 0);
  signal  bram_wrdata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
  signal  bram_rddata_a : STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT blk_mem_gen_1
  PORT (
    rsta_busy : OUT STD_LOGIC;
    rstb_busy : OUT STD_LOGIC;
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC
  );
END COMPONENT;


begin
GPIO0 : axi_gpio_0
  PORT MAP (
    s_axi_aclk => i_clk,
    s_axi_aresetn => i_rst_n,
    s_axi_awaddr => s_axi_awaddr(8 downto 0),
    s_axi_awvalid => s_axi_awvalid(0),
    s_axi_awready => s_axi_awready(0),
    s_axi_wdata => s_axi_wdata(31 downto 0),
    s_axi_wstrb => s_axi_wstrb(3 downto 0),
    s_axi_wvalid => s_axi_wvalid(0),
    s_axi_wready => s_axi_wready(0),
    s_axi_bresp => s_axi_bresp(1 downto 0),
    s_axi_bvalid => s_axi_bvalid(0),
    s_axi_bready => s_axi_bready(0),
    s_axi_araddr => s_axi_araddr(8 downto 0),
    s_axi_arvalid => s_axi_arvalid(0),
    s_axi_arready => s_axi_arready(0),
    s_axi_rdata => s_axi_rdata(31 downto 0),
    s_axi_rresp => s_axi_rresp(1 downto 0),
    s_axi_rvalid => s_axi_rvalid(0),
    s_axi_rready => s_axi_rready(0),
    gpio_io_o => gpio_io_o
  );

--BRAM0 : axi_bram_ctrl_0
--  PORT MAP (
--    s_axi_aclk => i_clk,
--    s_axi_aresetn => i_rst_n,
--    s_axi_awaddr => s_axi_awaddr(46 downto 32),
--    s_axi_awprot => "000",
--    s_axi_awvalid => s_axi_awvalid(1),
--    s_axi_awready => s_axi_awready(1),
--    s_axi_wdata => s_axi_wdata(63 downto 32),
--    s_axi_wstrb => s_axi_wstrb(7 downto 4),
--    s_axi_wvalid => s_axi_wvalid(1),
--    s_axi_wready => s_axi_wready(1),
--    s_axi_bresp => s_axi_bresp(3 downto 2),
--    s_axi_bvalid => s_axi_bvalid(1),
--    s_axi_bready => s_axi_bready(1),
--    s_axi_araddr => s_axi_araddr(46 downto 32),
--    s_axi_arprot => "000",
--    s_axi_arvalid => s_axi_arvalid(1),
--    s_axi_arready => s_axi_arready(1),
--    s_axi_rdata => s_axi_rdata(63 downto 32),
--    s_axi_rresp => s_axi_rresp(3 downto 2),
--    s_axi_rvalid => s_axi_rvalid(1),
--    s_axi_rready => s_axi_rready(1),
    
--    bram_rst_a => open,
--    bram_clk_a => bram_clk_a,
--    bram_en_a => bram_en_a,
--    bram_we_a => bram_we_a,
--    bram_addr_a => bram_addr_a,
--    bram_wrdata_a => bram_wrdata_a,
--    bram_rddata_a => bram_rddata_a
--  );
  
 BRM0 : blk_mem_gen_1
  PORT MAP (
    rsta_busy => open,
    rstb_busy => open,
    s_aclk => i_clk,
    s_aresetn => i_rst_n,
    s_axi_awaddr => s_axi_awaddr(63 downto 42),
    s_axi_awvalid => s_axi_awvalid(1),
    s_axi_awready => s_axi_awready(1),
    s_axi_wdata => s_axi_wdata(63 downto 42),
    s_axi_wstrb => s_axi_wstrb(7 downto 4),
    s_axi_wvalid => s_axi_wvalid(1),
    s_axi_wready => s_axi_wready(1),
    s_axi_bresp => s_axi_bresp(3 downto 2),
    s_axi_bvalid => s_axi_bvalid(1),
    s_axi_bready => s_axi_bready(1),
    s_axi_araddr => s_axi_araddr(63 downto 42),
    s_axi_arvalid => s_axi_arvalid(1),
    s_axi_arready => s_axi_arready(1),
    s_axi_rdata => s_axi_rdata(63 downto 42),
    s_axi_rresp => s_axi_rresp(3 downto 2),
    s_axi_rvalid => s_axi_rvalid(1),
    s_axi_rready => s_axi_rready(1)
  );
  
  
  
--BR0 : blk_mem_gen_0
--  PORT MAP (
--    clka => bram_clk_a,
--    ena => bram_en_a,
--    wea => bram_we_a,
--    addra => bram_addr_a,
--    dina => bram_wrdata_a,
--    douta => bram_rddata_a
--  );
XBAR0 : axi_crossbar_0
  PORT MAP (
    aclk => i_clk,
    aresetn => i_rst_n,
    s_axi_awaddr => s_axi_awaddr,
    s_axi_awprot => "00000",
    s_axi_awvalid => s_axi_awvalid,
    s_axi_awready => s_axi_awready,
    s_axi_wdata => s_axi_wdata,
    s_axi_wstrb => s_axi_wstrb,
    s_axi_wvalid => s_axi_wvalid,
    s_axi_wready => s_axi_wready,
    s_axi_bresp => s_axi_bresp,
    s_axi_bvalid => s_axi_bvalid,
    s_axi_bready => s_axi_bready,
    s_axi_araddr => s_axi_araddr,
    s_axi_arprot => "00000",
    s_axi_arvalid => s_axi_arvalid,
    s_axi_arready => s_axi_arready,
    s_axi_rdata => s_axi_rdata,
    s_axi_rresp => s_axi_rresp,
    s_axi_rvalid => s_axi_rvalid,
    s_axi_rready => s_axi_rready,
    m_axi_awaddr   => m_axi_awaddr,
    m_axi_awprot   => open,
    m_axi_awvalid  => m_axi_awvalid,
    m_axi_awready  => m_axi_awready,
    m_axi_wdata    => m_axi_wdata,
    m_axi_wstrb    => m_axi_wstrb,
    m_axi_wvalid   => m_axi_wvalid,
    m_axi_wready   => m_axi_wready,
    m_axi_bresp    => m_axi_bresp,
    m_axi_bvalid   => m_axi_bvalid,
    m_axi_bready   => m_axi_bready,
    m_axi_araddr   => m_axi_araddr,
    m_axi_arprot   => open,
    m_axi_arvalid  => m_axi_arvalid,
    m_axi_arready  => m_axi_arready,
    m_axi_rdata    => m_axi_rdata,
    m_axi_rresp    => m_axi_rresp,
    m_axi_rvalid   => m_axi_rvalid,
    m_axi_rready   => m_axi_rready
  );
SC0:entity work.sciv_base_system_axi 
Port map( 
          i_clk             =>i_clk,
          i_rst             =>i_rst_n,
          o_clk           =>open,
          o_rst_n         =>open,
          o_axi_araddr    =>m_axi_araddr, 
          o_axi_arvalid   =>m_axi_arvalid(0),
          i_axi_arready   =>m_axi_arready(0), 
          i_axi_rdata     =>m_axi_rdata, 
          i_axi_rvalid    =>m_axi_rvalid(0), 
          i_axi_rresp     =>m_axi_rresp,
          o_axi_awaddr    =>m_axi_awaddr,
          o_axi_awvalid   =>m_axi_awvalid(0),
          i_axi_awready   =>m_axi_awready(0),
          o_axi_wdata     =>m_axi_wdata, 
          i_axi_wvalid    =>m_axi_wvalid(0), 
          o_axi_rready    =>m_axi_rready(0), 
          o_axi_wstrb     =>m_axi_wstrb, 
          i_axi_wready    =>m_axi_wready(0), 
          i_axi_bresp     =>m_axi_bresp, 
          i_axi_bvalid    =>m_axi_bvalid(0), 
          o_axi_bready    =>m_axi_bready(0)   
);







o_port_b<=gpio_io_o(2 downto 0);



end beh;