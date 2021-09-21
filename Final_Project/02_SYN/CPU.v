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
`include "../04_MEM/SRAM256W16B.v"
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
reg [15:0] core_1_r0, core_1_r1, core_1_r2, core_1_r3;
reg [15:0] core_1_r4, core_1_r5, core_1_r6, core_1_r7;
reg [15:0] core_2_r0, core_2_r1, core_2_r2, core_2_r3;
reg [15:0] core_2_r4, core_2_r5, core_2_r6, core_2_r7;
// -----------------------------
reg signed [DATA_WIDTH-1:0] X1 [7:0];
reg signed [DATA_WIDTH-1:0] X2 [7:0];
reg [DATA_WIDTH-1:0] DATA_MEM [7:0];

reg [ADDR_WIDTH-1:0] BRG_ADDR_inst_1;
reg [ADDR_WIDTH-1:0] BRG_ADDR_inst_2;
reg [ADDR_WIDTH-1:0] BRG_ADDR_data;
reg BRG_in_valid_inst_1;
reg BRG_in_valid_inst_2;
reg BRG_in_valid_data;
wire [DATA_WIDTH-1:0] BRG_o_DATA_inst_1;
wire [DATA_WIDTH-1:0] BRG_o_DATA_inst_2;
wire [DATA_WIDTH-1:0] BRG_o_DATA_data;
reg [DATA_WIDTH-1:0] BRG_i_DATA_data;
reg BRG_rw_data;
wire BRG_out_valid_inst_1;
wire BRG_out_valid_inst_2;
wire BRG_out_valid_data;
reg [DATA_WIDTH-1:0] SRAM_D_inst_1;
reg [DATA_WIDTH-1:0] SRAM_D_inst_2;
wire [DATA_WIDTH-1:0] SRAM_Q_inst_1;
wire [DATA_WIDTH-1:0] SRAM_Q_inst_2;
reg [7:0] SRAM_A_inst_1;
reg [7:0] SRAM_A_inst_2;
reg [2:0] SRAM_A_data;
reg SRAM_WEN_inst_1;
reg SRAM_WEN_inst_2;


SRAM256W16B s1(
   .Q(SRAM_Q_inst_1),
   .CLK(clk),
   .CEN(1'b0),
   .WEN(SRAM_WEN_inst_1),
   .A(SRAM_A_inst_1),
   .D(SRAM_D_inst_1),
   .OEN(1'b0)
);
SRAM256W16B s2(
   .Q(SRAM_Q_inst_2),
   .CLK(clk),
   .CEN(1'b0),
   .WEN(SRAM_WEN_inst_2),
   .A(SRAM_A_inst_2),
   .D(SRAM_D_inst_2),
   .OEN(1'b0)
);
INST_BRIDGE b1(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(BRG_in_valid_inst_1),
    .i_ADDR( BRG_ADDR_inst_1 ),
    .out_valid(BRG_out_valid_inst_1),
    .o_DATA(BRG_o_DATA_inst_1),
    .bid_m_inf_inst_1(bid_m_inf_inst_1),
    .bresp_m_inf_inst_1(bresp_m_inf_inst_1),
    .bvalid_M_inf(bvalid_m_inf_inst_1),
    .bready_M_inf(bready_m_inf_inst_1),
    .arid_M_inf(arid_m_inf_inst_1),
    .araddr_M_inf(araddr_m_inf_inst_1),
    .arlen_M_inf(arlen_m_inf_inst_1),
    .arsize_M_inf(arsize_m_inf_inst_1),
    .arburst_M_inf(arburst_m_inf_inst_1),
    .arvalid_M_inf(arvalid_m_inf_inst_1),
    .arready_M_inf(arready_m_inf_inst_1),
    .rid_m_inf_inst_1(rid_m_inf_inst_1),
    .rdata_m_inf_inst_1(rdata_m_inf_inst_1),
    .rresp_m_inf_inst_1(rresp_m_inf_inst_1),
    .rlast_M_inf(rlast_m_inf_inst_1),
    .rvalid_m_inf_inst_1(rvalid_m_inf_inst_1),
    .rready_M_inf(rready_m_inf_inst_1)
);
INST_BRIDGE b2(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(BRG_in_valid_inst_2),
    .i_ADDR( BRG_ADDR_inst_2 ),
    .out_valid(BRG_out_valid_inst_2),
    .o_DATA(BRG_o_DATA_inst_2),
    .bid_m_inf_inst_1(bid_m_inf_inst_2),
    .bresp_m_inf_inst_1(bresp_m_inf_inst_2),
    .bvalid_M_inf(bvalid_m_inf_inst_2),
    .bready_M_inf(bready_m_inf_inst_2),
    .arid_M_inf(arid_m_inf_inst_2),
    .araddr_M_inf(araddr_m_inf_inst_2),
    .arlen_M_inf(arlen_m_inf_inst_2),
    .arsize_M_inf(arsize_m_inf_inst_2),
    .arburst_M_inf(arburst_m_inf_inst_2),
    .arvalid_M_inf(arvalid_m_inf_inst_2),
    .arready_M_inf(arready_m_inf_inst_2),
    .rid_m_inf_inst_1(rid_m_inf_inst_2),
    .rdata_m_inf_inst_1(rdata_m_inf_inst_2),
    .rresp_m_inf_inst_1(rresp_m_inf_inst_2),
    .rlast_M_inf(rlast_m_inf_inst_2),
    .rvalid_m_inf_inst_1(rvalid_m_inf_inst_2),
    .rready_M_inf(rready_m_inf_inst_2)
);

DATA_BRIDGE b3(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(BRG_in_valid_data),
    .i_ADDR( BRG_ADDR_data ),
    .i_DATA(),
    .i_rw(BRG_rw_data),
    .out_valid(BRG_out_valid_data),
    .o_DATA(BRG_o_DATA_data),
    .awid_M_inf(awid_m_inf_data),
    .awaddr_M_inf(awaddr_m_inf_data),
    .awsize_M_inf(awsize_m_inf_data),
    .awburst_M_inf(awburst_m_inf_data),
    .awlen_M_inf(awlen_m_inf_data),
    .awvalid_M_inf(awvalid_m_inf_data),
    .awready_M_inf(awready_m_inf_data),
    .wdata_M_inf(wdata_m_inf_data),
    .wlast_M_inf(wlast_m_inf_data),
    .wvalid_M_inf(wvalid_m_inf_data),
    .wready_m_inf_inst_1(wready_m_inf_data),
    .bid_m_inf_inst_1(bid_m_inf_data),
    .bresp_m_inf_inst_1(bresp_m_inf_data),
    .bvalid_M_inf(bvalid_m_inf_data),
    .bready_M_inf(bready_m_inf_data),
    .arid_M_inf(arid_m_inf_data),
    .araddr_M_inf(araddr_m_inf_data),
    .arlen_M_inf(arlen_m_inf_data),
    .arsize_M_inf(arsize_m_inf_data),
    .arburst_M_inf(arburst_m_inf_data),
    .arvalid_M_inf(arvalid_m_inf_data),
    .arready_M_inf(arready_m_inf_data),
    .rid_m_inf_inst_1(rid_m_inf_data),
    .rdata_m_inf_inst_1(rdata_m_inf_data),
    .rresp_m_inf_inst_1(rresp_m_inf_data),
    .rlast_M_inf(rlast_m_inf_data),
    .rvalid_m_inf_inst_1(rvalid_m_inf_data),
    .rready_M_inf(rready_m_inf_data)
);

//###########################################
// Wrtie down your design below
//###########################################
//-------------------
// Main FSM
//-------------------

reg [2:0] state_c;
reg [2:0] state_n;
parameter  s_idle = 3'd0;
parameter  s_start = 3'd1;
parameter  s_run = 3'd2;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) state_c <= s_idle;
    else state_c <= state_n;
end
always @ ( * ) begin
    case(state_c)
        s_idle: state_n <= s_start;
        s_start: state_n <= s_run;
        s_run: state_n <= s_run;
        default: state_n <= s_idle;
    endcase
end
//-------------------
// read inst 1 mem
//-------------------
reg [2:0] s_c_inst_1;
reg [2:0] s_n_inst_1;
parameter  ss_idle = 3'd0;
parameter  ss_read = 3'd1;
parameter  ss_write = 3'd2;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_c_inst_1 <= ss_idle;
    else s_c_inst_1 <= s_n_inst_1;
end
always @ ( * ) begin
    case(s_c_inst_1)
        s_idle: if(BRG_out_valid_inst_1) s_n_inst_1 <= ss_read; else s_n_inst_1 <= ss_idle;
        ss_read: if(!BRG_out_valid_inst_1) s_n_inst_1 <= ss_idle; else s_n_inst_1 <= ss_read;
        default: s_n_inst_1 <= ss_idle;
    endcase
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_in_valid_inst_1 <=0;
    else if(state_n==s_start) BRG_in_valid_inst_1 <= 1;
    else BRG_in_valid_inst_1 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_ADDR_inst_1 <=0;
end
always @ (posedge clk) begin
    if(s_c_inst_1==ss_read) SRAM_A_inst_1 <= SRAM_A_inst_1 + 1;
    else SRAM_A_inst_1 <= BRG_ADDR_inst_1;
end
always @ (posedge clk) begin
    if(s_n_inst_1==ss_read) SRAM_D_inst_1 <= BRG_o_DATA_inst_1;
    else SRAM_D_inst_1 <= 0;
end
always @ (posedge clk) begin
    if(s_n_inst_1==ss_read) SRAM_WEN_inst_1 <= 0;
    else SRAM_WEN_inst_1 <= 1;
end
//-------------------
// read inst 2 mem
//-------------------
reg [2:0] s_c_inst_2;
reg [2:0] s_n_inst_2;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_c_inst_2 <= ss_idle;
    else s_c_inst_2 <= s_n_inst_2;
end
always @ ( * ) begin
    case(s_c_inst_2)
        s_idle: if(BRG_out_valid_inst_2) s_n_inst_2 <= ss_read; else s_n_inst_2 <= ss_idle;
        ss_read: if(!BRG_out_valid_inst_2) s_n_inst_2 <= ss_idle; else s_n_inst_2 <= ss_read;
        default: s_n_inst_2 <= ss_idle;
    endcase
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_in_valid_inst_2 <=0;
    else if(state_n==s_start) BRG_in_valid_inst_2 <= 1;
    else BRG_in_valid_inst_2 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_ADDR_inst_2 <=0;
end
always @ (posedge clk) begin
    if(s_c_inst_2==ss_read) SRAM_A_inst_2 <= SRAM_A_inst_2 + 1;
    else SRAM_A_inst_2 <= BRG_ADDR_inst_2;
end
always @ (posedge clk) begin
    if(s_n_inst_2==ss_read) SRAM_D_inst_2 <= BRG_o_DATA_inst_2;
    else SRAM_D_inst_2 <= 0;
end
always @ (posedge clk) begin
    if(s_n_inst_2==ss_read) SRAM_WEN_inst_2 <= 0;
    else SRAM_WEN_inst_2 <= 1;
end
//-------------------
// read data mem
//-------------------
reg [2:0] s_c_data;
reg [2:0] s_n_data;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_c_data <= ss_idle;
    else s_c_data <= s_n_data;
end
always @ ( * ) begin
    case(s_c_data)
        ss_idle: if(BRG_out_valid_data) s_n_data <= ss_read; else s_n_data <= ss_idle;
        ss_read: if(!BRG_out_valid_data) s_n_data <= ss_write; else s_n_data <= ss_read;
        ss_write: s_n_data <= ss_write;
        default: s_n_data <= ss_idle;
    endcase
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_in_valid_data <=0;
    else if(state_n==s_start) BRG_in_valid_data <= 1;
    else BRG_in_valid_data <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_ADDR_data <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_DATA_data <=0;
    else if((s_n_data==ss_write)&&BRG_out_valid_data) BRG_i_DATA_data <= DATA_MEM[SRAM_A_data];
    else BRG_i_DATA_data <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_rw_data <=0;
    else if(s_n_data==ss_write) BRG_rw_data <=1;
    else BRG_rw_data <=0;
end
always @ (posedge clk) begin
    if(s_n_data==ss_read) SRAM_A_data <= SRAM_A_data + 1;
    else if((s_n_data==ss_write)&&BRG_out_valid_data) SRAM_A_data <= SRAM_A_data + 1;
    else SRAM_A_data <= BRG_ADDR_data;
end
always @ (posedge clk) begin
    if(BRG_out_valid_data) begin
        DATA_MEM[SRAM_A_data] <= BRG_o_DATA_data;
    end
end









//-------------------
// output
//-------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) stall_core1 <=1 ;
    else stall_core1 <=1 ;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) stall_core2 <=1 ;
    else stall_core2 <=1 ;
end
always @ ( * ) begin
    core_1_r0 <= X1[0];
    core_1_r1 <= X1[1];
    core_1_r2 <= X1[2];
    core_1_r3 <= X1[3];
    core_1_r4 <= X1[4];
    core_1_r5 <= X1[5];
    core_1_r6 <= X1[6];
    core_1_r7 <= X1[7];
    core_2_r0 <= X2[0];
    core_2_r1 <= X2[1];
    core_2_r2 <= X2[2];
    core_2_r3 <= X2[3];
    core_2_r4 <= X2[4];
    core_2_r5 <= X2[5];
    core_2_r6 <= X2[6];
    core_2_r7 <= X2[7];
end
endmodule
