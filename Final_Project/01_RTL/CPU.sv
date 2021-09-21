//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory System Integration and Silicon Implementation
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   ICLAB 2019 Final Project: Customized ISA Processor
//   Author              : Yun-Sheng Chan
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : CPU.v
//   Module Name : CPU.v
//   Release version : V1.0 (Release Date: 2019-Dec)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################
//synopsys translate_off
`include "../04_MEM/SRAM256W16B.v"
`include "../01_RTL/DATA_CONTROLLER.sv"
//synopsys translate_on
module CPU(
// Input
  clk,
  rst_n,
  interrupt_1,
  interrupt_2,
// Output
  stall_core1,
  stall_core2,
//===== AXI-4 Instruction Memory #1 =====
     arid_m_inf_inst_1,
   araddr_m_inf_inst_1,
    arlen_m_inf_inst_1,
   arsize_m_inf_inst_1,
  arburst_m_inf_inst_1,
  arvalid_m_inf_inst_1,
  arready_m_inf_inst_1,

      rid_m_inf_inst_1,
    rdata_m_inf_inst_1,
    rresp_m_inf_inst_1,
    rlast_m_inf_inst_1,
   rvalid_m_inf_inst_1,
   rready_m_inf_inst_1,

     awid_m_inf_inst_1,
   awaddr_m_inf_inst_1,
   awsize_m_inf_inst_1,
  awburst_m_inf_inst_1,
    awlen_m_inf_inst_1,
  awvalid_m_inf_inst_1,
  awready_m_inf_inst_1,

    wdata_m_inf_inst_1,
    wlast_m_inf_inst_1,
   wvalid_m_inf_inst_1,
   wready_m_inf_inst_1,

      bid_m_inf_inst_1,
    bresp_m_inf_inst_1,
   bvalid_m_inf_inst_1,
   bready_m_inf_inst_1,
//===== AXI-4 Instruction Memory #2 =====
     arid_m_inf_inst_2,
   araddr_m_inf_inst_2,
    arlen_m_inf_inst_2,
   arsize_m_inf_inst_2,
  arburst_m_inf_inst_2,
  arvalid_m_inf_inst_2,
  arready_m_inf_inst_2,

      rid_m_inf_inst_2,
    rdata_m_inf_inst_2,
    rresp_m_inf_inst_2,
    rlast_m_inf_inst_2,
   rvalid_m_inf_inst_2,
   rready_m_inf_inst_2,

     awid_m_inf_inst_2,
   awaddr_m_inf_inst_2,
   awsize_m_inf_inst_2,
  awburst_m_inf_inst_2,
    awlen_m_inf_inst_2,
  awvalid_m_inf_inst_2,
  awready_m_inf_inst_2,

    wdata_m_inf_inst_2,
    wlast_m_inf_inst_2,
   wvalid_m_inf_inst_2,
   wready_m_inf_inst_2,

      bid_m_inf_inst_2,
    bresp_m_inf_inst_2,
   bvalid_m_inf_inst_2,
   bready_m_inf_inst_2,
//===== AXI-4 Data Memory =====
     arid_m_inf_data,
   araddr_m_inf_data,
    arlen_m_inf_data,
   arsize_m_inf_data,
  arburst_m_inf_data,
  arvalid_m_inf_data,
  arready_m_inf_data,

      rid_m_inf_data,
    rdata_m_inf_data,
    rresp_m_inf_data,
    rlast_m_inf_data,
   rvalid_m_inf_data,
   rready_m_inf_data,

     awid_m_inf_data,
   awaddr_m_inf_data,
   awsize_m_inf_data,
  awburst_m_inf_data,
    awlen_m_inf_data,
  awvalid_m_inf_data,
  awready_m_inf_data,

    wdata_m_inf_data,
    wlast_m_inf_data,
   wvalid_m_inf_data,
   wready_m_inf_data,

      bid_m_inf_data,
    bresp_m_inf_data,
   bvalid_m_inf_data,
   bready_m_inf_data
);
// Input port
input  wire clk, rst_n, interrupt_1, interrupt_2;
// Output port
output reg  stall_core1, stall_core2;

parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=16;

// AXI Interface wire connecttion for pseudo DRAM read/write
/* Hint:
  your AXI-4 interface could be designed as convertor in submodule(which used reg for output signal),
  therefore I declared output of AXI as wire in CPU
*/

//########################################### Instruction Memory #1
// axi write addr channel
// src master
output wire [ID_WIDTH-1:0]      awid_m_inf_inst_1;
output wire [ADDR_WIDTH-1:0]  awaddr_m_inf_inst_1;
output wire [2:0]             awsize_m_inf_inst_1;
output wire [1:0]            awburst_m_inf_inst_1;
output wire [7:0]              awlen_m_inf_inst_1;
output wire                  awvalid_m_inf_inst_1;
// src slave
input  wire                  awready_m_inf_inst_1;
// -------------------------

// axi write data channel
// src master
output wire [DATA_WIDTH-1:0]   wdata_m_inf_inst_1;
output wire                    wlast_m_inf_inst_1;
output wire                   wvalid_m_inf_inst_1;
// src slave
input  wire                   wready_m_inf_inst_1;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_m_inf_inst_1;
input  wire  [1:0]             bresp_m_inf_inst_1;
input  wire                   bvalid_m_inf_inst_1;
// src master
output wire                   bready_m_inf_inst_1;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_m_inf_inst_1;
output wire [ADDR_WIDTH-1:0]  araddr_m_inf_inst_1;
output wire [7:0]              arlen_m_inf_inst_1;
output wire [2:0]             arsize_m_inf_inst_1;
output wire [1:0]            arburst_m_inf_inst_1;
output wire                  arvalid_m_inf_inst_1;
// src slave
input  wire                  arready_m_inf_inst_1;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_m_inf_inst_1;
input  wire [DATA_WIDTH-1:0]   rdata_m_inf_inst_1;
input  wire [1:0]              rresp_m_inf_inst_1;
input  wire                    rlast_m_inf_inst_1;
input  wire                   rvalid_m_inf_inst_1;
// master
output wire                   rready_m_inf_inst_1;
// -----------------------------

