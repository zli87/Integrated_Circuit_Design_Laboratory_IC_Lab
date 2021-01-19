
module payment(input clk, INF.payment_inf inf);
import usertype::*;
/*
logic [9:0] ccounter;
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) ccounter <= 1;
    else if(ccounter!=0) ccounter <= ccounter +1;
    else $finish();
end
*/
// payment FSM

FSM s_c;
FSM s_n;

// logic
Encrypt_PW d_en_pwd;
Action d_act;
logic [15:0] d_amnt;

full_id d_1ID; // [7:4] BANK [3:0] ACC
logic [3:0] d_1passwd;
logic [15:0] d_1balance;
full_id d_2ID;
logic [3:0] d_2passwd;
logic [15:0] d_2balance;

logic d_same_BANK;
logic [11:0] trnsf_fee;
logic enough_blc;

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_same_BANK <= 0;
    else    d_same_BANK <= (d_1ID.bank==d_2ID.bank)? 1 : 0 ;
end
always_comb begin
    trnsf_fee = (d_same_BANK)? 0 : d_amnt[15:4];
end
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) enough_blc <= 0;
    else enough_blc <= ( d_1balance >= (d_amnt + trnsf_fee))? 1 : 0 ;
end
//Error_Msg d_emsg;
//--------------------
// payment FSM
//--------------------

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) s_c <= s_idle;
    else s_c <= s_n;
end

always_comb begin
    case(s_c)
        s_idle: if(inf.id_valid) s_n = s_check_login; else s_n = s_idle;
        s_check_login: if(inf.C_out_valid) // get encrpt passwd
                            if(inf.C_data_r[23:20]^d_1ID[3:0]) // pass
                                s_n = s_pass_login;
                            else // passwd = 0000
                                s_n = s_fail_login;
                        else s_n = s_check_login;
        s_fail_login: s_n = s_idle;
        s_pass_login: s_n = s_check_passwd;

        s_check_passwd: if(inf.passwd_valid)
                            if(d_1passwd==inf.D.d_pw[0])
                                s_n = s_pass_passwd;
                            else
                                s_n = s_fail_passwd;
                        else s_n = s_check_passwd;
        s_fail_passwd: s_n = s_idle;
        s_pass_passwd: s_n = s_wait_action;
        s_wait_action : if(inf.act_valid)
                        case(inf.D.d_act[0])
                            check_blc: s_n = s_check_blc;
                            deposit: s_n = s_get_deposit;
                            exit:s_n = s_exit;
                            change_pw:s_n = s_change_pw;
                            trnsf: s_n = s_trnsf;
                            default:s_n = s_wait_action;
                        endcase
                        else s_n = s_wait_action;
        s_exit: s_n = s_idle;
        s_check_blc: s_n = s_wait_action;
        // save deposit
        s_get_deposit: if(inf.amnt_valid) s_n = s_save_deposit; else s_n = s_get_deposit;
        s_save_deposit: if(inf.C_out_valid) s_n = s_pass_deposit; else s_n = s_save_deposit;
        s_pass_deposit: s_n = s_wait_action;
        // change pwd
        s_change_pw: if(inf.passwd_valid)
                        if(inf.D.d_pw[0]==0)
                            s_n = s_fail_change_pw;
                        else
                            s_n = s_wait_change_pw;
                    else s_n = s_change_pw;
        s_wait_change_pw: if(inf.C_out_valid) s_n = s_pass_change_pw; else s_n = s_wait_change_pw;
        s_pass_change_pw:  s_n = s_wait_action;
        s_fail_change_pw:  s_n = s_wait_action;
        // transfer
        s_trnsf: if(inf.id_valid) s_n = s_trnsf_wait_amnt; else s_n = s_trnsf;
        s_trnsf_wait_amnt: if(inf.amnt_valid) s_n = s_trnsf_check_rgt; else s_n = s_trnsf_wait_amnt;
        s_trnsf_check_rgt: if(inf.C_out_valid)
                                if((inf.C_data_r[23:20]^inf.C_data_r[27:24]) == 0)
                                    s_n = s_trnsf_fail_rgt;
                                else
                                    s_n = s_trnsf_check_amt;
                            else s_n = s_trnsf_check_rgt;
        s_trnsf_fail_rgt : s_n = s_wait_action;
        s_trnsf_check_amt: if(enough_blc)
                                s_n = s_trnsf_setup_acc1;
                            else
                                s_n = s_trnsf_fail_amnt;
                                 // keep doing ....... save acct1 acc2....
        s_trnsf_fail_amnt: s_n = s_wait_action;
        s_trnsf_setup_acc1:s_n = s_trnsf_save_acc1;
        s_trnsf_save_acc1: if(inf.C_out_valid) s_n = s_trnsf_setup_acc2; else s_n = s_trnsf_save_acc1;
        s_trnsf_setup_acc2: s_n = s_trnsf_save_acc2;
        s_trnsf_save_acc2: if(inf.C_out_valid) s_n = s_pass_trnsf; else s_n = s_trnsf_save_acc2;
        s_pass_trnsf: s_n = s_wait_action;
        default: s_n = s_idle;
    endcase
