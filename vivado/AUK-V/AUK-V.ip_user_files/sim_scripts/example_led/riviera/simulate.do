onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+example_led -L xilinx_vip -L xil_defaultlib -L xpm -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_5 -L processing_system7_vip_v1_0_7 -L xlconstant_v1_1_6 -L util_vector_logic_v2_0_1 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.example_led xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {example_led.udo}

run -all

endsim

quit -force
