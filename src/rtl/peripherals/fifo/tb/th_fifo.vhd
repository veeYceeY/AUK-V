--================================================================================================================================
-- Copyright 2020 SCiMOS
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

library bitvis_vip_sbi;
-- library bitvis_vip_uart;
-- library bitvis_uart;
library bitvis_vip_clock_generator;


-- Test harness entity
entity th_fifo is
end entity th_fifo;

-- Test harness architecture
architecture struct of th_fifo is

  -- DSP interface and general control signals
  signal wrclk            : std_logic  := '0';
  signal wrrst           : std_logic  := '0';
  signal rdclk            : std_logic  := '0';
  signal rdrst           : std_logic  := '0';

  -- SBI VVC signals
  signal rd_cs             : std_logic;
  signal rd_addr           : unsigned(2 downto 0);
  signal rd_wr             : std_logic;
  signal rd_rd             : std_logic;
  signal rd_wdata          : std_logic_vector(7 downto 0);
  signal rd_rdata          : std_logic_vector(7 downto 0);
  signal rd_ready          : std_logic;

  signal wr_cs             : std_logic;
  signal wr_addr           : unsigned(2 downto 0);
  signal wr_wr             : std_logic;
  signal wr_rd             : std_logic;
  signal wr_wdata          : std_logic_vector(7 downto 0);
  signal wr_rdata          : std_logic_vector(7 downto 0);
  signal wr_ready          : std_logic;

  -- FIFO VVC signals
  signal fifo_full    : std_logic := '1';
  signal fifo_empty    : std_logic := '1';

  constant C_WRCLK_PERIOD : time    := 100 ns; -- 10 MHz
  constant C_RDCLK_PERIOD : time    := 1000 ns; -- 100 MHz
  constant C_RDCLOCK_GEN  : natural := 1;
  constant C_WRCLOCK_GEN  : natural := 1;

begin

  -----------------------------------------------------------------------------
  -- Instantiate the concurrent procedure that initializes UVVM
  -----------------------------------------------------------------------------
  i_ti_uvvm_engine : entity uvvm_vvc_framework.ti_uvvm_engine;

  -----------------------------------------------------------------------------
  -- Instantiate DUT
  -----------------------------------------------------------------------------

  fifo0: entity work.fifo

   generic map(
    FIFO_WIDTH => 8,
    FIFO_DEPTH => 8
   )
    port map (
     
        i_wrclk   =>wrclk,
        i_wrrst   =>wrrst,
        i_wren    =>wr_wr,
        i_wrdata  =>wr_wdata,
        o_full    =>fifo_full,

        i_rdclk   =>rdclk,
        i_rdrst   =>rdrst,
        i_rden    =>rd_rd,
        o_rddata  =>rd_rdata,
        o_empty   =>fifo_empty
  );


  -----------------------------------------------------------------------------
  -- SBI VVC
  -----------------------------------------------------------------------------
  i1_sbi_vvc: entity bitvis_vip_sbi.sbi_vvc
  generic map(
    GC_ADDR_WIDTH     => 3,
    GC_DATA_WIDTH     => 8,
    GC_INSTANCE_IDX   => 1
  )
  port map(
    clk                         => wrclk,
    sbi_vvc_master_if.cs        => wr_cs,
    sbi_vvc_master_if.rena      => wr_rd,
    sbi_vvc_master_if.wena      => wr_wr,
    sbi_vvc_master_if.addr      => wr_addr,
    sbi_vvc_master_if.wdata     => wr_wdata,
    sbi_vvc_master_if.ready     => wr_ready,
    sbi_vvc_master_if.rdata     => wr_rdata
  );
-----------------------------------------------------------------------------
  -- SBI VVC
  -----------------------------------------------------------------------------
  i2_sbi_vvc: entity bitvis_vip_sbi.sbi_vvc
  generic map(
    GC_ADDR_WIDTH     => 3,
    GC_DATA_WIDTH     => 8,
    GC_INSTANCE_IDX   => 2
  )
  port map(
    clk                         => rdclk,
    sbi_vvc_master_if.cs        => rd_cs,
    sbi_vvc_master_if.rena      => rd_rd,
    sbi_vvc_master_if.wena      => rd_wr,
    sbi_vvc_master_if.addr      => rd_addr,
    sbi_vvc_master_if.wdata     => rd_wdata,
    sbi_vvc_master_if.ready     => rd_ready,
    sbi_vvc_master_if.rdata     => rd_rdata
  );



  -- Static '1' ready signal for the SBI VVC
  rd_ready <= '1';
  wr_ready <= '1';

  -- Toggle the reset after 5 clock periods
  wr_arst: wrrst <= '1', '0' after 2 *C_WRCLK_PERIOD;
  rd_arst: rdrst <= '1', '0' after 2 *C_RDCLK_PERIOD;

  -----------------------------------------------------------------------------
  -- Write Clock Generator VVC
  -----------------------------------------------------------------------------
  i_wrclock_generator_vvc : entity bitvis_vip_clock_generator.clock_generator_vvc
    generic map(
      GC_INSTANCE_IDX    => C_WRCLOCK_GEN,
      GC_CLOCK_NAME      => "WrClock",
      GC_CLOCK_PERIOD    => C_WRCLK_PERIOD,
      GC_CLOCK_HIGH_TIME => C_WRCLK_PERIOD / 2
      )
    port map(
      clk => wrclk
      );

  -----------------------------------------------------------------------------
  -- read Clock Generator VVC
  -----------------------------------------------------------------------------
  i_rdclock_generator_vvc : entity bitvis_vip_clock_generator.clock_generator_vvc
    generic map(
      GC_INSTANCE_IDX    => C_RDCLOCK_GEN,
      GC_CLOCK_NAME      => "RdClock",
      GC_CLOCK_PERIOD    => C_RDCLK_PERIOD,
      GC_CLOCK_HIGH_TIME => C_RDCLK_PERIOD / 2
      )
    port map(
      clk => rdclk
      );


end struct;
