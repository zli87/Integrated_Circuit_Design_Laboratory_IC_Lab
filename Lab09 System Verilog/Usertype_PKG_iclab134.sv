//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory System Integration and Silicon Implementation
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   2019 ICLAB Fall Course
//   Lab09      : CTS
//   Author     : Tzu-Yun Huang
//
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : Usertype_PKG.sv
//   Module Name : usertype
//   Release version : v1.0 (Release Date: Nov-2019)
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`ifndef USERTYPE
`define USERTYPE

package usertype;

typedef enum logic  [3:0] { no_action = 4'd0 ,   //000
                            log_in    = 4'd1 ,   //001
							trnsf     = 4'd2 ,   //010
						    deposit   = 4'd3 ,   //011
							check_blc = 4'd5 ,   //101
							change_pw = 4'd6 ,   //110
							exit      = 4'd7 }  Action ;

typedef enum logic  [3:0] { No_Err            = 4'd0 ,
                            Out_Of_Money      = 4'd1 ,
							Wrong_Pw          = 4'd2 ,
						    Acct_Not_Exist    = 4'd4 ,
							Invalid_New_Pw    = 4'd8
						   }  Error_Msg ;


typedef logic [15:0] Balance;
typedef logic [ 7:0] Encrypt_PW;
typedef logic [ 3:0] Bank_ID;
typedef logic [ 3:0] Acct_No;

typedef struct packed {
    Bank_ID     bank;
	Acct_No     acct_no;
	Encrypt_PW  ecrp_pw;
	Balance     blnc;
} acct_status ;

typedef struct packed {
    Bank_ID     bank;
	Acct_No     acct_no;
} full_id ;

typedef union packed{
    Action       [3:0]d_act;
	logic [15:0] d_amnt;
	full_id      [1:0]d_id;
	logic [ 3:0] [3:0]d_pw;
}DATA;

typedef enum logic  [4:0] {
 s_idle = 5'd0,
 s_check_login = 5'd1,
 s_pass_login = 5'd2,
 s_fail_login = 5'd3,
 s_check_passwd = 5'd4,
 s_pass_passwd = 5'd5,
 s_fail_passwd = 5'd6,
 s_wait_action = 5'd7,
 s_check_blc = 5'd8,
 s_exit = 5'd12,

 s_get_deposit = 5'd9,
 s_save_deposit = 5'd10,
 s_pass_deposit = 5'd11,

 s_change_pw = 5'd13,
 s_wait_change_pw = 5'd14,
 s_pass_change_pw = 5'd15,
 s_fail_change_pw = 5'd16,

 s_trnsf = 5'd17,
 s_trnsf_wait_amnt = 5'd19,
 s_trnsf_check_rgt =5'd20,
 s_trnsf_fail_rgt =5'd21,
 s_trnsf_fail_amnt =5'd18,
 s_trnsf_check_amt =5'd22,
 s_trnsf_setup_acc1 = 5'd23,
 s_trnsf_save_acc1 =5'd24,
 s_trnsf_setup_acc2 = 5'd25,
 s_trnsf_save_acc2 =5'd26,
 s_pass_trnsf = 5'd27

						   }  FSM ;


endpackage

import usertype::*; //import usertype into $unit

`endif
