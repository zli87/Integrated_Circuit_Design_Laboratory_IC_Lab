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

module INST_CONTROLLER #(parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=16, R_LEN=8'd255)  (
  // Input
      input clk,
    input rst_n,
   // controll signal for only read mode
    input i_valid,
    input [13-1:0] i_addr,
    output reg o_valid,
    output reg [DATA_WIDTH-1:0] o_data,
  //===== AXI-4 Instruction Memory #1 =====
    input [ID_WIDTH-1:0] bid_m_inf_inst ,
    input [1:0] bresp_m_inf_inst ,
    input bvalid_m_inf_inst ,
    output bready_m_inf_inst,

      output [ID_WIDTH-1:0] arid_m_inf_inst ,
     output [ADDR_WIDTH-1:0] araddr_m_inf_inst ,
      output [7:0] arlen_m_inf_inst ,
     output [2:0] arsize_m_inf_inst ,
    output [1:0] arburst_m_inf_inst ,
    output arvalid_m_inf_inst ,
    input arready_m_inf_inst ,

    input [ID_WIDTH-1:0] rid_m_inf_inst ,
    input [DATA_WIDTH-1:0] rdata_m_inf_inst ,
    input [1:0] rresp_m_inf_inst ,
    input rlast_m_inf_inst ,
    input rvalid_m_inf_inst ,
    output rready_m_inf_inst

//    output [ID_WIDTH-1:0] awid_m_inf_inst ,
//   output [ADDR_WIDTH-1:0] awaddr_m_inf_inst ,
//   output [2:0] awsize_m_inf_inst ,
//  output [1:0] awburst_m_inf_inst ,
//    output [7:0] awlen_m_inf_inst ,
//  output awvalid_m_inf_inst ,
//  input awready_m_inf_inst ,

//      output [DATA_WIDTH-1:0] wdata_m_inf_inst ,
//      output wlast_m_inf_inst ,
//     output wvalid_m_inf_inst ,
//     input wready_m_inf_inst
);

reg [DATA_WIDTH-1:0] SRAM_D;
wire [DATA_WIDTH-1:0] SRAM_Q;
reg [7:0] SRAM_A;
reg SRAM_WEN;

reg [13-1:0] I_ADDR;
reg I_VALID;
reg [4+1-1:0] BASE_ADDR_HEAD; // BASE_ADDR = {BASE_ADDR_HEAD, 9'h00}
wire [4-1:0] ADDR_HEAD;
reg [7:0] ADDR_OFFSET;
wire SRAM_REFRESH;

assign ADDR_HEAD = i_addr[13-1:9];
assign SRAM_REFRESH = ( i_addr[13-1:9]!=BASE_ADDR_HEAD);

reg BRG_i_valid;
reg [ADDR_WIDTH-1:0] BRG_i_addr;
wire BRG_o_valid;
wire [DATA_WIDTH-1:0] BRG_o_data;
INST_BRIDGE bridge_1(
    .clk(clk),
    .rst_n(rst_n),
    // connect with controller
    .in_valid(BRG_i_valid),
    .i_ADDR(BRG_i_addr),
    .out_valid(BRG_o_valid),
    .o_DATA(BRG_o_data),
    // connect with dram
    .bid_m_inf_inst_1(bid_m_inf_inst),
    .bresp_m_inf_inst_1(bresp_m_inf_inst),
    .bvalid_M_inf(bvalid_m_inf_inst),
    .bready_M_inf(bready_m_inf_inst),
    .arid_M_inf(arid_m_inf_inst),
    .araddr_M_inf(araddr_m_inf_inst),
    .arlen_M_inf(arlen_m_inf_inst),
    .arsize_M_inf(arsize_m_inf_inst),
    .arburst_M_inf(arburst_m_inf_inst),
    .arvalid_M_inf(arvalid_m_inf_inst),
    .arready_M_inf(arready_m_inf_inst),
    .rid_m_inf_inst_1(rid_m_inf_inst),
    .rdata_m_inf_inst_1(rdata_m_inf_inst),
    .rresp_m_inf_inst_1(rresp_m_inf_inst),
    .rlast_M_inf(rlast_m_inf_inst),
    .rvalid_m_inf_inst_1(rvalid_m_inf_inst),
    .rready_M_inf(rready_m_inf_inst)
);

