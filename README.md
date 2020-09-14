# AUK-V
![Alt text](doc/arch.png?raw=true "Architecture")


    AUK-V is a RISC-V 32 bit processor compatible with RV32I instructions

## Requirements for running simulation

    ghdl
    gtkwave
## Create code rom in vhdl 
    cd tools
    make rom  
## Running simulation
    cd tools
    make sim  

## Todo
    Add AXI interface -- started
    Add support for exceptions
    Branch prediction
    