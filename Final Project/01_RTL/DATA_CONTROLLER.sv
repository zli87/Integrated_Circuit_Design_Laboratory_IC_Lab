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
      input i_interrupt,
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

    output reg [DATA_WIDTH-1:0] wdata_m_inf_data ,
    output reg wlast_m_inf_data ,
   output wvalid_m_inf_data ,
   input wready_m_inf_data ,

      input [ID_WIDTH-1:0] bid_m_inf_data ,
    input [1:0] bresp_m_inf_data ,
   input bvalid_m_inf_data ,
   output bready_m_inf_data  );

integer i,j;
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
reg [3:0] ADDR_HIT_SRAM [1:0]; // cpu 0 hit 4 sram // cpu 1 hit 4 sram
reg CPU_HIT_SRAM [1:0];
reg [3:0] SRAM_DIRTY;
reg [1:0] C0_HIT_NUM; // sram 0~3
reg [1:0] C1_HIT_NUM; // sram 0~3
reg [1:0] CACHE [3:0];

reg [DATA_WIDTH-1:0] SRAM_D [3:0];
wire [DATA_WIDTH-1:0] SRAM_Q [3:0];
reg [7:0] SRAM_A [3:0];
reg [3:0] SRAM_WEN;
reg [DATA_WIDTH-1:0] SRAM_FIRST_DATA [3:0];
reg [DATA_WIDTH-1:0] SRAM_SECOND_DATA [3:0];
reg [DATA_WIDTH-1:0] SRAM_THIRD_DATA [3:0];


reg wready_delay;
reg wready_delay2;
reg SRAM_A_FF;
reg [1:0] ITERUPT_NUM;
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
typedef enum logic  [3:0] {
      s_IDLE = 4'd0,
      s_CHECK_C0_HIT = 4'd1,
      s_C0_HIT = 4'd2,
      s_CHECK_C1_HIT = 4'd3,
      s_C1_HIT = 4'd4,
      s_CHECK_C0_MISS = 4'd5,
      s_CHECK_C1_MISS = 4'd6,
      s_C0_MISS = 4'd7,
      s_C1_MISS = 4'd8,
      s_C0_RHIT = 4'd9,
      s_C1_RHIT = 4'd10,
      s_OUT = 4'd11,
      s_ITERUPT = 4'd12
}FSM2;
FSM2 s_c;
FSM2 s_n;
reg C1_HITED;
reg s_OUT1,s_OUT0;
wire SN_C0_HIT,SN_C1_HIT;
/*
reg [3:0] s_c ;
reg [3:0] s_n ;
parameter  s_IDLE = 4'd0;
parameter  s_CHECK_C0_HIT = 4'd1;
parameter  s_C0_HIT = 4'd2;
parameter  s_CHECK_C1_HIT = 4'd3;
parameter  s_C1_HIT = 4'd4;
parameter  s_CHECK_C0_MISS = 4'd5;
parameter  s_CHECK_C1_MISS = 4'd6;
parameter  s_C0_MISS = 4'd7;
parameter  s_C1_MISS = 4'd8;
parameter  s_C0_RHIT = 4'd9;
parameter  s_C1_RHIT = 4'd10;
parameter  s_OUT = 4'd11;
*/
typedef enum logic  [3:0] {
    ss_IDLE = 4'd0,
    ss_WADDR = 4'd1,
    ss_STORE = 4'd2,
    ss_RADDR = 4'd3,
    ss_LOAD = 4'd4,
    ss_DONE = 4'd5,
    ss_PASS = 4'd6,
    ss_PREPARE = 4'd7
}FSM;
FSM ss_c;
FSM ss_n;
/*
reg [3:0] ss_c ;
reg [3:0] ss_n ;
parameter  ss_IDLE = 4'd0;
parameter  ss_WADDR = 4'd1;
parameter  ss_STORE = 4'd2;
parameter  ss_RADDR = 4'd3;
parameter  ss_LOAD = 4'd4;
parameter  ss_DONE = 4'd5;
*/

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_c <= s_IDLE;
    else s_c <= s_n;
