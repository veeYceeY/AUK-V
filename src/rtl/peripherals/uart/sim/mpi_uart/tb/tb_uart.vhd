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


library uvvm_util;
context uvvm_util.uvvm_util_context;

library uvvm_vvc_framework;
use uvvm_vvc_framework.ti_vvc_framework_support_pkg.all;

library bitvis_vip_sbi;
use bitvis_vip_sbi.vvc_methods_pkg.all;
use bitvis_vip_sbi.td_vvc_framework_common_methods_pkg.all;

library bitvis_vip_uart;
use bitvis_vip_uart.vvc_methods_pkg.all;
use bitvis_vip_uart.td_vvc_framework_common_methods_pkg.all;

library bitvis_vip_clock_generator;
context bitvis_vip_clock_generator.vvc_context;

-- Test bench entity
entity tb_uart is
end entity tb_uart;

-- Test bench architecture
architecture func of tb_uart is

  constant C_SCOPE              : string  := C_TB_SCOPE_DEFAULT;

  -- Clock and bit period settings
  constant C_CLK_PERIOD         : time := 10 ns;
  constant C_BIT_PERIOD         : time := 16 * C_CLK_PERIOD;

  -- Time for one UART transmission to complete
  constant C_TIME_OF_ONE_UART_TX : time := 11*C_BIT_PERIOD; -- =1760 ns;

  -- Predefined SBI addresses
  constant C_ADDR_CFG           : unsigned(31 downto 0) := x"00000000";
  constant C_ADDR_RX_DATA       : unsigned(31 downto 0) := x"00000002";
  constant C_ADDR_RX_DATA_VALID : unsigned(31 downto 0) := x"00000001";
  constant C_ADDR_TX_DATA       : unsigned(31 downto 0) := x"00000003";
  constant C_ADDR_TX_READY      : unsigned(31 downto 0) := x"00000004";


  begin

  -----------------------------------------------------------------------------
  -- Instantiate test harness, containing DUT and Executors
  -----------------------------------------------------------------------------
  i_test_harness : entity work.uart_th;


  ------------------------------------------------
  -- PROCESS: p_main
  ------------------------------------------------
  p_main: process
  begin

    -- Wait for UVVM to finish initialization
    await_uvvm_initialization(VOID);

    start_clock(CLOCK_GENERATOR_VVCT, 1, "Start clock generator");

    -- Print the configuration to the log
    report_global_ctrl(VOID);
    report_msg_id_panel(VOID);

    --enable_log_msg(ALL_MESSAGES);
    disable_log_msg(ALL_MESSAGES);
    enable_log_msg(ID_LOG_HDR);
    enable_log_msg(ID_SEQUENCER);
    enable_log_msg(ID_UVVM_SEND_CMD);

    disable_log_msg(SBI_VVCT, 1, ALL_MESSAGES);
    enable_log_msg(SBI_VVCT, 1, ID_BFM);
    enable_log_msg(SBI_VVCT, 1, ID_FINISH_OR_STOP);

    disable_log_msg(UART_VVCT, 1, RX, ALL_MESSAGES);
    enable_log_msg(UART_VVCT, 1, RX, ID_BFM);

    disable_log_msg(UART_VVCT, 1, TX, ALL_MESSAGES);
    enable_log_msg(UART_VVCT, 1, TX, ID_BFM);

    log(ID_LOG_HDR, "Starting simulation of TB for UART using VVCs", C_SCOPE);
    ------------------------------------------------------------

    log("Wait 10 clock period for reset to be turned off");
    wait for (10 * C_CLK_PERIOD); -- for reset to be turned off


    log(ID_LOG_HDR, "Configure UART VVC 1", C_SCOPE);
    ------------------------------------------------------------
    shared_uart_vvc_config(RX,1).bfm_config.bit_time := C_BIT_PERIOD;
    shared_uart_vvc_config(TX,1).bfm_config.bit_time := C_BIT_PERIOD;


    log(ID_LOG_HDR, "Check register defaults ", C_SCOPE);
    ------------------------------------------------------------
    -- This test will send three  --sbi_check commands to the SBI VVC, and then
    -- wait for them all to complete before continuing the test sequence.
    -- --sbi_check(SBI_VVCT, 1, C_ADDR_RX_DATA, x"00", "RX_DATA default");
    -- --sbi_check(SBI_VVCT, 1, C_ADDR_TX_READY, x"01", "TX_READY default");
    -- --sbi_check(SBI_VVCT, 1, C_ADDR_RX_DATA_VALID, x"00", "RX_DATA_VALID default");
    --await_completion(SBI_VVCT,1,  10 * C_CLK_PERIOD);


    log(ID_LOG_HDR, "Check simple transmit", C_SCOPE);

    --constant C_ADDR_CFG           : unsigned(31 downto 0) := 0;
    --constant C_ADDR_RX_DATA       : unsigned(31 downto 0) := 2;
    --constant C_ADDR_RX_DATA_VALID : unsigned(31 downto 0) := 1;
    --constant C_ADDR_TX_DATA       : unsigned(31 downto 0) := 3;
    --constant C_ADDR_TX_READY      : unsigned(31 downto 0) := 4;


    ------------------------------------------------------------
    -- This test case will instruct the SBI VVC to send the data x"55" to the DUT C_ADDR_TX_DATA address.
    -- This will cause the DUT to transmit x"55" on the UART line. In order to receive the data, the
    -- UART VVC is instructed to expect the data x"55" on the RX port. The test sequence will not continue
    -- until the UART VVC has received the data from the DUT, indicated by the await_completion method.
    sbi_write(SBI_VVCT,1,  C_ADDR_CFG, x"06", "TX_DATA");
    wait for 1000 ns;
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"ab", "TX_DATA");
    wait for 1000 ns;      
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;   
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"53", "TX_DATA");
    wait for 1000 ns;         
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"a5", "TX_DATA");
    wait for 1000 ns;           
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"00", "TX_DATA");
    wait for 1000 ns;           
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"01", "TX_DATA");
    wait for 1000 ns;           
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"10", "TX_DATA");
    wait for 1000 ns;           
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"11", "TX_DATA");
    wait for 1000 ns;           
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"20", "TX_DATA");
    wait for 1000 ns;           
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"22", "TX_DATA");
    wait for 1000 ns;           
    sbi_read(SBI_VVCT, 1, C_ADDR_RX_DATA, "RX_DATA default");
    wait for 1000 ns;  
    sbi_write(SBI_VVCT,1,  C_ADDR_TX_DATA, x"02", "TX_DATA");
    wait for 1000 ns;         
     --sbi_check(SBI_VVCT, 1, C_ADDR_RX_DATA, x"ab", "RX_DATA default");
    wait for 1000 ns;  
    --uart_expect(UART_VVCT,1,RX,  x"02", "Expecting data on UART RX");
    --await_completion(UART_VVCT,1,RX,  13 * C_BIT_PERIOD);




    -----------------------------------------------------------------------------
    -- Ending the simulation
    -----------------------------------------------------------------------------
    wait for 20000 ns;             -- to allow some time for completion
    report_alert_counters(FINAL); -- Report final counters and print conclusion for simulation (Success/Fail)
    log(ID_LOG_HDR, "SIMULATION COMPLETED", C_SCOPE);

    -- Finish the simulation
    std.env.stop;
    wait;  -- to stop completely

  end process p_main;

end func;
