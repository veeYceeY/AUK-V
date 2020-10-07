
rom:
	cd ../../sw/projects/bootloader && make all

COPY_CODEMEM:
	cp -f code_mem.vhd ../../src/rtl/infrastructure/
SIMULATE:
	cd ../../src/sim/Example_system_wb/ && make all
wave_view:
	cd ../../src/sim/Example_system_wb/ && make view 
sim: rom SIMULATE 

all: sim
clean:
	cd ../../src/sim/Example_system/ && make clean 