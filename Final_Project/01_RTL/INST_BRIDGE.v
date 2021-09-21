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
