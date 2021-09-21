module DATA_BRIDGE(
    clk,
    rst_n,
    in_valid,
    i_rw,
    i_ADDR,
    i_DATA,
    out_valid,
    o_DATA,
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
    wready_m_inf_inst_1,
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

output wire [ID_WIDTH-1:0]      awid_M_inf;
output reg [ADDR_WIDTH-1:0]  awaddr_M_inf;
output reg [2:0]             awsize_M_inf;
output reg [1:0]            awburst_M_inf;
output reg [7:0]              awlen_M_inf;
output reg                  awvalid_M_inf;
// src slave
input  wire                  awready_M_inf;
// -------------------------

// axi write data channel
// src master
output reg [DATA_WIDTH-1:0]   wdata_M_inf;
input wire                   wlast_M_inf;
output reg                   wvalid_M_inf;
// src slave
input  wire                   wready_m_inf_inst_1;

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
input [DATA_WIDTH-1:0] i_DATA;
input i_rw;
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
        s_idle: if (in_valid&& i_rw) state_n <= s_i_addr;
                else if (in_valid && !i_rw) state_n <= s_o_addr;
                else state_n <= s_idle;
        s_i_addr: if(arready_M_inf) state_n <= s_i_data; else state_n <= s_i_addr;
        s_i_data: if(rlast_M_inf) state_n <= s_idle; else state_n <= s_i_data;
        s_o_addr:if(awready_M_inf) state_n <= s_o_data; else state_n <= s_o_addr;
        s_o_data:if(wlast_M_inf) state_n <= s_out; else state_n <= s_o_data;
        s_out: state_n <= s_idle;
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
    else if((state_c==s_idle) && (state_n==s_i_addr)) araddr_M_inf <= i_ADDR;
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
//--------------------------------------------------------------
// Mail Base M write control
//--------------------------------------------------------------
// Mail Base M write address
assign awid_M_inf = 0;
always @ (posedge clk) begin
    //if( (state_c==s_o_addr) )
    //     awburst_M_inf <= 2'b01;
    //else if(awready_M_inf) awburst_M_inf <= 0;
    awburst_M_inf <= 2'b01;
end
always @ (posedge clk) begin
    //if( (state_c==s_o_addr) )
    //    awsize_M_inf <= 3'b010; // 4 byte = 32 bit
    //else if(awready_M_inf) awsize_M_inf <=0;
    awsize_M_inf <= 3'b010; // 4 byte = 32 bit
end
always @ (posedge clk or negedge rst_n) begin
    //if(!rst_n) awlen_M_inf <=0;
    //else if(awready_M_inf) awlen_M_inf <=0;
    //else if( (state_c==s_o_addr) )
    //    awlen_M_inf <= RW_LEN;
    awlen_M_inf <= RW_LEN;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awvalid_M_inf <=0;
    else if(awready_M_inf) awvalid_M_inf <=0;
    else if( (state_c==s_o_addr) )
        awvalid_M_inf <= 1;

end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) awaddr_M_inf <= 0;
    //else if( (state_n==s_o_addr) )
    //    awaddr_M_inf <= i_ADDR;
    //else if(awready_M_inf) awaddr_M_inf <=0;
    else if(in_valid) awaddr_M_inf <= i_ADDR;
end
// Mail Base M write data
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) wvalid_M_inf <=0;
    else if(awready_M_inf) wvalid_M_inf <=1;
    else if(wlast_M_inf) wvalid_M_inf <=0;
end
//always @ (posedge clk or negedge rst_n) begin
//    if(!rst_n) wdata_M_inf <= 0;
//    else if(wvalid_M_inf) wdata_M_inf <= i_DATA;
//    else if(wlast_M_inf) wdata_M_inf <= 0;
//end
always @ ( * ) begin
    wdata_M_inf <= i_DATA;
end
//always @ (posedge clk or negedge rst_n) begin
//    if(!rst_n) wlast_M_inf <= 0;
//    else if(( state_c==s_o_data)) wlast_M_inf <= 1;
//    else wlast_M_inf <= 0;
//end
// Mail Base M burst ready
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) bready_M_inf <=0;
    else if(awready_M_inf) bready_M_inf <= 1;
    else if(bvalid_M_inf) bready_M_inf <=0;
end

endmodule