//########################################### Instruction Memory #2
// axi write addr channel
// src master
output wire [ID_WIDTH-1:0]      awid_m_inf_inst_2;
output wire [ADDR_WIDTH-1:0]  awaddr_m_inf_inst_2;
output wire [2:0]             awsize_m_inf_inst_2;
output wire [1:0]            awburst_m_inf_inst_2;
output wire [7:0]              awlen_m_inf_inst_2;
output wire                  awvalid_m_inf_inst_2;
// src slave
input  wire                  awready_m_inf_inst_2;
// -------------------------

// axi write data channel
// src master
output wire [DATA_WIDTH-1:0]   wdata_m_inf_inst_2;
output wire                    wlast_m_inf_inst_2;
output wire                   wvalid_m_inf_inst_2;
// src slave
input  wire                   wready_m_inf_inst_2;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_m_inf_inst_2;
input  wire  [1:0]             bresp_m_inf_inst_2;
input  wire                   bvalid_m_inf_inst_2;
// src master
output wire                   bready_m_inf_inst_2;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_m_inf_inst_2;
output wire [ADDR_WIDTH-1:0]  araddr_m_inf_inst_2;
output wire [7:0]              arlen_m_inf_inst_2;
output wire [2:0]             arsize_m_inf_inst_2;
output wire [1:0]            arburst_m_inf_inst_2;
output wire                  arvalid_m_inf_inst_2;
// src slave
input  wire                  arready_m_inf_inst_2;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_m_inf_inst_2;
input  wire [DATA_WIDTH-1:0]   rdata_m_inf_inst_2;
input  wire [1:0]              rresp_m_inf_inst_2;
input  wire                    rlast_m_inf_inst_2;
input  wire                   rvalid_m_inf_inst_2;
// master
output wire                   rready_m_inf_inst_2;
// -----------------------------

//########################################### Data Memory
// axi write addr channel
// src master
output wire [ID_WIDTH-1:0]      awid_m_inf_data;
output wire [ADDR_WIDTH-1:0]  awaddr_m_inf_data;
output wire [2:0]             awsize_m_inf_data;
output wire [1:0]            awburst_m_inf_data;
output wire [7:0]              awlen_m_inf_data;
output wire                  awvalid_m_inf_data;
// src slave
input  wire                  awready_m_inf_data;
// -------------------------

// axi write data channel
// src master
output wire [DATA_WIDTH-1:0]   wdata_m_inf_data;
output wire                    wlast_m_inf_data;
output wire                   wvalid_m_inf_data;
// src slave
input  wire                   wready_m_inf_data;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_m_inf_data;
input  wire  [1:0]             bresp_m_inf_data;
input  wire                   bvalid_m_inf_data;
// src master
output wire                   bready_m_inf_data;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_m_inf_data;
output wire [ADDR_WIDTH-1:0]  araddr_m_inf_data;
output wire [7:0]              arlen_m_inf_data;
output wire [2:0]             arsize_m_inf_data;
output wire [1:0]            arburst_m_inf_data;
output wire                  arvalid_m_inf_data;
// src slave
input  wire                  arready_m_inf_data;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_m_inf_data;
input  wire [DATA_WIDTH-1:0]   rdata_m_inf_data;
input  wire [1:0]              rresp_m_inf_data;
input  wire                    rlast_m_inf_data;
input  wire                   rvalid_m_inf_data;
// master
output wire                   rready_m_inf_data;
// -----------------------------
//
//
//
/* Register in each core:
  There are sixteen registers in your CPU. You should not change the name of those registers.
  TA will check the value in each register when your core is not busy.
  If you change the name of registers below, you must get the fail in this lab.
*/
reg signed [15:0] core_1_r0, core_1_r1, core_1_r2, core_1_r3;
reg signed [15:0] core_1_r4, core_1_r5, core_1_r6, core_1_r7;
reg signed [15:0] core_2_r0, core_2_r1, core_2_r2, core_2_r3;
reg signed [15:0] core_2_r4, core_2_r5, core_2_r6, core_2_r7;
// -----------------------------
integer i,j;

wire signed [DATA_WIDTH-1:0] X1 [7:0];
wire signed [DATA_WIDTH-1:0] X2 [7:0];

wire [13-1:0] BRG_i_ADDR_inst_1,BRG_i_ADDR_inst_2;
reg [13-1:0] BRG_i_ADDR_data_1,BRG_i_ADDR_data_2;
reg BRG_i_valid_inst_1,BRG_i_valid_inst_2;
reg BRG_i_valid_data_1,BRG_i_valid_data_2;
wire [DATA_WIDTH-1:0] BRG_o_DATA_inst_1,BRG_o_DATA_inst_2;
wire [DATA_WIDTH-1:0] BRG_o_DATA_data_1,BRG_o_DATA_data_2;

reg [DATA_WIDTH-1:0] BRG_i_DATA_data_1,BRG_i_DATA_data_2;
reg BRG_RW_data_1,BRG_RW_data_2;
wire BRG_o_valid_inst_1,BRG_o_valid_inst_2;
wire BRG_o_valid_data_1,BRG_o_valid_data_2;

reg [2:0] RS_ADDR_1,RT_ADDR_1,RW_ADDR_1,RL_ADDR_1,  RS_ADDR_2,RT_ADDR_2,RW_ADDR_2,RL_ADDR_2;
wire [15:0] RS_DATA_1,RT_DATA_1,RS_DATA_2,RT_DATA_2;
reg [15:0] RW_DATA_1,RL_DATA_1,RW_DATA_2,RL_DATA_2;
reg RW_EN_1,RL_EN_1,  RW_EN_2,RL_EN_2;

