// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Thu Sep  3 14:20:07 2020
// Host        : SCiMOS running 64-bit Ubuntu 20.04.1 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ example_led_sciv_example_system_0_0_stub.v
// Design      : example_led_sciv_example_system_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "sciv_example_system,Vivado 2019.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(i_clk, i_rst, i_port_a, o_port_b)
/* synthesis syn_black_box black_box_pad_pin="i_clk,i_rst,i_port_a[31:0],o_port_b[2:0]" */;
  input i_clk;
  input i_rst;
  input [31:0]i_port_a;
  output [2:0]o_port_b;
endmodule
