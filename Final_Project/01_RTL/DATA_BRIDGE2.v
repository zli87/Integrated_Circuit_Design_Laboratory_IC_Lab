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
