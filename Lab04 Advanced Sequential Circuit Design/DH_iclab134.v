
//synopsys translate_off
`include "/usr/synthesis/dw/sim_ver/DW_sincos.v"
//synopsys translate_on


//`include "DW_sincos.v"
module DH(
	// Input signals
	input clk,
	input rst_n,
	input IN_VALID_1,
	input IN_VALID_2,
	input signed [5:0] ALPHA_I,
	input signed [2:0] A_I,
	input signed [2:0] D_I,
	input signed [5:0] THETA_JOINT_1,
	input signed [5:0] THETA_JOINT_2,
	input signed [5:0] THETA_JOINT_3,
	input signed [5:0] THETA_JOINT_4,
	// Output signals
	output  reg OUT_VALID,
	output  reg signed [8:0] OUT_X,
	output  reg signed [8:0] OUT_Y,
	output  reg signed [8:0] OUT_Z
);
//---------------------------------------------------------------------
//   PARAMETER
//---------------------------------------------------------------------


//parameter real printfloat = 2.0**11;
//parameter real printfloat2 = 2.0**22;

parameter float = 11;
parameter sign = 2;
parameter WAVE_width = sign + float - 1;

parameter floatT = 2*float;
parameter signT = 4;
parameter WAVE_widthT = signT + floatT - 1;

parameter floatP = 2*float;
parameter signP = 6;
parameter WAVE_widthP = signP + floatP - 1;

// parameter of DW_sincos
parameter A_width = 6;
parameter arch = 0;
parameter err_range = 1;
//================================================================
// parameters & integer
//================================================================
reg signed [WAVE_width:0] ALPHA_cos [3:0];
reg signed [WAVE_width:0] ALPHA_sin [3:0];
reg [2:0] output_count;
reg [10:0] exe_count;
reg signed [2:0] A [3:0];
reg signed [2:0] D [3:0];

wire signed [WAVE_width:0] cos_theta_0;
wire signed [WAVE_width:0] sin_theta_0;
reg signed [WAVE_width:0] cos_theta_00;
reg signed [WAVE_width:0] sin_theta_00;

wire signed [WAVE_width:0] cos_theta_1;
wire signed [WAVE_width:0] cos_theta_1_neg;
wire signed [WAVE_width:0] sin_theta_1;
wire signed [WAVE_width:0] sin_theta_1_neg;
wire signed [WAVE_width:0] cos_alpha_1;
wire signed [WAVE_width:0] sin_alpha_1;
reg signed [WAVE_width:0] cos_theta_11;
reg signed [WAVE_width:0] sin_theta_11;

wire signed [WAVE_width:0] cos_theta_2;
wire signed [WAVE_width:0] cos_theta_2_neg;
wire signed [WAVE_width:0] sin_theta_2;
wire signed [WAVE_width:0] sin_theta_2_neg;
wire signed [WAVE_width:0] cos_alpha_2;
wire signed [WAVE_width:0] sin_alpha_2;
reg signed [WAVE_width:0] cos_theta_22 [2:0];
reg signed [WAVE_width:0] sin_theta_22 [2:0];

wire signed [WAVE_width:0] cos_theta_3;
wire signed [WAVE_width:0] cos_theta_3_neg;
wire signed [WAVE_width:0] sin_theta_3;
wire signed [WAVE_width:0] sin_theta_3_neg;
wire signed [WAVE_width:0] cos_alpha_3;
wire signed [WAVE_width:0] sin_alpha_3;
reg signed [WAVE_width:0] cos_theta_33 [4:0];
reg signed [WAVE_width:0] sin_theta_33 [4:0];

