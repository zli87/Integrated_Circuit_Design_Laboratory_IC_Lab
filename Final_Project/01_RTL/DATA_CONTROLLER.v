module DATA_CONTROLLER  #(parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=16, RW_LEN=8'd255) (
// Input
        input clk ,
     input rst_n ,
// controll signal for read/write mode
      input i_valid_1 ,
      input [DATA_WIDTH-1:0] i_data_1 ,
      input [13-1:0] i_addr_1 ,
      input i_rw_1 ,
      output reg o_valid_1 ,
      output reg [DATA_WIDTH-1:0] o_data_1 ,
      input i_valid_2 ,
      input [DATA_WIDTH-1:0] i_data_2 ,
      input [13-1:0] i_addr_2 ,
      input i_rw_2 ,
      output reg o_valid_2 ,
      output reg [DATA_WIDTH-1:0] o_data_2 ,
//===== AXI-4 Data Memory =====
     output [ID_WIDTH-1:0] arid_m_inf_data ,
   output [ADDR_WIDTH-1:0] araddr_m_inf_data ,
    output [7:0] arlen_m_inf_data ,
   output [2:0] arsize_m_inf_data ,
  output [1:0] arburst_m_inf_data ,
  output arvalid_m_inf_data ,
  input arready_m_inf_data ,

     input [ID_WIDTH-1:0] rid_m_inf_data ,
    input [DATA_WIDTH-1:0]rdata_m_inf_data ,
    input [1:0] rresp_m_inf_data ,
    input rlast_m_inf_data ,
   input rvalid_m_inf_data ,
   output rready_m_inf_data ,

    output [ID_WIDTH-1:0] awid_m_inf_data ,
   output [ADDR_WIDTH-1:0] awaddr_m_inf_data ,
   output [2:0] awsize_m_inf_data ,
  output [1:0] awburst_m_inf_data ,
    output [7:0] awlen_m_inf_data ,
  output awvalid_m_inf_data ,
  input awready_m_inf_data ,

    output [DATA_WIDTH-1:0] wdata_m_inf_data ,
    output wlast_m_inf_data ,
   output wvalid_m_inf_data ,
   input wready_m_inf_data ,

      input [ID_WIDTH-1:0] bid_m_inf_data ,
    input [1:0] bresp_m_inf_data ,
   input bvalid_m_inf_data ,
   output bready_m_inf_data  );

integer i;
reg I_VALID[1:0];
reg [13-1:0] I_ADDR[1:0];
reg [DATA_WIDTH-1:0] I_DATA[1:0];
reg I_RW[1:0];
reg [4-1:0] I_BANK[1:0];

reg BRG_i_valid;
reg BRG_i_rw;
reg [ADDR_WIDTH-1:0] BRG_i_addr;
reg [DATA_WIDTH-1:0] BRG_i_data;
wire BRG_o_valid;
wire [DATA_WIDTH-1:0] BRG_o_data;

reg [5-1:0] BASE_BANK[3:0];
wire [3:0] ADDR_HIT_SRAM [1:0]; // cpu 0 hit 4 sram // cpu 1 hit 4 sram
reg [3:0] SRAM_DIRTY;
reg [1:0] SRAM_NUM; // sram 0~3
reg [1:0] CACHE [3:0];

reg [DATA_WIDTH-1:0] SRAM_D [3:0];
wire [DATA_WIDTH-1:0] SRAM_Q [3:0];
reg [7:0] SRAM_A [3:0];
reg [3:0] SRAM_WEN;

