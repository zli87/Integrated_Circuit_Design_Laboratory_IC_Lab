//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory System Integration and Silicon Implementation
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   ICLAB 2019 Final Project: Customized ISA Processor
//   Author     		     : Yun-Sheng Chan
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : TESTBED.v
//   Module Name : TESTBED.v
//   Release version : V1.0 (Release Date: 2019-Dec)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`timescale 1ns/1ps
`include "PATTERN.v"

`ifdef RTL
    `include "CPU.v"
`elsif GATE
    `include "CPU_SYN.v"
`elsif CHIP
    `include "CHIP_SYN.v"
`elsif POST
    `include "CHIP.v"
`endif

//synopsys translate_off
`include "../04_MEM/SRAM256W16B.v"
//synopsys translate_on
module TESTBED();
parameter ID_WIDTH = 4 , ADDR_WIDTH = 32, DATA_WIDTH = 16;
//Connection wires
wire clk, rst_n, interrupt_1, interrupt_2;
wire stall_core1, stall_core2;

//########################################### Instruction Memory #1
// axi write addr channel
// src master
wire [ID_WIDTH-1:0]      awid_w_inf_inst_1;
wire [ADDR_WIDTH-1:0]  awaddr_w_inf_inst_1;
wire [2:0]             awsize_w_inf_inst_1;
wire [1:0]            awburst_w_inf_inst_1;
wire [7:0]              awlen_w_inf_inst_1;
wire                  awvalid_w_inf_inst_1;
// src slave
wire                  awready_w_inf_inst_1;
// -------------------------

// axi write data channel
// src master
wire [DATA_WIDTH-1:0]   wdata_w_inf_inst_1;
wire                    wlast_w_inf_inst_1;
wire                   wvalid_w_inf_inst_1;
// src slave
wire                   wready_w_inf_inst_1;

// axi write resp channel
// src slave
wire  [ID_WIDTH-1:0]      bid_w_inf_inst_1;
wire  [1:0]             bresp_w_inf_inst_1;
wire                   bvalid_w_inf_inst_1;
// src master
wire                   bready_w_inf_inst_1;
// ------------------------

// axi read addr channel
// src master
wire [ID_WIDTH-1:0]      arid_w_inf_inst_1;
wire [ADDR_WIDTH-1:0]  araddr_w_inf_inst_1;
wire [7:0]              arlen_w_inf_inst_1;
wire [2:0]             arsize_w_inf_inst_1;
wire [1:0]            arburst_w_inf_inst_1;
wire                  arvalid_w_inf_inst_1;
// src slave
wire                  arready_w_inf_inst_1;
// ------------------------

// axi read data channel
// slave
wire [ID_WIDTH-1:0]       rid_w_inf_inst_1;
wire [DATA_WIDTH-1:0]   rdata_w_inf_inst_1;
wire [1:0]              rresp_w_inf_inst_1;
wire                    rlast_w_inf_inst_1;
wire                   rvalid_w_inf_inst_1;
// master
wire                   rready_w_inf_inst_1;
// -----------------------------

//########################################### City A
// axi write addr channel
// src master
wire [ID_WIDTH-1:0]      awid_w_inf_inst_2;
wire [ADDR_WIDTH-1:0]  awaddr_w_inf_inst_2;
wire [2:0]             awsize_w_inf_inst_2;
wire [1:0]            awburst_w_inf_inst_2;
wire [7:0]              awlen_w_inf_inst_2;
wire                  awvalid_w_inf_inst_2;
// src slave
wire                  awready_w_inf_inst_2;
// -------------------------

// axi write data channel
// src master
wire [DATA_WIDTH-1:0]   wdata_w_inf_inst_2;
wire                    wlast_w_inf_inst_2;
wire                   wvalid_w_inf_inst_2;
// src slave
wire                   wready_w_inf_inst_2;

// axi write resp channel
// src slave
wire  [ID_WIDTH-1:0]      bid_w_inf_inst_2;
wire  [1:0]             bresp_w_inf_inst_2;
wire                   bvalid_w_inf_inst_2;
// src master
wire                   bready_w_inf_inst_2;
// ------------------------

// axi read addr channel
// src master
wire [ID_WIDTH-1:0]      arid_w_inf_inst_2;
wire [ADDR_WIDTH-1:0]  araddr_w_inf_inst_2;
wire [7:0]              arlen_w_inf_inst_2;
wire [2:0]             arsize_w_inf_inst_2;
wire [1:0]            arburst_w_inf_inst_2;
wire                  arvalid_w_inf_inst_2;
// src slave
wire                  arready_w_inf_inst_2;
// ------------------------

// axi read data channel
// slave
wire [ID_WIDTH-1:0]       rid_w_inf_inst_2;
wire [DATA_WIDTH-1:0]   rdata_w_inf_inst_2;
wire [1:0]              rresp_w_inf_inst_2;
wire                    rlast_w_inf_inst_2;
wire                   rvalid_w_inf_inst_2;
// master
wire                   rready_w_inf_inst_2;
// -----------------------------

//########################################### City B
// axi write addr channel
// src master
wire [ID_WIDTH-1:0]      awid_w_inf_data;
wire [ADDR_WIDTH-1:0]  awaddr_w_inf_data;
wire [2:0]             awsize_w_inf_data;
wire [1:0]            awburst_w_inf_data;
wire [7:0]              awlen_w_inf_data;
wire                  awvalid_w_inf_data;
// src slave
wire                  awready_w_inf_data;
// -------------------------

// axi write data channel
// src master
wire [DATA_WIDTH-1:0]   wdata_w_inf_data;
wire                    wlast_w_inf_data;
wire                   wvalid_w_inf_data;
// src slave
wire                   wready_w_inf_data;

// axi write resp channel
// src slave
wire  [ID_WIDTH-1:0]      bid_w_inf_data;
wire  [1:0]             bresp_w_inf_data;
wire                   bvalid_w_inf_data;
// src master
wire                   bready_w_inf_data;
// ------------------------

// axi read addr channel
// src master
wire [ID_WIDTH-1:0]      arid_w_inf_data;
wire [ADDR_WIDTH-1:0]  araddr_w_inf_data;
wire [7:0]              arlen_w_inf_data;
wire [2:0]             arsize_w_inf_data;
wire [1:0]            arburst_w_inf_data;
wire                  arvalid_w_inf_data;
// src slave
wire                  arready_w_inf_data;
// ------------------------

// axi read data channel
// slave
wire [ID_WIDTH-1:0]       rid_w_inf_data;
wire [DATA_WIDTH-1:0]   rdata_w_inf_data;
wire [1:0]              rresp_w_inf_data;
wire                    rlast_w_inf_data;
wire                   rvalid_w_inf_data;
// master
wire                   rready_w_inf_data;
// ------------------------

initial begin
  `ifdef RTL
    $fsdbDumpfile("CPU.fsdb");
    $fsdbDumpvars(0,"+mda");
  `elsif GATE
    //$sdf_annotate("CPU_SYN.sdf",My_CPU);
     $fsdbDumpfile("CPU_SYN.fsdb");
    $fsdbDumpvars(0,"+mda");
  `elsif CHIP
    //$fsdbDumpfile("CHIP_SYN.fsdb");
    //$fsdbDumpvars(0,"+mda");
  `elsif POST
    $sdf_annotate("CHIP.sdf",My_CHIP);
    $fsdbDumpfile("CHIP_POST.fsdb");
    $fsdbDumpvars(0,"+mda");
  `endif
