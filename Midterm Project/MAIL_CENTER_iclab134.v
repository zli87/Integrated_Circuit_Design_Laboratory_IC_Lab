//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright SI2 LAB @ NCTU ED430
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   ICLAB 2019 Spring
//   Midterm Proejct            : Mail Center (AXI-4)
//   Author                     : Yun-Sheng Chan (yschan.ee03g@g2.nctu.edu.tw)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : MAIL_CENTER.v
//   Module Name : MAIL_CENTER
//   Release version : V1.0 (Release Date: 2019-11)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

module MAIL_CENTER(
      clk,
      rst_n,
      start_i,
      done_o,

     arid_M_inf,
   araddr_M_inf,
    arlen_M_inf,
   arsize_M_inf,
  arburst_M_inf,
  arvalid_M_inf,
  arready_M_inf,

      rid_M_inf,
    rdata_M_inf,
    rresp_M_inf,
    rlast_M_inf,
   rvalid_M_inf,
   rready_M_inf,

     awid_M_inf,
   awaddr_M_inf,
   awsize_M_inf,
  awburst_M_inf,
    awlen_M_inf,
  awvalid_M_inf,
  awready_M_inf,

    wdata_M_inf,
    wlast_M_inf,
   wvalid_M_inf,
   wready_M_inf,

      bid_M_inf,
    bresp_M_inf,
   bvalid_M_inf,
   bready_M_inf,
   //------------- A
     arid_A_inf,
   araddr_A_inf,
    arlen_A_inf,
   arsize_A_inf,
  arburst_A_inf,
  arvalid_A_inf,
  arready_A_inf,

      rid_A_inf,
    rdata_A_inf,
    rresp_A_inf,
    rlast_A_inf,
   rvalid_A_inf,
   rready_A_inf,

     awid_A_inf,
   awaddr_A_inf,
   awsize_A_inf,
  awburst_A_inf,
    awlen_A_inf,
  awvalid_A_inf,
  awready_A_inf,

    wdata_A_inf,
    wlast_A_inf,
   wvalid_A_inf,
   wready_A_inf,

      bid_A_inf,
    bresp_A_inf,
   bvalid_A_inf,
   bready_A_inf,
   //------------- B
     arid_B_inf,
   araddr_B_inf,
    arlen_B_inf,
   arsize_B_inf,
  arburst_B_inf,
  arvalid_B_inf,
  arready_B_inf,

      rid_B_inf,
    rdata_B_inf,
    rresp_B_inf,
    rlast_B_inf,
   rvalid_B_inf,
   rready_B_inf,

     awid_B_inf,
   awaddr_B_inf,
   awsize_B_inf,
  awburst_B_inf,
    awlen_B_inf,
  awvalid_B_inf,
  awready_B_inf,

    wdata_B_inf,
    wlast_B_inf,
   wvalid_B_inf,
   wready_B_inf,

      bid_B_inf,
    bresp_B_inf,
   bvalid_B_inf,
   bready_B_inf,
   //------------- C
     arid_C_inf,
   araddr_C_inf,
    arlen_C_inf,
   arsize_C_inf,
  arburst_C_inf,
  arvalid_C_inf,
  arready_C_inf,

      rid_C_inf,
    rdata_C_inf,
    rresp_C_inf,
    rlast_C_inf,
   rvalid_C_inf,
   rready_C_inf,

     awid_C_inf,
   awaddr_C_inf,
   awsize_C_inf,
  awburst_C_inf,
    awlen_C_inf,
  awvalid_C_inf,
  awready_C_inf,

    wdata_C_inf,
    wlast_C_inf,
   wvalid_C_inf,
   wready_C_inf,

      bid_C_inf,
    bresp_C_inf,
   bvalid_C_inf,
   bready_C_inf
);
input  wire clk, rst_n, start_i;
output reg  done_o;

parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=32;

// AXI Interface wire connecttion for pseudo DRAM read/write
/* Hint:
  your AXI-4 interface could be designed as convertor in submodule(which used reg for output signal),
  therefore I declared output of AXI as wire in MAIL_CENTER
*/