end
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_amnt <= 0;
    else if(inf.amnt_valid&&(s_c==s_get_deposit))
        d_amnt <= inf.D.d_amnt;
    else if(inf.amnt_valid&&(s_c==s_trnsf_wait_amnt)) begin
        d_amnt <= inf.D.d_amnt;
    end
end
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_act <= no_action;
    else if(inf.act_valid&&(s_c==s_wait_action)) begin
        d_act <= inf.D.d_act[0];
    end
end
//--------------------
// account 1
//--------------------
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_1ID <=0;
    else if(inf.id_valid&&(s_c==s_idle)) begin
        d_1ID <= inf.D.d_id[0];
    end
end

/*
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_ACC <=0;
    else if(inf.id_valid&&(s_c==s_idle)) begin
        d_ACC <= inf.D.d_id[0].acct_no;
    end
end
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_BANK <=0;
    else if(inf.id_valid&&(s_c==s_idle)) begin
        d_BANK <= inf.D.d_id[0].bank;
    end
end
*/
// passwd
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_1passwd <=0;
    else if(inf.C_out_valid&&(s_c==s_check_login)) begin
        d_1passwd <= inf.C_data_r[23:20]^d_1ID.acct_no;
    end else if(inf.passwd_valid&&(s_n == s_wait_change_pw)) begin
        d_1passwd <= inf.D.d_pw[0];
    end
end

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_1balance <=0;
    else if(inf.C_out_valid&&(s_c==s_check_login))
        d_1balance <= inf.C_data_r[15:0];
    else if(inf.amnt_valid&&(s_c==s_get_deposit))
        d_1balance <= d_1balance + inf.D.d_amnt;
    else if( (enough_blc) &&(s_c==s_trnsf_check_amt))
        d_1balance <= d_1balance - d_amnt - trnsf_fee ;
end
//--------------------
// account 2
//--------------------
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_2ID <=0;
    else if(inf.id_valid&&(s_c==s_trnsf))
        d_2ID <= inf.D.d_id[0];
end
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_2passwd <=0;
    else if(inf.C_out_valid&&(s_c==s_trnsf_check_rgt))
        d_2passwd <= inf.C_data_r[23:20]^inf.C_data_r[27:24];
        // en_pwd = [23:20]  ACC = [27:24]
end
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) d_2balance <=0;
    else if(inf.C_out_valid&&(s_c==s_trnsf_check_rgt))
        d_2balance <= inf.C_data_r[15:0];
    else if( (enough_blc) &&(s_c==s_trnsf_check_amt))
        d_2balance <= d_2balance + d_amnt ;
end

//--------------------
// Brdge
//--------------------
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.C_data_w <=0;
    else if(inf.amnt_valid&&(s_c==s_get_deposit)) begin
        inf.C_data_w <= {d_1ID,(d_1passwd^(d_1ID.acct_no)),d_1ID.bank,(d_1balance + inf.D.d_amnt)};
    end else if(inf.passwd_valid&&(s_n == s_wait_change_pw)) begin
        inf.C_data_w <= {d_1ID,(inf.D.d_pw[0]^(d_1ID.acct_no)),d_1ID.bank,(d_1balance)};
    end else if(s_c==s_trnsf_setup_acc1) begin
        inf.C_data_w <= {d_1ID,(d_1passwd^(d_1ID.acct_no)),d_1ID.bank,d_1balance};
    end else if(s_c==s_trnsf_setup_acc2) begin
        inf.C_data_w <= {d_2ID,(d_2passwd^(d_2ID.acct_no)),d_2ID.bank,d_2balance};
    end
end

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.C_in_valid <=0;
    else if(inf.id_valid&&(s_c==s_idle)) inf.C_in_valid <= 1;
    else if(inf.amnt_valid&&(s_c==s_get_deposit)) inf.C_in_valid <= 1;
    else if(inf.passwd_valid&&(s_n == s_wait_change_pw)) inf.C_in_valid <= 1;
    else if(inf.amnt_valid&&(s_c==s_trnsf_wait_amnt)) inf.C_in_valid <= 1;
    else if(s_c==s_trnsf_setup_acc1) inf.C_in_valid <= 1;
    else if(s_c==s_trnsf_setup_acc2) inf.C_in_valid <= 1;
    else inf.C_in_valid <=0;