DATA_BRIDGE bridge(
    .clk(clk),
    .rst_n(rst_n),
    .in_valid(BRG_i_valid),
    .i_rw(BRG_i_rw),
    .i_ADDR(BRG_i_addr),
    .i_DATA(BRG_i_data),
    .out_valid(BRG_o_valid),
    .o_DATA(BRG_o_data),
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

SRAM256W16B s0(   .Q(SRAM_Q[0]),   .CLK(clk),   .CEN(1'b0),   .WEN(SRAM_WEN[0]),   .A(SRAM_A[0]),   .D(SRAM_D[0]),   .OEN(1'b0)    );
SRAM256W16B s1(   .Q(SRAM_Q[1]),   .CLK(clk),   .CEN(1'b0),   .WEN(SRAM_WEN[1]),   .A(SRAM_A[1]),   .D(SRAM_D[1]),   .OEN(1'b0)    );
SRAM256W16B s2(   .Q(SRAM_Q[2]),   .CLK(clk),   .CEN(1'b0),   .WEN(SRAM_WEN[2]),   .A(SRAM_A[2]),   .D(SRAM_D[2]),   .OEN(1'b0)    );
SRAM256W16B s3(   .Q(SRAM_Q[3]),   .CLK(clk),   .CEN(1'b0),   .WEN(SRAM_WEN[3]),   .A(SRAM_A[3]),   .D(SRAM_D[3]),   .OEN(1'b0)    );

always @ ( * ) begin
    for(i=0;i<2;i=i+1)
        I_BANK[i] <= I_ADDR[i][13-1:9];
end
reg [3:0] s_c ;
reg [3:0] s_n ;
parameter  s_idle = 4'd0;
parameter  s_check_cpu_0_hit = 4'd1;
parameter  s_cpu_0_hit = 4'd2;
parameter  s_check_cpu_1_hit = 4'd3;
parameter  s_cpu_1_hit = 4'd4;
parameter  s_check_cpu_0_miss = 4'd5;
parameter  s_check_cpu_1_miss = 4'd6;
parameter  s_cpu_0_miss = 4'd7;
parameter  s_cpu_1_miss = 4'd8;
parameter  s_cpu_0_rehit = 4'd9;
parameter  s_cpu_1_rehit = 4'd10;
parameter  s_out = 4'd11;

reg [3:0] ss_c ;
reg [3:0] ss_n ;
parameter  ss_idle = 4'd0;
parameter  ss_init_waddr = 4'd1;
parameter  ss_init_store = 4'd2;
parameter  ss_init_raddr = 4'd3;
parameter  ss_init_sram = 4'd4;
parameter  ss_loaded = 4'd5;


always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_c <= s_idle;
    else s_c <= s_n;
end
// cpu 0 & cpu 1
// only cpu 0
// only cpu 1
// CHECK HIT FSM
// for SRAM signal control
always @ ( * ) begin
    case(s_c)
        s_idle: if(I_VALID[0]|I_VALID[1]) s_n <= s_check_cpu_0_hit; // do cpu 0 first
                else s_n <= s_idle;
        s_check_cpu_0_hit:    if( I_VALID[0] && ( ADDR_HIT_SRAM[0] != 0 )) s_n <= s_cpu_0_hit;
                              else s_n <= s_check_cpu_1_hit;
        s_cpu_0_hit:          if(I_VALID[1]) s_n <= s_check_cpu_1_hit;
                              else s_n <= s_out;
        s_check_cpu_1_hit:    if( I_VALID[1] && ( ADDR_HIT_SRAM[1] != 0 )) s_n <= s_cpu_1_hit;
                              else s_n <= s_cpu_1_miss;
        s_cpu_1_hit:          if(I_VALID[0]) s_n <= s_check_cpu_0_miss;
                              else  s_n <= s_out;
        s_check_cpu_0_miss:   if( I_VALID[0] && ( ADDR_HIT_SRAM[0] != 0 )) s_n <= s_check_cpu_1_miss;
                              else s_n <= s_cpu_0_miss;
        s_check_cpu_1_miss:   if( I_VALID[1] && ( ADDR_HIT_SRAM[1] != 0 )) s_n <= s_out;
                              else s_n <= s_cpu_1_miss;
        s_cpu_0_miss:         if(ss_n==ss_loaded) s_n <= s_cpu_0_rehit; else s_n <= s_cpu_0_miss; // wait for reload
        s_cpu_1_miss:         if(ss_n==ss_loaded) s_n <= s_cpu_1_rehit; else s_n <= s_cpu_1_miss; // wait for reload
        s_cpu_0_rehit:        s_n <= s_check_cpu_1_miss;
        s_cpu_1_rehit:        s_n <= s_out;
        s_out:                s_n <= s_idle;
        //default: begin $display("error"); $finish; end
    endcase
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) ss_c <= ss_idle;
    else ss_c <= ss_n;
end
// READ/WRITE FSM
// for DRAM signal control
always @ ( * ) begin
  case(ss_c)
    ss_idle:  if((s_c==s_cpu_0_miss)|(s_c==s_cpu_1_miss)) begin
                  if(SRAM_DIRTY[CACHE[3]]==1) ss_n <= ss_init_waddr;
                  else ss_n <= ss_init_raddr;
              end else ss_n <= ss_idle;
    ss_init_waddr:  if(BRG_o_valid) ss_n <= ss_init_store; else ss_n <= ss_init_waddr;
    ss_init_store:    if(!BRG_o_valid) ss_n <= ss_init_raddr; else ss_n <= ss_init_store;
    ss_init_raddr:  if(BRG_o_valid) ss_n <= ss_init_sram; else ss_n <= ss_init_raddr;
    ss_init_sram:   if(!BRG_o_valid) ss_n <= ss_loaded; else ss_n <= ss_init_sram;
    ss_loaded: s_n <= ss_idle;
    default:ss_n <= ss_idle;
  endcase
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0;i<2;i=i+1) begin
          I_VALID[i] <= 0;
          I_ADDR[i] <= 0;
          I_DATA[i] <= 0;
          I_RW[i] <= 0;
        end
    end else begin
      if(i_valid_1) begin
        I_VALID[0] <= i_valid_1;
        I_ADDR[0] <= i_addr_1;
        I_DATA[0] <= i_data_1;
        I_RW[0] <= i_rw_1;
      end
      if(i_valid_2) begin
        I_VALID[1] <= i_valid_2;
        I_ADDR[1] <= i_addr_2;
        I_DATA[1] <= i_data_2;
        I_RW[1] <= i_rw_2;
      end
      if(o_valid_1) I_VALID[0] <= 0;
      if(o_valid_2) I_VALID[1] <= 0;
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin    // initial is impossible adress !
        for(i=0;i<4;i=i+1)
          BASE_BANK[i] <= i;
    end
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0;i<4;i=i+1)
          SRAM_DIRTY[i] <=0;
    end