//########################################### Mail Database
// axi write addr channel
// src master
output wire  [ID_WIDTH-1:0]      awid_M_inf;
output reg  [ADDR_WIDTH-1:0]  awaddr_M_inf;
output reg  [2:0]             awsize_M_inf;
output reg  [1:0]            awburst_M_inf;
output reg  [7:0]              awlen_M_inf;
output reg                   awvalid_M_inf;
// src slave
input  wire                  awready_M_inf;
// -------------------------

// axi write data channel
// src master
output reg  [DATA_WIDTH-1:0]   wdata_M_inf;
output reg                     wlast_M_inf;
output reg                    wvalid_M_inf;
// src slave
input  wire                   wready_M_inf;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_M_inf;
input  wire  [1:0]             bresp_M_inf;
input  wire                   bvalid_M_inf;
// src master
output reg                    bready_M_inf;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_M_inf;
output reg  [ADDR_WIDTH-1:0]  araddr_M_inf;
output reg  [7:0]              arlen_M_inf;
output reg  [2:0]             arsize_M_inf;
output reg  [1:0]            arburst_M_inf;
output reg                   arvalid_M_inf;
// src slave
input  wire                  arready_M_inf;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_M_inf;
input  wire [DATA_WIDTH-1:0]   rdata_M_inf;
input  wire [1:0]              rresp_M_inf;
input  wire                    rlast_M_inf;
input  wire                   rvalid_M_inf;
// master
output reg                    rready_M_inf;
// -----------------------------

//########################################### City A
// axi write addr channel
// src master
output wire [ID_WIDTH-1:0]      awid_A_inf;
output reg  [ADDR_WIDTH-1:0]  awaddr_A_inf;
output reg  [2:0]             awsize_A_inf;
output reg  [1:0]            awburst_A_inf;
output reg  [7:0]              awlen_A_inf;
output reg                   awvalid_A_inf;
// src slave
input  wire                  awready_A_inf;
// -------------------------

// axi write data channel
// src master
output reg  [DATA_WIDTH-1:0]   wdata_A_inf;
output reg                     wlast_A_inf;
output reg                    wvalid_A_inf;
// src slave
input  wire                   wready_A_inf;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_A_inf;
input  wire  [1:0]             bresp_A_inf;
input  wire                   bvalid_A_inf;
// src master
output reg                    bready_A_inf;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_A_inf;
output reg  [ADDR_WIDTH-1:0]  araddr_A_inf;
output reg  [7:0]              arlen_A_inf;
output reg  [2:0]             arsize_A_inf;
output reg  [1:0]            arburst_A_inf;
output reg                   arvalid_A_inf;
// src slave
input  wire                  arready_A_inf;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_A_inf;
input  wire [DATA_WIDTH-1:0]   rdata_A_inf;
input  wire [1:0]              rresp_A_inf;
input  wire                    rlast_A_inf;
input  wire                   rvalid_A_inf;
// master
output reg                    rready_A_inf;
// -----------------------------

//########################################### City B
// axi write addr channel
// src master
output wire [ID_WIDTH-1:0]      awid_B_inf;
output reg  [ADDR_WIDTH-1:0]  awaddr_B_inf;
output reg  [2:0]             awsize_B_inf;
output reg  [1:0]            awburst_B_inf;
output reg  [7:0]              awlen_B_inf;
output reg                   awvalid_B_inf;
// src slave
input  wire                  awready_B_inf;
// -------------------------

