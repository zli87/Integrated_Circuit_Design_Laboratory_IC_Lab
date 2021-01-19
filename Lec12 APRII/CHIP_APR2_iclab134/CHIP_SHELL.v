module CHIP( clk, rst_n, in_valid_d, in_valid_t, in_valid_w1, in_valid_w2,
        data_point, target, weight1, weight2, out_valid, out );

  input clk, rst_n, in_valid_d, in_valid_t, in_valid_w1, in_valid_w2;
  input [7:0] data_point;
  input [7:0] target;
  input [7:0] weight1;
  input [7:0] weight2;

  output [7:0] out;
  output out_valid;

wire C_clk,
     C_rst_n,
     C_in_valid_d,
     C_in_valid_t,
     C_in_valid_w1,
     C_in_valid_w2;

wire [7:0] C_data_point;
wire [7:0] C_target;
wire [7:0] C_weight1;
wire [7:0] C_weight2;

wire [7:0] C_out;
wire       C_out_valid;

wire BUF_clk;
CLKBUFX20 buf0(.A(C_clk),.Y(BUF_clk));

NN I_NN
(
	// Input signals
	        .clk(BUF_clk),
	      .rst_n(C_rst_n),
	 .in_valid_d(C_in_valid_d),
	 .in_valid_t(C_in_valid_t),
	.in_valid_w1(C_in_valid_w1),
	.in_valid_w2(C_in_valid_w2),
	 .data_point(C_data_point),
	     .target(C_target),
	    .weight1(C_weight1),
	    .weight2(C_weight2),
	// Output signals
	  .out_valid(C_out_valid),
	        .out(C_out)
);


// Input Pads
P8C I_CLK (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_clk), .P(clk));
P8C I_RESET (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_rst_n), .P(rst_n));
P4C I_VALID_D (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_in_valid_d), .P(in_valid_d));
P4C I_VALID_T (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_in_valid_t), .P(in_valid_t));
P4C I_VALID_W1 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_in_valid_w1), .P(in_valid_w1));
P4C I_VALID_W2 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_in_valid_w2), .P(in_valid_w2));
P4C I_DP_0 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[0]), .P(data_point[0]));
P4C I_DP_1 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[1]), .P(data_point[1]));
P4C I_DP_2 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[2]), .P(data_point[2]));
P4C I_DP_3 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[3]), .P(data_point[3]));
P4C I_DP_4 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[4]), .P(data_point[4]));
P4C I_DP_5 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[5]), .P(data_point[5]));
P4C I_DP_6 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[6]), .P(data_point[6]));
P4C I_DP_7 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_data_point[7]), .P(data_point[7]));

P4C I_TAR_0 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[0]), .P(target[0]));
P4C I_TAR_1 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[1]), .P(target[1]));
P4C I_TAR_2 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[2]), .P(target[2]));
P4C I_TAR_3 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[3]), .P(target[3]));
P4C I_TAR_4 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[4]), .P(target[4]));
P4C I_TAR_5 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[5]), .P(target[5]));
P4C I_TAR_6 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[6]), .P(target[6]));
P4C I_TAR_7 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_target[7]), .P(target[7]));

P4C I_WEI1_0 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[0]), .P(weight1[0]));
P4C I_WEI1_1 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[1]), .P(weight1[1]));
P4C I_WEI1_2 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[2]), .P(weight1[2]));
P4C I_WEI1_3 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[3]), .P(weight1[3]));
P4C I_WEI1_4 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[4]), .P(weight1[4]));
P4C I_WEI1_5 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[5]), .P(weight1[5]));
P4C I_WEI1_6 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[6]), .P(weight1[6]));
P4C I_WEI1_7 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight1[7]), .P(weight1[7]));

P4C I_WEI2_0 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[0]), .P(weight2[0]));
P4C I_WEI2_1 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[1]), .P(weight2[1]));
P4C I_WEI2_2 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[2]), .P(weight2[2]));
P4C I_WEI2_3 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[3]), .P(weight2[3]));
P4C I_WEI2_4 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[4]), .P(weight2[4]));
P4C I_WEI2_5 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[5]), .P(weight2[5]));
P4C I_WEI2_6 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[6]), .P(weight2[6]));
P4C I_WEI2_7 (.A(1'b0), .ODEN(1'b0), .OCEN(1'b0), .PU(1'b1), .PD(1'b0), .CEN(1'b1), .CSEN(1'b0), .Y(C_weight2[7]), .P(weight2[7]));
// Output Pads
P8C O_VALID (.A(C_out_valid),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out_valid));
P8C O_OUT_0 (.A(C_out[0]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[0]));
P8C O_OUT_1 (.A(C_out[1]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[1]));
P8C O_OUT_2 (.A(C_out[2]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[2]));
P8C O_OUT_3 (.A(C_out[3]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[3]));
P8C O_OUT_4 (.A(C_out[4]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[4]));
P8C O_OUT_5 (.A(C_out[5]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[5]));
P8C O_OUT_6 (.A(C_out[6]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[6]));
P8C O_OUT_7 (.A(C_out[7]),  .ODEN(1'b1),  .OCEN(1'b1),  .PU(1'b1),  .PD(1'b0),  .CEN(1'b1),  .CSEN(1'b0), .P(out[7]));

// IO power 3.3V pads  (DVDD + DGND)
PVDDR VDDP0 ();
PVSSR GNDP0 ();
PVDDR VDDP1 ();
PVSSR GNDP1 ();
PVDDR VDDP2 ();
PVSSR GNDP2 ();
PVDDR VDDP3 ();
PVSSR GNDP3 ();
PVDDR VDDP4 ();
PVSSR GNDP4 ();
PVDDR VDDP5 ();
PVSSR GNDP5 ();
PVDDR VDDP6 ();
PVSSR GNDP6 ();

// Core poweri 1.8V pads  (VDD + GND)
PVDDC VDDC0 ();
PVSSC GNDC0 ();
PVDDC VDDC1 ();
PVSSC GNDC1 ();
PVDDC VDDC2 ();
PVSSC GNDC2 ();
PVDDC VDDC3 ();
PVSSC GNDC3 ();
PVDDC VDDC4 ();
PVSSC GNDC4 ();
PVDDC VDDC5 ();
PVSSC GNDC5 ();
PVDDC VDDC6 ();
PVSSC GNDC6 ();

endmodule