SRAM256W16B s1(
   .Q(SRAM_Q),
   .CLK(clk),
   .CEN(1'b0),
   .WEN(SRAM_WEN),
   .A(SRAM_A),
   .D(SRAM_D),
   .OEN(1'b0)
);
always @ (posedge clk) begin
    I_ADDR <= i_addr;
    I_VALID <= i_valid;
end
//  Algorithm Instruction Controller
//   1  i_valid => input i_addr
//   2  if BASE_ADD < i_addr < RBASE_ADDR + 255
//   3      read sram
//   4      output data
//   5  else
//   6      read dram
//   7      write sram
//   8      read sram
//   9      output data
reg [2:0] s_c ;
reg [2:0] s_n ;
parameter  s_idle = 3'd0;
parameter  s_init_addr = 3'd1;
parameter  s_init_sram = 3'd2;
parameter  s_read_sram_1 = 3'd3;
parameter  s_wait = 3'd4;
parameter  s_read_sram_2 = 3'd5;
parameter  s_out = 3'd6;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_c <= s_idle;
    else s_c <= s_n ;
end
always @ ( * ) begin
    case(s_c)
        s_idle: if(I_VALID) s_n <= s_init_addr; else s_n <= s_idle;
        s_init_addr: if(BRG_o_valid) s_n <= s_init_sram; else s_n <= s_init_addr;
        s_init_sram: if(!BRG_o_valid) s_n <= s_read_sram_1; else s_n <= s_init_sram;
        s_read_sram_1: s_n <= s_out;
        s_wait: if(I_VALID & (!SRAM_REFRESH)) s_n <= s_read_sram_2;
                else if(I_VALID & (SRAM_REFRESH)) s_n <= s_init_addr;
                else s_n <= s_wait;
        s_read_sram_2: s_n <= s_out;
        s_out: s_n <= s_wait;
        default: s_n <= s_idle;
    endcase
end
always @ (posedge clk) begin
    if(I_VALID) begin
        //$strobe("BASE_ADDR_HEAD %h",BASE_ADDR_HEAD);
        //$strobe("BRG_i_valid %h",BRG_i_valid);
        //$strobe("BRG_i_addr %h",BRG_i_addr);
        //$strobe("i_addr %h",i_addr);
        //$strobe("ADDR_OFFSET %h",ADDR_OFFSET);
        //$strobe("");
        //if((s_n==s_init_addr)) $display("***********************");
    end
end
// addr controll
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BASE_ADDR_HEAD <= 5'h10;
    else if((s_c==s_idle) && (s_n==s_init_addr)) BASE_ADDR_HEAD <=  I_ADDR[13-1:9];
    else if((s_c==s_wait) && (s_n==s_init_addr)) BASE_ADDR_HEAD <=  I_ADDR[13-1:9];
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) ADDR_OFFSET <= 0;
    else if((s_c==s_idle) && (s_n==s_init_addr)) ADDR_OFFSET <= I_ADDR[8:1];
    else if((s_c==s_wait) && (s_n==s_init_addr)) ADDR_OFFSET <= I_ADDR[8:1];
end
// Bridge controll
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_valid <=0;
    else if((s_c==s_idle) && (s_n==s_init_addr)) BRG_i_valid <= 1;
    else if((s_c==s_wait) && (s_n==s_init_addr)) BRG_i_valid <= 1;
    else BRG_i_valid <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_addr <=0;
    else if((s_c==s_idle) && (s_n==s_init_addr)) BRG_i_addr <= { I_ADDR[13-1:9],9'h00};
    else if((s_c==s_wait) && (s_n==s_init_addr)) BRG_i_addr <= { I_ADDR[13-1:9],9'h00};
    else BRG_i_addr <= 0;
end
// sram controll
always @ (posedge clk) begin
    if( s_n==s_read_sram_2 )  SRAM_A <= I_ADDR[8:1];
    else if(s_n==s_read_sram_1 )  SRAM_A <= ADDR_OFFSET;
    else if(s_c==s_init_sram )  SRAM_A <= SRAM_A + 1;
    else SRAM_A <= 0;

end
always @ (posedge clk) begin
    if(s_n==s_init_sram ) SRAM_D <= BRG_o_data;
    else SRAM_D <= 0;
end
always @ (posedge clk) begin
    if(s_n==s_init_sram ) SRAM_WEN <= 0;
    else SRAM_WEN <= 1;
end
// output controll
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_valid <=0;
    else if(s_c==s_out) o_valid <= 1;
    else o_valid <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_data <=0;
    else if(s_c==s_out) o_data <= SRAM_Q;
    else o_data <=0;
end
endmodule
module INST_BRIDGE(
    clk,
    rst_n,
    // connect with controller
    in_valid,
    i_ADDR,
    out_valid,
    o_DATA,
    // connect with dram
    bid_m_inf_inst_1,
    bresp_m_inf_inst_1,
    bvalid_M_inf,
    bready_M_inf,
    arid_M_inf,
    araddr_M_inf,
    arlen_M_inf,
    arsize_M_inf,
    arburst_M_inf,
    arvalid_M_inf,
    arready_M_inf,
    rid_m_inf_inst_1,
    rdata_m_inf_inst_1,
    rresp_m_inf_inst_1,
    rlast_M_inf,
    rvalid_m_inf_inst_1,
    rready_M_inf
);
parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=16;
parameter RW_LEN = 8'd255;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_m_inf_inst_1;
input  wire  [1:0]             bresp_m_inf_inst_1;
input  wire                   bvalid_M_inf;
// src master
output reg                   bready_M_inf;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_M_inf;
output reg [ADDR_WIDTH-1:0]  araddr_M_inf;
output reg [7:0]              arlen_M_inf;
output reg [2:0]             arsize_M_inf;
output reg [1:0]            arburst_M_inf;
output reg                  arvalid_M_inf;
// src slave
input  wire                  arready_M_inf;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_m_inf_inst_1;
input  wire [DATA_WIDTH-1:0]   rdata_m_inf_inst_1;
input  wire [1:0]              rresp_m_inf_inst_1;
input  wire                    rlast_M_inf;
input  wire                   rvalid_m_inf_inst_1;
// master
output reg                   rready_M_inf;

// bridge
input clk;
input rst_n;
input [ADDR_WIDTH-1:0] i_ADDR;
input in_valid;
output out_valid;
output [DATA_WIDTH-1:0] o_DATA;

assign out_valid = rvalid_m_inf_inst_1;
assign o_DATA = rdata_m_inf_inst_1;
parameter s_idle = 3'd0;
parameter s_i_addr = 3'd1;
parameter s_i_data = 3'd2;
parameter s_o_addr = 3'd3;
parameter s_o_data = 3'd4;
parameter s_out = 3'd5;
reg [2:0] state_c;
reg [2:0] state_n;
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) state_c <= s_idle;
    else state_c <= state_n;
end
always @ ( * ) begin
    case(state_c)
        s_idle: if (in_valid) state_n <= s_i_addr;
                else state_n <= s_idle;
        s_i_addr: if(arready_M_inf) state_n <= s_i_data; else state_n <= s_i_addr;
        s_i_data: if(rlast_M_inf) state_n <= s_idle; else state_n <= s_i_data;
        default:state_n <= s_idle;
    endcase
end

//--------------------------------------------------------------
// DRAM
//--------------------------------------------------------------
// read address
assign arid_M_inf = 0;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) araddr_M_inf <= 32'd0;
    else if(in_valid) araddr_M_inf <= i_ADDR;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arlen_M_inf <=0;
    else if(state_c==s_i_addr) arlen_M_inf <= RW_LEN;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arsize_M_inf <=0;
    else if(state_c==s_i_addr) arsize_M_inf <= 3'b010; // 4 byte = 32 bit
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arburst_M_inf <=0;
    else if(state_c==s_i_addr) arburst_M_inf <= 2'd01;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arvalid_M_inf <=0;
    else if(arready_M_inf) arvalid_M_inf <= 0;
    else if(state_c==s_i_addr) arvalid_M_inf <= 2'd01;
end
// read data
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) rready_M_inf <=0;
    else if(arready_M_inf) rready_M_inf <= 1;
    else if(rlast_M_inf) rready_M_inf <=1;
