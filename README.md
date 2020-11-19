# AUK-V
![Alt text](doc/arch.png?raw=true "Architecture")


    AUK-V is a RISC-V 32 bit processor compatible with RV32I instructions

## Install tool chain
    git clone https://github.com/riscv/riscv-gnu-toolchain.git
    cd riscv-gnu-toolchain
    make clean
    ./configure --with-arch=rv32i --prefix=/opt/riscv32i
    make newlib


## Create code rom in vhdl 
    cd make/wishbone
    make rom 

## Todo
    
    uart  bootloader
    
    Documentation
    