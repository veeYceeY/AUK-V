--================================================================================================================================
-- Copyright 2020 Bitvis
-- Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 and in the provided LICENSE.TXT.
--
-- Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
-- an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and limitations under the License.
--================================================================================================================================
-- Note : Any functionality not explicitly described in the documentation is subject to change at any time
----------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
-- Description   : See library quick reference (under 'doc') and README-file(s)
------------------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library uvvm_vvc_framework;
use uvvm_vvc_framework.ti_vvc_framework_support_pkg.all;

library bitvis_vip_axilite;
library bitvis_vip_uart;
--library bitvis_uart;
library bitvis_vip_clock_generator;


-- Test harness entity
entity axi_uart_th is
end entity axi_uart_th;

-- Test harness architecture
architecture struct of axi_uart_th is

  -- DSP interface and general control signals
  signal clk            : std_logic  := '0';
  signal arst           : std_logic  := '0';

  -- UART VVC signals
  signal uart_vvc_xx    : std_logic := '1';
  signal uart_vvc_rx    : std_logic := '1';
  signal uart_vvc_tx    : std_logic := '1';

  constant C_CLK_PERIOD : time    := 10 ns; -- 100 MHz
  constant C_CLOCK_GEN  : natural := 1;
  signal aclk    : std_logic;
  signal aresetn : std_logic;
  signal awaddr  : std_logic_vector(31 downto 0);
  signal awvalid : std_logic;
  signal awprot  : std_logic_vector(2 downto 0);
  signal awready : std_logic;
  signal wdata   : std_logic_vector(31 downto 0);
  signal wstrb   : std_logic_vector(3 downto 0);
  signal wvalid  : std_logic;
  signal wready  : std_logic;
  signal bready  : std_logic;
  signal bresp   : std_logic_vector(1 downto 0);
  signal bvalid  : std_logic;
  signal araddr  : std_logic_vector(31 downto 0);
  signal arvalid : std_logic;
  signal arprot  : std_logic_vector(2 downto 0);
  signal arready : std_logic;
  signal rready  : std_logic;
  signal rdata   : std_logic_vector(31 downto 0);
  signal rresp   : std_logic_vector(1 downto 0);
  signal rvalid  : std_logic;
  signal i_rx    : std_logic;
  signal o_tx    : std_logic;


begin

  -----------------------------------------------------------------------------
  -- Instantiate the concurrent procedure that initializes UVVM
  -----------------------------------------------------------------------------
  i_ti_uvvm_engine : entity uvvm_vvc_framework.ti_uvvm_engine;

  -----------------------------------------------------------------------------
  -- Instantiate DUT
  -----------------------------------------------------------------------------

  i_uart: entity work.axi_uart
  port map (
    i_aclk        => aclk     ,

    i_aresetn     => aresetn  ,
    i_araddr      => araddr   ,
    i_arprot      => arprot   ,
    i_arvalid     => arvalid  ,
    o_arready     => arready  ,

    o_rdata       => rdata    ,
    o_rresp       => rresp    ,
    o_rvalid      => rvalid   ,
    i_rready      => rready   ,

    i_awaddr      => awaddr   ,
    i_awprot      => awprot   ,
    i_awvalid     => awvalid  ,
    o_awready     => awready  ,

    i_wdata       => wdata    ,
    i_wstrb       => wstrb    ,
    o_wready      => wready   ,
    i_wvalid      => wvalid   ,

    o_bresp       => bresp    ,
    o_bvalid      => bvalid   ,
    o_bready      => bready   ,
    
    i_rx          => uart_vvc_xx,
    o_tx          => uart_vvc_xx

  );

  -----------------------------------------------------------------------------
  -- SBI VVC
  -----------------------------------------------------------------------------
  i1_axilite_vvc: entity bitvis_vip_axilite.axilite_vvc
  generic map(
    GC_ADDR_WIDTH     => 32,
    GC_DATA_WIDTH     => 32,
    GC_INSTANCE_IDX   => 1
  )
  port map(
    
    clk      => aclk,
    --aresetn   => aresetn,
    axilite_vvc_master_if.write_address_channel.awaddr    => awaddr ,
    axilite_vvc_master_if.write_address_channel.awvalid   => awvalid,
    axilite_vvc_master_if.write_address_channel.awprot    => awprot ,
    axilite_vvc_master_if.write_address_channel.awready   => awready,

    axilite_vvc_master_if.write_data_channel.wdata     => wdata  ,
    axilite_vvc_master_if.write_data_channel.wstrb     => wstrb  ,
    axilite_vvc_master_if.write_data_channel.wvalid    => wvalid ,
    axilite_vvc_master_if.write_data_channel.wready    => wready ,

    axilite_vvc_master_if.write_response_channel.bready    => bready ,
    axilite_vvc_master_if.write_response_channel.bresp     => bresp  ,
    axilite_vvc_master_if.write_response_channel.bvalid    => bvalid ,

    axilite_vvc_master_if.read_address_channel.araddr    => araddr ,
    axilite_vvc_master_if.read_address_channel.arvalid   => arvalid,
    axilite_vvc_master_if.read_address_channel.arprot    => arprot ,
    axilite_vvc_master_if.read_address_channel.arready   => arready,

    axilite_vvc_master_if.read_data_channel.rready    => rready ,
    axilite_vvc_master_if.read_data_channel.rdata     => rdata  ,
    axilite_vvc_master_if.read_data_channel.rresp     => rresp  ,
    axilite_vvc_master_if.read_data_channel.rvalid    => rvalid 

      );


  -----------------------------------------------------------------------------
  -- UART VVC
  -----------------------------------------------------------------------------
  i1_uart_vvc: entity bitvis_vip_uart.uart_vvc
  generic map(
    GC_DATA_WIDTH     => 8,
    GC_INSTANCE_IDX   => 1
  )
  port map(
    uart_vvc_rx         => uart_vvc_xx,
    uart_vvc_tx         => uart_vvc_xx
  );


  -- Static '1' ready signal for the SBI VVC
  --ready <= '1';

  -- Toggle the reset after 5 clock periods
  p_arst: aresetn <= '0', '1' after 5 *C_CLK_PERIOD;

  -----------------------------------------------------------------------------
  -- Clock Generator VVC
  -----------------------------------------------------------------------------
  i_clock_generator_vvc : entity bitvis_vip_clock_generator.clock_generator_vvc
    generic map(
      GC_INSTANCE_IDX    => C_CLOCK_GEN,
      GC_CLOCK_NAME      => "Clock",
      GC_CLOCK_PERIOD    => C_CLK_PERIOD,
      GC_CLOCK_HIGH_TIME => C_CLK_PERIOD / 2
      )
    port map(
      clk => aclk
      );


end struct;