// axi write data channel
// src master
output reg  [DATA_WIDTH-1:0]   wdata_B_inf;
output reg                     wlast_B_inf;
output reg                    wvalid_B_inf;
// src slave
input  wire                   wready_B_inf;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_B_inf;
input  wire  [1:0]             bresp_B_inf;
input  wire                   bvalid_B_inf;
// src master
output reg                    bready_B_inf;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_B_inf;
output reg  [ADDR_WIDTH-1:0]  araddr_B_inf;
output reg  [7:0]              arlen_B_inf;
output reg  [2:0]             arsize_B_inf;
output reg  [1:0]            arburst_B_inf;
output reg                   arvalid_B_inf;
// src slave
input  wire                  arready_B_inf;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_B_inf;
input  wire [DATA_WIDTH-1:0]   rdata_B_inf;
input  wire [1:0]              rresp_B_inf;
input  wire                    rlast_B_inf;
input  wire                   rvalid_B_inf;
// master
output reg                    rready_B_inf;
// -----------------------------
//########################################### City C
// axi write addr channel
// src master
output wire [ID_WIDTH-1:0]      awid_C_inf;
output reg  [ADDR_WIDTH-1:0]  awaddr_C_inf;
output reg  [2:0]             awsize_C_inf;
output reg  [1:0]            awburst_C_inf;
output reg  [7:0]              awlen_C_inf;
output reg                   awvalid_C_inf;
// src slave
input  wire                  awready_C_inf;
// -------------------------

// axi write data channel
// src master
output reg  [DATA_WIDTH-1:0]   wdata_C_inf;
output reg                     wlast_C_inf;
output reg                    wvalid_C_inf;
// src slave
input  wire                   wready_C_inf;

// axi write resp channel
// src slave
input  wire  [ID_WIDTH-1:0]      bid_C_inf;
input  wire  [1:0]             bresp_C_inf;
input  wire                   bvalid_C_inf;
// src master
output reg                    bready_C_inf;
// ------------------------

// axi read addr channel
// src master
output wire [ID_WIDTH-1:0]      arid_C_inf;
output reg  [ADDR_WIDTH-1:0]  araddr_C_inf;
output reg  [7:0]              arlen_C_inf;
output reg  [2:0]             arsize_C_inf;
output reg  [1:0]            arburst_C_inf;
output reg                   arvalid_C_inf;
// src slave
input  wire                  arready_C_inf;
// ------------------------

// axi read data channel
// slave
input  wire [ID_WIDTH-1:0]       rid_C_inf;
input  wire [DATA_WIDTH-1:0]   rdata_C_inf;
input  wire [1:0]              rresp_C_inf;
input  wire                    rlast_C_inf;
input  wire                   rvalid_C_inf;
// master
output reg                    rready_C_inf;
// -----------------------------

reg  [ADDR_WIDTH-1:0] araddr_M_inf_delay;
reg  rvalid_M_inf_delay;
// reg
reg [32-1:0] mail;
reg [8-1:0] mail_hamming;
reg [6-1:0] mail_dest;
reg [14-1:0] mail_addr;
reg [4-1:0] mail_content;
reg [8-1:0] correct_hamming;
reg [2:0] cal_error;
reg [2-1:0] cal_dest;
reg [4:0] counter;
// FSM Main
reg [3:0] state_c;
reg [3:0] state_n;
parameter s_idle = 4'd0;
parameter s_input_addr = 4'd1;
parameter s_input_data = 4'd2;
parameter s_read_mail = 4'd3;
parameter s_cal = 4'd4;
parameter s_buff = 4'd5;
parameter s_back_addr = 4'd6;
parameter s_back_data = 4'd7;
parameter s_out = 4'd8;
reg finish_process;
// FSM City A B C
parameter ss_idle = 2'd0;
parameter ss_write_addr = 2'd1;
parameter ss_write_data = 2'd2;

reg [1:0] s_A_c;
reg [1:0] s_B_c;
reg [1:0] s_C_c;
reg [1:0] s_A_n;
reg [1:0] s_B_n;
reg [1:0] s_C_n;

reg [32:0] buff_A;
reg [32:0] buff_B;
reg [32:0] buff_C;
// -----------------------------
// SRAM
wire [32-1:0] M_Q_o;
wire CEN;
wire OEN;
reg M_WEN_i;
reg [8-1:0] M_A_i;
reg [32-1:0] M_D_i;
// -----------------------------
SRAM256W32B mem_M( .Q(M_Q_o), .CLK(clk), .CEN(CEN), .WEN(M_WEN_i), .A(M_A_i), .D(M_D_i), .OEN(OEN) );
assign CEN = 0;
assign OEN = 0;

