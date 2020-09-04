-makelib xcelium_lib/xilinx_vip -sv \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "/opt/vivado191/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/opt/vivado191/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/opt/vivado191/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_5 -sv \
  "../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/processing_system7_vip_v1_0_7 -sv \
  "../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/example_led/ip/example_led_processing_system7_0_0/sim/example_led_processing_system7_0_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/example_led/ip/example_led_sciv_example_system_0_0/sim/example_led_sciv_example_system_0_0.vhd" \
  "../../../bd/example_led/ip/example_led_ila_0_0/sim/example_led_ila_0_0.vhd" \
-endlib
-makelib xcelium_lib/xlconstant_v1_1_6 \
  "../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/example_led/ip/example_led_xlconstant_0_0/sim/example_led_xlconstant_0_0.v" \
-endlib
-makelib xcelium_lib/util_vector_logic_v2_0_1 \
  "../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/example_led/ip/example_led_util_vector_logic_0_0/sim/example_led_util_vector_logic_0_0.v" \
  "../../../bd/example_led/ip/example_led_clk_wiz_0_1/example_led_clk_wiz_0_1_clk_wiz.v" \
  "../../../bd/example_led/ip/example_led_clk_wiz_0_1/example_led_clk_wiz_0_1.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/example_led/sim/example_led.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

