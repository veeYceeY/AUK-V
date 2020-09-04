-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
-- Date        : Fri Sep  4 08:58:13 2020
-- Host        : SCiMOS running 64-bit Ubuntu 20.04.1 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/veeyceey/Documents/workspace/github/AUK-V/vivado/AUK-V/AUK-V.srcs/sources_1/bd/example_led/ip/example_led_sciv_example_system_0_0/example_led_sciv_example_system_0_0_stub.vhdl
-- Design      : example_led_sciv_example_system_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity example_led_sciv_example_system_0_0 is
  Port ( 
    i_clk : in STD_LOGIC;
    i_rst : in STD_LOGIC;
    i_port_a : in STD_LOGIC_VECTOR ( 31 downto 0 );
    o_port_b : out STD_LOGIC_VECTOR ( 2 downto 0 )
  );

end example_led_sciv_example_system_0_0;

architecture stub of example_led_sciv_example_system_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "i_clk,i_rst,i_port_a[31:0],o_port_b[2:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "sciv_example_system,Vivado 2019.1";
begin
end;