end
// CHECK HIT FSM
// for SRAM signal control
always @ ( * ) begin
    case(s_c)
        s_IDLE: if(I_VALID[0]|I_VALID[1])       s_n <= s_CHECK_C0_HIT; // do cpu 0 first
                else if( i_interrupt )          s_n <= s_ITERUPT;
                else                            s_n <= s_IDLE;
        s_CHECK_C0_HIT:  if( CPU_HIT_SRAM[0] )  s_n <= s_C0_HIT;
                         else                   s_n <= s_CHECK_C1_HIT;
        s_C0_HIT:        if(I_VALID[1])         s_n <= s_CHECK_C1_HIT;
                         else                   s_n <= s_OUT;
        s_CHECK_C1_HIT:  if( CPU_HIT_SRAM[1] )  s_n <= s_C1_HIT;
                         else                   s_n <= s_CHECK_C0_MISS;
        s_C1_HIT:        if(I_VALID[0])         s_n <= s_CHECK_C0_MISS;
                         else                   s_n <= s_OUT;
        s_CHECK_C0_MISS: if( CPU_HIT_SRAM[0] )  s_n <= s_CHECK_C1_MISS;
                         else if(I_VALID[0])    s_n <= s_C0_MISS;
                         else                   s_n <= s_CHECK_C1_MISS;
        s_CHECK_C1_MISS: if( CPU_HIT_SRAM[1] ) begin
                                if(C1_HITED)    s_n <= s_OUT;
                                else            s_n <= s_C1_RHIT;
                         end else if(I_VALID[1]) s_n <= s_C1_MISS;
                         else s_n <= s_IDLE;
        s_C0_MISS:       if(ss_c==ss_DONE) s_n <= s_C0_RHIT; else s_n <= s_C0_MISS; // wait for reload
        s_C1_MISS:       if(ss_c==ss_DONE) s_n <= s_C1_RHIT; else s_n <= s_C1_MISS; // wait for reload
        s_C0_RHIT:       s_n <= s_CHECK_C1_MISS;
        s_C1_RHIT:       s_n <= s_OUT;
        s_OUT:           s_n <= s_IDLE;
        s_ITERUPT:       if(ITERUPT_NUM==2'd3 && wlast_m_inf_data) s_n <= s_IDLE; else s_n <= s_ITERUPT;
        //default: begin $display("error"); $finish; end
    endcase
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) C1_HITED <= 0;
    else if(s_c==s_IDLE) C1_HITED <= 0;
    else if(s_c==s_C1_HIT) C1_HITED <= 1;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_OUT0 <= 0;
    else if(s_c==s_C0_HIT || s_c==s_C0_RHIT) s_OUT0 <= 1;
    else s_OUT0 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_OUT1 <= 0;
    else if(s_c==s_C1_HIT || s_c==s_C1_RHIT) s_OUT1 <= 1;
    else s_OUT1 <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) ss_c <= ss_IDLE;
    else ss_c <= ss_n;