end

// JOB_ADDR hit sram 0
assign ADDR_HIT_SRAM[0][0] = (BASE_BANK[0] == I_BANK[0]);
assign ADDR_HIT_SRAM[0][1] = (BASE_BANK[1] == I_BANK[0]);
assign ADDR_HIT_SRAM[0][2] = (BASE_BANK[2] == I_BANK[0]);
assign ADDR_HIT_SRAM[0][3] = (BASE_BANK[3] == I_BANK[0]);
// JOB_ADDR hit sram 1
assign ADDR_HIT_SRAM[1][0] = (BASE_BANK[0] == I_BANK[1]);
assign ADDR_HIT_SRAM[1][1] = (BASE_BANK[1] == I_BANK[1]);
assign ADDR_HIT_SRAM[1][2] = (BASE_BANK[2] == I_BANK[1]);
assign ADDR_HIT_SRAM[1][3] = (BASE_BANK[3] == I_BANK[1]);

//  Algorithm Data Controller
//   1  i_valid_[i] => input i_addr_[i]
//   2  if read
//   3      if BASE_ADD_1 < i_addr_[i] < RBASE_ADDR_1 + 255
//   4          read sram 1
//   5          output data
//   6      else if BASE_ADD_2 < i_addr_[i] < RBASE_ADDR_2 + 255
//   7          read sram 2
//   8          output data
//   9      else
//  10          if sram [i] is dirty
//  11              write back dram
//  12          read dram
//  13          write sram [i] *256
//  14          read sram
//  15          output data
//  16  else write
//  17      if BASE_ADD_1 < i_addr_[i] < RBASE_ADDR_1 + 255
//  18          write sram 1
//  19          output finish
//  20      else if BASE_ADD_2 < i_addr_[i] < RBASE_ADDR_2 + 255
//  21          write sram 2
//  22          output finish
//  23      else
//  24          if sram [i] is dirty
//  25              write back dram
//  26          read dram
//  27          write sram [i] *256
//  28          write sram [i]
//  29          output finish

// Bridge controll
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_valid <=0;
    //else if((s_c==s_addr_miss) && (s_n==s_init_addr)) BRG_i_valid <= 1;
    else BRG_i_valid <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_addr <=0;
    //else if((s_c==s_addr_miss) && (s_n==s_init_addr)) BRG_i_addr <= { JOB_BLOCK,8'h00 };
    else BRG_i_addr <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_data <= 0;
    //else if((s_c==s_addr_miss) && (s_n==s_init_addr)) BRG_i_data <= 0;
    else BRG_i_data <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_rw <=0;
    //else if((s_c==s_addr_miss) && (s_n==s_init_addr)) BRG_i_rw <=0;
    else BRG_i_rw <=0;
end
// sram controll
always @ (posedge clk) begin
    //if( s_n==s_addr_hit )  SRAM_A[ 0 ] <= 0;
    //else
    if(ss_c==ss_init_sram )  SRAM_A[ 0 ] <= SRAM_A[ 0 ] + 1;
    else begin
        for(i=0;i<4;i=i+1)
            SRAM_A[i] <= 0;
    end
end
always @ (posedge clk) begin
    //if(s_c==s_copy_sram && s_n==s_copy_sram) SRAM_D[ JOB_PORT ][ SRAM_NUM ] <= SRAM_Q[ ~JOB_PORT ][ CP_NUM ];
    if(ss_n==ss_init_sram ) SRAM_D[ 0 ] <= BRG_o_data;
    else begin
        for(i=0;i<4;i=i+1)
            SRAM_D[i] <= 0;
    end
end
always @ (posedge clk) begin
    if( s_n==s_cpu_0_hit ) begin
    //    if(JOB_RW==JOB_WRITE) SRAM_WEN[ JOB_PORT ][ SRAM_NUM ] <= 0;
    //    else SRAM_WEN[ JOB_PORT ][ SRAM_NUM ] <= 1;
    end else begin
        for(i=0;i<4;i=i+1)
            SRAM_WEN[i] <= 0;
    end
end




















// output controll
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_valid_1 <=0;
    else o_valid_1 <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_valid_2 <=0;
    else  o_valid_2 <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_data_1 <=0;
    else  o_data_1 <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_data_2 <=0;
    else  o_data_2 <=0;
end
endmodule
