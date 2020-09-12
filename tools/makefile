
TPATH := /opt/riscv32i/bin/
PREFIX := riscv32-unknown-elf
XSCT := /opt/vivado191/SDK/2019.1/bin/xsct/
ASM: 
	$(TPATH)$(PREFIX)-as  -march=rv32i start.S -o start.o

GCC:
	$(TPATH)$(PREFIX)-gcc -march=rv32i -Wall -Werror -mpreferred-stack-boundary=3  -ffreestanding -c main.c -o main.o 
LINK:
	$(TPATH)$(PREFIX)-ld start.o main.o -T ldscript -o main.elf
VERILOG:
	$(TPATH)$(PREFIX)-objcopy -O verilog  main.elf  main.v
IHEX:
	$(TPATH)$(PREFIX)-objcopy -O ihex  main.elf  main.hex
LST:
	$(TPATH)$(PREFIX)-objdump --source --all-headers --demangle  --line-numbers --wide "main.elf" > "main.lst"
ROM:
	python3 rom_gen.py main.hex
COPY_CODEMEM:
	cp -f code_mem.vhd ../src/rtl/infrastructure/
SIMULATE:
	cd ../src/sim/Example_system/ && make all
wave_view:
	cd ../src/sim/Example_system/ && make view 
rom: ASM GCC LINK VERILOG IHEX LST ROM COPY_CODEMEM
sim: ASM GCC LINK VERILOG IHEX LST ROM COPY_CODEMEM SIMULATE 

all: rom

#FLASH:
#	$(XSCT) connect
#	$(XSCT) exec bootgen -arch zynq -image ./output/output.bif -w -o ./output/BOOT.bin
#COPY_OUTPUTS:	
#	cp ../vivado/AUK-V/AUK-V.sdk/auk-clock/Debug/auk-clock.elf -f ./output/arm.elf
#	cp ../vivado/AUK-V/AUK-V.sdk/example_led_wrapper_hw_platform_0/example_led_wrapper.bit ./output/fpga.bit

#xsct targets 2
#dow ./output/arm.elf  
#fpga ./output/fpga.bit
#exec bootgen -arch zynq -image output.bif -w -o BOOT.bin
#exec program_flash -f /tmp/wrk/BOOT.bin -flash_type qspi_single
#
#
#