/*typedef enum logic [2:0] {
     ADD = 3'd0,
     SUB = 3'd1,
     AND = 3'd2,
     OR = 3'd3,
     NAND = 3'd4,
     NOR = 3'd5,
     XOR = 3'd6,
     MULT = 3'd7
} ALU_TYPE;*/
parameter ADD = 3'd0;
parameter SUB = 3'd1;
parameter AND = 3'd2;
parameter OR = 3'd3;
parameter NAND = 3'd4;
parameter NOR = 3'd5;
parameter XOR = 3'd6;
parameter MULT = 3'd7;
reg [2:0] ALU_OP_1,ALU_OP_2;
/*typedef enum logic [2:0] {
     F_ADD = 3'd0,
     F_SUB = 3'd1,
     F_AND = 3'd2,
     F_OR = 3'd3,
     F_NAND = 3'd4,
     F_NOR = 3'd5,
     F_XOR = 3'd6,
     F_SLT = 3'd7
} FUNC_TYPE;*/
parameter F_ADD = 3'd0;
parameter F_SUB = 3'd1;
parameter F_AND = 3'd2;
parameter F_OR = 3'd3;
parameter F_NAND = 3'd4;
parameter F_NOR = 3'd5;
parameter F_XOR = 3'd6;
parameter F_SLT = 3'd7;
reg [2:0] I_FUNC_1,I_FUNC_2;
/*
parameter ADD = 3'd0;
parameter SUB = 3'd1;
parameter AND = 3'd2;
parameter OR = 3'd3;
parameter NAND = 3'd4;
parameter NOR = 3'd5;
parameter XOR = 3'd6;
parameter MULT = 3'd7;
*/
/*typedef enum logic [2:0] {
     I_RTYPE = 3'd0,
     I_MULT = 3'd1,
     I_ADDI = 3'd2,
     I_SUBI = 3'd3,
     I_LOAD = 3'd4,
     I_STORE = 3'd5,
     I_BEQ = 3'd6,
     I_JP = 3'd7
} INST_TYPE;*/
parameter I_RTYPE = 3'd0;
parameter I_MULT = 3'd1;
parameter I_ADDI = 3'd2;
parameter I_SUBI = 3'd3;
parameter I_LOAD = 3'd4;
parameter I_STORE = 3'd5;
parameter I_BEQ = 3'd6;
parameter I_JP = 3'd7;
reg [2:0] I_OP_1,I_OP_2;

INST_CONTROLLER b1(
    .clk(clk),
    .rst_n(rst_n),
    .i_valid( BRG_i_valid_inst_1 ),
    .i_addr( BRG_i_ADDR_inst_1 ),
    .o_valid( BRG_o_valid_inst_1 ),
    .o_data( BRG_o_DATA_inst_1 ),
    .bid_m_inf_inst(bid_m_inf_inst_1),
    .bresp_m_inf_inst(bresp_m_inf_inst_1),
    .bvalid_m_inf_inst(bvalid_m_inf_inst_1),
    .bready_m_inf_inst(bready_m_inf_inst_1),
    .arid_m_inf_inst(arid_m_inf_inst_1),
    .araddr_m_inf_inst(araddr_m_inf_inst_1),
    .arlen_m_inf_inst(arlen_m_inf_inst_1),
    .arsize_m_inf_inst(arsize_m_inf_inst_1),
    .arburst_m_inf_inst(arburst_m_inf_inst_1),
    .arvalid_m_inf_inst(arvalid_m_inf_inst_1),
    .arready_m_inf_inst(arready_m_inf_inst_1),
    .rid_m_inf_inst(rid_m_inf_inst_1),
    .rdata_m_inf_inst(rdata_m_inf_inst_1),
    .rresp_m_inf_inst(rresp_m_inf_inst_1),
    .rlast_m_inf_inst(rlast_m_inf_inst_1),
    .rvalid_m_inf_inst(rvalid_m_inf_inst_1),
    .rready_m_inf_inst(rready_m_inf_inst_1)
);
INST_CONTROLLER b2(
    .clk(clk),
    .rst_n(rst_n),
    .i_valid( BRG_i_valid_inst_2 ),
    .i_addr( BRG_i_ADDR_inst_2 ),
    .o_valid( BRG_o_valid_inst_2 ),
    .o_data( BRG_o_DATA_inst_2 ),
    .bid_m_inf_inst(bid_m_inf_inst_2),
    .bresp_m_inf_inst(bresp_m_inf_inst_2),
    .bvalid_m_inf_inst(bvalid_m_inf_inst_2),
    .bready_m_inf_inst(bready_m_inf_inst_2),
    .arid_m_inf_inst(arid_m_inf_inst_2),
    .araddr_m_inf_inst(araddr_m_inf_inst_2),
    .arlen_m_inf_inst(arlen_m_inf_inst_2),
    .arsize_m_inf_inst(arsize_m_inf_inst_2),
    .arburst_m_inf_inst(arburst_m_inf_inst_2),
    .arvalid_m_inf_inst(arvalid_m_inf_inst_2),
    .arready_m_inf_inst(arready_m_inf_inst_2),
    .rid_m_inf_inst(rid_m_inf_inst_2),
    .rdata_m_inf_inst(rdata_m_inf_inst_2),
    .rresp_m_inf_inst(rresp_m_inf_inst_2),
    .rlast_m_inf_inst(rlast_m_inf_inst_2),
    .rvalid_m_inf_inst(rvalid_m_inf_inst_2),
    .rready_m_inf_inst(rready_m_inf_inst_2)
);

DATA_CONTROLLER b3(
    .clk(clk),
    .rst_n(rst_n),
    .i_valid_1( BRG_i_valid_data_1 ),
    .i_addr_1( BRG_i_ADDR_data_1 ),
    .i_data_1( BRG_i_DATA_data_1 ),
    .i_rw_1( BRG_RW_data_1),
    .o_valid_1(BRG_o_valid_data_1),
    .o_data_1(BRG_o_DATA_data_1),
    .i_valid_2( BRG_i_valid_data_2 ),
    .i_addr_2( BRG_i_ADDR_data_2 ),
    .i_data_2( BRG_i_DATA_data_2 ),
    .i_rw_2( BRG_RW_data_2 ),
    .o_valid_2( BRG_o_valid_data_2  ),
    .o_data_2( BRG_o_DATA_data_2 ),
    .awid_m_inf_data(awid_m_inf_data),
    .awaddr_m_inf_data(awaddr_m_inf_data),
    .awsize_m_inf_data(awsize_m_inf_data),
    .awburst_m_inf_data(awburst_m_inf_data),
    .awlen_m_inf_data(awlen_m_inf_data),
    .awvalid_m_inf_data(awvalid_m_inf_data),
    .awready_m_inf_data(awready_m_inf_data),
    .wdata_m_inf_data(wdata_m_inf_data),
    .wlast_m_inf_data(wlast_m_inf_data),
    .wvalid_m_inf_data(wvalid_m_inf_data),
    .wready_m_inf_data(wready_m_inf_data),
    .bid_m_inf_data(bid_m_inf_data),
    .bresp_m_inf_data(bresp_m_inf_data),
    .bvalid_m_inf_data(bvalid_m_inf_data),
    .bready_m_inf_data(bready_m_inf_data),
    .arid_m_inf_data(arid_m_inf_data),
    .araddr_m_inf_data(araddr_m_inf_data),
    .arlen_m_inf_data(arlen_m_inf_data),
    .arsize_m_inf_data(arsize_m_inf_data),
    .arburst_m_inf_data(arburst_m_inf_data),
    .arvalid_m_inf_data(arvalid_m_inf_data),
    .arready_m_inf_data(arready_m_inf_data),
    .rid_m_inf_data(rid_m_inf_data),
    .rdata_m_inf_data(rdata_m_inf_data),
    .rresp_m_inf_data(rresp_m_inf_data),
    .rlast_m_inf_data(rlast_m_inf_data),
    .rvalid_m_inf_data(rvalid_m_inf_data),
    .rready_m_inf_data(rready_m_inf_data)
);