end
// READ/WRITE FSM
// for DRAM signal control
always @ ( * ) begin
  case(ss_c)
    ss_IDLE:  if((s_c==s_C0_MISS)|(s_c==s_C1_MISS)) begin
                  if(SRAM_DIRTY[CACHE[3]]==1) ss_n <= ss_PREPARE;
                  else ss_n <= ss_RADDR;
              end else if( s_c==s_ITERUPT ) begin
                    if(BASE_BANK[CACHE[3]]!=5'h10) ss_n <= ss_PREPARE;
                    else ss_n <= ss_PASS;
              end else ss_n <= ss_IDLE;
    ss_PREPARE:if(SRAM_A[CACHE[3]]=='d3) ss_n <= ss_WADDR; else ss_n <= ss_PREPARE;
    ss_WADDR:  if(wready_m_inf_data) ss_n <= ss_STORE; else ss_n <= ss_WADDR;
    ss_STORE:    if(wlast_m_inf_data) ss_n <= ss_IDLE; else ss_n <= ss_STORE;
    ss_RADDR:  if(BRG_o_valid) ss_n <= ss_LOAD; else ss_n <= ss_RADDR;
    ss_LOAD:   if(!BRG_o_valid) ss_n <= ss_DONE; else ss_n <= ss_LOAD;
    ss_DONE:    ss_n <= ss_IDLE;
    ss_PASS:    ss_n <= ss_IDLE;
    default:ss_n <= ss_IDLE;
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
      if(SN_C0_HIT) I_VALID[0] <= 0;
      else if(SN_C1_HIT) I_VALID[1] <= 0;
    end
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin    // initial is impossible adress !
        for(i=0;i<4;i=i+1)
          BASE_BANK[i] <= 5'h10;
    end
    else if(wlast_m_inf_data)  BASE_BANK[ CACHE[3] ] <= 5'h10;
    else if(ss_c==ss_LOAD && s_c==s_C0_MISS) BASE_BANK[ CACHE[3] ] <= I_BANK[0];
    else if(ss_c==ss_LOAD && s_c==s_C1_MISS) BASE_BANK[ CACHE[3] ] <= I_BANK[1];
end
always @ ( * ) begin
    for(i=0;i<2;i=i+1)begin
        for(j=0;j<4;j=j+1)begin
            ADDR_HIT_SRAM[i][j] <= (BASE_BANK[j] == I_BANK[i]);
        end
    end
end
always @ ( * ) begin
    for(i=0;i<2;i=i+1)
        CPU_HIT_SRAM[i] = ( I_VALID[i] && ( ADDR_HIT_SRAM[i] != 0 ) ) ? 1 : 0 ;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0;i<4;i=i+1)
            CACHE[i] <= i;
    end else if(SN_C0_HIT)begin
        if(ADDR_HIT_SRAM[0][CACHE[1]])begin
            CACHE[0] <= CACHE[1];
            CACHE[1] <= CACHE[0];
        end
        if(ADDR_HIT_SRAM[0][CACHE[2]])begin
            CACHE[0] <= CACHE[2];
            CACHE[1] <= CACHE[0];
            CACHE[2] <= CACHE[1];
        end
        if(ADDR_HIT_SRAM[0][CACHE[3]])begin
            CACHE[0] <= CACHE[3];
            CACHE[1] <= CACHE[0];
            CACHE[2] <= CACHE[1];
            CACHE[3] <= CACHE[2];
        end
    end else if(SN_C1_HIT)begin
        if(ADDR_HIT_SRAM[1][CACHE[1]])begin
            CACHE[0] <= CACHE[1];
            CACHE[1] <= CACHE[0];
        end
        if(ADDR_HIT_SRAM[1][CACHE[2]])begin
            CACHE[0] <= CACHE[2];
            CACHE[1] <= CACHE[0];
            CACHE[2] <= CACHE[1];
        end
        if(ADDR_HIT_SRAM[1][CACHE[3]])begin
            CACHE[0] <= CACHE[3];
            CACHE[1] <= CACHE[0];
            CACHE[2] <= CACHE[1];
            CACHE[3] <= CACHE[2];
        end
    end else if(s_c==s_ITERUPT && wlast_m_inf_data)begin
        CACHE[0] <= CACHE[3];
        CACHE[1] <= CACHE[0];
        CACHE[2] <= CACHE[1];
        CACHE[3] <= CACHE[2];
    end
end
always @ ( * ) begin
    case(ADDR_HIT_SRAM[0])
        4'd1: C0_HIT_NUM <= 0;
        4'd2: C0_HIT_NUM <= 1;
        4'd4: C0_HIT_NUM <= 2;
        4'd8: C0_HIT_NUM <= 3;
        default: C0_HIT_NUM <= 0;
    endcase
end
always @ ( * ) begin
    case(ADDR_HIT_SRAM[1])
        4'd1: C1_HIT_NUM <= 0;
        4'd2: C1_HIT_NUM <= 1;
        4'd4: C1_HIT_NUM <= 2;
        4'd8: C1_HIT_NUM <= 3;
        default:C1_HIT_NUM <= 0;
    endcase
end
//  Algorithm Data Controller


// Bridge controll
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_valid <=0;
    else if((ss_c==ss_IDLE) && (ss_n==ss_RADDR)) BRG_i_valid <= 1;
    else if((ss_c==ss_PREPARE) && (ss_n==ss_WADDR)) BRG_i_valid <= 1;
    else BRG_i_valid <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_addr <=0;
    else if((ss_c==ss_IDLE) && (ss_n==ss_RADDR) && (s_c==s_C0_MISS) ) BRG_i_addr <= { I_BANK[0],9'h00 };
    else if((ss_c==ss_IDLE) && (ss_n==ss_RADDR) && (s_c==s_C1_MISS) ) BRG_i_addr <= { I_BANK[1],9'h00 };
    else if((ss_c==ss_PREPARE) && (ss_n==ss_WADDR)  ) BRG_i_addr <= { BASE_BANK[ CACHE[3] ],9'h00 };
    else BRG_i_addr <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_data <= 0;
    else if( wvalid_m_inf_data && !wready_m_inf_data) BRG_i_data <= SRAM_FIRST_DATA[ CACHE[3] ];
    else if( wready_m_inf_data && !wready_delay ) BRG_i_data <= SRAM_SECOND_DATA[ CACHE[3] ];
    else if( wready_delay && !wready_delay2 ) BRG_i_data <= SRAM_THIRD_DATA[ CACHE[3] ];
    else if(ss_c==ss_STORE) BRG_i_data <= SRAM_Q[ CACHE[3] ];
    else BRG_i_data <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) BRG_i_rw <=1;
    //else if((ss_c==ss_IDLE) && (ss_n==ss_RADDR) ) BRG_i_rw <=1;
    else if((ss_c==ss_PREPARE) && (ss_n==ss_WADDR) ) BRG_i_rw <=0;
    else BRG_i_rw <=1;
end
always @ (posedge clk) begin
    if(SRAM_A[CACHE[3]]=='d1) SRAM_FIRST_DATA[ CACHE[3] ] <= SRAM_Q[ CACHE[3] ];
end
always @ (posedge clk) begin
    if(SRAM_A[CACHE[3]]=='d2) SRAM_SECOND_DATA[ CACHE[3] ] <= SRAM_Q[ CACHE[3] ];
end
always @ (posedge clk) begin
    if(SRAM_A[CACHE[3]]=='d3) SRAM_THIRD_DATA[ CACHE[3] ] <= SRAM_Q[ CACHE[3] ];
end
always @ (posedge clk) begin
    wready_delay <= wready_m_inf_data;
    wready_delay2 <= wready_delay;
end
always @ (posedge clk) begin
    if(SRAM_A[ CACHE[3] ]==8'hff) SRAM_A_FF <= 1;
    else SRAM_A_FF <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wlast_m_inf_data <= 0;
    else if(ss_c==ss_STORE && SRAM_A_FF==1)  wlast_m_inf_data <= 1;
    else if(ss_n==ss_PASS) wlast_m_inf_data <= 1;
    else wlast_m_inf_data <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) ITERUPT_NUM <= 0;
    if(wlast_m_inf_data && s_c==s_ITERUPT) ITERUPT_NUM <= ITERUPT_NUM + 1;
end
// sram controll
assign SN_C0_HIT = (s_n==s_C0_HIT || s_n==s_C0_RHIT);
assign SN_C1_HIT = (s_n==s_C1_HIT || s_n==s_C1_RHIT);

always @ (posedge clk) begin
    if( SN_C0_HIT  )  SRAM_A[ C0_HIT_NUM ] <= I_ADDR[0][8:1];
    else if( SN_C1_HIT )  SRAM_A[ C1_HIT_NUM ] <= I_ADDR[1][8:1];
    else if(ss_c==ss_LOAD )  SRAM_A[ CACHE[3] ] <= SRAM_A[ CACHE[3] ] + 1;
    else if(ss_c==ss_PREPARE)  SRAM_A[ CACHE[3] ] <= SRAM_A[ CACHE[3] ] + 1;
    else if(ss_c==ss_WADDR && ss_n==ss_STORE) SRAM_A[ CACHE[3] ] <= 3;
    else if(ss_c==ss_STORE) SRAM_A[ CACHE[3] ] <= SRAM_A[ CACHE[3] ] + 1;
    else begin
        for(i=0;i<4;i=i+1)
            SRAM_A[i] <= 0;
    end
end
always @ (posedge clk) begin
    if( SN_C0_HIT )  SRAM_D[ C0_HIT_NUM ] <= I_DATA[0];
    else if( SN_C1_HIT )  SRAM_D[ C1_HIT_NUM ] <= I_DATA[1];
    else if(ss_n==ss_LOAD ) SRAM_D[ CACHE[3] ] <= BRG_o_data;
    else begin
        for(i=0;i<4;i=i+1)
            SRAM_D[i] <= 0;
    end
end
always @ (posedge clk) begin
    if( SN_C0_HIT && I_RW[0]==0)  SRAM_WEN[ C0_HIT_NUM ] <= 0;
    else if( SN_C1_HIT && I_RW[1]==0)  SRAM_WEN[ C1_HIT_NUM ] <= 0;
    else if(ss_n==ss_LOAD ) SRAM_WEN[ CACHE[3] ] <= 0;
    else begin
        for(i=0;i<4;i=i+1)
            SRAM_WEN[i] <= 1;
    end
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        for(i=0;i<4;i=i+1)
          SRAM_DIRTY[i] <=0;
    end else if( SN_C0_HIT && I_RW[0]==0 )  SRAM_DIRTY[ C0_HIT_NUM ] <= 1;
    else if( SN_C1_HIT && I_RW[1]==0)  SRAM_DIRTY[ C1_HIT_NUM ] <= 1;
    else if( wlast_m_inf_data ) SRAM_DIRTY[ CACHE[3] ] <= 0;
end



// output controll
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_valid_1 <=0;
    else if( s_OUT0 ) o_valid_1 <=1;
    else o_valid_1 <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_valid_2 <=0;
    else if( s_OUT1 ) o_valid_2 <=1;
    else  o_valid_2 <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_data_1 <=0;
    else if( s_OUT0 && I_RW[0]==1 ) o_data_1 <= SRAM_Q[ C0_HIT_NUM ];
    else  o_data_1 <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) o_data_2 <=0;
    else if( s_OUT1 && I_RW[1]==1 ) o_data_2 <= SRAM_Q[ C1_HIT_NUM ];
    else  o_data_2 <=0;
end
endmodule
