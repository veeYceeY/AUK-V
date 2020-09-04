vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_5
vlib questa_lib/msim/processing_system7_vip_v1_0_7
vlib questa_lib/msim/xlconstant_v1_1_6
vlib questa_lib/msim/util_vector_logic_v2_0_1

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_5 questa_lib/msim/axi_vip_v1_1_5
vmap processing_system7_vip_v1_0_7 questa_lib/msim/processing_system7_vip_v1_0_7
vmap xlconstant_v1_1_6 questa_lib/msim/xlconstant_v1_1_6
vmap util_vector_logic_v2_0_1 questa_lib/msim/util_vector_logic_v2_0_1

vlog -work xilinx_vip -64 -sv -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"/opt/vivado191/Vivado/2019.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib -64 -sv -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"/opt/vivado191/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/vivado191/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/opt/vivado191/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work axi_infrastructure_v1_1_0 -64 "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_5 -64 -sv -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/d4a8/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_7 -64 -sv -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xilinx_vip "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib -64 "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/example_led/ip/example_led_processing_system7_0_0/sim/example_led_processing_system7_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/example_led/ip/example_led_sciv_example_system_0_0/sim/example_led_sciv_example_system_0_0.vhd" \
"../../../bd/example_led/ip/example_led_ila_0_0/sim/example_led_ila_0_0.vhd" \

vlog -work xlconstant_v1_1_6 -64 "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/example_led/ip/example_led_xlconstant_0_0/sim/example_led_xlconstant_0_0.v" \

vlog -work util_vector_logic_v2_0_1 -64 "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/ec67/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/8c62/hdl" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/c923" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ip/example_led_processing_system7_0_0" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/1b7e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/122e/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/6887/hdl/verilog" "+incdir+../../../../AUK-V.srcs/sources_1/bd/example_led/ipshared/9623/hdl/verilog" "+incdir+/opt/vivado191/Vivado/2019.1/data/xilinx_vip/include" \
"../../../bd/example_led/ip/example_led_util_vector_logic_0_0/sim/example_led_util_vector_logic_0_0.v" \
"../../../bd/example_led/ip/example_led_clk_wiz_0_1/example_led_clk_wiz_0_1_clk_wiz.v" \
"../../../bd/example_led/ip/example_led_clk_wiz_0_1/example_led_clk_wiz_0_1.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/example_led/sim/example_led.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