/*
DATA_BRIDGE2 b3(
    .clk(clk),
    .rst_n(rst_n),
    .C_in_valid_1( BRG_i_valid_data_1 ),
    .C_addr_1( BRG_i_ADDR_data_1 ),
    .C_data_w_1( BRG_i_DATA_data_1 ),
    .C_r_wb_1( BRG_RW_data_1),
    .C_out_valid_1(BRG_o_valid_data_1),
    .C_data_r_1(BRG_o_DATA_data_1),
    .C_in_valid_2( BRG_i_valid_data_2 ),
    .C_addr_2( BRG_i_ADDR_data_2 ),
    .C_data_w_2( BRG_i_DATA_data_2 ),
    .C_r_wb_2( BRG_RW_data_2 ),
    .C_out_valid_2( BRG_o_valid_data_2  ),
    .C_data_r_2( BRG_o_DATA_data_2 ),
    .awid_M_inf(awid_m_inf_data),
    .AW_ADDR(awaddr_m_inf_data),
    .awsize_M_inf(awsize_m_inf_data),
    .awburst_M_inf(awburst_m_inf_data),
    .awlen_M_inf(awlen_m_inf_data),
    .AW_VALID(awvalid_m_inf_data),
    .AW_READY(awready_m_inf_data),
    .W_DATA(wdata_m_inf_data),
    .W_LAST(wlast_m_inf_data),
    .W_VALID(wvalid_m_inf_data),
    .W_READY(wready_m_inf_data),
    .bid_M_inf(bid_m_inf_data),
    .B_RESP(bresp_m_inf_data),
    .B_VALID(bvalid_m_inf_data),
    .B_READY(bready_m_inf_data),
    .arid_M_inf(arid_m_inf_data),
    .AR_ADDR(araddr_m_inf_data),
    .arlen_M_inf(arlen_m_inf_data),
    .arsize_M_inf(arsize_m_inf_data),
    .arburst_M_inf(arburst_m_inf_data),
    .AR_VALID(arvalid_m_inf_data),
    .AR_READY(arready_m_inf_data),
    .rid_M_inf(rid_m_inf_data),
    .R_DATA(rdata_m_inf_data),
    .rresp_M_inf(rresp_m_inf_data),
    .rlast_M_inf(rlast_m_inf_data),
    .R_VALID(rvalid_m_inf_data),
    .R_READY(rready_m_inf_data)
);
*/

//###########################################
// Wrtie down your design below
//###########################################
//-------------------
// Main FSM
//-------------------
reg [12:0] PC_1,PC_2;
reg [15:0] INST_1,INST_2;
reg [2:0] I_RS_1,I_RT_1,I_RD_1,I_RL_1,I_RS_2,I_RT_2,I_RD_2,I_RL_2;
reg signed [6:0] I_IMM_1,I_IMM_2;
reg [12:0] I_ADDRESS_1,I_ADDRESS_2;

wire signed [15:0] ALU_DO_1,ALU_DO_2;
reg signed [15:0] ALU_D1_1,ALU_D2_1,RS_DATA_NEG_1,RT_DATA_NEG_1,ALU_D1_2,ALU_D2_2,RS_DATA_NEG_2,RT_DATA_NEG_2;
reg signed [31:0] MULT_DO_1,MULT_DO_NEG_1,MULT_DO_2,MULT_DO_NEG_2;
wire ALU_ZERO_1,ALU_LESS_1,ALU_ZERO_2,ALU_LESS_2;
reg BOTH_DONE;
reg [2:0] MULT_CNT_2,MULT_CNT_1;

/*typedef enum logic [3:0] {
      s_IDLE = 4'd0,
      s_IMEM = 4'd1,
      s_IF = 4'd2,
      s_ALU = 4'd4,
      s_DMEM = 4'd5,
      s_WB = 4'd6,
      s_BRANCH = 4'd3,
      s_WAIT = 4'd7
} FSM;*/
parameter s_IDLE = 4'd0;
parameter s_IMEM = 4'd1;
parameter s_IF = 4'd2;
parameter s_ALU = 4'd4;
parameter s_DMEM = 4'd5;
parameter s_WB = 4'd6;
parameter s_BRANCH = 4'd3;
parameter s_WAIT = 4'd7;
reg [3:0] SC_1,SP_1,SN_1,SC_2,SP_2,SN_2;

always @ ( posedge clk ) begin
    if(SN_1==s_WAIT && SN_2==s_WAIT) BOTH_DONE <= 1'd1;
    else BOTH_DONE <= 1'd0;