end

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.C_r_wb <=1; // 0:write 1:read
    else if(inf.id_valid&&(s_c==s_idle)) inf.C_r_wb <= 1;
    else if(inf.amnt_valid&&(s_c==s_get_deposit)) inf.C_r_wb <= 0;
    else if(inf.passwd_valid&&(s_n == s_wait_change_pw)) inf.C_r_wb <= 0;
    else if(inf.amnt_valid&&(s_c==s_trnsf_wait_amnt)) inf.C_r_wb <= 1;
    else if(s_c==s_trnsf_setup_acc1) inf.C_r_wb <= 0; // save account 1
    else if(s_c==s_trnsf_setup_acc2) inf.C_r_wb <= 0; // save account 2
    else inf.C_r_wb <= 1;
end

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.C_addr <=0; // 0:write 1:read
    else if(inf.id_valid&&(s_c==s_idle)) inf.C_addr <= inf.D.d_id[0];
    else if(inf.amnt_valid&&(s_c==s_get_deposit)) inf.C_addr <= d_1ID;
    else if(inf.passwd_valid&&(s_n == s_wait_change_pw)) inf.C_addr <= d_1ID;
    else if(inf.amnt_valid&&(s_c==s_trnsf_wait_amnt)) inf.C_addr <= d_2ID;
    else if(s_c==s_trnsf_setup_acc1) inf.C_addr <= d_1ID;
    else if(s_c==s_trnsf_setup_acc2) inf.C_addr <= d_2ID;
    else inf.C_addr <=0;
end

//--------------------
// payment output
//--------------------
always_ff @ (posedge clk or negedge inf.rst_n ) begin
    if(!inf.rst_n) inf.out_valid <=0 ;
    else begin
        case(s_c)
            s_fail_login:inf.out_valid <=1 ;
            s_pass_login:inf.out_valid <=1 ;
            s_pass_passwd:inf.out_valid <=1 ;
            s_fail_passwd:inf.out_valid <=1 ;
            s_exit:inf.out_valid <=1 ;
            s_check_blc:inf.out_valid <=1 ;
            s_pass_deposit:inf.out_valid <=1 ;
            s_pass_change_pw:inf.out_valid <=1 ;
            s_fail_change_pw:inf.out_valid <=1 ;
            s_trnsf_fail_rgt:inf.out_valid <=1 ;
            s_trnsf_fail_amnt:inf.out_valid <=1 ;
            s_pass_trnsf:inf.out_valid <=1 ;
            default:inf.out_valid <=0 ;
        endcase
    end
end
always_ff @ (posedge clk or negedge inf.rst_n ) begin
    if(!inf.rst_n) inf.err_msg <= No_Err ;
    else begin
        case(s_c)
            s_fail_login:inf.err_msg <= Acct_Not_Exist;
            s_fail_passwd:inf.err_msg <= Wrong_Pw;
            s_fail_change_pw:inf.err_msg <= Invalid_New_Pw;
            s_trnsf_fail_rgt: inf.err_msg <= Acct_Not_Exist;
            s_trnsf_fail_amnt:inf.err_msg <= Out_Of_Money;
            default:inf.err_msg <= No_Err ;
        endcase
    end
end
always_ff @ (posedge clk or negedge inf.rst_n ) begin
    if(!inf.rst_n) inf.complete <=0 ;
    else begin
        case(s_c)
            s_pass_login:inf.complete <=1 ;
            s_pass_passwd:inf.complete <=1 ;
            s_check_blc:inf.complete <=1 ;
            s_pass_deposit:inf.complete <=1 ;
            s_exit:inf.complete <=1 ;
            s_pass_change_pw:inf.complete <=1 ;
            s_pass_trnsf:inf.complete <=1 ;
            default:inf.complete <=0 ;
        endcase
    end
end
always_ff @ (posedge clk or negedge inf.rst_n ) begin
    if(!inf.rst_n) inf.out_balance <=0 ;
    else begin
        case(s_c)
            s_check_blc: inf.out_balance <=d_1balance ;
            s_pass_deposit:inf.out_balance <=d_1balance ;
            s_pass_trnsf:inf.out_balance <=d_1balance ;
            s_trnsf_fail_rgt:inf.out_balance <=d_1balance ;
            s_trnsf_fail_amnt:inf.out_balance <=d_1balance ;
            default:inf.out_balance <=0 ;
        endcase
    end
end


endmodule