end

endmodule
module DATA_BRIDGE2(
    clk,
    rst_n,
    C_in_valid_1,
    C_addr_1,
    C_data_w_1,
    C_r_wb_1,
    C_out_valid_1,
    C_data_r_1,
    C_in_valid_2,
    C_addr_2,
    C_data_w_2,
    C_r_wb_2,
    C_out_valid_2,
    C_data_r_2,
    awid_M_inf,
    AW_ADDR,
    awsize_M_inf,
    awburst_M_inf,
    awlen_M_inf,
    AW_VALID,
    AW_READY,
    W_DATA,
    W_LAST,
    W_VALID,
    W_READY,
    bid_M_inf,
    B_RESP,
    B_VALID,
    B_READY,
    arid_M_inf,
    AR_ADDR,
    arlen_M_inf,
    arsize_M_inf,
    arburst_M_inf,
    AR_VALID,
    AR_READY,
    rid_M_inf,
    R_DATA,
    rresp_M_inf,
    rlast_M_inf,
    R_VALID,
    R_READY
);
parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=16;
parameter RW_LEN = 8'd0;

output wire [ID_WIDTH-1:0]      awid_M_inf;
output reg [ADDR_WIDTH-1:0]  AW_ADDR;
output wire [2:0]             awsize_M_inf;
output wire [1:0]            awburst_M_inf;
output wire [7:0]              awlen_M_inf;
output reg                  AW_VALID;
// src slave
input  wire                  AW_READY;
// -------------------------