end
REG_FILE RF1( .clk(clk), .rst_n(rst_n),  .i_r1a(RS_ADDR_1),  .i_r2a(RT_ADDR_1),  .i_w1en(RW_EN_1),  .i_w1a(RW_ADDR_1),  .i_w1d(RW_DATA_1),  .i_w2en(RL_EN_1),  .i_w2a(RL_ADDR_1),  .i_w2d(RL_DATA_1),  .o_r1d(RS_DATA_1),  .o_r2d(RT_DATA_1),  .core_r0(X1[0]),  .core_r1(X1[1]),  .core_r2(X1[2]),  .core_r3(X1[3]),  .core_r4(X1[4]),  .core_r5(X1[5]),  .core_r6(X1[6]),  .core_r7(X1[7])   );
REG_FILE RF2( .clk(clk), .rst_n(rst_n),  .i_r1a(RS_ADDR_2),  .i_r2a(RT_ADDR_2),  .i_w1en(RW_EN_2),  .i_w1a(RW_ADDR_2),  .i_w1d(RW_DATA_2),  .i_w2en(RL_EN_2),  .i_w2a(RL_ADDR_2),  .i_w2d(RL_DATA_2),  .o_r1d(RS_DATA_2),  .o_r2d(RT_DATA_2),  .core_r0(X2[0]),  .core_r1(X2[1]),  .core_r2(X2[2]),  .core_r3(X2[3]),  .core_r4(X2[4]),  .core_r5(X2[5]),  .core_r6(X2[6]),  .core_r7(X2[7])   );
ALU alu1(    .clk(clk),    .i_ALUop(ALU_OP_1),    .i_D1(ALU_D1_1),    .i_D2(ALU_D2_1),    .o_Data(ALU_DO_1),    .o_ZERO(ALU_ZERO_1),    .o_LESS(ALU_LESS_1) );
ALU alu2(    .clk(clk),    .i_ALUop(ALU_OP_2),    .i_D1(ALU_D1_2),    .i_D2(ALU_D2_2),    .o_Data(ALU_DO_2),    .o_ZERO(ALU_ZERO_2),    .o_LESS(ALU_LESS_2) );
/*
parameter  s_IDLE = 3'd0;
parameter  s_IMEM = 3'd1;
parameter  s_IF = 3'd2;
parameter  s_DECODE = 3'd3;
parameter  s_ALU = 3'd4;
parameter  s_DMEM = 3'd5;
parameter  s_WB = 3'd6;
parameter  s_RUN = 3'd7;
*/
assign    BRG_i_ADDR_inst_1 = PC_1;
assign    BRG_i_ADDR_inst_2 = PC_2;
always @ (posedge clk) begin
    SP_1 <= SC_1;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) SC_1 <= s_IDLE;
    else SC_1 <= SN_1;
end
always @ ( * ) begin
    case(SC_1)
        s_IDLE: SN_1 <= s_IMEM;
        s_IMEM: if(BRG_o_valid_inst_1) SN_1 <= s_IF; else SN_1 <= s_IMEM;
        s_IF:   SN_1 <= s_ALU;
        s_ALU:  if(I_OP_1==I_LOAD || I_OP_1==I_STORE) SN_1 <= s_DMEM;
                else if(I_OP_1==I_BEQ || I_OP_1==I_JP) SN_1 <= s_BRANCH;
                else if(I_OP_1==I_MULT && MULT_CNT_1==3'd5) SN_1 <= s_WB;
                else if(I_OP_1==I_MULT) SN_1 <= s_ALU;
                else SN_1 <= s_WB;
        s_DMEM: if(BRG_o_valid_data_1) SN_1 <= s_WB; else SN_1 <= s_DMEM;
        s_WB:   SN_1 <= s_WAIT;
        s_BRANCH : SN_1 <= s_WAIT;
        s_WAIT: if(BOTH_DONE) SN_1 <= s_IDLE; else SN_1 <= s_WAIT;
        default: SN_1 <= s_IDLE;
    endcase
end
// inst mem
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)  BRG_i_valid_inst_1 <= 0;
    else if(SC_1==s_IDLE && SN_1==s_IMEM) BRG_i_valid_inst_1 <= 1;
    else BRG_i_valid_inst_1 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) PC_1 <= 0;
    else if(I_OP_1==I_BEQ && SC_1==s_BRANCH) if(ALU_ZERO_1) PC_1 <= $signed(PC_1) + $signed(I_IMM_1) + $signed(1); else PC_1 <= PC_1 + 2;
    else if(I_OP_1==I_JP && SN_1==s_BRANCH) PC_1 <= I_ADDRESS_1;
    else if(I_OP_1<I_BEQ && SC_1!=s_WAIT && SN_1==s_WAIT) PC_1 <= PC_1 + 2;
end
// data mem
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_RW_data_1 <= 1;
    else if(I_OP_1==I_STORE) BRG_RW_data_1 <= 0;
    else BRG_RW_data_1 <= 1;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_valid_data_1 <=0 ;
    else if(SP_1==s_ALU && SC_1==s_DMEM) BRG_i_valid_data_1 <= 1;
    else BRG_i_valid_data_1 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_ADDR_data_1 <=0 ;
    else if(SP_1==s_ALU && SC_1==s_DMEM) BRG_i_ADDR_data_1 <= ALU_DO_1;
    else BRG_i_ADDR_data_1 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_DATA_data_1 <=0;
    else if(SP_1==s_ALU && SC_1==s_DMEM && I_OP_1==I_STORE) BRG_i_DATA_data_1 <= RT_DATA_1;
    else BRG_i_DATA_data_1 <= 0;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) INST_1 <= 0;
    else if(BRG_o_valid_inst_1) INST_1 <= BRG_o_DATA_inst_1;
end
always @ ( * ) begin
    I_OP_1 <= INST_1[15:13];
    I_RS_1 <= INST_1[12:10];
    I_RT_1 <= INST_1[9:7];
    I_RD_1 <= INST_1[6:4];
    I_RL_1 <= INST_1[3:1];
    I_FUNC_1 <= INST_1[3:1];
    I_IMM_1 <= INST_1[6:0];
    I_ADDRESS_1 <= INST_1[12:0];
end
always @ ( * ) begin
    RS_ADDR_1 <= I_RS_1;
    RT_ADDR_1 <= I_RT_1;
end
always @ ( * ) begin
    if(I_OP_1==I_RTYPE || I_OP_1==I_MULT) RW_ADDR_1 <= I_RD_1;
    else RW_ADDR_1 <= I_RT_1;
end
always @ ( * ) begin
    RL_ADDR_1 <= I_RL_1;