end

`ifdef RTL
  CPU My_CPU(
// Input
    .clk(clk),
  .rst_n(rst_n),
  .interrupt_1(interrupt_1),
  .interrupt_2(interrupt_2),
// Output
  .stall_core1(stall_core1),
  .stall_core2(stall_core2),
//===== AXI-4 Instruction Memory #1 =====
     .arid_m_inf_inst_1(arid_w_inf_inst_1),
   .araddr_m_inf_inst_1(araddr_w_inf_inst_1),
    .arlen_m_inf_inst_1(arlen_w_inf_inst_1),
   .arsize_m_inf_inst_1(arsize_w_inf_inst_1),
  .arburst_m_inf_inst_1(arburst_w_inf_inst_1),
  .arvalid_m_inf_inst_1(arvalid_w_inf_inst_1),
  .arready_m_inf_inst_1(arready_w_inf_inst_1),

      .rid_m_inf_inst_1(rid_w_inf_inst_1),
    .rdata_m_inf_inst_1(rdata_w_inf_inst_1),
    .rresp_m_inf_inst_1(rresp_w_inf_inst_1),
    .rlast_m_inf_inst_1(rlast_w_inf_inst_1),
   .rvalid_m_inf_inst_1(rvalid_w_inf_inst_1),
   .rready_m_inf_inst_1(rready_w_inf_inst_1),

     .awid_m_inf_inst_1(awid_w_inf_inst_1),
   .awaddr_m_inf_inst_1(awaddr_w_inf_inst_1),
   .awsize_m_inf_inst_1(awsize_w_inf_inst_1),
  .awburst_m_inf_inst_1(awburst_w_inf_inst_1),
    .awlen_m_inf_inst_1(awlen_w_inf_inst_1),
  .awvalid_m_inf_inst_1(awvalid_w_inf_inst_1),
  .awready_m_inf_inst_1(awready_w_inf_inst_1),

    .wdata_m_inf_inst_1(wdata_w_inf_inst_1),
    .wlast_m_inf_inst_1(wlast_w_inf_inst_1),
   .wvalid_m_inf_inst_1(wvalid_w_inf_inst_1),
   .wready_m_inf_inst_1(wready_w_inf_inst_1),

      .bid_m_inf_inst_1(bid_w_inf_inst_1),
    .bresp_m_inf_inst_1(bresp_w_inf_inst_1),
   .bvalid_m_inf_inst_1(bvalid_w_inf_inst_1),
   .bready_m_inf_inst_1(bready_w_inf_inst_1),
//===== AXI-4 Instruction Memory #2 =====
     .arid_m_inf_inst_2(arid_w_inf_inst_2),
   .araddr_m_inf_inst_2(araddr_w_inf_inst_2),
    .arlen_m_inf_inst_2(arlen_w_inf_inst_2),
   .arsize_m_inf_inst_2(arsize_w_inf_inst_2),
  .arburst_m_inf_inst_2(arburst_w_inf_inst_2),
  .arvalid_m_inf_inst_2(arvalid_w_inf_inst_2),
  .arready_m_inf_inst_2(arready_w_inf_inst_2),

      .rid_m_inf_inst_2(rid_w_inf_inst_2),
    .rdata_m_inf_inst_2(rdata_w_inf_inst_2),
    .rresp_m_inf_inst_2(rresp_w_inf_inst_2),
    .rlast_m_inf_inst_2(rlast_w_inf_inst_2),
   .rvalid_m_inf_inst_2(rvalid_w_inf_inst_2),
   .rready_m_inf_inst_2(rready_w_inf_inst_2),

     .awid_m_inf_inst_2(awid_w_inf_inst_2),
   .awaddr_m_inf_inst_2(awaddr_w_inf_inst_2),
   .awsize_m_inf_inst_2(awsize_w_inf_inst_2),
  .awburst_m_inf_inst_2(awburst_w_inf_inst_2),
    .awlen_m_inf_inst_2(awlen_w_inf_inst_2),
  .awvalid_m_inf_inst_2(awvalid_w_inf_inst_2),
  .awready_m_inf_inst_2(awready_w_inf_inst_2),

    .wdata_m_inf_inst_2(wdata_w_inf_inst_2),
    .wlast_m_inf_inst_2(wlast_w_inf_inst_2),
   .wvalid_m_inf_inst_2(wvalid_w_inf_inst_2),
   .wready_m_inf_inst_2(wready_w_inf_inst_2),

      .bid_m_inf_inst_2(bid_w_inf_inst_2),
    .bresp_m_inf_inst_2(bresp_w_inf_inst_2),
   .bvalid_m_inf_inst_2(bvalid_w_inf_inst_2),
   .bready_m_inf_inst_2(bready_w_inf_inst_2),
//===== AXI-4 Data Memory =====
     .arid_m_inf_data(arid_w_inf_data),
   .araddr_m_inf_data(araddr_w_inf_data),
    .arlen_m_inf_data(arlen_w_inf_data),
   .arsize_m_inf_data(arsize_w_inf_data),
  .arburst_m_inf_data(arburst_w_inf_data),
  .arvalid_m_inf_data(arvalid_w_inf_data),
  .arready_m_inf_data(arready_w_inf_data),

      .rid_m_inf_data(rid_w_inf_data),
    .rdata_m_inf_data(rdata_w_inf_data),
    .rresp_m_inf_data(rresp_w_inf_data),
    .rlast_m_inf_data(rlast_w_inf_data),
   .rvalid_m_inf_data(rvalid_w_inf_data),
   .rready_m_inf_data(rready_w_inf_data),

     .awid_m_inf_data(awid_w_inf_data),
   .awaddr_m_inf_data(awaddr_w_inf_data),
   .awsize_m_inf_data(awsize_w_inf_data),
  .awburst_m_inf_data(awburst_w_inf_data),
    .awlen_m_inf_data(awlen_w_inf_data),
  .awvalid_m_inf_data(awvalid_w_inf_data),
  .awready_m_inf_data(awready_w_inf_data),

    .wdata_m_inf_data(wdata_w_inf_data),
    .wlast_m_inf_data(wlast_w_inf_data),
   .wvalid_m_inf_data(wvalid_w_inf_data),
   .wready_m_inf_data(wready_w_inf_data),

      .bid_m_inf_data(bid_w_inf_data),
    .bresp_m_inf_data(bresp_w_inf_data),
   .bvalid_m_inf_data(bvalid_w_inf_data),
   .bready_m_inf_data(bready_w_inf_data)
);
`elsif GATE
  CPU My_CPU(
// Input
    .clk(clk),
  .rst_n(rst_n),
  .interrupt_1(interrupt_1),
  .interrupt_2(interrupt_2),
// Output
  .stall_core1(stall_core1),
  .stall_core2(stall_core2),
//===== AXI-4 Instruction Memory #1 =====
     .arid_m_inf_inst_1(arid_w_inf_inst_1),
   .araddr_m_inf_inst_1(araddr_w_inf_inst_1),
    .arlen_m_inf_inst_1(arlen_w_inf_inst_1),
   .arsize_m_inf_inst_1(arsize_w_inf_inst_1),
  .arburst_m_inf_inst_1(arburst_w_inf_inst_1),
  .arvalid_m_inf_inst_1(arvalid_w_inf_inst_1),
  .arready_m_inf_inst_1(arready_w_inf_inst_1),

      .rid_m_inf_inst_1(rid_w_inf_inst_1),
    .rdata_m_inf_inst_1(rdata_w_inf_inst_1),
    .rresp_m_inf_inst_1(rresp_w_inf_inst_1),
    .rlast_m_inf_inst_1(rlast_w_inf_inst_1),
   .rvalid_m_inf_inst_1(rvalid_w_inf_inst_1),
   .rready_m_inf_inst_1(rready_w_inf_inst_1),

     .awid_m_inf_inst_1(awid_w_inf_inst_1),
   .awaddr_m_inf_inst_1(awaddr_w_inf_inst_1),
   .awsize_m_inf_inst_1(awsize_w_inf_inst_1),
  .awburst_m_inf_inst_1(awburst_w_inf_inst_1),
    .awlen_m_inf_inst_1(awlen_w_inf_inst_1),
  .awvalid_m_inf_inst_1(awvalid_w_inf_inst_1),
  .awready_m_inf_inst_1(awready_w_inf_inst_1),

    .wdata_m_inf_inst_1(wdata_w_inf_inst_1),
    .wlast_m_inf_inst_1(wlast_w_inf_inst_1),
   .wvalid_m_inf_inst_1(wvalid_w_inf_inst_1),
   .wready_m_inf_inst_1(wready_w_inf_inst_1),

      .bid_m_inf_inst_1(bid_w_inf_inst_1),
    .bresp_m_inf_inst_1(bresp_w_inf_inst_1),
   .bvalid_m_inf_inst_1(bvalid_w_inf_inst_1),
   .bready_m_inf_inst_1(bready_w_inf_inst_1),
//===== AXI-4 Instruction Memory #2 =====
     .arid_m_inf_inst_2(arid_w_inf_inst_2),
   .araddr_m_inf_inst_2(araddr_w_inf_inst_2),
    .arlen_m_inf_inst_2(arlen_w_inf_inst_2),
   .arsize_m_inf_inst_2(arsize_w_inf_inst_2),
  .arburst_m_inf_inst_2(arburst_w_inf_inst_2),
  .arvalid_m_inf_inst_2(arvalid_w_inf_inst_2),
  .arready_m_inf_inst_2(arready_w_inf_inst_2),

      .rid_m_inf_inst_2(rid_w_inf_inst_2),
    .rdata_m_inf_inst_2(rdata_w_inf_inst_2),
    .rresp_m_inf_inst_2(rresp_w_inf_inst_2),
    .rlast_m_inf_inst_2(rlast_w_inf_inst_2),
   .rvalid_m_inf_inst_2(rvalid_w_inf_inst_2),
   .rready_m_inf_inst_2(rready_w_inf_inst_2),

     .awid_m_inf_inst_2(awid_w_inf_inst_2),
   .awaddr_m_inf_inst_2(awaddr_w_inf_inst_2),
   .awsize_m_inf_inst_2(awsize_w_inf_inst_2),
  .awburst_m_inf_inst_2(awburst_w_inf_inst_2),
    .awlen_m_inf_inst_2(awlen_w_inf_inst_2),
  .awvalid_m_inf_inst_2(awvalid_w_inf_inst_2),
  .awready_m_inf_inst_2(awready_w_inf_inst_2),

    .wdata_m_inf_inst_2(wdata_w_inf_inst_2),
    .wlast_m_inf_inst_2(wlast_w_inf_inst_2),
   .wvalid_m_inf_inst_2(wvalid_w_inf_inst_2),
   .wready_m_inf_inst_2(wready_w_inf_inst_2),

      .bid_m_inf_inst_2(bid_w_inf_inst_2),
    .bresp_m_inf_inst_2(bresp_w_inf_inst_2),
   .bvalid_m_inf_inst_2(bvalid_w_inf_inst_2),
   .bready_m_inf_inst_2(bready_w_inf_inst_2),
//===== AXI-4 Data Memory =====
     .arid_m_inf_data(arid_w_inf_data),
   .araddr_m_inf_data(araddr_w_inf_data),
    .arlen_m_inf_data(arlen_w_inf_data),
   .arsize_m_inf_data(arsize_w_inf_data),
  .arburst_m_inf_data(arburst_w_inf_data),
  .arvalid_m_inf_data(arvalid_w_inf_data),
  .arready_m_inf_data(arready_w_inf_data),

      .rid_m_inf_data(rid_w_inf_data),
    .rdata_m_inf_data(rdata_w_inf_data),
    .rresp_m_inf_data(rresp_w_inf_data),
    .rlast_m_inf_data(rlast_w_inf_data),
   .rvalid_m_inf_data(rvalid_w_inf_data),
   .rready_m_inf_data(rready_w_inf_data),

     .awid_m_inf_data(awid_w_inf_data),
   .awaddr_m_inf_data(awaddr_w_inf_data),
   .awsize_m_inf_data(awsize_w_inf_data),
  .awburst_m_inf_data(awburst_w_inf_data),
    .awlen_m_inf_data(awlen_w_inf_data),
  .awvalid_m_inf_data(awvalid_w_inf_data),
  .awready_m_inf_data(awready_w_inf_data),

    .wdata_m_inf_data(wdata_w_inf_data),
    .wlast_m_inf_data(wlast_w_inf_data),
   .wvalid_m_inf_data(wvalid_w_inf_data),
   .wready_m_inf_data(wready_w_inf_data),

      .bid_m_inf_data(bid_w_inf_data),
    .bresp_m_inf_data(bresp_w_inf_data),
   .bvalid_m_inf_data(bvalid_w_inf_data),
   .bready_m_inf_data(bready_w_inf_data)
);
`elsif CHIP
  CHIP My_CHIP(
// Input
    .clk(clk),
  .rst_n(rst_n),
  .interrupt_1(interrupt_1),
  .interrupt_2(interrupt_2),
// Output
  .stall_core1(stall_core1),
  .stall_core2(stall_core2),
//===== AXI-4 Instruction Memory #1 =====
     .arid_m_inf_inst_1(arid_w_inf_inst_1),
   .araddr_m_inf_inst_1(araddr_w_inf_inst_1),
    .arlen_m_inf_inst_1(arlen_w_inf_inst_1),
   .arsize_m_inf_inst_1(arsize_w_inf_inst_1),
  .arburst_m_inf_inst_1(arburst_w_inf_inst_1),
  .arvalid_m_inf_inst_1(arvalid_w_inf_inst_1),
  .arready_m_inf_inst_1(arready_w_inf_inst_1),

      .rid_m_inf_inst_1(rid_w_inf_inst_1),
    .rdata_m_inf_inst_1(rdata_w_inf_inst_1),
    .rresp_m_inf_inst_1(rresp_w_inf_inst_1),
    .rlast_m_inf_inst_1(rlast_w_inf_inst_1),
   .rvalid_m_inf_inst_1(rvalid_w_inf_inst_1),
   .rready_m_inf_inst_1(rready_w_inf_inst_1),

     .awid_m_inf_inst_1(awid_w_inf_inst_1),
   .awaddr_m_inf_inst_1(awaddr_w_inf_inst_1),
   .awsize_m_inf_inst_1(awsize_w_inf_inst_1),
  .awburst_m_inf_inst_1(awburst_w_inf_inst_1),
    .awlen_m_inf_inst_1(awlen_w_inf_inst_1),
  .awvalid_m_inf_inst_1(awvalid_w_inf_inst_1),
  .awready_m_inf_inst_1(awready_w_inf_inst_1),

    .wdata_m_inf_inst_1(wdata_w_inf_inst_1),
    .wlast_m_inf_inst_1(wlast_w_inf_inst_1),
   .wvalid_m_inf_inst_1(wvalid_w_inf_inst_1),
   .wready_m_inf_inst_1(wready_w_inf_inst_1),

      .bid_m_inf_inst_1(bid_w_inf_inst_1),
    .bresp_m_inf_inst_1(bresp_w_inf_inst_1),
   .bvalid_m_inf_inst_1(bvalid_w_inf_inst_1),
   .bready_m_inf_inst_1(bready_w_inf_inst_1),
//===== AXI-4 Instruction Memory #2 =====
     .arid_m_inf_inst_2(arid_w_inf_inst_2),
   .araddr_m_inf_inst_2(araddr_w_inf_inst_2),
    .arlen_m_inf_inst_2(arlen_w_inf_inst_2),
   .arsize_m_inf_inst_2(arsize_w_inf_inst_2),
  .arburst_m_inf_inst_2(arburst_w_inf_inst_2),
  .arvalid_m_inf_inst_2(arvalid_w_inf_inst_2),
  .arready_m_inf_inst_2(arready_w_inf_inst_2),

      .rid_m_inf_inst_2(rid_w_inf_inst_2),
    .rdata_m_inf_inst_2(rdata_w_inf_inst_2),
    .rresp_m_inf_inst_2(rresp_w_inf_inst_2),
    .rlast_m_inf_inst_2(rlast_w_inf_inst_2),
   .rvalid_m_inf_inst_2(rvalid_w_inf_inst_2),
   .rready_m_inf_inst_2(rready_w_inf_inst_2),

     .awid_m_inf_inst_2(awid_w_inf_inst_2),
   .awaddr_m_inf_inst_2(awaddr_w_inf_inst_2),
   .awsize_m_inf_inst_2(awsize_w_inf_inst_2),
  .awburst_m_inf_inst_2(awburst_w_inf_inst_2),
    .awlen_m_inf_inst_2(awlen_w_inf_inst_2),
  .awvalid_m_inf_inst_2(awvalid_w_inf_inst_2),
  .awready_m_inf_inst_2(awready_w_inf_inst_2),

    .wdata_m_inf_inst_2(wdata_w_inf_inst_2),
    .wlast_m_inf_inst_2(wlast_w_inf_inst_2),
   .wvalid_m_inf_inst_2(wvalid_w_inf_inst_2),
   .wready_m_inf_inst_2(wready_w_inf_inst_2),

      .bid_m_inf_inst_2(bid_w_inf_inst_2),
    .bresp_m_inf_inst_2(bresp_w_inf_inst_2),
   .bvalid_m_inf_inst_2(bvalid_w_inf_inst_2),
   .bready_m_inf_inst_2(bready_w_inf_inst_2),
//===== AXI-4 Data Memory =====
     .arid_m_inf_data(arid_w_inf_data),
   .araddr_m_inf_data(araddr_w_inf_data),
    .arlen_m_inf_data(arlen_w_inf_data),
   .arsize_m_inf_data(arsize_w_inf_data),
  .arburst_m_inf_data(arburst_w_inf_data),
  .arvalid_m_inf_data(arvalid_w_inf_data),
  .arready_m_inf_data(arready_w_inf_data),

      .rid_m_inf_data(rid_w_inf_data),
    .rdata_m_inf_data(rdata_w_inf_data),
    .rresp_m_inf_data(rresp_w_inf_data),
    .rlast_m_inf_data(rlast_w_inf_data),
   .rvalid_m_inf_data(rvalid_w_inf_data),
   .rready_m_inf_data(rready_w_inf_data),

     .awid_m_inf_data(awid_w_inf_data),
   .awaddr_m_inf_data(awaddr_w_inf_data),
   .awsize_m_inf_data(awsize_w_inf_data),
  .awburst_m_inf_data(awburst_w_inf_data),
    .awlen_m_inf_data(awlen_w_inf_data),
  .awvalid_m_inf_data(awvalid_w_inf_data),
  .awready_m_inf_data(awready_w_inf_data),

    .wdata_m_inf_data(wdata_w_inf_data),
    .wlast_m_inf_data(wlast_w_inf_data),
   .wvalid_m_inf_data(wvalid_w_inf_data),
   .wready_m_inf_data(wready_w_inf_data),

      .bid_m_inf_data(bid_w_inf_data),
    .bresp_m_inf_data(bresp_w_inf_data),
   .bvalid_m_inf_data(bvalid_w_inf_data),
   .bready_m_inf_data(bready_w_inf_data)
);
`elsif POST
  CHIP My_CHIP(
// Input
    .clk(clk),
  .rst_n(rst_n),
  .interrupt_1(interrupt_1),
  .interrupt_2(interrupt_2),
// Output
  .stall_core1(stall_core1),
  .stall_core2(stall_core2),
//===== AXI-4 Instruction Memory #1 =====
     .arid_m_inf_inst_1(arid_w_inf_inst_1),
   .araddr_m_inf_inst_1(araddr_w_inf_inst_1),
    .arlen_m_inf_inst_1(arlen_w_inf_inst_1),
   .arsize_m_inf_inst_1(arsize_w_inf_inst_1),
  .arburst_m_inf_inst_1(arburst_w_inf_inst_1),
  .arvalid_m_inf_inst_1(arvalid_w_inf_inst_1),
  .arready_m_inf_inst_1(arready_w_inf_inst_1),

      .rid_m_inf_inst_1(rid_w_inf_inst_1),
    .rdata_m_inf_inst_1(rdata_w_inf_inst_1),
    .rresp_m_inf_inst_1(rresp_w_inf_inst_1),
    .rlast_m_inf_inst_1(rlast_w_inf_inst_1),
   .rvalid_m_inf_inst_1(rvalid_w_inf_inst_1),
   .rready_m_inf_inst_1(rready_w_inf_inst_1),

     .awid_m_inf_inst_1(awid_w_inf_inst_1),
   .awaddr_m_inf_inst_1(awaddr_w_inf_inst_1),
   .awsize_m_inf_inst_1(awsize_w_inf_inst_1),
  .awburst_m_inf_inst_1(awburst_w_inf_inst_1),
    .awlen_m_inf_inst_1(awlen_w_inf_inst_1),
  .awvalid_m_inf_inst_1(awvalid_w_inf_inst_1),
  .awready_m_inf_inst_1(awready_w_inf_inst_1),

    .wdata_m_inf_inst_1(wdata_w_inf_inst_1),
    .wlast_m_inf_inst_1(wlast_w_inf_inst_1),
   .wvalid_m_inf_inst_1(wvalid_w_inf_inst_1),
   .wready_m_inf_inst_1(wready_w_inf_inst_1),

      .bid_m_inf_inst_1(bid_w_inf_inst_1),
    .bresp_m_inf_inst_1(bresp_w_inf_inst_1),
   .bvalid_m_inf_inst_1(bvalid_w_inf_inst_1),
   .bready_m_inf_inst_1(bready_w_inf_inst_1),
//===== AXI-4 Instruction Memory #2 =====
     .arid_m_inf_inst_2(arid_w_inf_inst_2),
   .araddr_m_inf_inst_2(araddr_w_inf_inst_2),
    .arlen_m_inf_inst_2(arlen_w_inf_inst_2),
   .arsize_m_inf_inst_2(arsize_w_inf_inst_2),
  .arburst_m_inf_inst_2(arburst_w_inf_inst_2),
  .arvalid_m_inf_inst_2(arvalid_w_inf_inst_2),
  .arready_m_inf_inst_2(arready_w_inf_inst_2),

      .rid_m_inf_inst_2(rid_w_inf_inst_2),
    .rdata_m_inf_inst_2(rdata_w_inf_inst_2),
    .rresp_m_inf_inst_2(rresp_w_inf_inst_2),
    .rlast_m_inf_inst_2(rlast_w_inf_inst_2),
   .rvalid_m_inf_inst_2(rvalid_w_inf_inst_2),
   .rready_m_inf_inst_2(rready_w_inf_inst_2),

     .awid_m_inf_inst_2(awid_w_inf_inst_2),
   .awaddr_m_inf_inst_2(awaddr_w_inf_inst_2),
   .awsize_m_inf_inst_2(awsize_w_inf_inst_2),
  .awburst_m_inf_inst_2(awburst_w_inf_inst_2),
    .awlen_m_inf_inst_2(awlen_w_inf_inst_2),
  .awvalid_m_inf_inst_2(awvalid_w_inf_inst_2),
  .awready_m_inf_inst_2(awready_w_inf_inst_2),

    .wdata_m_inf_inst_2(wdata_w_inf_inst_2),
    .wlast_m_inf_inst_2(wlast_w_inf_inst_2),
   .wvalid_m_inf_inst_2(wvalid_w_inf_inst_2),
   .wready_m_inf_inst_2(wready_w_inf_inst_2),

      .bid_m_inf_inst_2(bid_w_inf_inst_2),
    .bresp_m_inf_inst_2(bresp_w_inf_inst_2),
   .bvalid_m_inf_inst_2(bvalid_w_inf_inst_2),
   .bready_m_inf_inst_2(bready_w_inf_inst_2),
//===== AXI-4 Data Memory =====
     .arid_m_inf_data(arid_w_inf_data),
   .araddr_m_inf_data(araddr_w_inf_data),
    .arlen_m_inf_data(arlen_w_inf_data),
   .arsize_m_inf_data(arsize_w_inf_data),
  .arburst_m_inf_data(arburst_w_inf_data),
  .arvalid_m_inf_data(arvalid_w_inf_data),
  .arready_m_inf_data(arready_w_inf_data),

      .rid_m_inf_data(rid_w_inf_data),
    .rdata_m_inf_data(rdata_w_inf_data),
    .rresp_m_inf_data(rresp_w_inf_data),
    .rlast_m_inf_data(rlast_w_inf_data),
   .rvalid_m_inf_data(rvalid_w_inf_data),
   .rready_m_inf_data(rready_w_inf_data),

     .awid_m_inf_data(awid_w_inf_data),
   .awaddr_m_inf_data(awaddr_w_inf_data),
   .awsize_m_inf_data(awsize_w_inf_data),
  .awburst_m_inf_data(awburst_w_inf_data),
    .awlen_m_inf_data(awlen_w_inf_data),
  .awvalid_m_inf_data(awvalid_w_inf_data),
  .awready_m_inf_data(awready_w_inf_data),

    .wdata_m_inf_data(wdata_w_inf_data),
    .wlast_m_inf_data(wlast_w_inf_data),
   .wvalid_m_inf_data(wvalid_w_inf_data),
   .wready_m_inf_data(wready_w_inf_data),

      .bid_m_inf_data(bid_w_inf_data),
    .bresp_m_inf_data(bresp_w_inf_data),
   .bvalid_m_inf_data(bvalid_w_inf_data),
   .bready_m_inf_data(bready_w_inf_data)
);
`endif

    PATTERN u_PATTERN(
// Input
    .clk(clk),
  .rst_n(rst_n),
  .interrupt_1(interrupt_1),
  .interrupt_2(interrupt_2),
// Output
  .stall_core1(stall_core1),
  .stall_core2(stall_core2),
  /*.core_1_r0(My_CPU.core_1_r0),
  .core_1_r1(My_CPU.core_1_r1),
  .core_1_r2(My_CPU.core_1_r2),
  .core_1_r3(My_CPU.core_1_r3),
  .core_1_r4(My_CPU.core_1_r4),
  .core_1_r5(My_CPU.core_1_r5),
  .core_1_r6(My_CPU.core_1_r6),
  .core_1_r7(My_CPU.core_1_r7),
  .core_2_r0(My_CPU.core_2_r0),
  .core_2_r1(My_CPU.core_2_r1),
  .core_2_r2(My_CPU.core_2_r2),
  .core_2_r3(My_CPU.core_2_r3),
  .core_2_r4(My_CPU.core_2_r4),
  .core_2_r5(My_CPU.core_2_r5),
  .core_2_r6(My_CPU.core_2_r6),
  .core_2_r7(My_CPU.core_2_r7),*/
//===== AXI-4 Instruction Memory #1 =====
     .arid_s_inf_inst_1(arid_w_inf_inst_1),
   .araddr_s_inf_inst_1(araddr_w_inf_inst_1),
    .arlen_s_inf_inst_1(arlen_w_inf_inst_1),
   .arsize_s_inf_inst_1(arsize_w_inf_inst_1),
  .arburst_s_inf_inst_1(arburst_w_inf_inst_1),
  .arvalid_s_inf_inst_1(arvalid_w_inf_inst_1),
  .arready_s_inf_inst_1(arready_w_inf_inst_1),

      .rid_s_inf_inst_1(rid_w_inf_inst_1),
    .rdata_s_inf_inst_1(rdata_w_inf_inst_1),
    .rresp_s_inf_inst_1(rresp_w_inf_inst_1),
    .rlast_s_inf_inst_1(rlast_w_inf_inst_1),
   .rvalid_s_inf_inst_1(rvalid_w_inf_inst_1),
   .rready_s_inf_inst_1(rready_w_inf_inst_1),

     .awid_s_inf_inst_1(awid_w_inf_inst_1),
   .awaddr_s_inf_inst_1(awaddr_w_inf_inst_1),
   .awsize_s_inf_inst_1(awsize_w_inf_inst_1),
  .awburst_s_inf_inst_1(awburst_w_inf_inst_1),
    .awlen_s_inf_inst_1(awlen_w_inf_inst_1),
  .awvalid_s_inf_inst_1(awvalid_w_inf_inst_1),
  .awready_s_inf_inst_1(awready_w_inf_inst_1),

    .wdata_s_inf_inst_1(wdata_w_inf_inst_1),
    .wlast_s_inf_inst_1(wlast_w_inf_inst_1),
   .wvalid_s_inf_inst_1(wvalid_w_inf_inst_1),
   .wready_s_inf_inst_1(wready_w_inf_inst_1),

      .bid_s_inf_inst_1(bid_w_inf_inst_1),
    .bresp_s_inf_inst_1(bresp_w_inf_inst_1),
   .bvalid_s_inf_inst_1(bvalid_w_inf_inst_1),
   .bready_s_inf_inst_1(bready_w_inf_inst_1),
//===== AXI-4 Instruction Memory #2 =====
     .arid_s_inf_inst_2(arid_w_inf_inst_2),
   .araddr_s_inf_inst_2(araddr_w_inf_inst_2),
    .arlen_s_inf_inst_2(arlen_w_inf_inst_2),
   .arsize_s_inf_inst_2(arsize_w_inf_inst_2),
  .arburst_s_inf_inst_2(arburst_w_inf_inst_2),
  .arvalid_s_inf_inst_2(arvalid_w_inf_inst_2),
  .arready_s_inf_inst_2(arready_w_inf_inst_2),

      .rid_s_inf_inst_2(rid_w_inf_inst_2),
    .rdata_s_inf_inst_2(rdata_w_inf_inst_2),
    .rresp_s_inf_inst_2(rresp_w_inf_inst_2),
    .rlast_s_inf_inst_2(rlast_w_inf_inst_2),
   .rvalid_s_inf_inst_2(rvalid_w_inf_inst_2),
   .rready_s_inf_inst_2(rready_w_inf_inst_2),

     .awid_s_inf_inst_2(awid_w_inf_inst_2),
   .awaddr_s_inf_inst_2(awaddr_w_inf_inst_2),
   .awsize_s_inf_inst_2(awsize_w_inf_inst_2),
  .awburst_s_inf_inst_2(awburst_w_inf_inst_2),
    .awlen_s_inf_inst_2(awlen_w_inf_inst_2),
  .awvalid_s_inf_inst_2(awvalid_w_inf_inst_2),
  .awready_s_inf_inst_2(awready_w_inf_inst_2),

    .wdata_s_inf_inst_2(wdata_w_inf_inst_2),
    .wlast_s_inf_inst_2(wlast_w_inf_inst_2),
   .wvalid_s_inf_inst_2(wvalid_w_inf_inst_2),
   .wready_s_inf_inst_2(wready_w_inf_inst_2),

      .bid_s_inf_inst_2(bid_w_inf_inst_2),
    .bresp_s_inf_inst_2(bresp_w_inf_inst_2),
   .bvalid_s_inf_inst_2(bvalid_w_inf_inst_2),
   .bready_s_inf_inst_2(bready_w_inf_inst_2),
//===== AXI-4 Data Memory =====
     .arid_s_inf_data(arid_w_inf_data),
   .araddr_s_inf_data(araddr_w_inf_data),
    .arlen_s_inf_data(arlen_w_inf_data),
   .arsize_s_inf_data(arsize_w_inf_data),
  .arburst_s_inf_data(arburst_w_inf_data),
  .arvalid_s_inf_data(arvalid_w_inf_data),
  .arready_s_inf_data(arready_w_inf_data),

      .rid_s_inf_data(rid_w_inf_data),
    .rdata_s_inf_data(rdata_w_inf_data),
    .rresp_s_inf_data(rresp_w_inf_data),
    .rlast_s_inf_data(rlast_w_inf_data),
   .rvalid_s_inf_data(rvalid_w_inf_data),
   .rready_s_inf_data(rready_w_inf_data),

     .awid_s_inf_data(awid_w_inf_data),
   .awaddr_s_inf_data(awaddr_w_inf_data),
   .awsize_s_inf_data(awsize_w_inf_data),
  .awburst_s_inf_data(awburst_w_inf_data),
    .awlen_s_inf_data(awlen_w_inf_data),
  .awvalid_s_inf_data(awvalid_w_inf_data),
  .awready_s_inf_data(awready_w_inf_data),

    .wdata_s_inf_data(wdata_w_inf_data),
    .wlast_s_inf_data(wlast_w_inf_data),
   .wvalid_s_inf_data(wvalid_w_inf_data),
   .wready_s_inf_data(wready_w_inf_data),

      .bid_s_inf_data(bid_w_inf_data),
    .bresp_s_inf_data(bresp_w_inf_data),
   .bvalid_s_inf_data(bvalid_w_inf_data),
   .bready_s_inf_data(bready_w_inf_data)
);

integer complete;

always@(posedge clk,negedge rst_n)
begin
	if(!rst_n)
		complete<=0;
	else if(stall_core1==0)
		complete<=complete+1;
end
/*
always@(*)
begin
	if(complete>50)begin
		$display ("--------------------------------------------------------------------");
		$display ("                         Congratulations!                           ");
		$display ("                  You have passed all patterns!                     ");
		$display ("--------------------------------------------------------------------");
		repeat(2)@(negedge clk);
		$finish;
	end
end
*/
`ifdef RTL
always @ ( negedge clk ) begin
    if( stall_core1==0 && interrupt_1==0) begin
    // check cpu 1 reg
        if (	(u_PATTERN.REG[0][0] != My_CPU.core_1_r0)||(u_PATTERN.REG[0][1] != My_CPU.core_1_r1)||(u_PATTERN.REG[0][2] != My_CPU.core_1_r2)||(u_PATTERN.REG[0][3] != My_CPU.core_1_r3)||
                (u_PATTERN.REG[0][4] != My_CPU.core_1_r4)||(u_PATTERN.REG[0][5] != My_CPU.core_1_r5)||(u_PATTERN.REG[0][6] != My_CPU.core_1_r6)||(u_PATTERN.REG[0][7] != My_CPU.core_1_r7)	)
        begin
            $display ("--------------------------------------------------------------------");
            $display ("                         Error in CPU 1!     ");
			$display ("                         	No. %4d cycle   ",u_PATTERN.inst_1_cnt);
            $display ("                                             ");
			$display ("                           ANS           YOURS    ");
            $display ("                  r0       %h         %h     ",u_PATTERN.REG[0][0],My_CPU.core_1_r0);
            $display ("                  r1       %h         %h     ",u_PATTERN.REG[0][1],My_CPU.core_1_r1);
            $display ("                  r2       %h         %h     ",u_PATTERN.REG[0][2],My_CPU.core_1_r2);
            $display ("                  r3       %h         %h     ",u_PATTERN.REG[0][3],My_CPU.core_1_r3);
            $display ("                  r4       %h         %h     ",u_PATTERN.REG[0][4],My_CPU.core_1_r4);
            $display ("                  r5       %h         %h     ",u_PATTERN.REG[0][5],My_CPU.core_1_r5);
            $display ("                  r6       %h         %h     ",u_PATTERN.REG[0][6],My_CPU.core_1_r6);
            $display ("                  r7       %h         %h     ",u_PATTERN.REG[0][7],My_CPU.core_1_r7);
            $display ("                                             ");
			$display ("                              at  %8d        ",$time);
			$display ("--------------------------------------------------------------------");
            repeat(3)@(negedge clk);
            $finish;
        end
		$display("\033[0;34mPASS PATTERN NO.%4d,\033[m \033[0;32mexecution CPU : 1\033[m", complete);
		$display ("                           ANS           YOURS    ");
        $display ("                  r0       %h         %h     ",u_PATTERN.REG[0][0],My_CPU.core_1_r0);
        $display ("                  r1       %h         %h     ",u_PATTERN.REG[0][1],My_CPU.core_1_r1);
        $display ("                  r2       %h         %h     ",u_PATTERN.REG[0][2],My_CPU.core_1_r2);
        $display ("                  r3       %h         %h     ",u_PATTERN.REG[0][3],My_CPU.core_1_r3);
        $display ("                  r4       %h         %h     ",u_PATTERN.REG[0][4],My_CPU.core_1_r4);
        $display ("                  r5       %h         %h     ",u_PATTERN.REG[0][5],My_CPU.core_1_r5);
        $display ("                  r6       %h         %h     ",u_PATTERN.REG[0][6],My_CPU.core_1_r6);
        $display ("                  r7       %h         %h     ",u_PATTERN.REG[0][7],My_CPU.core_1_r7);
        $display("\033[0;34m --------------------------------------------------\033[m  " );
    end
    if( stall_core2==0  && interrupt_2==0) begin
    // check cpu 2 reg
        if (	(u_PATTERN.REG[3][0] != My_CPU.core_2_r0)||(u_PATTERN.REG[3][1] != My_CPU.core_2_r1)||(u_PATTERN.REG[3][2] != My_CPU.core_2_r2)||(u_PATTERN.REG[3][3] != My_CPU.core_2_r3)||
                (u_PATTERN.REG[3][4] != My_CPU.core_2_r4)||(u_PATTERN.REG[3][5] != My_CPU.core_2_r5)||(u_PATTERN.REG[3][6] != My_CPU.core_2_r6)||(u_PATTERN.REG[3][7] != My_CPU.core_2_r7)	)
        begin
			$display ("--------------------------------------------------------------------");
            $display ("                         Error in CPU 2!     ");
			$display ("                         	No. %4d cycle   ",u_PATTERN.inst_2_cnt);
            $display ("                           ANS           YOURS    ");
            $display ("                  r0       %h         %h     ",u_PATTERN.REG[3][0],My_CPU.core_2_r0);
            $display ("                  r1       %h         %h     ",u_PATTERN.REG[3][1],My_CPU.core_2_r1);
            $display ("                  r2       %h         %h     ",u_PATTERN.REG[3][2],My_CPU.core_2_r2);
            $display ("                  r3       %h         %h     ",u_PATTERN.REG[3][3],My_CPU.core_2_r3);
            $display ("                  r4       %h         %h     ",u_PATTERN.REG[3][4],My_CPU.core_2_r4);
            $display ("                  r5       %h         %h     ",u_PATTERN.REG[3][5],My_CPU.core_2_r5);
            $display ("                  r6       %h         %h     ",u_PATTERN.REG[3][6],My_CPU.core_2_r6);
            $display ("                  r7       %h         %h     ",u_PATTERN.REG[3][7],My_CPU.core_2_r7);
            $display ("--------------------------------------------------------------------");
            repeat(3)@(negedge clk);
            $finish;
        end
		$display("\033[0;34mPASS PATTERN NO.%4d,\033[m \033[0;32mexecution CPU : 2\033[m", complete);
		$display ("                           ANS           YOURS    ");
        $display ("                  r0       %h         %h     ",u_PATTERN.REG[3][0],My_CPU.core_2_r0);
        $display ("                  r1       %h         %h     ",u_PATTERN.REG[3][1],My_CPU.core_2_r1);
        $display ("                  r2       %h         %h     ",u_PATTERN.REG[3][2],My_CPU.core_2_r2);
        $display ("                  r3       %h         %h     ",u_PATTERN.REG[3][3],My_CPU.core_2_r3);
        $display ("                  r4       %h         %h     ",u_PATTERN.REG[3][4],My_CPU.core_2_r4);
        $display ("                  r5       %h         %h     ",u_PATTERN.REG[3][5],My_CPU.core_2_r5);
        $display ("                  r6       %h         %h     ",u_PATTERN.REG[3][6],My_CPU.core_2_r6);
        $display ("                  r7       %h         %h     ",u_PATTERN.REG[3][7],My_CPU.core_2_r7);
        $display("\033[0;34m --------------------------------------------------\033[m  " );
    end

end
`endif
endmodule
