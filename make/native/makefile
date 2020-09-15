
ROM:
	cd ../../sw/ && make all

COPY_CODEMEM:
	cp -f code_mem.vhd ../../src/rtl/infrastructure/
SIMULATE:
	cd ../../src/sim/Example_system/ && make all
wave_view:
	cd ../../src/sim/Example_system/ && make view 
sim: ROM SIMULATE 

all: sim