// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Thu Sep  3 14:21:39 2020
// Host        : SCiMOS running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/veeyceey/Documents/workspace/github/AUK-V/vivado/SCiV/SCiV.srcs/sources_1/bd/example_led/ip/example_led_ila_0_0/example_led_ila_0_0_stub.v
// Design      : example_led_ila_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "ila,Vivado 2019.2" *)
module example_led_ila_0_0(clk, probe0, probe1)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[2:0],probe1[0:0]" */;
  input clk;
  input [2:0]probe0;
  input [0:0]probe1;
endmodule