// axi write data channel
// src master
output reg [DATA_WIDTH-1:0]   W_DATA;
output reg                   W_LAST;
output reg                   W_VALID;
// src slave
input  wire                   W_READY ;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_M_inf ;
input  wire  [1:0]             B_RESP ;
input  wire                   B_VALID;
// src master
output reg                   B_READY;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_M_inf;
output reg [ADDR_WIDTH-1:0]  AR_ADDR;
output wire [7:0]              arlen_M_inf;
output wire [2:0]             arsize_M_inf;
output wire [1:0]            arburst_M_inf;
output reg                  AR_VALID;
// src slave
input  wire                  AR_READY;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_M_inf ;
input  wire [DATA_WIDTH-1:0]   R_DATA;
input  wire [1:0]              rresp_M_inf ;
input  wire                    rlast_M_inf;
input  wire                   R_VALID;
// master
output reg                   R_READY;

// bridge
input clk;
input rst_n;
input [13-1:0] C_addr_1,C_addr_2;
input C_in_valid_1,C_in_valid_2;
input [DATA_WIDTH-1:0] C_data_w_1,C_data_w_2;
input C_r_wb_1,C_r_wb_2;
output reg C_out_valid_1,C_out_valid_2;
output reg [DATA_WIDTH-1:0] C_data_r_1,C_data_r_2;

assign   arid_M_inf = 0;
assign   arlen_M_inf = 0;
assign   arsize_M_inf = 2;
assign   arburst_M_inf = 1;
assign   awid_M_inf = 0;
assign   awsize_M_inf = 2;
assign   awburst_M_inf = 1;
assign   awlen_M_inf = 0;

reg C_1_IV,C_2_IV;
reg [13-1:0] C_1_ADDR,C_2_ADDR;
reg [DATA_WIDTH-1:0] C_1_DATA_W,C_2_DATA_W;
reg C_1_RW,C_2_RW;

reg C_in_valid;
reg C_r_wb;
reg [15:0] C_data_w;
reg [13-1:0] C_addr;

reg [2:0] s_c,s_n;
parameter s_IDLE=3'd0;
parameter s_PRE_1=3'd1;
parameter s_PRE_2=3'd2;
parameter s_RW_1=3'd3;
parameter s_RW_2=3'd4;

//assign C_in_valid = (s_c==s_IDLE && s_n!=s_IDLE)? 1 : 0;
//assign C_r_wb = (s_n==s_RW_1)? C_RW_1 : C_RW_2;
//assign C_data_w = (s_n==s_RW_1)? C_DATA_W_1 : C_DATA_W_2;
//assign C_addr = (s_n==s_RW_1)? C_ADDR_1 : C_ADDR_2;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin C_in_valid <= 0;
    end else if(s_c==s_PRE_1 && s_n==s_RW_1) C_in_valid <= 1;
     else if(s_c==s_PRE_2 && s_n==s_RW_2) C_in_valid <= 1;
    else C_in_valid <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin C_r_wb <= 0;
    end else if(s_c==s_IDLE && s_n==s_PRE_1) C_r_wb <= C_1_RW;
     else if(s_c==s_IDLE && s_n==s_PRE_2) C_r_wb <= C_2_RW;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin C_data_w <= 0;
    end else if(s_c==s_IDLE && s_n==s_PRE_1) C_data_w <= C_1_DATA_W;
     else if(s_c==s_IDLE && s_n==s_PRE_2) C_data_w <= C_2_DATA_W;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin C_addr <= 0;
    end else if(s_c==s_IDLE && s_n==s_PRE_1) C_addr <= C_1_ADDR;
     else if(s_c==s_IDLE && s_n==s_PRE_2) C_addr <= C_2_ADDR;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        C_1_IV <= 0;
        C_1_ADDR<= 0;
        C_1_DATA_W<= 0;
        C_1_RW <= 1;
    end else if(C_in_valid_1) begin
        C_1_IV <= 1;
        C_1_ADDR<= C_addr_1;
        C_1_DATA_W<= C_data_w_1;
        C_1_RW <= C_r_wb_1;
    end else if(C_out_valid_1) begin
        C_1_IV <= 0;
        C_1_ADDR<= 0;
        C_1_DATA_W<= 0;
        C_1_RW <= 1;
    end
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        C_2_IV <= 0;
        C_2_ADDR<= 0;
        C_2_DATA_W<= 0;
        C_2_RW <= 1;
    end else if(C_in_valid_2) begin
        C_2_IV <= 1;
        C_2_ADDR<= C_addr_2;
        C_2_DATA_W<= C_data_w_2;
        C_2_RW <= C_r_wb_2;
    end else if(C_out_valid_2) begin
        C_2_IV <= 0;
        C_2_ADDR<= 0;
        C_2_DATA_W<= 0;
        C_2_RW <= 1;
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_c <= s_IDLE;
    else s_c <= s_n;
