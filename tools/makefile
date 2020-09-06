
TPATH := /opt/riscv32i/bin/
PREFIX := riscv32-unknown-elf

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
	$(TPATH)$(PREFIX)-objdump --source --all-headers --demangle --line-numbers --wide "main.elf" > "main.lst"
ROM:
	python3 rom_gen.py main.hex
COPY_CODEMEM:
	cp -f code_mem.vhd ../src/rtl/infrastructure/
SIMULATE:
	cd ../src/sim/Example_system/ && make all
wave_view:
	cd ../src/sim/Example_system/ && make view 
rom: ASM GCC LINK VERILOG IHEX LST ROM COPY_CODEMEM
sim: ASM GCC LINK VERILOG IHEX LST ROM SIMULATE 

all: rom