end
always @ (posedge clk) begin
    if(SC_1==s_ALU) MULT_CNT_1 <= MULT_CNT_1 + 1;
    else MULT_CNT_1 <=0;
end
always @ ( * ) begin
    RS_DATA_NEG_1 <= -RS_DATA_1;
    RT_DATA_NEG_1 <= -RT_DATA_1;
    MULT_DO_NEG_1 <= -MULT_DO_1;
end
always @ ( * ) begin
    if(I_OP_1==I_MULT && MULT_CNT_1==0) if(!RS_DATA_1[15]) ALU_D1_1 <= RS_DATA_1[7:0]; else ALU_D1_1 <= RS_DATA_NEG_1[7:0];
    else if(I_OP_1==I_MULT && MULT_CNT_1==1) if(!RS_DATA_1[15]) ALU_D1_1 <= RS_DATA_1[7:0]; else ALU_D1_1 <= RS_DATA_NEG_1[7:0];
    else if(I_OP_1==I_MULT && MULT_CNT_1==2) if(!RS_DATA_1[15]) ALU_D1_1 <= RS_DATA_1[15:8]; else ALU_D1_1 <= RS_DATA_NEG_1[15:8];
    else if(I_OP_1==I_MULT && MULT_CNT_1==3) if(!RS_DATA_1[15]) ALU_D1_1 <= RS_DATA_1[15:8]; else ALU_D1_1 <= RS_DATA_NEG_1[15:8];
    //else if(I_OP_1==I_BEQ) ALU_D1_1 <= PC_1 + 1;
    else ALU_D1_1 <= RS_DATA_1;
end
always @ ( * ) begin
    if(I_OP_1==I_MULT && MULT_CNT_1==0) if(!RT_DATA_1[15]) ALU_D2_1 <= RT_DATA_1[7:0]; else ALU_D2_1 <= RT_DATA_NEG_1[7:0];
    else if(I_OP_1==I_MULT && MULT_CNT_1==1) if(!RT_DATA_1[15]) ALU_D2_1 <= RT_DATA_1[15:8]; else ALU_D2_1 <= RT_DATA_NEG_1[15:8];
    else if(I_OP_1==I_MULT && MULT_CNT_1==2) if(!RT_DATA_1[15]) ALU_D2_1 <= RT_DATA_1[7:0]; else ALU_D2_1 <= RT_DATA_NEG_1[7:0];
    else if(I_OP_1==I_MULT && MULT_CNT_1==3) if(!RT_DATA_1[15]) ALU_D2_1 <= RT_DATA_1[15:8]; else ALU_D2_1 <= RT_DATA_NEG_1[15:8];
    else if(I_OP_1==I_RTYPE || I_OP_1==I_MULT || I_OP_1==I_BEQ) ALU_D2_1 <= RT_DATA_1;
    else ALU_D2_1 <= I_IMM_1;
end
always @ (posedge clk) begin
    if(MULT_CNT_1==1) MULT_DO_1 <= {1'b0,ALU_DO_1};
    else if(MULT_CNT_1==2) MULT_DO_1 <= MULT_DO_1 + (ALU_DO_1<<8);
    else if(MULT_CNT_1==3) MULT_DO_1 <= MULT_DO_1 + (ALU_DO_1<<8);
    else if(MULT_CNT_1==4) MULT_DO_1 <= MULT_DO_1 + (ALU_DO_1<<16);
end
always @ ( * ) begin
    case(I_OP_1)
        3'd0: if(I_FUNC_1==3'd7) ALU_OP_1 <= SUB; else ALU_OP_1 <= I_FUNC_1;
        3'd1: ALU_OP_1 <= MULT;
        3'd2: ALU_OP_1 <= ADD;
        3'd3: ALU_OP_1 <= SUB;
        3'd6: ALU_OP_1 <= SUB;
        default : ALU_OP_1 <= ADD;
    endcase
end
always @ (posedge clk) begin
    if(SN_1==s_WB && I_OP_1==I_MULT) RW_EN_1 <= 1;
    else if(SC_1==s_WB && I_OP_1 < I_STORE && I_OP_1!=I_MULT) RW_EN_1 <= 1;
    else RW_EN_1 <= 0;
end
always @ (posedge clk) begin
    if(I_OP_1==I_MULT && SC_1==s_WB) RL_EN_1 <= 1;
    else RL_EN_1 <= 0;
end
always @ ( posedge clk ) begin
    if(I_OP_1==I_MULT && MULT_CNT_1==3'd5) RL_DATA_1 <= MULT_DO_1[15:0];
    else RL_DATA_1 <= ALU_DO_1[15:0];
end
always @ (posedge clk) begin
    if(I_OP_1 ==I_MULT && MULT_CNT_1==3'd5) if(!(RS_DATA_1[15]^RT_DATA_1[15])) RW_DATA_1 <= MULT_DO_1[31:16]; else RW_DATA_1 <= MULT_DO_NEG_1[31:16];
    else if(I_OP_1==I_RTYPE && I_FUNC_1==F_SLT) RW_DATA_1 <= ALU_DO_1[15];
    else if(I_OP_1==I_LOAD && BRG_o_valid_data_1) RW_DATA_1 <= BRG_o_DATA_data_1;
    else if(I_OP_1!=I_LOAD) RW_DATA_1 <= ALU_DO_1[15:0];
end
////
/// CPU 2
///
always @ (posedge clk) begin
    SP_2 <= SC_2;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) SC_2 <= s_IDLE;
    else SC_2 <= SN_2;
end
always @ ( * ) begin
    case(SC_2)
        s_IDLE: SN_2 <= s_IMEM;
        s_IMEM: if(BRG_o_valid_inst_2) SN_2 <= s_IF; else SN_2 <= s_IMEM;
        s_IF:   SN_2 <= s_ALU;
        s_ALU:  if(I_OP_2==I_LOAD || I_OP_2==I_STORE) SN_2 <= s_DMEM;
                else if(I_OP_2==I_BEQ || I_OP_2==I_JP) SN_2 <= s_BRANCH;
                else if(I_OP_2==I_MULT && MULT_CNT_2==3'd5) SN_2 <= s_WB;
                else if(I_OP_2==I_MULT) SN_2 <= s_ALU;
                else SN_2 <= s_WB;
        s_DMEM: if(BRG_o_valid_data_2) SN_2 <= s_WB; else SN_2 <= s_DMEM;
        s_WB:   SN_2 <= s_WAIT;
        s_BRANCH : SN_2 <= s_WAIT;
        s_WAIT: if(BOTH_DONE) SN_2 <= s_IDLE; else SN_2 <= s_WAIT;
        default: SN_2 <= s_IDLE;
    endcase
end
// inst mem
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)  BRG_i_valid_inst_2 <= 0;
    else if(SC_2==s_IDLE && SN_2==s_IMEM) BRG_i_valid_inst_2 <= 1;
    else BRG_i_valid_inst_2 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) PC_2 <= 0;
    else if(I_OP_2==I_BEQ && SC_2==s_BRANCH) if(ALU_ZERO_2) PC_2 <= $signed(PC_2) + $signed(I_IMM_2) + $signed(1); else PC_2 <= PC_2 + 2;
    else if(I_OP_2==I_JP && SN_2==s_BRANCH) PC_2 <= I_ADDRESS_2;
    else if(I_OP_2<I_BEQ && SC_2!=s_WAIT && SN_2==s_WAIT) PC_2 <= PC_2 + 2;
