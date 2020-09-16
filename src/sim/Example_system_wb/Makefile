


compile_rtl:

	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/pkg_aukv.vhd

	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/wb_oc_rom.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/wb_oc_ram.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/wb_arbiter.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/wb_master.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/wb_interconnect.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/peripherals/wb_reg_if.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/peripherals/wb_gpio.vhd



	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/alu.vhd
	#ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/code_mem.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/comp.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/execute.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/fetch.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/microcode_mem.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/decode_uc.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/decode.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/memory_access.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/reg_file.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/write_back.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/sciv_core.vhd

	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/system/sciv_core_wb.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/system/sciv_example_system_wb.vhd

compile_tb:
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../tb/example_system/tb_aukv_example_wb.vhd

simulate:
	echo "Starting simulations..."
	ghdl -e -frelaxed-rules --ieee=synopsys --std=08  --work=scivlib tb_aukv_example_wb
	ghdl -r -frelaxed-rules --ieee=synopsys --std=08 --work=scivlib tb_aukv_example_wb --wave=simdump.ghw 

view:
	gtkwave simdump.ghw

all: compile_rtl compile_tb simulate view