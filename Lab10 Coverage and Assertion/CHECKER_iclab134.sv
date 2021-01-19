//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory System Integration and Silicon Implementation
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   2019 ICLAB Fall Course
//   Lab10      : CTS Coverage
//   Author     : Chi-Yuan, Sung
//
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : CHECKER.sv
//   Module Name : Checker
//   Release version : v1.0 (Release Date: Dec-2019)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################
`include "Usertype_PKG.sv"
module Checker(input clk, INF.CHECKER inf);
import usertype::*;

//covergroup Spec1 @();
//
//       finish your covergroup here
//
//
//endgroup

//declare other cover group

covergroup Spec1@(posedge inf.id_valid);
	ID_COV: coverpoint inf.D.d_id[0] {
		option.auto_bin_max = 256;
		option.at_least = 1;
	}
	option.per_instance = 1;
endgroup

covergroup Spec2@(posedge inf.passwd_valid);
	PW_COV: coverpoint inf.D.d_pw[0] {
		//bins s2[] = {[4'b0001:4'b0011],[4'b0100:4'b0111],[4'b1000:4'b1011],[4'b1100:4'b1111]};
		bins s0 = {[1:3]};
		bins s1 = {[4:7]};
		bins s2 = {[8:11]};
		bins s3 = {[12:15]};
		option.at_least = 10;
	}
	option.per_instance = 1;
endgroup

covergroup Spec3@(posedge inf.act_valid);
	ACT_COV: coverpoint inf.D.d_act[0] {
		bins S [] = (trnsf=>trnsf),(trnsf=>deposit),(trnsf=>check_blc),(trnsf=>change_pw),(trnsf=>exit),
					 (deposit=>trnsf),(deposit=>deposit),(deposit=>check_blc),(deposit=>change_pw),(deposit=>exit),
					 (check_blc=>trnsf),(check_blc=>deposit),(check_blc=>check_blc),(check_blc=>change_pw),(check_blc=>exit),
					 (change_pw=>trnsf),(change_pw=>deposit),(change_pw=>check_blc),(change_pw=>change_pw),(change_pw=>exit),
					 (exit=>trnsf),(exit=>deposit),(exit=>check_blc),(exit=>change_pw);
		option.at_least = 10;
	}
	option.per_instance = 1;
endgroup

covergroup Spec4@(posedge inf.out_valid);
	MSG_COV: coverpoint inf.err_msg {
		bins s4[] = {Out_Of_Money,Wrong_Pw,Acct_Not_Exist,Invalid_New_Pw};
		option.at_least = 10;
	}
	option.per_instance = 1;
endgroup

covergroup Spec5@(posedge inf.out_valid);
	BLC_COV: coverpoint inf.out_balance {
		bins s0 = {[1:17695]};
		bins s1 = {[17696:29492]};
		bins s2 = {[29493:36045]};
		bins s3 = {[36046:47842]};
		bins s4 = {[47843:65535]};
		option.at_least = 20;
	}
	CPE_COV: coverpoint inf.complete {
		bins s0 = { 0 };
		bins s1 = { 1 };
		option.at_least = 100;
	}
	CROSS_COV: cross BLC_COV,CPE_COV {
		option.at_least = 20;
	}
	option.per_instance = 1;
endgroup

//declare the cover group
//Spec1 cov_inst_1 = new();
Spec1 cov_inst_1 = new();
Spec2 cov_inst_2 = new();
Spec3 cov_inst_3 = new();
Spec4 cov_inst_4 = new();
Spec5 cov_inst_5 = new();

//************************************ below assertion is to check your pattern *****************************************
//                                          Please finish and hand in it
// This is an example assertion given by TA, please write other assertions at the below
assert_interval : assert property ( @(posedge clk)  inf.out_valid |=> inf.id_valid == 0 [*2])
else
begin
	$display("Assertion X is violated");
	$fatal;
end

//write other assertions
//always @ (*) begin
//	#0.001 assert ((inf.rst_n==1)||(( inf.out_valid==0 )&&( inf.err_msg==No_Err )&&(inf.complete==0)&&( inf.out_balance==0 )))
//	else
//	begin
//		$display("Assertion 1 is violated");
//		$fatal;
//	end
//end
assert_reset: assert property (  @( inf.rst_n==0 ) (inf.rst_n==0) |-> ( inf.out_valid==0 )&&( inf.err_msg==No_Err )&&(inf.complete==0)&&( inf.out_balance==0 ) )
else
begin
	$display("Assertion 1 is violated");
	$fatal;
end
assert_complete : assert property ( @(posedge clk)  inf.complete |-> inf.err_msg == No_Err )
else
begin
	$display("Assertion 2 is violated");
	repeat(3)@(posedge clk);
	$fatal;
end
Action act_c;
always_ff @ (posedge inf.act_valid) begin
	act_c <= inf.D.d_act[0];
end
assert_trnsf : assert property ( @(posedge clk)  (inf.id_valid&&(act_c==trnsf)) |=> inf.amnt_valid == 0 [*1])
else
begin
	$display("Assertion 3 is violated");
	$fatal;
end

logic [2:0] state_c;
logic [2:0] state_n;
parameter s_idle = 3'd0;
parameter s_act=  3'd1;
parameter s_id = 3'd2;
parameter s_amnt = 3'd3;
always_ff @ (posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n) state_c <= 0;
	else state_c <= state_n;
end
always_comb begin
	case(state_c)
		s_idle : if((inf.act_valid)&&(inf.D.d_act[0]==trnsf)) state_n<= s_act; else state_n <= s_idle;
		s_act : if(inf.amnt_valid) state_n <= s_amnt;
				else if(inf.id_valid) state_n <= s_id;
				else state_n <= s_act;
		s_id : if(inf.amnt_valid) state_n = s_idle; else state_n<= s_id;
		s_amnt : state_n <= s_idle;
	endcase
end
assert_trnsf2 : assert property ( @(state_c==s_amnt) (state_c==s_amnt) |-> 0)
else
begin
	$display("Assertion 3 is violated");
	$fatal;
end

endmodule