end
// data mem
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_RW_data_2 <= 1;
    else if(I_OP_2==I_STORE) BRG_RW_data_2 <= 0;
    else BRG_RW_data_2 <= 1;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_valid_data_2 <=0 ;
    else if(SP_2==s_ALU && SC_2==s_DMEM) BRG_i_valid_data_2 <= 1;
    else BRG_i_valid_data_2 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_ADDR_data_2 <=0 ;
    else if(SP_2==s_ALU && SC_2==s_DMEM) BRG_i_ADDR_data_2 <= ALU_DO_2;
    else BRG_i_ADDR_data_2 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_DATA_data_2 <=0;
    else if(SP_2==s_ALU && SC_2==s_DMEM && I_OP_2==I_STORE) BRG_i_DATA_data_2 <= RT_DATA_2;
    else BRG_i_DATA_data_2 <= 0;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) INST_2 <= 0;
    else if(BRG_o_valid_inst_2) INST_2 <= BRG_o_DATA_inst_2;
end
always @ ( * ) begin
    I_OP_2 <= INST_2[15:13];
    I_RS_2 <= INST_2[12:10];
    I_RT_2 <= INST_2[9:7];
    I_RD_2 <= INST_2[6:4];
    I_RL_2 <= INST_2[3:1];
    I_FUNC_2 <= INST_2[3:1];
    I_IMM_2 <= INST_2[6:0];
    I_ADDRESS_2 <= INST_2[12:0];
end
always @ ( * ) begin
    RS_ADDR_2 <= I_RS_2;
    RT_ADDR_2 <= I_RT_2;
end
always @ ( * ) begin
    if(I_OP_2==I_RTYPE || I_OP_2==I_MULT) RW_ADDR_2 <= I_RD_2;
    else RW_ADDR_2 <= I_RT_2;
end
always @ ( * ) begin
    RL_ADDR_2 <= I_RL_2;
end
always @ (posedge clk) begin
    if(SC_2==s_ALU) MULT_CNT_2 <= MULT_CNT_2 + 1;
    else MULT_CNT_2 <=0;
end
always @ ( * ) begin
    RS_DATA_NEG_2 <= -RS_DATA_2;
    RT_DATA_NEG_2 <= -RT_DATA_2;
    MULT_DO_NEG_2 <= -MULT_DO_2;
end
always @ ( * ) begin
    if(I_OP_2==I_MULT && MULT_CNT_2==0) if(!RS_DATA_2[15]) ALU_D1_2 <= RS_DATA_2[7:0]; else ALU_D1_2 <= RS_DATA_NEG_2[7:0];
    else if(I_OP_2==I_MULT && MULT_CNT_2==1) if(!RS_DATA_2[15]) ALU_D1_2 <= RS_DATA_2[7:0]; else ALU_D1_2 <= RS_DATA_NEG_2[7:0];
    else if(I_OP_2==I_MULT && MULT_CNT_2==2) if(!RS_DATA_2[15]) ALU_D1_2 <= RS_DATA_2[15:8]; else ALU_D1_2 <= RS_DATA_NEG_2[15:8];
    else if(I_OP_2==I_MULT && MULT_CNT_2==3) if(!RS_DATA_2[15]) ALU_D1_2 <= RS_DATA_2[15:8]; else ALU_D1_2 <= RS_DATA_NEG_2[15:8];
    //else if(I_OP_1==I_BEQ) ALU_D1_1 <= PC_1 + 1;
    else ALU_D1_2 <= RS_DATA_2;
end
always @ ( * ) begin
    if(I_OP_2==I_MULT && MULT_CNT_2==0) if(!RT_DATA_2[15]) ALU_D2_2 <= RT_DATA_2[7:0]; else ALU_D2_2 <= RT_DATA_NEG_2[7:0];
    else if(I_OP_2==I_MULT && MULT_CNT_2==1) if(!RT_DATA_2[15]) ALU_D2_2 <= RT_DATA_2[15:8]; else ALU_D2_2 <= RT_DATA_NEG_2[15:8];
    else if(I_OP_2==I_MULT && MULT_CNT_2==2) if(!RT_DATA_2[15]) ALU_D2_2 <= RT_DATA_2[7:0]; else ALU_D2_2 <= RT_DATA_NEG_2[7:0];
    else if(I_OP_2==I_MULT && MULT_CNT_2==3) if(!RT_DATA_2[15]) ALU_D2_2 <= RT_DATA_2[15:8]; else ALU_D2_2 <= RT_DATA_NEG_2[15:8];
    else if(I_OP_2==I_RTYPE || I_OP_2==I_MULT || I_OP_2==I_BEQ) ALU_D2_2 <= RT_DATA_2;
    else ALU_D2_2 <= I_IMM_2;
