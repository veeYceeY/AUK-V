


compile_rtl:


	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/pkg_aukv.vhd

	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/code_mem.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/ram.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/native_mem_interconnect.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/infrastructure/mem_interconnect.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/peripherals/reg_if.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/peripherals/gpio.vhd



	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/alu.vhd
	#ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/code_mem.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/comp.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/execute.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/fetch.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/microcode_mem.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/decode_uc.vhd
	#ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/decode.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/memory_access.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/reg_file.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/csr_file.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/write_back.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/sciv_core.vhd

	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/system/sciv_base_system_native.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../rtl/system/sciv_example_system_native.vhd

compile_tb:
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../../tb/example_system/tb_aukv_example_native.vhd

simulate:
	echo "Starting simulations..."
	ghdl -e -frelaxed-rules --ieee=synopsys --std=08  --work=scivlib tb_aukv_example_native
	ghdl -r -frelaxed-rules --ieee=synopsys --std=08 --work=scivlib tb_aukv_example_native --wave=simdump.ghw 

view:
	gtkwave simdump.ghw

all: compile_rtl compile_tb simulate view
clean:
	rm simdump.ghw 