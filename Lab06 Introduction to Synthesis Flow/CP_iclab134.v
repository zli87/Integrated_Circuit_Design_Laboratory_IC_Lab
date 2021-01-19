//synopsys translate_off
`include "CONV2D.v"
//synopsys translate_on
module CP(
    input [2:0] kernel1,kernel2,kernel3,
    input [7:0] im,
    input in_valid1,in_valid2,rst_n,clk,
    output reg [18:0] out1,out2,out3,
    output reg out_valid
);
parameter M = 4,  N = 3,  WIDTH1 = 8,  WIDTH2 = 3;

integer i,j;
reg [10:0] counter;

wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high11;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high12;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] highest1;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high21;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high22;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] highest2;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high31;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high32;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] highest3;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high41;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] high42;
wire  [(WIDTH1+WIDTH2+N*N-1)-1:0] highest4;
reg [(WIDTH1+WIDTH2+N*N-1)-1:0] highest4_delay [4:0];
reg [(WIDTH1+WIDTH2+N*N-1)-1:0] highest3_delay [3:0];
reg [(WIDTH1+WIDTH2+N*N-1)-1:0] highest2_delay [2:0];
reg [(WIDTH1+WIDTH2+N*N-1)-1:0] highest1_delay [1:0];
// in
reg [(M*M*WIDTH1)-1:0] IMAGE;
reg [(N*N*WIDTH2)-1:0] KERNEL1;
reg [(N*N*WIDTH2)-1:0] KERNEL2;
reg [(N*N*WIDTH2)-1:0] KERNEL3;
reg [M*M*(WIDTH1+WIDTH2+N*N-1)-1:0] RESULT;
// in
wire [(M*M*WIDTH1)-1:0] IMAGE_i;
wire [(N*N*WIDTH2)-1:0] KERNEL_i;
// out
wire [M*M*(WIDTH1+WIDTH2+N*N-1)-1:0] RESULT_o;

assign IMAGE_i = IMAGE;
assign KERNEL_i = (counter[1]==1)? KERNEL1 : (counter[2]==1)? KERNEL2 : KERNEL3 ;

CONV2D #(M,N,WIDTH1,WIDTH2) I_CONV2D(
.IMAGE(IMAGE_i),
.KERNEL(KERNEL_i),
.RESULT(RESULT_o)
);
always @ (posedge clk) begin
    RESULT <= RESULT_o;
end
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) IMAGE <=0;
    else if(in_valid2) begin
        IMAGE[127:120] <= im;
        IMAGE[119:112] <= IMAGE[127:120];
        IMAGE[111:104] <= IMAGE[119:112];
        IMAGE[103:96] <= IMAGE[111:104];
        IMAGE[95:88] <= IMAGE[103:96];
        IMAGE[87:80] <= IMAGE[95:88];
        IMAGE[79:72] <= IMAGE[87:80];
        IMAGE[71:64] <= IMAGE[79:72];
        IMAGE[63:56] <= IMAGE[71:64];
        IMAGE[55:48] <= IMAGE[63:56];
        IMAGE[47:40] <= IMAGE[55:48];
        IMAGE[39:32] <= IMAGE[47:40];
        IMAGE[31:24] <= IMAGE[39:32];
        IMAGE[23:16] <= IMAGE[31:24];
        IMAGE[15:8] <= IMAGE[23:16];
        IMAGE[7:0] <= IMAGE[15:8];
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) KERNEL1 <=0;
    else if(in_valid1) begin
        KERNEL1[26:24] <= kernel1;
        KERNEL1[23:21] <= KERNEL1[26:24];
        KERNEL1[20:18] <= KERNEL1[23:21];
        KERNEL1[17:15] <= KERNEL1[20:18];
        KERNEL1[14:12] <= KERNEL1[17:15];
        KERNEL1[11:9] <= KERNEL1[14:12];
        KERNEL1[8:6] <= KERNEL1[11:9];
        KERNEL1[5:3] <= KERNEL1[8:6];
        KERNEL1[2:0] <= KERNEL1[5:3];
    end
end

assign high11 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(0)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(1)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(0)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(1)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign high12 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(4)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(5)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(4)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(5)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign highest1 = ( high11 > high12 )? high11 : high12 ;
assign high21 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(2)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(3)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(2)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(3)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign high22 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(6)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(7)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(6)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(7)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign highest2 = ( high21 > high22 )? high21 : high22 ;
assign high31 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(8)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(9)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(8)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(9)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign high32 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(12)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(13)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(12)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(13)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign highest3 = ( high31 > high32 )? high31 : high32 ;
assign high41 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(10)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(11)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(10)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(11)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign high42 = ( RESULT[(WIDTH1+WIDTH2+N*N-1)*(14)+:(WIDTH1+WIDTH2+N*N-1)] > RESULT[(WIDTH1+WIDTH2+N*N-1)*(15)+:(WIDTH1+WIDTH2+N*N-1)] ) ? RESULT[(WIDTH1+WIDTH2+N*N-1)*(14)+:(WIDTH1+WIDTH2+N*N-1)] : RESULT[(WIDTH1+WIDTH2+N*N-1)*(15)+:(WIDTH1+WIDTH2+N*N-1)] ;
assign highest4 = ( high41 > high42 )? high41 : high42 ;

always @ (posedge clk) begin
    highest4_delay[0] <= highest4;
    highest4_delay[1] <= highest4_delay[0];
    highest4_delay[2] <= highest4_delay[1];
    highest4_delay[3] <= highest4_delay[2];
    highest4_delay[4] <= highest4_delay[3];
end

always @ (posedge clk) begin
    highest3_delay[0] <= highest3;
    highest3_delay[1] <= highest3_delay[0];
    highest3_delay[2] <= highest3_delay[1];
    highest3_delay[3] <= highest3_delay[2];
end

always @ (posedge clk) begin
    highest2_delay[0] <= highest2;
    highest2_delay[1] <= highest2_delay[0];
    highest2_delay[2] <= highest2_delay[1];
end

always @ (posedge clk) begin
    highest1_delay[0] <= highest1;
    highest1_delay[1] <= highest1_delay[0];
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) counter <=0;
    else if(in_valid1) counter <=0;
    else if(in_valid2) begin
        counter[0] <= 1;
        counter[10:1] <= 0;
    end else begin
        counter[0] <= 0;
        counter[1] <= counter[0];
        counter[2] <= counter[1];
        counter[3] <= counter[2];
        counter[4] <= counter[3];
        counter[5] <= counter[4];
        counter[6] <= counter[5];
        counter[7] <= counter[6];
        counter[8] <= counter[7];
        counter[9] <= counter[8];
        counter[10] <= counter[9];
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) KERNEL2 <=0;
    else if(in_valid1) begin
        KERNEL2[26:24] <= kernel2;
        KERNEL2[23:21] <= KERNEL2[26:24];
        KERNEL2[20:18] <= KERNEL2[23:21];
        KERNEL2[17:15] <= KERNEL2[20:18];
        KERNEL2[14:12] <= KERNEL2[17:15];
        KERNEL2[11:9] <= KERNEL2[14:12];
        KERNEL2[8:6] <= KERNEL2[11:9];
        KERNEL2[5:3] <= KERNEL2[8:6];
        KERNEL2[2:0] <= KERNEL2[5:3];
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) KERNEL3 <=0;
    else if(in_valid1) begin
        KERNEL3[26:24] <= kernel3;
        KERNEL3[23:21] <= KERNEL3[26:24];
        KERNEL3[20:18] <= KERNEL3[23:21];
        KERNEL3[17:15] <= KERNEL3[20:18];
        KERNEL3[14:12] <= KERNEL3[17:15];
        KERNEL3[11:9] <= KERNEL3[14:12];
        KERNEL3[8:6] <= KERNEL3[11:9];
        KERNEL3[5:3] <= KERNEL3[8:6];
        KERNEL3[2:0] <= KERNEL3[5:3];
    end
end

always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        out_valid <=0;
        out1<=0;
        out2<=0;
        out3<=0;
    end else if(counter[4]==1) begin
        out_valid <= 1;
        out1<=highest1_delay[1];
        out2<=highest1_delay[0];
        out3<=highest1;
    end else if(counter[5]==1) begin
        out_valid <= 1;
        out1<=highest2_delay[2];
        out2<=highest2_delay[1];
        out3<=highest2_delay[0];
    end else if(counter[6]==1) begin
        out_valid <= 1;
        out1<=highest3_delay[3];
        out2<=highest3_delay[2];
        out3<=highest3_delay[1];
    end else if(counter[7]==1) begin
        out_valid <= 1;
        out1<=highest4_delay[4];
        out2<=highest4_delay[3];
        out3<=highest4_delay[2];
    end else begin
        out_valid <=0;
        out1<=0;
        out2<=0;
        out3<=0;
    end
end

endmodule
