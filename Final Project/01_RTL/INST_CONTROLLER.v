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
