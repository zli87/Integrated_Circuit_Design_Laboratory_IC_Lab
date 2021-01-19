module OT(
	clk,
	rst_n,
	in_valid,
	in_real,
	in_image,
    out_valid,
	out_real,
	out_image
);
input clk;
input rst_n;
input in_valid;
input signed [6:0]in_real;
input signed [6:0]in_image;

output reg out_valid;
output reg signed [8:0]out_real;
output reg signed [8:0]out_image;

parameter print3 = 2.0**3;
parameter print6 = 2.0**6;

parameter IN_INT = 4;
parameter IN_FLOAT = 3;
parameter IN_LEN = 4+3-1;
parameter MULT_LEN = 8+6+1-1;
parameter DET_LEN = MULT_LEN+1;
parameter DET_FLOAT = 2*IN_FLOAT; // 6

reg signed [IN_LEN:0] A_rr; // 4 int + 3 float
reg signed [IN_LEN:0] A_imm;
reg signed [IN_LEN:0] B_rr;
reg signed [IN_LEN:0] B_imm;
reg signed [IN_LEN:0] C_rr;
reg signed [IN_LEN:0] C_imm;
reg signed [IN_LEN:0] D_rr;
reg signed [IN_LEN:0] D_imm;

wire signed [IN_LEN+1:0] B_r_neg;
wire signed [IN_LEN+1:0] B_i_neg;
wire signed [IN_LEN+1:0] C_r_neg;
wire signed [IN_LEN+1:0] C_i_neg;

reg signed [MULT_LEN:0] ad_rr;
reg signed [MULT_LEN:0] ad_imm;
reg signed [MULT_LEN:0] bc_rr;
reg signed [MULT_LEN:0] bc_imm;

reg signed [DET_LEN:0] det_rr;
reg signed [DET_LEN:0] det_imm;

reg [6:0] counter;

/*always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
	end else begin
	end
end*/

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		D_rr <= 0;
		C_rr <= 0;
		B_rr <= 0;
		A_rr <= 0;
	end else if(in_valid==1) begin
		D_rr <= in_real;
		C_rr <= D_rr;
		B_rr <= C_rr;
		A_rr <= B_rr;
	end
end

assign B_r_neg = -$signed({B_rr[IN_LEN],B_rr});
assign B_i_neg = -$signed({B_imm[IN_LEN],B_imm});
assign C_r_neg = -$signed({C_rr[IN_LEN],C_rr});
assign C_i_neg = -$signed({C_imm[IN_LEN],C_imm});

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		D_imm <= 0;
		C_imm <= 0;
		B_imm <= 0;
		A_imm <= 0;
	end else if(in_valid==1) begin
		D_imm <= in_image;
		C_imm <= D_imm;
		B_imm <= C_imm;
		A_imm <= B_imm;
	end
end

// A*D real
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin ad_rr <=0;
	end else begin
		ad_rr <= -A_imm*D_imm + A_rr*D_rr;
	end
end
// A*D img
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin ad_imm <=0;
	end else begin
		ad_imm <= A_rr*D_imm + A_imm*D_rr;
	end
end

// B*C real
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin bc_rr <=0;
	end else begin
		bc_rr <= -B_imm*C_imm + B_rr*C_rr;
	end
end
// B*C img
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin bc_imm <=0;
	end else begin
		bc_imm <= B_rr*C_imm + B_imm*C_rr;
	end
end
// det real
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin det_rr <=0;
	end else begin
		det_rr <= ad_rr - bc_rr;
	end
end
// det img
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin det_imm <=0;
	end else begin
		det_imm <= ad_imm - bc_imm;
	end
end
// exe counter
always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin  counter <=0;
	end else if(in_valid==1) begin
		counter[0] <=1;
		counter[6:1] <=0;
	end else if(counter[2]==1 && det_rr[DET_LEN:6]==0 && det_imm[DET_LEN:6]==0) begin
		counter<=0;
	end else begin
		counter[0] <=0;
		counter[1] <= counter[0];
		counter[2] <= counter[1];
		counter[3] <= counter[2];
		counter[4] <= counter[3];
		counter[5] <= counter[4];
		counter[6] <= counter[5];
	end
end
/*
always@(negedge in_valid) begin
	$display("A_(real,img) = %d %f %d %f",A_rr,A_rr/print3,A_imm,A_imm/print3);
	$display("B_(real,img) = %d %f %d %f",B_rr,B_rr/print3,B_imm,B_imm/print3);
	$display("C_(real,img) = %d %f %d %f",C_rr,C_rr/print3,C_imm,C_imm/print3);
	$display("D_(real,img) = %d %f %d %f",D_rr,D_rr/print3,D_imm,D_imm/print3);
	$display("");
end
always@(posedge clk) begin
	if(counter[1]==1) begin
		$display("ad real = %d %f ans=%f",$signed(ad_rr[MULT_LEN:0]),(ad_rr/print6),(A_imm/print3*D_imm/print3)+(A_rr/print3*D_rr/print3));
		$display("ad image = %d %f ans=%f",$signed(ad_imm[MULT_LEN:6]),(ad_imm/print6),(A_imm/print3*D_rr/print3)+(A_rr/print3*D_imm/print3));
		$display("bc real = %d %f ans=%f",$signed(bc_rr[MULT_LEN:6]),(bc_rr/print6),(B_imm/print3*C_imm/print3)+(B_rr/print3*C_rr/print3));
		$display("bc image = %d %f ans=%f",$signed(bc_imm[MULT_LEN:6]),(bc_imm/print6),(B_imm/print3*C_rr/print3)+(B_rr/print3*C_imm/print3));
	$display("");
	end
end
always@(posedge clk) begin
	if(counter[2]==1) begin
		$display("det real = %d %f ",$signed(det_rr[DET_LEN:6]),(det_rr/(2**6)));
		$display("det image = %d %f ",$signed(det_imm[DET_LEN:6]),(det_imm/(2**6)));
	end
end
*/
// out put
always @(posedge clk or negedge rst_n)begin
	if(!rst_n) begin
		out_valid <= 0;
		out_real<=0;
		out_image <=0;
	end else if(counter[2]==1) begin
		out_valid <=1;
		out_real<=$signed(det_rr[DET_LEN:6]);
		out_image<=$signed(det_imm[DET_LEN:6]);
	end else if(counter[3]==1) begin
		out_valid <=1;
		out_real <= $signed(D_rr[IN_LEN:3]);
		out_image<= $signed(D_imm[IN_LEN:3]);
		//$display("D_real=%d,image=%d",D_rr[IN_LEN:3],D_imm[IN_LEN:3]);
	end else if(counter[4]==1) begin
		out_valid <=1;
		out_real <= $signed(B_r_neg[IN_LEN+1:3]);
		out_image<= $signed(B_i_neg[IN_LEN+1:3]);
		//$display("B %d",$signed(B_i_neg[IN_LEN:3]));
	end else if(counter[5]==1) begin
		out_valid <=1;
		out_real <= $signed(C_r_neg[IN_LEN+1:3]);
		out_image<= $signed(C_i_neg[IN_LEN+1:3]);
	end else if(counter[6]==1) begin
		out_valid <=1;
		out_real <= $signed(A_rr[IN_LEN:3]);
		out_image<= $signed(A_imm[IN_LEN:3]);
	end else begin
		out_valid<=0;
		out_real<=0;
		out_image <=0;
	end
end

endmodule
