
TPATH := /opt/riscv32i/bin/
PREFIX := riscv32-unknown-elf
XSCT := /opt/vivado191/SDK/2019.1/bin/xsct/
ASM: 
	$(TPATH)$(PREFIX)-as  -march=rv32i bsp/start.S -o build/start.o

GCC:
	$(TPATH)$(PREFIX)-gcc -march=rv32i -Wall -Werror -mpreferred-stack-boundary=3  -ffreestanding -c src/main.c -o build/main.o 
LINK:
	$(TPATH)$(PREFIX)-ld build/start.o build/main.o -T bsp/ldscript -o build/main.elf
VERILOG:
	$(TPATH)$(PREFIX)-objcopy -O verilog  build/main.elf  build/main.v
IHEX:
	$(TPATH)$(PREFIX)-objcopy -O ihex  build/main.elf  build/main.hex
LST:
	$(TPATH)$(PREFIX)-objdump --source --all-headers --demangle  --line-numbers --wide "build/main.elf" > "build/main.lst"
ROM:
	python3 ../tools/rom_.py ./build/main.v
rom: ASM GCC LINK VERILOG IHEX LST ROM COPY_CODEMEM


COPY_CODEMEM:
	cp -f build/wb_oc_rom.vhd ../src/rtl/infrastructure/
	
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
