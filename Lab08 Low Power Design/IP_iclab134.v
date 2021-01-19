// synopsys translate_off
`ifdef RTL
`include "GATED_OR.v"
`else
`include "Netlist/GATED_OR_SYN.v"
`endif
// synopsys translate_on
module IP(
	// Input signals
	input clk,
	input rst_n,
	input cg_en,
	input in_valid_1,
	input [7:0] in_image,
	input in_valid_2,
	input [1:0] in_mode,
	// Output signals
	output reg out_valid,
	output reg signed[11:0] out_number
);

//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
reg cg_a;
reg cg_b;
reg cg_c;

reg signed [8:0] img[9:0][9:0];
reg [2:0] in_i;
reg [2:0] in_j;
reg [1:0] mode;
reg [11:0] ans_a ;
reg [11:0] ans_b ;
reg [11:0] ans_a_1 ;
reg [11:0] ans_b_1 ;
reg [11:0] ans_c ;
reg [2:0] out_i;
reg [2:0] out_j;
reg [3:0] out_i_1;
reg [3:0] out_j_1;
reg [3:0] out_i_2;
reg [3:0] out_j_2;

//
reg   [8:0] max1;
reg   [8:0] max2;
reg   [8:0] max3;
reg   [8:0] max4;
reg   [8:0] min1;
reg   [8:0] min2;
reg   [8:0] min3;
reg   [8:0] min4;
reg   [8:0] mmax1;
reg   [8:0] mmax2;
reg   [8:0] mmin1;
reg   [8:0] mmin2;
reg  [8:0] maxx;
reg  [8:0] minn;
reg  [8:0] maxxx;
reg  [8:0] minnn;

reg signed [11:0] a00;
reg signed [11:0] a01;
reg signed [11:0] a02;
reg signed [11:0] a10;
reg signed [11:0] a11;
reg signed [11:0] a12;
reg signed [11:0] a20;
reg signed [11:0] a21;
reg signed [11:0] a22;

reg [2:0] state_n;
reg [2:0] state_c;
parameter s_idle = 'd0;
parameter s_read_img = 'd1;
parameter s_cal = 'd2;
parameter s_cal2 = 'd3;
parameter s_output = 'd4;
parameter s_output2 = 'd5;
//---------------------------------------------------
//	gate clock instance
//---------------------------------------------------
wire G_clock_a;
wire G_sleep_a = cg_a;
GATED_OR GATED_a (
.CLOCK( clk ),
.SLEEP_CTRL( G_sleep_a ),	// gated clock
.RST_N( rst_n ),
.CLOCK_GATED( G_clock_a )
);

wire G_clock_b;
wire G_sleep_b = cg_b;
GATED_OR GATED_b (
.CLOCK( clk ),
.SLEEP_CTRL( G_sleep_b ),	// gated clock
.RST_N( rst_n ),
.CLOCK_GATED( G_clock_b )
);

wire G_clock_c;
wire G_sleep_c = cg_c;
GATED_OR GATED_c (
.CLOCK( clk ),
.SLEEP_CTRL( G_sleep_c ),	// gated clock
.RST_N( rst_n ),
.CLOCK_GATED( G_clock_c )
);

//---------------------------------------------------
//	gate clock CTRL
//---------------------------------------------------
always @ ( * ) begin
	if((mode==2'b00)&&(state_c!=s_idle)&&(state_c!=s_read_img)||((state_c!=s_output)&&(state_c!=s_read_img)) )
	//if((mode==2'b00)|| ((out_i==0)&&(out_j==0)&&( ( (in_i==0)&&(in_j==0) )||( (in_i==3'd7)&&(in_j==3'd7) ) )) )
		cg_a <= 'd0;
	else
		cg_a <= cg_en;
end
always @ ( * ) begin
	if((mode==2'b01)&&(state_c!=s_idle)&&(state_c!=s_read_img)||((state_c!=s_output)&&(state_c!=s_read_img)) )
	//if((mode==2'b01)|| ((out_i==0)&&(out_j==0)&&( ( (in_i==0)&&(in_j==0) )||( (in_i==3'd7)&&(in_j==3'd7) ) )) )
		cg_b <= 'd0;
	else
		cg_b <= cg_en;
end
always @ ( * ) begin
	if((mode==2'b10)&&(state_c!=s_idle)&&(state_c!=s_read_img)|| ((state_c!=s_output)&&(state_c!=s_read_img)) )
	//if((mode==2'b10)|| ((out_i==0)&&(out_j==0)&&( ( (in_i==0)&&(in_j==0) )||( (in_i==3'd7)&&(in_j==3'd7) ) )) )
		cg_c <= 'd0;
	else
		cg_c <= cg_en;
end
//---------------------------------------------------
//	FSM
//---------------------------------------------------

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) state_c <= s_idle;
	else state_c <= state_n;
end
always @ ( * ) begin
	case(state_c)
	s_idle: if(in_valid_1&(!in_valid_2)) state_n = s_read_img;
	 		else if((!in_valid_1)&in_valid_2)  state_n = s_cal2;
			else state_n = s_idle;
	s_read_img: if((in_i==3'd7)&&(in_j==3'd7)) state_n = s_cal; else state_n = s_read_img;
	s_cal: state_n = s_cal2;
	s_cal2: state_n = s_output;
	s_output: if((out_i==3'd0)&&(out_j==3'd0)) state_n = s_output2; else state_n = s_output;
	s_output2 : state_n = s_idle;
	default: state_n = s_idle;
	endcase
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) in_j <=0;
	else if((state_c==s_read_img)||(state_n==s_read_img))
		in_j <= in_j + 1;
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) in_i <= 0;
	else if( ((state_c==s_read_img)||(state_n==s_read_img)) && (in_j==3'd7) )
		in_i <= in_i + 1;
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		img[0][0] <= 0;
		img[0][1] <= 0;
		img[0][2] <= 0;
		img[0][3] <= 0;
		img[0][4] <= 0;
		img[0][5] <= 0;
		img[0][6] <= 0;
		img[0][7] <= 0;
		img[0][8] <= 0;
		img[0][9] <= 0;
		img[9][0] <= 0;
		img[9][1] <= 0;
		img[9][2] <= 0;
		img[9][3] <= 0;
		img[9][4] <= 0;
		img[9][5] <= 0;
		img[9][6] <= 0;
		img[9][7] <= 0;
		img[9][8] <= 0;
		img[9][9] <= 0;
		img[1][0] <= 0;
		img[2][0] <= 0;
		img[3][0] <= 0;
		img[4][0] <= 0;
		img[5][0] <= 0;
		img[6][0] <= 0;
		img[7][0] <= 0;
		img[8][0] <= 0;
		img[1][9] <= 0;
		img[2][9] <= 0;
		img[3][9] <= 0;
		img[4][9] <= 0;
		img[5][9] <= 0;
		img[6][9] <= 0;
		img[7][9] <= 0;
		img[8][9] <= 0;
	end else if((state_c==s_read_img)||(state_n==s_read_img))
		img[in_i+1][in_j+1] <= {1'b0,in_image};
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) mode <= 0;
	else if(in_valid_2&&(!in_valid_1)&&(state_c==s_idle)) mode <= in_mode;
	else if(in_valid_2&&(!in_valid_1)&&(state_c==s_cal)) mode <= in_mode;
end

//---------------------------------------------------
//	Data filter
//---------------------------------------------------
always @ (posedge clk) begin
	if(!cg_c) begin
		a00 <= img[out_i][out_j];
		a01 <= img[out_i][out_j_1];
		a02 <= img[out_i][out_j_2];
		a10 <= img[out_i_1][out_j];
		a11 <= img[out_i_1][out_j_1];
		a12 <= img[out_i_1][out_j_2];
		a20 <= img[out_i_2][out_j];
		a21 <= img[out_i_2][out_j_1];
		a22 <= img[out_i_2][out_j_2];
	end else begin
		a00 <=0;
		a01 <=0;
		a02 <=0;
		a10 <=0;
		a11 <=0;
		a12 <=0;
		a20 <=0;
		a21 <=0;
		a22 <=0;
	end
end

always @ (posedge G_clock_a  ) begin
	 //ans_a <= 5*a11 - a01 - a10 - a12 -a21;
	 ans_a_1 <= 5*img[out_i_1][out_j_1] - img[out_i][out_j_1] - img[out_i_1][out_j] - img[out_i_1][out_j_2] -img[out_i_2][out_j_1];
	 ans_a <= ans_a_1;
end

always @ (posedge G_clock_b ) begin
	 ans_b_1 <= ( img[out_i][out_j] + img[out_i][out_j_1] + img[out_i][out_j_2] +
	 			img[out_i_1][out_j] + img[out_i_1][out_j_1] + img[out_i_1][out_j_2] +
				img[out_i_2][out_j] + img[out_i_2][out_j_1] + img[out_i_2][out_j_2] );
	ans_b <= ans_b_1/9 ;
end

always @ (posedge G_clock_c ) begin
	ans_c <= (maxxx + minnn)>>1;
end

always @ (*) begin
	if(!cg_c) begin
		if(a00 > a01) begin max1 <= a00; min1 <= a01; end
		else begin max1 <= a01; min1 <= a00; end
		if(a02 > a10) begin max2 <= a02; min2 <= a10; end
		else begin max2 <= a10; min2 <= a02; end
		if(a11 > a12) begin max3 <= a11; min3 <= a12; end
		else begin max3 <= a12; min3 <= a11; end
		if(a20 > a21) begin max4 <= a20; min4 <= a21; end
		else begin max4 <= a21; min4 <= a20; end
	end else begin
		max1 <= 0;
		min1 <= 0;
		max2 <= 0;
		min2 <= 0;
		max3 <= 0;
		min3 <= 0;
		max4 <= 0;
		min4 <= 0;
	end
end
always @ ( * ) begin
		if(max1>max2) mmax1 <= max1; else mmax1 <= max2;
		if(max3>max4) mmax2 <= max3; else mmax2 <= max4;
		if(min1<min2) mmin1 <= min1; else mmin1 <= min2;
		if(min3<min4) mmin2 <= min3; else mmin2 <= min4;
end
always @ ( * ) begin
	if(mmax1>mmax2) maxx <= mmax1; else maxx <= mmax2;
	if(mmin1<mmin2) minn <= mmin1; else minn <= mmin2;
end
always @ ( * ) begin
	if(!cg_c) begin
		if(a22 >maxx) maxxx <= a22 ; else maxxx <= maxx;
		if(a22 <minn) minnn <= a22 ; else minnn <= minn;
	end else begin
		maxxx <= 0;
		minnn <= 0;
	end
end

//---------------------------------------------------
//	Data output
//---------------------------------------------------
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
	 	out_valid <=0;
		out_number <=0;
	end else if((state_c>'d3)) begin
		out_valid <=1;
		case(mode)
			2'b00: out_number <= ans_a ;
			2'b01: out_number <= ans_b ;
			2'b10: out_number <= ans_c ;
		endcase
	end else begin
		out_valid <=0;
		out_number <= 0;
	end
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) out_j <= 0;
	else if((state_n==s_output)||(state_n==s_cal2))
		out_j <= out_j+1;
end

always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) out_i <= 0;
	else if( ((state_n==s_output)||(state_n==s_cal2)) && (out_j==3'd7) )
		out_i <= out_i+1;
end

always @ (*) begin
		out_j_1 <= out_j + 1;
		out_j_2 <= out_j + 2;
		out_i_1 <= out_i +1;
		out_i_2 <= out_i +2;
end

endmodule