//--------------------------------------------------------------
// DRAM
//--------------------------------------------------------------
// read address
assign arid_M_inf = 0;

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) araddr_M_inf <= 32'h00010000;
    else if(arready_M_inf) araddr_M_inf <= araddr_M_inf + 32'h00000400;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) araddr_M_inf_delay <= 32'h00010000;
    else if(arready_M_inf) araddr_M_inf_delay <= araddr_M_inf ;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arlen_M_inf <=0;
    else if(state_c==s_input_addr) arlen_M_inf <= 8'd255;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arsize_M_inf <=0;
    else if(state_c==s_input_addr) arsize_M_inf <= 3'b010; // 4 byte = 32 bit
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arburst_M_inf <=0;
    else if(state_c==s_input_addr) arburst_M_inf <= 2'd01;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) arvalid_M_inf <=0;
    else if(arready_M_inf) arvalid_M_inf <= 0;
    else if(state_c==s_input_addr) arvalid_M_inf <= 2'd01;
end
// read data
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) rready_M_inf <=0;
    else if(arready_M_inf) rready_M_inf <= 1;
    else if(rlast_M_inf) rready_M_inf <=1;
end
//--------------------------------------------------------------
// SRAM
//--------------------------------------------------------------
// M_WEN
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) M_WEN_i <=1;
    else if(rvalid_M_inf) M_WEN_i <=0;
    else if(counter[3]&&(cal_error!=0)) M_WEN_i <=0;
    else M_WEN_i <=1;
end
always @ (posedge clk) begin
    rvalid_M_inf_delay <= rvalid_M_inf;
end
// M_A
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) M_A_i <=0;
    else if(rvalid_M_inf_delay) M_A_i <= M_A_i + 1;
    else if(arready_M_inf) M_A_i <= 0;
    else if(state_c==s_read_mail) M_A_i <= M_A_i + 1;
    else if(state_n==s_back_addr) M_A_i <= 0;
    else if(state_n==s_back_data) M_A_i <= M_A_i + 1;
end
// M_D
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) M_D_i =0;
    else if(rvalid_M_inf) M_D_i = rdata_M_inf;
    else if(counter[3]&&(cal_error!=0)) begin
        //$display("hamming before %b",mail_hamming);
        correct_hamming = mail_hamming;
        case(cal_error)
            3'b111: correct_hamming[6] = ~mail_hamming[6];
            3'b110: correct_hamming[5] = ~mail_hamming[5];
            3'b101: correct_hamming[4] = ~mail_hamming[4];
            3'b011: correct_hamming[3] = ~mail_hamming[3];
            3'b100: correct_hamming[2] = ~mail_hamming[2];
            3'b001: correct_hamming[1] = ~mail_hamming[1];
            3'b010: correct_hamming[0] = ~mail_hamming[0];
        endcase
        correct_hamming[7] = 1;
        //$display("hamming after %b",mail_hamming);
        M_D_i = {correct_hamming,mail[23:0]};
    end else M_D_i = 0;
end
//--------------------------------------------------------------
// FSM main
//--------------------------------------------------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) state_c <= s_idle;
    else state_c <= state_n;
end

