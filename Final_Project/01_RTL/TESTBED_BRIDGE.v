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
`include "PATTERN_BRIDGE.v"
`include "../04_MEM/SRAM256W16B.v"
//`include "../04_MEM/SRAM128W16B.v"
`include "../01_RTL/INST_BRIDGE.v"
`include "../01_RTL/DATA_BRIDGE.v"
`include "../01_RTL/INST_CONTROLLER.v"
`include "../01_RTL/DATA_CONTROLLER.sv"

module TESTBED();
parameter ID_WIDTH = 4 , ADDR_WIDTH = 32, DATA_WIDTH = 16;
//Connection wires
wire clk, rst_n, interrupt_1, interrupt_2;
wire stall_core1, stall_core2;

// single port inst control
wire ci_1_i_valid;
wire [13-1:0] ci_1_i_addr;
wire ci_1_o_valid;
wire [16-1:0] ci_1_o_data;
wire ci_2_i_valid;
wire [13-1:0] ci_2_i_addr;
wire ci_2_o_valid;
wire [16-1:0] ci_2_o_data;
// dual port data controll
wire i_valid_1;
wire [16-1:0] i_data_1;
wire [13-1:0] i_addr_1;
wire i_rw_1;
wire o_valid_1;
wire [16-1:0] o_data_1;
wire i_valid_2;
wire [16-1:0] i_data_2;
wire [13-1:0] i_addr_2;
wire i_rw_2;
wire o_valid_2;
wire [16-1:0] o_data_2;
// special
wire i_interrupt;
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
    $fsdbDumpfile("CPU2.fsdb");
    $fsdbDumpvars(0,"+mda");
  `elsif GATE
    $sdf_annotate("CPU_SYN.sdf",My_CPU);
    // $fsdbDumpfile("CPU_SYN.fsdb");
    //$fsdbDumpvars(0,"+mda");
  `elsif CHIP
    //$fsdbDumpfile("CHIP_SYN.fsdb");
    //$fsdbDumpvars(0,"+mda");
  `elsif POST
    $sdf_annotate("CHIP.sdf",My_CHIP);
    //$fsdbDumpfile("CHIP_POST.fsdb");
    //$fsdbDumpvars(0,"+mda");
  `endif
end