end
always @ (posedge clk) begin
    if(MULT_CNT_2==1) MULT_DO_2 <= {1'b0,ALU_DO_2};
    else if(MULT_CNT_2==2) MULT_DO_2 <= MULT_DO_2 + (ALU_DO_2<<8);
    else if(MULT_CNT_2==3) MULT_DO_2 <= MULT_DO_2 + (ALU_DO_2<<8);
    else if(MULT_CNT_2==4) MULT_DO_2 <= MULT_DO_2 + (ALU_DO_2<<16);
end
always @ ( * ) begin
    case(I_OP_2)
        3'd0: if(I_FUNC_2==3'd7) ALU_OP_2 <= SUB; else ALU_OP_2 <= I_FUNC_2;
        3'd1: ALU_OP_2 <= MULT;
        3'd2: ALU_OP_2 <= ADD;
        3'd3: ALU_OP_2 <= SUB;
        3'd6: ALU_OP_2 <= SUB;
        default : ALU_OP_2 <= ADD;
    endcase
end
always @ (posedge clk) begin
    if(SN_2==s_WB && I_OP_2==I_MULT) RW_EN_2 <= 1;
    else if(SC_2==s_WB && I_OP_2 < I_STORE && I_OP_2!=I_MULT) RW_EN_2 <= 1;
    else RW_EN_2 <= 0;
end
always @ (posedge clk) begin
    if(I_OP_2==I_MULT && SC_2==s_WB) RL_EN_2 <= 1;
    else RL_EN_2 <= 0;
end
always @ ( posedge clk ) begin
    if(I_OP_2==I_MULT && MULT_CNT_2==3'd5) RL_DATA_2 <= MULT_DO_2[15:0];
    else RL_DATA_2 <= ALU_DO_2[15:0];
end
always @ (posedge clk) begin
    if(I_OP_2 ==I_MULT && MULT_CNT_2==3'd5) if(!(RS_DATA_2[15]^RT_DATA_2[15])) RW_DATA_2 <= MULT_DO_2[31:16]; else RW_DATA_2 <= MULT_DO_NEG_2[31:16];
    else if(I_OP_2==I_RTYPE && I_FUNC_2==F_SLT) RW_DATA_2 <= ALU_DO_2[15];
    else if(I_OP_2==I_LOAD && BRG_o_valid_data_2) RW_DATA_2 <= BRG_o_DATA_data_2;
    else if(I_OP_2!=I_LOAD) RW_DATA_2 <= ALU_DO_2[15:0];
end
//-------------------
// output
//-------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) stall_core1 <=1 ;
    else if(BOTH_DONE) stall_core1 <=0;
    else stall_core1 <=1 ;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) stall_core2 <=1 ;
    else if(BOTH_DONE) stall_core2 <=0;
    else stall_core2 <=1 ;
end
always @ ( * ) begin
    core_1_r0 = X1[0];
    core_1_r1 = X1[1];
    core_1_r2 = X1[2];
    core_1_r3 = X1[3];
    core_1_r4 = X1[4];
    core_1_r5 = X1[5];
    core_1_r6 = X1[6];
    core_1_r7 = X1[7];
    core_2_r0 = X2[0];
    core_2_r1 = X2[1];
    core_2_r2 = X2[2];
    core_2_r3 = X2[3];
    core_2_r4 = X2[4];
    core_2_r5 = X2[5];
    core_2_r6 = X2[6];
    core_2_r7 = X2[7];
end


endmodule

module REG_FILE(
    input clk,
    input rst_n,
    input [2:0] i_r1a,
    input [2:0] i_r2a,
    input i_w1en,
    input [2:0] i_w1a,
    input signed [15:0] i_w1d,
    input i_w2en,
    input [2:0] i_w2a,
    input signed [15:0] i_w2d,
    output reg signed [15:0] o_r1d,
    output reg signed [15:0] o_r2d,
    output signed [15:0] core_r0,
    output signed [15:0] core_r1,
    output signed [15:0] core_r2,
    output signed [15:0] core_r3,
    output signed [15:0] core_r4,
    output signed [15:0] core_r5,
    output signed [15:0] core_r6,
    output signed [15:0] core_r7
    );
integer i,j;
reg signed [15:0] REG [7:0];
assign core_r0 = REG[0];
assign core_r1 = REG[1];
assign core_r2 = REG[2];
assign core_r3 = REG[3];
assign core_r4 = REG[4];
assign core_r5 = REG[5];
assign core_r6 = REG[6];
assign core_r7 = REG[7];

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0;i<8;i=i+1)
            REG[i] <= 16'h0;
    end
    else begin
        if(i_w1en)
            REG[i_w1a] <= i_w1d;
        if(i_w2en)
            REG[i_w2a] <= i_w2d;
    end
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)  o_r1d <= 0;
    else o_r1d <= REG[i_r1a];
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)  o_r2d <= 0;
    else o_r2d <= REG[i_r2a];
end
endmodule

module ALU(
    input clk,
    input [2:0] i_ALUop,
    input signed [15:0] i_D1,
    input signed [15:0] i_D2,
    output reg signed [15:0] o_Data,
    output reg o_ZERO,
    output reg o_LESS
);
/*typedef enum logic [2:0] {
     ADD = 3'd0,
     SUB = 3'd1,
     AND = 3'd2,
     OR = 3'd3,
     NAND = 3'd4,
     NOR = 3'd5,
     XOR = 3'd6,
     MULT = 3'd7
} ALU_TYPE;*/
parameter ADD = 3'd0;
parameter SUB = 3'd1;
parameter AND = 3'd2;
parameter OR = 3'd3;
parameter NAND = 3'd4;
parameter NOR = 3'd5;
parameter XOR = 3'd6;
parameter MULT = 3'd7;

always @ (posedge clk) begin
    case(i_ALUop)
        ADD: o_Data <= $signed(i_D1) + $signed(i_D2);
        SUB: o_Data <= $signed(i_D1) - $signed(i_D2);
        AND: o_Data <= i_D1 & i_D2;
        OR: o_Data <= i_D1 | i_D2;
        NAND: o_Data <= ~(i_D1 & i_D2);
        NOR: o_Data <= ~(i_D1 | i_D2);
        XOR: o_Data <= i_D1 ^ i_D2;
        MULT: o_Data <= i_D1 * i_D2;
    endcase
end
always @ ( * ) begin
    if(o_Data==0) o_ZERO <= 1;
    else o_ZERO <= 0;
end
always @ ( * ) begin
    o_LESS <= o_Data[15];
end
endmodule