always @ ( * ) begin
    case(state_c)
        s_idle: if (start_i) state_n <= s_input_addr; else state_n <= s_idle;
        s_input_addr: if(arready_M_inf) state_n <= s_input_data; else state_n <= s_input_addr;
        s_input_data: if(rlast_M_inf) state_n <= s_read_mail; else state_n <= s_input_data;
        s_read_mail: if((M_A_i==8'hff)&&(finish_process)) state_n <= s_back_addr; else state_n <= s_cal;
        s_cal: if(counter[3])
                    if(cal_error!=0) state_n <= s_read_mail;
                    else state_n <= s_buff;
                else state_n <= s_cal;
        s_buff: if( (buff_A[32]==0)&&(buff_B[32]==0)&&(buff_C[32]==0) )
                     state_n <= s_read_mail;
                else state_n <= s_buff;

        s_back_addr:if(awready_M_inf) state_n <= s_back_data; else state_n <= s_back_addr;
        s_back_data:if(wlast_M_inf) state_n <= s_out; else state_n <= s_back_data;
        s_out: state_n <= s_idle;
        default: state_n <= s_idle;
    endcase
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) finish_process <= 0;
    else if((state_c==s_read_mail)&&(M_A_i==8'hff)) finish_process <= 1;
    else if(state_c==s_out) finish_process <= 0;
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) counter <= 0;
    else if((state_c==s_read_mail)&&(state_n!=s_back_addr)) counter <= 5'd1;
    else counter <= {counter[3:0],1'b0};
end
always @ (posedge clk) begin
    if(counter[1]) begin
        mail <= M_Q_o;
        {mail_hamming,mail_dest,mail_addr,mail_content} <= M_Q_o;
    end
end
always @ (posedge clk) begin
    if(counter[2]) begin
        cal_error[2] <= mail_hamming[6]^mail_hamming[5]^mail_hamming[4]^mail_hamming[2];
        cal_error[1] <= mail_hamming[6]^mail_hamming[5]^mail_hamming[3]^mail_hamming[0];
        cal_error[0] <= mail_hamming[6]^mail_hamming[4]^mail_hamming[3]^mail_hamming[1];
    end
end
always @ (posedge clk) begin
    if(counter[2]) begin
    case(mail_dest[5:4])
        2'b00: cal_dest <= mail_dest[3:2] ^ mail_dest[1:0];
        2'b01: cal_dest <= mail_dest[3:2] & mail_dest[1:0];
        2'b10: cal_dest <= mail_dest[3:2] | mail_dest[1:0];
        2'b11: cal_dest <= ~ mail_dest[1:0];
    endcase
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) buff_A <= 0;
    else if(counter[3]&&(cal_error==0)&&(cal_dest==0))
        buff_A <= {1'b1,mail};
    else if(wready_A_inf) begin
        buff_A <= 0;
    end
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) buff_B <= 0;
    else if(counter[3]&&(cal_error==0)&&(cal_dest==1))
        buff_B <= {1'b1, mail };
    else if(wready_B_inf) begin
        buff_B <= 0;
    end
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) buff_C <= 0;
    else if(counter[3]&&(cal_error==0)&&(cal_dest[1]))
        buff_C <= {1'b1, mail };
    else if(wready_C_inf) begin
        buff_C <= 0;
    end
end

//--------------------------------------------------------------
// FSM Mail BAse
//--------------------------------------------------------------

//--------------------------------------------------------------
// FSM A City
//--------------------------------------------------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_A_c <= ss_idle;
    else s_A_c <= s_A_n;
end
always @ ( * ) begin
    case(s_A_c)
        ss_idle: if(buff_A!=0) s_A_n <= ss_write_addr; else s_A_n <= ss_idle;
        ss_write_addr: if(awready_A_inf) s_A_n <= ss_write_data; else s_A_n <= ss_write_addr;
        ss_write_data: if(wready_A_inf) s_A_n <= ss_idle; else s_A_n <= ss_write_data;
        default: s_A_n <= ss_idle;
    endcase
end
//--------------------------------------------------------------
// FSM B City
//--------------------------------------------------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_B_c <= ss_idle;
    else s_B_c <= s_B_n;
end
always @ ( * ) begin
    case(s_B_c)
        ss_idle: if(buff_B!=0) s_B_n <= ss_write_addr; else s_B_n <= ss_idle;
        ss_write_addr: if(awready_B_inf) s_B_n <= ss_write_data; else s_B_n <= ss_write_addr;
        ss_write_data: if(wready_B_inf) s_B_n <= ss_idle; else s_B_n <= ss_write_data;
        default: s_B_n <= ss_idle;
    endcase
end
//--------------------------------------------------------------
// FSM C City
//--------------------------------------------------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) s_C_c <= ss_idle;
    else s_C_c <= s_C_n;
end
always @ ( * ) begin
    case(s_C_c)
        ss_idle: if(buff_C!=0) s_C_n <= ss_write_addr; else s_C_n <= ss_idle;
        ss_write_addr: if(awready_C_inf) s_C_n <= ss_write_data; else s_C_n <= ss_write_addr;
        ss_write_data: if(wready_C_inf) s_C_n <= ss_idle; else s_C_n <= ss_write_data;
        default: s_C_n <= ss_idle;
    endcase
end
// output
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)  done_o <=0;
    else if(state_c==s_out) done_o <=1;
    else done_o <=0;
end

//--------------------------------------------------------------
// Mail Base M write control
//--------------------------------------------------------------
// Mail Base M write address
assign awid_M_inf = 0;
always @ (posedge clk) begin
    if( (state_c==s_back_addr) )
         awburst_M_inf <= 2'b01;
    else if(awready_M_inf) awburst_M_inf <= 0;
end
always @ (posedge clk) begin
    if( (state_c==s_back_addr) )
        awsize_M_inf <= 3'b010; // 4 byte = 32 bit
    else if(awready_M_inf) awsize_M_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awlen_M_inf <=0;
    else if(awready_M_inf) awlen_M_inf <=0;
    else if( (state_c==s_back_addr) )
        awlen_M_inf <= 8'd255;

end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awvalid_M_inf <=0;
    else if(awready_M_inf) awvalid_M_inf <=0;
    else if( (state_c==s_back_addr) )
        awvalid_M_inf <= 1;

end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awaddr_M_inf <= 0;
    else if(awready_M_inf) awaddr_M_inf <=0;
    else if( (state_c==s_back_addr) )
        awaddr_M_inf <= {  14'd0 , { araddr_M_inf_delay[17:0] + (M_A_i<<2) } };

end
// Mail Base M write data
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wvalid_M_inf <=0;
    else if(awready_M_inf) wvalid_M_inf <=1;
    else if(wlast_M_inf) wvalid_M_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wdata_M_inf <= 0;
    else if(wvalid_M_inf) wdata_M_inf <= M_Q_o;
    else if(wlast_M_inf) wdata_M_inf <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wlast_M_inf <= 0;
    else if((M_A_i==8'h00)&&(state_c==s_back_data)) wlast_M_inf <= 1;
    else wlast_M_inf <= 0;
end
// Mail Base M burst ready
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) bready_M_inf <=0;
    else if(awready_M_inf) bready_M_inf <= 1;
    else if(bvalid_M_inf) bready_M_inf <=0;
end

//--------------------------------------------------------------
// City A write control
//--------------------------------------------------------------
// City A write address
assign awid_A_inf = 0;
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awburst_A_inf <= 0;
    else if(s_A_n==ss_write_addr) awburst_A_inf <= 2'b01;
    else awburst_A_inf <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awsize_A_inf <=0;
    else if(s_A_n==ss_write_addr) awsize_A_inf <= 3'b010; // 4 byte = 32 bit
    else awsize_A_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awlen_A_inf <=0;
    else if(s_A_n==ss_write_addr) awlen_A_inf <= 8'd0;
    else awlen_A_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awvalid_A_inf <=0;
    else if(s_A_n==ss_write_addr) awvalid_A_inf <= 1;
    else if(awready_A_inf) awvalid_A_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awaddr_A_inf <= 0;
    else if(s_A_n==ss_write_addr) awaddr_A_inf <= mail_addr;
    else if(awready_A_inf) awaddr_A_inf <=0;
end
// City A write data
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wvalid_A_inf <=0;
    else if(s_A_n==ss_write_data) wvalid_A_inf <=1;
    else if(s_A_c==ss_write_addr) wvalid_A_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wdata_A_inf <= 0;
    else if(s_A_n==ss_write_addr) wdata_A_inf <= buff_A[31:0];
    else if(s_A_n!=ss_write_data) wdata_A_inf <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)  wlast_A_inf <= 0;
    else if(s_A_n==ss_write_addr) wlast_A_inf <= 1;
    else if(s_A_n!=ss_write_data) wlast_A_inf <= 0;
end
// City A burst ready
always @ (posedge clk) begin
    if(s_A_n==ss_write_addr) bready_A_inf <= 1;
    else if(bvalid_A_inf) bready_A_inf <=0;
end

//--------------------------------------------------------------
// City B write control
//--------------------------------------------------------------
// City B write address
assign awid_B_inf = 0;
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awburst_B_inf <= 0;
    else if(s_B_n==ss_write_addr) awburst_B_inf <= 2'b01;
    else awburst_B_inf <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awsize_B_inf <=0;
    else if(s_B_n==ss_write_addr) awsize_B_inf <= 3'b010; // 4 byte = 32 bit
    else awsize_B_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awlen_B_inf <=0;
    else if(s_B_n==ss_write_addr) awlen_B_inf <= 8'd0;
    else awlen_B_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awvalid_B_inf <= 0;
    else if(s_B_n==ss_write_addr) awvalid_B_inf <= 1;
    else if(awready_B_inf) awvalid_B_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awaddr_B_inf <=0 ;
    else if(s_B_n==ss_write_addr) awaddr_B_inf <= mail_addr;
    else if(awready_B_inf) awaddr_B_inf <=0;
end
// City B write data
always @ (posedge clk or negedge rst_n ) begin
    if(!rst_n) wvalid_B_inf <=0;
    else if(s_B_n==ss_write_data) wvalid_B_inf <=1;
    else if(s_B_c==ss_write_addr) wvalid_B_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wdata_B_inf <= 0;
    else if(s_B_n==ss_write_addr) wdata_B_inf <= buff_B[31:0];
    else if(s_B_n!=ss_write_data) wdata_B_inf <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wlast_B_inf <= 0;
    else if(s_B_n==ss_write_addr) wlast_B_inf <= 1;
    else if(s_B_n!=ss_write_data) wlast_B_inf <= 0;
end
// City B burst ready
always @ (posedge clk) begin
    if(s_B_n==ss_write_addr) bready_B_inf <= 1;
    else if(bvalid_B_inf) bready_B_inf <=0;
end

//--------------------------------------------------------------
// City C write control
//--------------------------------------------------------------
// City C write address
assign awid_C_inf = 0;
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awburst_C_inf <= 0;
    else if(s_C_n==ss_write_addr) awburst_C_inf <= 2'b01;
    else awburst_C_inf <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awsize_C_inf <=0;
    else if(s_C_n==ss_write_addr) awsize_C_inf <= 3'b010; // 4 byte = 32 bit
    else awsize_C_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awlen_C_inf <=0;
    else if(s_C_n==ss_write_addr) awlen_C_inf <= 8'd0;
    else awlen_C_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awvalid_C_inf <= 0;
    else if(s_C_n==ss_write_addr) awvalid_C_inf <= 1;
    else if(awready_C_inf) awvalid_C_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awaddr_C_inf <= 0;
    else if(s_C_n==ss_write_addr) awaddr_C_inf <= mail_addr;
    else if(awready_C_inf) awaddr_C_inf <=0;
end
// City C write data
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wvalid_C_inf <=0;
    else if(s_C_n==ss_write_data) wvalid_C_inf <=1;
    else if(s_C_c==ss_write_addr) wvalid_C_inf <=0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n ) wdata_C_inf <= 0;
    else if(s_C_n==ss_write_addr) wdata_C_inf <= buff_C[31:0];
    else if(s_C_n!=ss_write_data) wdata_C_inf <= 0;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wlast_C_inf <= 0;
    else if(s_C_n==ss_write_addr) wlast_C_inf <= 1;
    else if(s_C_n!=ss_write_data) wlast_C_inf <= 0;
end
// City C burst ready
always @ (posedge clk) begin
    if(s_C_n==ss_write_addr) bready_C_inf <= 1;
    else if(bvalid_C_inf) bready_C_inf <=0;
end

endmodule