reg signed [WAVE_widthT:0] T1_00;
reg signed [WAVE_widthT:0] T1_10;
reg signed [WAVE_widthT:0] T1_01;
reg signed [WAVE_widthT:0] T1_11;
reg signed [WAVE_widthT:0] T1_21;
reg signed [WAVE_widthT:0] T1_02;
reg signed [WAVE_widthT:0] T1_12;
reg signed [WAVE_widthT:0] T1_22;
reg signed [WAVE_widthT:0] T1_03;
reg signed [WAVE_widthT:0] T1_13;
reg signed [WAVE_widthT:0] T1_23;

reg signed [WAVE_widthT:0] T2_00;
reg signed [WAVE_widthT:0] T2_10;
reg signed [WAVE_widthT:0] T2_01;
reg signed [WAVE_widthT:0] T2_11;
reg signed [WAVE_widthT:0] T2_21;
reg signed [WAVE_widthT:0] T2_02;
reg signed [WAVE_widthT:0] T2_12;
reg signed [WAVE_widthT:0] T2_22;
reg signed [WAVE_widthT:0] T2_03;
reg signed [WAVE_widthT:0] T2_13;
reg signed [WAVE_widthT:0] T2_23;

reg signed [WAVE_widthT:0] T3_00;
reg signed [WAVE_widthT:0] T3_10;
reg signed [WAVE_widthT:0] T3_01;
reg signed [WAVE_widthT:0] T3_11;
reg signed [WAVE_widthT:0] T3_21;
reg signed [WAVE_widthT:0] T3_02;
reg signed [WAVE_widthT:0] T3_12;
reg signed [WAVE_widthT:0] T3_22;
reg signed [WAVE_widthT:0] T3_03;
reg signed [WAVE_widthT:0] T3_13;
reg signed [WAVE_widthT:0] T3_23;

reg signed [WAVE_widthT:0] p1_0;
reg signed [WAVE_widthT:0] p1_1;
reg signed [WAVE_widthT:0] p1_2;
reg signed [WAVE_widthP:0] p2_0;
reg signed [WAVE_widthP:0] p2_1;
reg signed [WAVE_widthP:0] p2_2;
reg signed [WAVE_widthP:0] p3_0;
reg signed [WAVE_widthP:0] p3_1;
reg signed [WAVE_widthP:0] p3_2;
reg signed [WAVE_widthP:0] p4_0;
reg signed [WAVE_widthP:0] p4_1;
reg signed [WAVE_widthP:0] p4_2;

reg signed [WAVE_widthP:0] p2_00;
reg signed [WAVE_widthP:0] p2_01;
reg signed [WAVE_widthP:0] p2_02;
reg signed [WAVE_widthP:0] p2_03;
reg signed [WAVE_widthP:0] p2_10;
reg signed [WAVE_widthP:0] p2_11;
reg signed [WAVE_widthP:0] p2_12;
reg signed [WAVE_widthP:0] p2_13;
reg signed [WAVE_widthP:0] p2_21;
reg signed [WAVE_widthP:0] p2_22;
reg signed [WAVE_widthP:0] p2_23;

reg signed [WAVE_widthP:0] p3_00;
reg signed [WAVE_widthP:0] p3_01;
reg signed [WAVE_widthP:0] p3_02;
reg signed [WAVE_widthP:0] p3_03;
reg signed [WAVE_widthP:0] p3_10;
reg signed [WAVE_widthP:0] p3_11;
reg signed [WAVE_widthP:0] p3_12;
reg signed [WAVE_widthP:0] p3_13;
reg signed [WAVE_widthP:0] p3_21;
reg signed [WAVE_widthP:0] p3_22;
reg signed [WAVE_widthP:0] p3_23;

reg signed [WAVE_widthP:0] p4_00;
reg signed [WAVE_widthP:0] p4_01;
reg signed [WAVE_widthP:0] p4_02;
reg signed [WAVE_widthP:0] p4_03;
reg signed [WAVE_widthP:0] p4_10;
reg signed [WAVE_widthP:0] p4_11;
reg signed [WAVE_widthP:0] p4_12;
reg signed [WAVE_widthP:0] p4_13;
reg signed [WAVE_widthP:0] p4_21;
reg signed [WAVE_widthP:0] p4_22;
reg signed [WAVE_widthP:0] p4_23;

DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M1sina (.A(ALPHA_I), .SIN_COS(1'b0),  .WAVE(sin_alpha_1));
DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M1cosa (.A(ALPHA_I), .SIN_COS(1'b1),  .WAVE(cos_alpha_1));

DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M0sint (.A(THETA_JOINT_1), .SIN_COS(1'b0),  .WAVE(sin_theta_0));
DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M0cost (.A(THETA_JOINT_1), .SIN_COS(1'b1),  .WAVE(cos_theta_0));

DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M1sint (.A(THETA_JOINT_2), .SIN_COS(1'b0),  .WAVE(sin_theta_1));
DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M1cost (.A(THETA_JOINT_2), .SIN_COS(1'b1),  .WAVE(cos_theta_1));

assign cos_theta_1_neg = -cos_theta_11;
assign sin_theta_1_neg = -sin_theta_11;
DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M2sint (.A(THETA_JOINT_3), .SIN_COS(1'b0),  .WAVE(sin_theta_2));
DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M2cost (.A(THETA_JOINT_3), .SIN_COS(1'b1),  .WAVE(cos_theta_2));
assign cos_theta_2_neg = -cos_theta_22[2];
assign sin_theta_2_neg = -sin_theta_22[2];
DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M3sint (.A(THETA_JOINT_4), .SIN_COS(1'b0),  .WAVE(sin_theta_3));
DW_sincos #(A_width , WAVE_width+1 , arch ,err_range ) M3cost (.A(THETA_JOINT_4), .SIN_COS(1'b1),  .WAVE(cos_theta_3));
assign cos_theta_3_neg = -cos_theta_33[4];
assign sin_theta_3_neg = -sin_theta_33[4];

//================================================================
// cos sin theta
//================================================================
always @ (posedge clk) begin
	cos_theta_00 <= cos_theta_0;
	sin_theta_00 <= sin_theta_0;
	cos_theta_11 <= cos_theta_1;
	sin_theta_11 <= sin_theta_1;

	cos_theta_22[0] <= cos_theta_2;
	cos_theta_22[1] <= cos_theta_22[0];
	cos_theta_22[2] <= cos_theta_22[1];
	sin_theta_22[0] <= sin_theta_2;
	sin_theta_22[1] <= sin_theta_22[0];
	sin_theta_22[2] <= sin_theta_22[1];

	cos_theta_33[0] <= cos_theta_3;
	cos_theta_33[1] <= cos_theta_33[0];
	cos_theta_33[2] <= cos_theta_33[1];
	cos_theta_33[3] <= cos_theta_33[2];
	cos_theta_33[4] <= cos_theta_33[3];
	sin_theta_33[0] <= sin_theta_3;
	sin_theta_33[1] <= sin_theta_33[0];
	sin_theta_33[2] <= sin_theta_33[1];
	sin_theta_33[3] <= sin_theta_33[2];
	sin_theta_33[4] <= sin_theta_33[3];
end
//================================================================
// matrix T1
//================================================================
always @ (posedge clk) begin
	T1_00 <= $signed({{sign{cos_theta_11[WAVE_width]}},cos_theta_11,{float{1'b0}}});
	T1_10 <= $signed({{sign{sin_theta_11[WAVE_width]}},sin_theta_11,{float{1'b0}}});

	T1_01 <= sin_theta_1_neg*ALPHA_cos[1];
	T1_11 <= cos_theta_11*ALPHA_cos[1];
	T1_21 <= $signed({{sign{ALPHA_sin[1][WAVE_width]}},ALPHA_sin[1],{float{1'b0}}});

	T1_02 <= sin_theta_11*ALPHA_sin[1];
	T1_12 <= cos_theta_1_neg*ALPHA_sin[1];
	T1_22 <= $signed({{sign{ALPHA_cos[1][WAVE_width]}},ALPHA_cos[1],{float{1'b0}}});

	T1_03 <= $signed({1'b0,A[1],{float{1'b0}}})*cos_theta_11;
	T1_13 <= $signed({1'b0,A[1],{float{1'b0}}})*sin_theta_11;
	T1_23 <= $signed({1'b0,D[1],{floatT{1'b0}}});
end
/*
always @ ( posedge clk ) begin
	if(exe_count!=0) begin
	$display("******************************************************");
	$display("sin(0O): %f ",sin_theta_0/printfloat);
	$display("sin(01): %f -sin(01): %f sin(aO): %f",sin_theta_1/printfloat,sin_theta_1_neg/printfloat,ALPHA_sin[1]/printfloat);
	$display("sin(02): %f -sin(02): %f sin(a1): %f",sin_theta_2/printfloat,sin_theta_2_neg/printfloat,ALPHA_sin[2]/printfloat);
	$display("sin(03): %f -sin(03): %f sin(a2): %f",sin_theta_3/printfloat,sin_theta_3_neg/printfloat,ALPHA_sin[3]/printfloat);
	$display("cos(0O): %f ",cos_theta_0/printfloat);
	$display("cos(01): %f -cos(01): %f cos(aO): %f",cos_theta_1/printfloat,cos_theta_1_neg/printfloat,ALPHA_cos[1]/printfloat);
	$display("cos(02): %f -cos(02): %f cos(a1): %f",cos_theta_2/printfloat,cos_theta_2_neg/printfloat,ALPHA_cos[2]/printfloat);
	$display("cos(03): %f -cos(03): %f cos(a2): %f",cos_theta_3/printfloat,cos_theta_3_neg/printfloat,ALPHA_cos[3]/printfloat);
	end
end
*/
/*
always @ ( posedge clk ) begin
	if(exe_count!=0) begin
	$display("count = %1d",exe_count);
	$display("****************************************************** T1 ");
	$display(" %f  %f  %f  %f",T1_00/printfloat2,T1_01/printfloat2,T1_02/printfloat2,T1_03/printfloat2);
	$display(" %f  %f  %f  %f",T1_10/printfloat2,T1_11/printfloat2,T1_12/printfloat2,T1_13/printfloat2);
	$display("            %f  %f  %f",					 T1_21/printfloat2,T1_22/printfloat2,T1_23/printfloat2);
	$display("****************************************************** T2 ");
	$display(" %f  %f  %f  %f",T2_00/printfloat2,T2_01/printfloat2,T2_02/printfloat2,T2_03/printfloat2);
	$display(" %f  %f  %f  %f",T2_10/printfloat2,T2_11/printfloat2,T2_12/printfloat2,T2_13/printfloat2);
	$display("            %f  %f  %f",					 T2_21/printfloat2,T2_22/printfloat2,T2_23/printfloat2);
	$display("****************************************************** T3 ");
	$display(" %f  %f  %f  %f",T3_00/printfloat2,T3_01/printfloat2,T3_02/printfloat2,T3_03/printfloat2);
	$display(" %f  %f  %f  %f",T3_10/printfloat2,T3_11/printfloat2,T3_12/printfloat2,T3_13/printfloat2);
	$display("            %f  %f  %f",					 T3_21/printfloat2,T3_22/printfloat2,T3_23/printfloat2);
	end
end
*/
//================================================================
// matrix T2
//================================================================
always @ (posedge clk) begin
	T2_00 <= $signed({{sign{cos_theta_22[2][WAVE_width]}},cos_theta_22[2],{float{1'b0}}});
	T2_10 <= $signed({{sign{sin_theta_22[2][WAVE_width]}},sin_theta_22[2],{float{1'b0}}});

	T2_01 <= sin_theta_2_neg*ALPHA_cos[2];
	T2_11 <= cos_theta_22[2]*ALPHA_cos[2];
	T2_21 <= $signed({{sign{ALPHA_sin[2][WAVE_width]}},ALPHA_sin[2],{float{1'b0}}});

	T2_02 <= sin_theta_22[2]*ALPHA_sin[2];
	T2_12 <= cos_theta_2_neg*ALPHA_sin[2];
	T2_22 <= $signed({{sign{ALPHA_cos[2][WAVE_width]}},ALPHA_cos[2],{float{1'b0}}});

	T2_03 <= $signed({1'b0,A[2],{float{1'b0}}})*cos_theta_22[2];
	T2_13 <= $signed({1'b0,A[2],{float{1'b0}}})*sin_theta_22[2];
	T2_23 <= $signed({1'b0,D[2],{floatT{1'b0}}});
end
//================================================================
// matrix T3
//================================================================
always @ (posedge clk) begin
	T3_00 <= $signed({{sign{cos_theta_33[4][WAVE_width]}},cos_theta_33[4],{float{1'b0}}});
	T3_10 <= $signed({{sign{sin_theta_33[4][WAVE_width]}},sin_theta_33[4],{float{1'b0}}});

	T3_01 <= sin_theta_3_neg*ALPHA_cos[3];
	T3_11 <= cos_theta_33[4]*ALPHA_cos[3];
	T3_21 <= $signed({{sign{ALPHA_sin[3][WAVE_width]}},ALPHA_sin[3],{float{1'b0}}});

	T3_02 <= sin_theta_33[4]*ALPHA_sin[3];
	T3_12 <= cos_theta_3_neg*ALPHA_sin[3];
	T3_22 <= $signed({{sign{ALPHA_cos[3][WAVE_width]}},ALPHA_cos[3],{float{1'b0}}});

	T3_03 <= $signed({1'b0,A[3],{float{1'b0}}})*cos_theta_33[4];
	T3_13 <= $signed({1'b0,A[3],{float{1'b0}}})*sin_theta_33[4];
	T3_23 <= $signed({1'b0,D[3],{floatT{1'b0}}});
end
//================================================================
// position 1
//================================================================
always @ (posedge clk) begin
	p1_0 <= $signed({1'b0,A[0],{float{1'b0}}})*cos_theta_00;
	p1_1 <= $signed({1'b0,A[0],{float{1'b0}}})*sin_theta_00;
	p1_2 <= $signed({1'b0,D[0],{floatT{1'b0}}});
end
/*
always @ (posedge clk) begin
	if(exe_count!=0) begin
	$display("****************************************************** P1 ");
	$display("  %f  %f  %f ",p1_0/printfloat2,p1_1/printfloat2,p1_2/printfloat2);
	$display("****************************************************** P2 ");
	$display("  %f  %f  %f ",p2_0/printfloat2,p2_1/printfloat2,p2_2/printfloat2);
	$display("****************************************************** P3 ");
	$display("  %f  %f  %f ",p3_0/printfloat2,p3_1/printfloat2,p3_2/printfloat2);
	$display("****************************************************** P4 ");
	$display("  %f  %f  %f ",p4_0/printfloat2,p4_1/printfloat2,p4_2/printfloat2);
	//$display("****************************************************** P1-1 ");
	//$display("  %f  %f  %f ",$signed(p1_0[WAVE_widthT:float])/printfloat,$signed(p1_1[WAVE_widthT:float])/printfloat,$signed(p1_2[WAVE_widthT:float])/printfloat);
	//$display("****************************************************** P3-1 ");
	//$display("  %f  %f  %f  %f",p3_00/printfloat2,p3_01/printfloat2,p3_02/printfloat2,p3_03/printfloat2);
	//$display("  %f  %f  %f  %f",p3_10/printfloat2,p3_11/printfloat2,p3_12/printfloat2,p3_13/printfloat2);
	//$display("          %f  %f  %f", p3_21/printfloat2,p3_22/printfloat2,p3_23/printfloat2);
	end
end
*/
//================================================================
// position 2
//================================================================
always @ (posedge clk) begin
	p2_00 <= $signed(p1_0[WAVE_widthT:float])*$signed(T1_00[WAVE_widthT:float]);
	p2_01 <= $signed(p1_1[WAVE_widthT:float])*$signed(T1_01[WAVE_widthT:float]);
	p2_02 <= $signed(p1_2[WAVE_widthT:float])*$signed(T1_02[WAVE_widthT:float]);
	p2_03 <= T1_03;
	p2_10 <= $signed(p1_0[WAVE_widthT:float])*$signed(T1_10[WAVE_widthT:float]);
	p2_11 <= $signed(p1_1[WAVE_widthT:float])*$signed(T1_11[WAVE_widthT:float]);
	p2_12 <= $signed(p1_2[WAVE_widthT:float])*$signed(T1_12[WAVE_widthT:float]);
	p2_13 <= T1_13;
	p2_21 <= $signed(p1_1[WAVE_widthT:float])*$signed(T1_21[WAVE_widthT:float]);
	p2_22 <= $signed(p1_2[WAVE_widthT:float])*$signed(T1_22[WAVE_widthT:float]);
	p2_23 <= T1_23;
end
always @ (posedge clk) begin
	p2_0 <= ( p2_00 + p2_01 )+( p2_02 + p2_03 );
	p2_1 <= ( p2_10 + p2_11 )+( p2_12 + p2_13 );
	p2_2 <= (		  p2_21 )+( p2_22 + p2_23 );
end
//================================================================
// position 3
//================================================================
always @ (posedge clk) begin
	p3_00 <= $signed(p2_0[WAVE_widthP:float])*$signed(T2_00[WAVE_widthT:float]);
	p3_01 <= $signed(p2_1[WAVE_widthP:float])*$signed(T2_01[WAVE_widthT:float]);
	p3_02 <= $signed(p2_2[WAVE_widthP:float])*$signed(T2_02[WAVE_widthT:float]);
	p3_03 <= T2_03;
	p3_10 <= $signed(p2_0[WAVE_widthP:float])*$signed(T2_10[WAVE_widthT:float]);
	p3_11 <= $signed(p2_1[WAVE_widthP:float])*$signed(T2_11[WAVE_widthT:float]);
	p3_12 <= $signed(p2_2[WAVE_widthP:float])*$signed(T2_12[WAVE_widthT:float]);
	p3_13 <= T2_13;
	p3_21 <= $signed(p2_1[WAVE_widthP:float])*$signed(T2_21[WAVE_widthT:float]);
	p3_22 <= $signed(p2_2[WAVE_widthP:float])*$signed(T2_22[WAVE_widthT:float]);
	p3_23 <= T2_23;
end
always @ (posedge clk) begin
	p3_0 <= ( p3_00 + p3_01 )+( p3_02 + p3_03 );
	p3_1 <= ( p3_10 + p3_11 )+( p3_12 + p3_13 );
	p3_2 <= (		  p3_21 )+( p3_22 + p3_23 );
end
//================================================================
// position 4
//================================================================
always @ (posedge clk) begin
	p4_00 <= $signed(p3_0[WAVE_widthP:float])*$signed(T3_00[WAVE_widthT:float]);
	p4_01 <= $signed(p3_1[WAVE_widthP:float])*$signed(T3_01[WAVE_widthT:float]);
	p4_02 <= $signed(p3_2[WAVE_widthP:float])*$signed(T3_02[WAVE_widthT:float]);
	p4_03 <= T3_03;
	p4_10 <= $signed(p3_0[WAVE_widthP:float])*$signed(T3_10[WAVE_widthT:float]);
	p4_11 <= $signed(p3_1[WAVE_widthP:float])*$signed(T3_11[WAVE_widthT:float]);
	p4_12 <= $signed(p3_2[WAVE_widthP:float])*$signed(T3_12[WAVE_widthT:float]);
	p4_13 <= T3_13;
	p4_21 <= $signed(p3_1[WAVE_widthP:float])*$signed(T3_21[WAVE_widthT:float]);
	p4_22 <= $signed(p3_2[WAVE_widthP:float])*$signed(T3_22[WAVE_widthT:float]);
	p4_23 <= T3_23;
end
always @ (posedge clk) begin
	p4_0 <= ( p4_00 + p4_01 )+( p4_02 + p4_03 );
	p4_1 <= ( p4_10 + p4_11 )+( p4_12 + p4_13 );
	p4_2 <= (		  p4_21 )+( p4_22 + p4_23 );
end

always @ ( posedge clk or negedge rst_n ) begin
	if(!rst_n) begin
		ALPHA_sin[0] <= 0;
		ALPHA_sin[1] <= 0;
		ALPHA_sin[2] <= 0;
		ALPHA_sin[3] <= 0;
		ALPHA_cos[0] <= 0;
		ALPHA_cos[1] <= 0;
		ALPHA_cos[2] <= 0;
		ALPHA_cos[3] <= 0;
		A[0] <= 0;
		A[1] <= 0;
		A[2] <= 0;
		A[3] <= 0;
		D[0] <= 0;
		D[1] <= 0;
		D[2] <= 0;
		D[3] <= 0;
	end else if(IN_VALID_1==1) begin
		ALPHA_sin[3] <= sin_alpha_1;
		ALPHA_sin[2] <= ALPHA_sin[3];
		ALPHA_sin[1] <= ALPHA_sin[2];
		ALPHA_sin[0] <= ALPHA_sin[1];

		ALPHA_cos[3] <= cos_alpha_1;
		ALPHA_cos[2] <= ALPHA_cos[3];
		ALPHA_cos[1] <= ALPHA_cos[2];
		ALPHA_cos[0] <= ALPHA_cos[1];

		A[3] <= A_I;
		A[2] <= A[3];
		A[1] <= A[2];
		A[0] <= A[1];

		D[3] <= D_I;
		D[2] <= D[3];
		D[1] <= D[2];
		D[0] <= D[1];
	end
end

always @ ( posedge clk or negedge rst_n ) begin
	if(!rst_n) exe_count <=0;
	else begin
			if(IN_VALID_2)
	 			exe_count[0] <= 1;
			else exe_count[0] <= 0;
			exe_count[1] <= exe_count[0];
			exe_count[2] <= exe_count[1];
			exe_count[3] <= exe_count[2];
			exe_count[4] <= exe_count[3];
			exe_count[5] <= exe_count[4];
			exe_count[6] <= exe_count[5];
			exe_count[7] <= exe_count[6];
			exe_count[8] <= exe_count[7];
	end
end

always @ (posedge clk or negedge rst_n ) begin
	if(!rst_n) begin
		OUT_VALID <=0;
		OUT_X <=0;
		OUT_Y <=0;
		OUT_Z <=0;
	end else if(exe_count[7]) begin
		OUT_VALID <= 1;
		OUT_X <=$signed(p4_0[WAVE_widthP:floatP-3]);
		OUT_Y <=$signed(p4_1[WAVE_widthP:floatP-3]);
		OUT_Z <=$signed(p4_2[WAVE_widthP:floatP-3]);
		//$display(" X %f Y %f Z %f",$signed(p4_0[WAVE_widthP:floatP-3])/8.0,$signed(p4_1[WAVE_widthP:floatP-3])/8.0,$signed(p4_2[WAVE_widthP:floatP-3])/8.0);
	end else begin
		OUT_VALID <=0;
		OUT_X <=0;
		OUT_Y <=0;
		OUT_Z <=0;
	end
end
endmodule