`ifdef RTL
  INST_CONTROLLER ci_1(
// Input
    .clk(clk),
  .rst_n(rst_n),
 // controll signal for only read mode
  .i_valid(ci_1_i_valid),
  .i_addr(ci_1_i_addr),
  .o_valid(ci_1_o_valid),
  .o_data(ci_1_o_data),
//===== AXI-4 Instruction Memory #1 =====
     .arid_m_inf_inst(arid_w_inf_inst_1),
   .araddr_m_inf_inst(araddr_w_inf_inst_1),
    .arlen_m_inf_inst(arlen_w_inf_inst_1),
   .arsize_m_inf_inst(arsize_w_inf_inst_1),
  .arburst_m_inf_inst(arburst_w_inf_inst_1),
  .arvalid_m_inf_inst(arvalid_w_inf_inst_1),
  .arready_m_inf_inst(arready_w_inf_inst_1),

      .rid_m_inf_inst(rid_w_inf_inst_1),
    .rdata_m_inf_inst(rdata_w_inf_inst_1),
    .rresp_m_inf_inst(rresp_w_inf_inst_1),
    .rlast_m_inf_inst(rlast_w_inf_inst_1),
   .rvalid_m_inf_inst(rvalid_w_inf_inst_1),
   .rready_m_inf_inst(rready_w_inf_inst_1),

     .awid_m_inf_inst(awid_w_inf_inst_1),
   .awaddr_m_inf_inst(awaddr_w_inf_inst_1),
   .awsize_m_inf_inst(awsize_w_inf_inst_1),
  .awburst_m_inf_inst(awburst_w_inf_inst_1),
    .awlen_m_inf_inst(awlen_w_inf_inst_1),
  .awvalid_m_inf_inst(awvalid_w_inf_inst_1),
  .awready_m_inf_inst(awready_w_inf_inst_1),

    .wdata_m_inf_inst(wdata_w_inf_inst_1),
    .wlast_m_inf_inst(wlast_w_inf_inst_1),
   .wvalid_m_inf_inst(wvalid_w_inf_inst_1),
   .wready_m_inf_inst(wready_w_inf_inst_1),

      .bid_m_inf_inst(bid_w_inf_inst_1),
    .bresp_m_inf_inst(bresp_w_inf_inst_1),
   .bvalid_m_inf_inst(bvalid_w_inf_inst_1),
   .bready_m_inf_inst(bready_w_inf_inst_1)
 );
   INST_CONTROLLER ci_2(
 // Input
     .clk(clk),
   .rst_n(rst_n),
  // controll signal for only read mode
   .i_valid(ci_2_i_valid),
   .i_addr(ci_2_i_addr),
   .o_valid(ci_2_o_valid),
   .o_data(ci_2_o_data),
//===== AXI-4 Instruction Memory #2 =====
     .arid_m_inf_inst(arid_w_inf_inst_2),
   .araddr_m_inf_inst(araddr_w_inf_inst_2),
    .arlen_m_inf_inst(arlen_w_inf_inst_2),
   .arsize_m_inf_inst(arsize_w_inf_inst_2),
  .arburst_m_inf_inst(arburst_w_inf_inst_2),
  .arvalid_m_inf_inst(arvalid_w_inf_inst_2),
  .arready_m_inf_inst(arready_w_inf_inst_2),

      .rid_m_inf_inst(rid_w_inf_inst_2),
    .rdata_m_inf_inst(rdata_w_inf_inst_2),
    .rresp_m_inf_inst(rresp_w_inf_inst_2),
    .rlast_m_inf_inst(rlast_w_inf_inst_2),
   .rvalid_m_inf_inst(rvalid_w_inf_inst_2),
   .rready_m_inf_inst(rready_w_inf_inst_2),

     .awid_m_inf_inst(awid_w_inf_inst_2),
   .awaddr_m_inf_inst(awaddr_w_inf_inst_2),
   .awsize_m_inf_inst(awsize_w_inf_inst_2),
  .awburst_m_inf_inst(awburst_w_inf_inst_2),
    .awlen_m_inf_inst(awlen_w_inf_inst_2),
  .awvalid_m_inf_inst(awvalid_w_inf_inst_2),
  .awready_m_inf_inst(awready_w_inf_inst_2),

    .wdata_m_inf_inst(wdata_w_inf_inst_2),
    .wlast_m_inf_inst(wlast_w_inf_inst_2),
   .wvalid_m_inf_inst(wvalid_w_inf_inst_2),
   .wready_m_inf_inst(wready_w_inf_inst_2),

      .bid_m_inf_inst(bid_w_inf_inst_2),
    .bresp_m_inf_inst(bresp_w_inf_inst_2),
   .bvalid_m_inf_inst(bvalid_w_inf_inst_2),
   .bready_m_inf_inst(bready_w_inf_inst_2)
  );
 DATA_CONTROLLER cd(
// Input
        .clk(clk),
      .rst_n(rst_n),
// controll signal for read/write mode
      .i_valid_1(i_valid_1),
      .i_data_1(i_data_1),
      .i_addr_1(i_addr_1),
      .i_rw_1(i_rw_1),
      .o_valid_1(o_valid_1),
      .o_data_1(o_data_1),
      .i_valid_2(i_valid_2),
      .i_data_2(i_data_2),
      .i_addr_2(i_addr_2),
      .i_rw_2(i_rw_2),
      .o_valid_2(o_valid_2),
      .o_data_2(o_data_2),
      .i_interrupt(i_interrupt),
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
// single port inst control
  .inst_1_i_valid(ci_1_i_valid),
  .inst_1_i_addr(ci_1_i_addr),
  .inst_1_o_valid(ci_1_o_valid),
  .inst_1_o_data(ci_1_o_data),
  .inst_2_i_valid(ci_2_i_valid),
  .inst_2_i_addr(ci_2_i_addr),
  .inst_2_o_valid(ci_2_o_valid),
  .inst_2_o_data(ci_2_o_data),
// dual port data controll
  .data_1_i_valid(i_valid_1),
  .data_1_i_data(i_data_1),
  .data_1_i_addr(i_addr_1),
  .data_1_i_rw(i_rw_1),
  .data_1_o_valid(o_valid_1),
  .data_1_o_data(o_data_1),
  .data_2_i_valid(i_valid_2),
  .data_2_i_data(i_data_2),
  .data_2_i_addr(i_addr_2),
  .data_2_i_rw(i_rw_2),
  .data_2_o_valid(o_valid_2),
  .data_2_o_data(o_data_2),
  .data_i_interrupt(i_interrupt),
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

endmodule