end
always @ ( * ) begin
    case(s_c)
        s_IDLE: if(C_1_IV) s_n <= s_PRE_1;
                else if(C_2_IV) s_n <= s_PRE_2;
                else s_n <= s_IDLE;
        s_PRE_1: s_n <= s_RW_1 ;
        s_PRE_2: s_n <= s_RW_2 ;
        s_RW_1: if(C_out_valid_1) s_n <= s_IDLE; else s_n <= s_RW_1;
        s_RW_2: if(C_out_valid_2) s_n <= s_IDLE; else s_n <= s_RW_2;
        default:s_n <= s_IDLE;
    endcase
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) C_out_valid_1 = 0;
    else if(B_VALID | R_VALID && s_c==s_RW_1)  C_out_valid_1 = 1;
    else C_out_valid_1 = 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) C_out_valid_2 = 0;
    else if(B_VALID | R_VALID && s_c==s_RW_2)  C_out_valid_2 = 1;
    else C_out_valid_2 = 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) C_data_r_1 <=0;
    else if(R_VALID && s_c==s_RW_1) C_data_r_1 <= R_DATA;
    else C_data_r_1 <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) C_data_r_2 <=0;
    else if(R_VALID && s_c==s_RW_2) C_data_r_2 <= R_DATA;
    else C_data_r_2 <=0;
end
/*
output AR_READY,
output R_VALID,
output R_DATA,
output AW_READY,
output W_READY,
output B_VALID,
output B_RESP,
// read
input AR_VALID,
input AR_ADDR,
input R_READY,
// write
input AW_VALID,
input AW_ADDR,
input W_VALID,
input W_DATA,
input B_READY
*/
//--------------------------------------------------
// read
//--------------------------------------------------
// AR_VALID
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) AR_VALID = 0;
    else if(C_in_valid && (C_r_wb)) AR_VALID = 1;
    else if(AR_READY) AR_VALID = 0;
end
// AR_ADDR
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) AR_ADDR = 0;
    else if(C_in_valid && (C_r_wb)) begin
        AR_ADDR = C_addr;
        //$strobe("read addr %h",AR_ADDR);
    end
    else if(AR_READY) AR_ADDR = 0;
end
// R_READY
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) R_READY = 0;
    else if(C_in_valid && (C_r_wb)) R_READY = 1;
    else if(R_VALID) R_READY = 0;
end

//--------------------------------------------------
// write
//--------------------------------------------------
// AW_VALID
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) AW_VALID = 0;
    else if(C_in_valid && (!C_r_wb)) AW_VALID = 1;
    else if(AW_READY) AW_VALID = 0;
end
// AW_ADDR
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) AW_ADDR = 0;
    else if(C_in_valid && (!C_r_wb)) begin
        AW_ADDR = C_addr ;
        //$strobe("write addr %h",inf.AW_ADDR);
    end
    else if(AW_READY) AW_ADDR = 0;
end
// W_VALID
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) W_VALID = 0;
    else if(C_in_valid && (!C_r_wb)) W_VALID = 1;
    else if( W_READY ) W_VALID = 0;
end
// W_DATA
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) W_DATA = 0;
    else if(C_in_valid && (!C_r_wb)) W_DATA =  C_data_w;
    else if( W_READY ) W_DATA = 0;
end
// B_READY
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) B_READY = 0;
    else if(C_in_valid && (!C_r_wb)) B_READY = 1;
    else if( B_VALID ) B_READY = 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) W_LAST = 1;
    //else if(W_READY) W_LAST <= 1;
    else W_LAST = 1;
end
endmodule
