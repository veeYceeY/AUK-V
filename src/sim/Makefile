


compile_rtl:
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/alu.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/code_mem.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/comp.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/execute.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/fetch.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/microcode_mem.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/decode_uc.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/decode.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/memory_access.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/reg_file.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/write_back.vhd
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../rtl/sciv_core.vhd

compile_tb:
	ghdl -a -frelaxed-rules --ieee=synopsys --std=08 -Wno-hide -Wno-shared --work=scivlib ../tb/tb_sciv_core.vhd

simulate:
	echo "Starting simulations..."
	ghdl -e -frelaxed-rules --ieee=synopsys --std=08  --work=scivlib tb_sciv_core
	ghdl -r -frelaxed-rules --ieee=synopsys --std=08 --work=scivlib tb_sciv_core --vcd=simdump.vcd 

view:
	gtkwave simdump.vcd

all: compile_rtl compile_tb simulate view