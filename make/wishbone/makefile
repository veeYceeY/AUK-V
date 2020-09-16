
ROM:
	cd ../../sw/ && make all

COPY_CODEMEM:
	cp -f code_mem.vhd ../../src/rtl/infrastructure/
SIMULATE:
	cd ../../src/sim/Example_system_wb/ && make all
wave_view:
	cd ../../src/sim/Example_system_wb/ && make view 
sim: ROM SIMULATE 

all: sim