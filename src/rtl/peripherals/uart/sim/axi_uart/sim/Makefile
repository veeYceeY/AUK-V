
compile_uvvm:
	echo "\nThis script has been tested with GHDL v.0.37\n"

	# Compiling UVVM Util
	echo "Compiling UVVM Utility Library..."
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/types_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/adaptations_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/string_methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/protected_types_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/global_signals_and_shared_variables_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/hierarchy_linked_list_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/alert_hierarchy_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/license_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/bfm_common_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_util ../../../../../uvvm/uvvm_util/src/uvvm_util_context.vhd

	# Compiling UVVM VVC Framework
	echo "Compiling UVVM VVC Framework..."
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_vvc_framework ../../../../../uvvm/uvvm_vvc_framework/src/ti_protected_types_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_vvc_framework ../../../../../uvvm/uvvm_vvc_framework/src/ti_vvc_framework_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_vvc_framework ../../../../../uvvm/uvvm_vvc_framework/src/ti_generic_queue_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_vvc_framework ../../../../../uvvm/uvvm_vvc_framework/src/ti_data_queue_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_vvc_framework ../../../../../uvvm/uvvm_vvc_framework/src/ti_data_fifo_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_vvc_framework ../../../../../uvvm/uvvm_vvc_framework/src/ti_data_stack_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=uvvm_vvc_framework ../../../../../uvvm/uvvm_vvc_framework/src/ti_uvvm_engine.vhd

	# Compiling Bitvis VIP Scoreboard
	echo "Compiling Bitvis VIP Scoreboard..."
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_scoreboard ../../../../../uvvm/bitvis_vip_scoreboard/src/generic_sb_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_scoreboard ../../../../../uvvm/bitvis_vip_scoreboard/src/generic_sb_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_scoreboard ../../../../../uvvm/bitvis_vip_scoreboard/src/predefined_sb.vhd

	# Compiling Bitvis VIP SBI
	echo "Compiling Bitvis VIP SBI..."
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/bitvis_vip_axilite/src/transaction_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/bitvis_vip_axilite/src/axilite_bfm_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/bitvis_vip_axilite/src/vvc_cmd_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_target_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_vvc_framework_common_methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/bitvis_vip_axilite/src/vvc_methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_queue_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_vvc_entity_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/bitvis_vip_axilite/src/axilite_vvc.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_axilite ../../../../../uvvm/bitvis_vip_axilite/src/vvc_context.vhd


	# Compiling Bitvis VIP UART
	echo "Compiling Bitvis VIP UART..."
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/uart_bfm_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/transaction_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/vvc_cmd_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/monitor_cmd_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_target_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_vvc_framework_common_methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/vvc_methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_queue_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_vvc_entity_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/uart_rx_vvc.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/uart_tx_vvc.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/uart_vvc.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/uart_monitor.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_uart  ../../../../../uvvm/bitvis_vip_uart/src/vvc_context.vhd



	# Compiling Bitvis VIP Clock Generator
	echo "Compiling Bitvis VIP Clock Generator..."
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/bitvis_vip_clock_generator/src/vvc_cmd_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_target_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_vvc_framework_common_methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/bitvis_vip_clock_generator/src/vvc_methods_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_queue_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/uvvm_vvc_framework/src_target_dependent/td_vvc_entity_support_pkg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/bitvis_vip_clock_generator/src/clock_generator_vvc.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=bitvis_vip_clock_generator ../../../../../uvvm/bitvis_vip_clock_generator/src/vvc_context.vhd


compile_rtl:
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../../../rtl/baud.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../../../rtl/axi_reg.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../../../rtl/uart_rx.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../../../rtl/uart_tx.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../../../rtl/uart.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../../../rtl/axi_uart.vhd

compile_tb:
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../tb/th_axi_uart.vhd
	ghdl -a -frelaxed-rules --std=08 -Wno-hide -Wno-shared --work=scivlib ../tb/tb_axi_uart.vhd

simulate:
	echo "Starting simulations..."
	ghdl -e -frelaxed-rules --std=08  --work=scivlib tb_axi_uart
	ghdl -r -frelaxed-rules --std=08 --work=scivlib tb_axi_uart --vcd=tb_axi_uart.vcd  

view:
	gtkwave tb_uart.vcd
	
cli: compile_uvvm compile_rtl compile_tb simulate 

gui: compile_uvvm compile_rtl compile_tb simulate view

all: compile_uvvm compile_rtl compile_tb simulate view