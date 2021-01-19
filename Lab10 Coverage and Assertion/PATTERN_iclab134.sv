`include "../00_TESTBED/pseudo_DRAM.sv"
`include "Usertype_PKG.sv"
program automatic PATTERN(input clk, INF.PATTERN inf);
import usertype::*;


//---------------------------------------------------------------------
//   define macro
//---------------------------------------------------------------------
`define ADDR32(x,addr) {x.DRAM[(addr)],x.DRAM[(addr)+1],x.DRAM[(addr)+2],x.DRAM[(addr)+3]}
`define ACCT2NETLIST(x) {  x.bank, x.acct_no, x.ecrp_pw, x.blnc }

`define ID2ADDR(id) (32'h00010000 + (id<<2))
`define GET_BANK(addr) { golden_DRAM[(addr)][7:4] }
`define GET_PASSWD(addr) { golden_DRAM[(addr)][3:0]^golden_DRAM[(addr)+1][7:4] }
`define GET_BALANCE(addr) { golden_DRAM[(addr+2)] , golden_DRAM[(addr+3)] }
`define ENCRYPT_PW(addr,passwd) { golden_DRAM[(addr)][3:0]^passwd }
//---------------------------------------------------------------------
//   Pseudo DRAM
//---------------------------------------------------------------------
logic [7:0] golden_DRAM[((65536+256*4)-1):(65536+0)];
parameter DRAM_p_r = "../00_TESTBED/DRAM/dram.dat";
integer addr_start = 32'h00010000 ;     // 65536
integer addr_end   = 32'h00010400 ;     // 65536 + 256*4
//---------------------------------------------------------------------
//   PARAMETER
//---------------------------------------------------------------------
parameter CYCLE = 7.0;
integer i,t,x,lat,p,patnumber=603; // 0x10000~0x3ffff => (0x40000-0x10000)/0x400

//---------------------------------------------------------------------
//   logic
//---------------------------------------------------------------------
acct_status acct_golden, acct ;
Action act_c,act_n;
full_id id_c;
Error_Msg msg_ans;
logic [15:0] blc_ans;
logic cpe_ans;

logic [15:0] trnsf_fee;
logic same_bank,trnsf_OK;
logic [16:0] check_overflow;
full_id id_n ;

initial begin
  $readmemh(DRAM_p_r, golden_DRAM);
  // initial input signal
  inf.rst_n<=1'b1;
  inf.id_valid<=1'b0;
  inf.passwd_valid<=1'b0;
  inf.amnt_valid<=1'b0;
  inf.act_valid<=1'b0;
  inf.D <= 0;
  // initial ans
  msg_ans = No_Err;
  cpe_ans = 0;

  force clk = 0;
  reset_signal_task;
  for(p=3;p<patnumber;p=p+1) begin
      input_task;
      wait_done;
      //check_ans;
      @(negedge clk);
  end
  //YOU_PASS_task;
  repeat(2)@(negedge clk);
  $finish;
end

//================================================================
// task
//================================================================
task reset_signal_task; begin
    #CYCLE; inf.rst_n <= 0;
    #CYCLE; inf.rst_n <= 1;
    //if(inf.out_valid!==1'b0) begin//out!==0
    //    $display("************************************************************");
    //    $display("*  Output signal should be 0 after initial RESET  at %8t   *",$time);
    //    $display("************************************************************");
    //    repeat(2) #CYCLE;
    //    $finish;
    //end
	#CYCLE; release clk;
    //for(i=addr_start;i<addr_end;i=i+4)
    //    `ADDR32(u_DRAM,i) = $random();             // address to 8 bit
end endtask

task login_task(input [7:0] id); begin
    //input bit [7:0] id; // addr
    inf.D <= { 24'h000000,id };
    inf.id_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.id_valid<=1'b0;
    if(`GET_PASSWD(`ID2ADDR(id))==0) begin
        msg_ans = Acct_Not_Exist;
        cpe_ans = 0;
    end else begin
        msg_ans = No_Err;
        cpe_ans = 1;
    end
    blc_ans = 0;
    id_c = id;
end endtask

task passwd_task(input [3:0] passwd); begin
    inf.D <= {28'h0000000, passwd};
    inf.passwd_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.passwd_valid<=1'b0;
    if(`GET_PASSWD(`ID2ADDR(id_c))!=passwd) begin
        msg_ans = Wrong_Pw;
        cpe_ans = 0;
    end else begin
        msg_ans = No_Err;
        cpe_ans = 1;
    end
    blc_ans = 0;
end endtask

task change_pw_task(input [3:0] new_pw); begin
    inf.D <= {28'h0000000, change_pw};
    inf.act_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.act_valid<=1'b0;
    //@(negedge clk);
    //@(negedge clk);
    inf.D <= { 28'h0, new_pw };
    inf.passwd_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.passwd_valid<=1'b0;
    if(new_pw==0) begin
        msg_ans = Invalid_New_Pw;
        cpe_ans = 0;
    end else begin
        msg_ans = No_Err;
        cpe_ans = 1;
        golden_DRAM[`ID2ADDR(id_c) +1][7:4] = `ENCRYPT_PW(`ID2ADDR(id_c),new_pw);
    end
    blc_ans = 0;
end endtask

task check_blc_task(); begin
    inf.D <= {28'h0000000, check_blc};
    inf.act_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.act_valid<=1'b0;

    msg_ans = No_Err;
    cpe_ans = 1;
    blc_ans = `GET_BALANCE(`ID2ADDR(id_c));
    //if(blc_ans<=17695) $display("%h blc 0",p/4);
    //else if(blc_ans<=29492) $display("%h blc 1",p/4);
    //else if(blc_ans<=36045) $display("%h blc 2",p/4);
    //else if(blc_ans<=47842) $display("%h blc 3",p/4);
    //else if(blc_ans<=65535) $display("%h blc 4",p/4);
end endtask

task deposit_task(input [15:0] current); begin
    inf.D <= {28'h0000000, deposit};
    inf.act_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.act_valid<=1'b0;
    //@(negedge clk);
    //@(negedge clk);
    inf.D <= { 17'h0, current };
    inf.amnt_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.amnt_valid<=1'b0;

    msg_ans = No_Err;
    cpe_ans = 1;
    blc_ans = `GET_BALANCE(`ID2ADDR(id_c)) + current ;
    `GET_BALANCE(`ID2ADDR(id_c)) = blc_ans;
    //check_overflow = {1'b0,`GET_BALANCE(`ID2ADDR(id_c))} + {1'b0,current} ;
    //if(check_overflow[16]) begin
    //    $display("overflow at id_c %h",id_c);
    //    $finish;
    //end
end endtask

task trnsf_task(input [7:0] trnsf_id,input [15:0] trnsf_amt); begin
    inf.D <= {28'h0000000, trnsf};
    inf.act_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.act_valid<=1'b0;
    //@(negedge clk);
    inf.D <= {24'h0000000, trnsf_id };
    inf.id_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.id_valid<=1'b0;
    @(negedge clk);
    inf.D <= {24'h0000000, trnsf_amt };
    inf.amnt_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.amnt_valid<=1'b0;

    id_n = trnsf_id;
    trnsf_fee = trnsf_amt>>4;
    same_bank = (id_c.bank==id_n.bank)? 1:0;
    if(same_bank)
        trnsf_OK = (`GET_BALANCE(`ID2ADDR(id_c)) > trnsf_amt) ;
    else
        trnsf_OK = (`GET_BALANCE(`ID2ADDR(id_c)) > ({1'b0,trnsf_amt} + {5'b0,trnsf_fee})) ;

    if(`GET_PASSWD(`ID2ADDR(id_n))==0)begin
        msg_ans = Acct_Not_Exist;
        cpe_ans = 0;
        blc_ans = `GET_BALANCE(`ID2ADDR(id_c));
        //$display("Acct_Not_Exist");
    end else if(!trnsf_OK) begin
        msg_ans = Out_Of_Money;
        cpe_ans = 0;
        blc_ans = `GET_BALANCE(`ID2ADDR(id_c));
        //$display("Out_Of_Money");
    end else begin
        msg_ans = No_Err;
        cpe_ans = 1;
        blc_ans = (same_bank) ? (`GET_BALANCE(`ID2ADDR(id_c)) - trnsf_amt) : (`GET_BALANCE(`ID2ADDR(id_c)) - (trnsf_amt + trnsf_fee)) ;
        `GET_BALANCE(`ID2ADDR(id_c)) = blc_ans;
        `GET_BALANCE(`ID2ADDR(id_n)) = `GET_BALANCE(`ID2ADDR(id_n)) + trnsf_amt;

        //check_overflow = {1'b0,`GET_BALANCE(`ID2ADDR(id_n))} + {1'b0,trnsf_amt} ;
        //if(check_overflow[16]) begin
        //    $display("overflow at id_n %h",id_n);
        //    $finish;
        //end
    end
end endtask

task exit_task; begin
    inf.D <= {28'h0000000, exit};
    inf.act_valid<=1'b1;
    @(negedge clk);
    inf.D <= { 32'h0 };
    inf.act_valid<=1'b0;

    msg_ans = No_Err;
    cpe_ans = 1;
    blc_ans = 0;
end endtask

task input_task; begin

	repeat(2) @(negedge clk);
    // set input signal
    // 1 trnsf_task(8'h01,15'h10);  //1
    // 2 deposit_task(15'h10);      //2
    // 3 check_blc_task();          //3
    // 4 change_pw_task(4'h0);      //4
    // 5 exit_task;                 //5
    case(p)
        // 0

         //0:login_task(8'h67);
         //1:passwd_task(`GET_PASSWD(`ID2ADDR(8'h67)));
         //2:exit_task;                 //5
         3:login_task(8'h00);
         4:passwd_task(`GET_PASSWD(`ID2ADDR(8'h00)));
         5:trnsf_task(8'h11,16'hffff);  //1
         6:trnsf_task(8'h17,16'hffff);  //1
         7:deposit_task(16'h10);      //2
         8:trnsf_task(8'h18,16'hffff);  //1
         9:check_blc_task();          //3
        10:trnsf_task(8'h1b,16'hffff);  //1
        11:change_pw_task(4'h0);      //4
        12:trnsf_task(8'h1c,16'hffff);  //1
        13:exit_task;                 //5
        14:login_task(8'h08);
        15:passwd_task(`GET_PASSWD(`ID2ADDR(8'h08)));
        16:deposit_task(16'h10);      //2
        17:deposit_task(16'h10);      //2
        18:check_blc_task();          //3
        19:deposit_task(16'h10);      //2
        20:change_pw_task(4'h0);      //4
        21:deposit_task(16'h10);      //2
        22:exit_task;                 //5
        23:login_task(8'h02);
        24:passwd_task(`GET_PASSWD(`ID2ADDR(8'h02)));
        25:check_blc_task();          //3
        26:check_blc_task();          //3
        27:change_pw_task(4'h0);      //4
        28:check_blc_task();          //3
        29:exit_task;                 //5
        30:login_task(8'h20);
        31:passwd_task(`GET_PASSWD(`ID2ADDR(8'h20)));
        32:change_pw_task(4'h0);      //4
        33:change_pw_task(4'h0);      //4
        34:exit_task;                 //5
        // 1
        35:login_task(8'h04);
        36:passwd_task(`GET_PASSWD(`ID2ADDR(8'h04)));
        37:trnsf_task(8'h22,16'hffff);  //1
        38:trnsf_task(8'h23,16'hffff);  //1
        39:deposit_task(16'h10);      //2
        40:trnsf_task(8'h24,16'hffff);  //1
        41:check_blc_task();          //3
        42:trnsf_task(8'h25,16'hffff);  //1
        43:change_pw_task(4'h0);      //4
        44:trnsf_task(8'h26,16'hffff);  //1
        45:exit_task;                 //5
        46:login_task(8'h0b);
        47:passwd_task(`GET_PASSWD(`ID2ADDR(8'h0b)));
        48:deposit_task(16'h10);      //2
        49:deposit_task(16'h10);      //2
        50:check_blc_task();          //3
        51:deposit_task(16'h10);      //2
        52:change_pw_task(4'h0);      //4
        53:deposit_task(16'h10);      //2
        54:exit_task;                 //5
        55:login_task(8'h05);
        56:passwd_task(`GET_PASSWD(`ID2ADDR(8'h05)));
        57:check_blc_task();          //3
        58:check_blc_task();          //3
        59:change_pw_task(4'h0);      //4
        60:check_blc_task();          //3
        61:exit_task;                 //5
        62:login_task(8'h29);
        63:passwd_task(`GET_PASSWD(`ID2ADDR(8'h29)));
        64:change_pw_task(4'h0);      //4
        65:change_pw_task(4'h0);      //4
        66:exit_task;                 //5
        // 2
        67:login_task(8'h06);
        68:passwd_task(`GET_PASSWD(`ID2ADDR(8'h06)));
        69:trnsf_task(8'h2a,16'hffff);  //1
        70:trnsf_task(8'h2b,16'hffff);  //1
        71:deposit_task(16'h10);      //2
        72:trnsf_task(8'h2d,16'hffff);  //1
        73:check_blc_task();          //3
        74:trnsf_task(8'h2e,16'hffff);  //1
        75:change_pw_task(4'h0);      //4
        76:trnsf_task(8'h2f,16'hffff);  //1
        77:exit_task;                 //5
        78:login_task(8'h0e);
        79:passwd_task(`GET_PASSWD(`ID2ADDR(8'h0e)));
        80:deposit_task(16'h10);      //2
        81:deposit_task(16'h10);      //2
        82:check_blc_task();          //3
        83:deposit_task(16'h10);      //2
        84:change_pw_task(4'h0);      //4
        85:deposit_task(16'h10);      //2
        86:exit_task;                 //5
        87:login_task(8'h09);
        88:passwd_task(`GET_PASSWD(`ID2ADDR(8'h09)));
        89:check_blc_task();          //3
        90:check_blc_task();          //3
        91:change_pw_task(4'h0);      //4
        92:check_blc_task();          //3
        93:exit_task;                 //5
        94:login_task(8'h34);
        95:passwd_task(`GET_PASSWD(`ID2ADDR(8'h34)));
        96:change_pw_task(4'h0);      //4
        97:change_pw_task(4'h0);      //4
        98:exit_task;                 //5
        // 3
        99:login_task(8'h0f);
        100:passwd_task(`GET_PASSWD(`ID2ADDR(8'h0f)));
        101:trnsf_task(8'h35,16'hffff);  //1
        102:trnsf_task(8'h36,16'hffff);  //1
        103:deposit_task(16'h10);      //2
        104:trnsf_task(8'h37,16'hffff);  //1
        105:check_blc_task();          //3
        106:trnsf_task(8'h39,16'hffff);  //1
        107:change_pw_task(4'h0);      //4
        108:trnsf_task(8'h3b,16'hffff);  //1
        109:exit_task;                 //5
        110:login_task(8'h14);
        111:passwd_task(`GET_PASSWD(`ID2ADDR(8'h14)));
        112:deposit_task(16'h10);      //2
        113:deposit_task(16'h10);      //2
        114:check_blc_task();          //3
        115:deposit_task(16'h10);      //2
        116:change_pw_task(4'h0);      //4
        117:deposit_task(16'h10);      //2
        118:exit_task;                 //5
        119:login_task(8'h10);
        120:passwd_task(`GET_PASSWD(`ID2ADDR(8'h10)));
        121:check_blc_task();          //3
        122:check_blc_task();          //3
        123:change_pw_task(4'h0);      //4
        124:check_blc_task();          //3
        125:exit_task;                 //5
        126:login_task(8'h3c);
        127:passwd_task(`GET_PASSWD(`ID2ADDR(8'h3c)));
        128:change_pw_task(4'h0);      //4
        129:change_pw_task(4'h0);      //4
        130:exit_task;                 //5
        //4
        131:login_task(8'h0a);
        132:passwd_task(`GET_PASSWD(`ID2ADDR(8'h0a)));
        133:trnsf_task(8'h3d,16'hffff);  //1
        134:trnsf_task(8'h3e,16'hffff);  //1
        135:deposit_task(16'h10);      //2
        136:trnsf_task(8'h3f,16'hffff);  //1
        137:check_blc_task();          //3
        138:trnsf_task(8'h40,16'hffff);  //1
        139:change_pw_task(4'h0);      //4
        140:trnsf_task(8'h41,16'hffff);  //1
        141:exit_task;                 //5
        142:login_task(8'h03);
        143:passwd_task(`GET_PASSWD(`ID2ADDR(8'h03)));
        144:deposit_task(16'h10);      //2
        145:deposit_task(16'h10);      //2
        146:check_blc_task();          //3
        147:deposit_task(16'h10);      //2
        148:change_pw_task(4'h0);      //4
        149:deposit_task(16'h10);      //2
        150:exit_task;                 //5
        151:login_task(8'h12);
        152:passwd_task(`GET_PASSWD(`ID2ADDR(8'h12)));
        153:check_blc_task();          //3
        154:check_blc_task();          //3
        155:change_pw_task(4'h0);      //4
        156:check_blc_task();          //3
        157:exit_task;                 //5
        158:login_task(8'h43);
        159:passwd_task(`GET_PASSWD(`ID2ADDR(8'h43)));
        160:change_pw_task(4'h0);      //4
        161:change_pw_task(4'h0);      //4
        162:exit_task;                 //5
        //5
        163:login_task(8'h21);
        164:passwd_task(`GET_PASSWD(`ID2ADDR(8'h21)));
        165:trnsf_task(8'h44,16'hffff);  //1
        166:trnsf_task(8'h45,16'hffff);  //1
        167:deposit_task(16'h10);      //2
        168:trnsf_task(8'h48,16'hffff);  //1
        169:check_blc_task();          //3
        170:trnsf_task(8'h4a,16'hffff);  //1
        171:change_pw_task(4'h0);      //4
        172:trnsf_task(8'h4b,16'hffff);  //1
        173:exit_task;                 //5
        174:login_task(8'h0d);
        175:passwd_task(`GET_PASSWD(`ID2ADDR(8'h0d)));
        176:deposit_task(16'h10);      //2
        177:deposit_task(16'h10);      //2
        178:check_blc_task();          //3
        179:deposit_task(16'h10);      //2
        180:change_pw_task(4'h0);      //4
        181:deposit_task(16'h10);      //2
        182:exit_task;                 //5
        183:login_task(8'h28);
        184:passwd_task(`GET_PASSWD(`ID2ADDR(8'h28)));
        185:check_blc_task();          //3
        186:check_blc_task();          //3
        187:change_pw_task(4'h0);      //4
        188:check_blc_task();          //3
        189:exit_task;                 //5
        190:login_task(8'h4d);
        191:passwd_task(`GET_PASSWD(`ID2ADDR(8'h4d)));
        192:change_pw_task(4'h0);      //4
        193:change_pw_task(4'h0);      //4
        194:exit_task;                 //5
        //6
        195:login_task(8'h30);
        196:passwd_task(`GET_PASSWD(`ID2ADDR(8'h30)));
        197:trnsf_task(8'h4e,16'hffff);  //1
        198:trnsf_task(8'h4f,16'hffff);  //1
        199:deposit_task(16'h10);      //2
        200:trnsf_task(8'h50,16'hffff);  //1
        201:check_blc_task();          //3
        202:trnsf_task(8'h51,16'hffff);  //1
        203:change_pw_task(4'h0);      //4
        204:trnsf_task(8'h52,16'hffff);  //1
        205:exit_task;                 //5
        206:login_task(8'h15);
        207:passwd_task(`GET_PASSWD(`ID2ADDR(8'h15)));
        208:deposit_task(16'h10);      //2
        209:deposit_task(16'h10);      //2
        210:check_blc_task();          //3
        211:deposit_task(16'h10);      //2
        212:change_pw_task(4'h0);      //4
        213:deposit_task(16'h10);      //2
        214:exit_task;                 //5
        215:login_task(8'h38);
        216:passwd_task(`GET_PASSWD(`ID2ADDR(8'h38)));
        217:check_blc_task();          //3
        218:check_blc_task();          //3
        219:change_pw_task(4'h0);      //4
        220:check_blc_task();          //3
        221:exit_task;                 //5
        222:login_task(8'h53);
        223:passwd_task(`GET_PASSWD(`ID2ADDR(8'h53)));
        224:change_pw_task(4'h0);      //4
        225:change_pw_task(4'h0);      //4
        226:exit_task;                 //5
        //7
        227:login_task(8'h42);
        228:passwd_task(`GET_PASSWD(`ID2ADDR(8'h42)));
        229:trnsf_task(8'h54,16'hffff);  //1
        230:trnsf_task(8'h55,16'hffff);  //1
        231:deposit_task(16'h10);      //2
        232:trnsf_task(8'h57,16'hffff);  //1
        233:check_blc_task();          //3
        234:trnsf_task(8'h58,16'hffff);  //1
        235:change_pw_task(4'h0);      //4
        236:trnsf_task(8'h59,16'hffff);  //1
        237:exit_task;                 //5
        238:login_task(8'h1e);
        239:passwd_task(`GET_PASSWD(`ID2ADDR(8'h1e)));
        240:deposit_task(16'h10);      //2
        241:deposit_task(16'h10);      //2
        242:check_blc_task();          //3
        243:deposit_task(16'h10);      //2
        244:change_pw_task(4'h0);      //4
        245:deposit_task(16'h10);      //2
        246:exit_task;                 //5
        247:login_task(8'h46);
        248:passwd_task(`GET_PASSWD(`ID2ADDR(8'h46)));
        249:check_blc_task();          //3
        250:check_blc_task();          //3
        251:change_pw_task(4'h0);      //4
        252:check_blc_task();          //3
        253:exit_task;                 //5
        254:login_task(8'h5a);
        255:passwd_task(`GET_PASSWD(`ID2ADDR(8'h5a)));
        256:change_pw_task(4'h0);      //4
        257:change_pw_task(4'h0);      //4
        258:exit_task;                 //5
        //8
        259:login_task(8'h01);
        260:passwd_task(`GET_PASSWD(`ID2ADDR(8'h01)));
        261:trnsf_task(8'h5b,16'hffff);  //1
        262:trnsf_task(8'h5c,16'hffff);  //1
        263:deposit_task(16'h10);      //2
        264:trnsf_task(8'h5d,16'hffff);  //1
        265:check_blc_task();          //3
        266:trnsf_task(8'h5e,16'hffff);  //1
        267:change_pw_task(4'h0);      //4
        268:trnsf_task(8'h5f,16'hffff);  //1
        269:exit_task;                 //5
        270:login_task(8'h0c);
        271:passwd_task(`GET_PASSWD(`ID2ADDR(8'h0c)));
        272:deposit_task(16'h10);      //2
        273:deposit_task(16'h10);      //2
        274:check_blc_task();          //3
        275:deposit_task(16'h10);      //2
        276:change_pw_task(4'h0);      //4
        277:deposit_task(16'h10);      //2
        278:exit_task;                 //5
        279:login_task(8'h13);
        280:passwd_task(`GET_PASSWD(`ID2ADDR(8'h13)));
        281:check_blc_task();          //3
        282:check_blc_task();          //3
        283:change_pw_task(4'h0);      //4
        284:check_blc_task();          //3
        285:exit_task;                 //5
        286:login_task(8'h60);
        287:passwd_task(`GET_PASSWD(`ID2ADDR(8'h60)));
        288:change_pw_task(4'h0);      //4
        289:change_pw_task(4'h0);      //4
        290:exit_task;                 //5
        //9
        291:login_task(8'h27);
        292:passwd_task(`GET_PASSWD(`ID2ADDR(8'h27)));
        293:trnsf_task(8'h61,16'hffff);  //1
        294:trnsf_task(8'h62,16'hffff);  //1
        295:deposit_task(16'h10);      //2
        296:trnsf_task(8'h63,16'hffff);  //1
        297:check_blc_task();          //3
        298:trnsf_task(8'h64,16'hffff);  //1
        299:change_pw_task(4'h0);      //4
        300:trnsf_task(8'h65,16'hffff);  //1
        301:exit_task;                 //5
        302:login_task(8'h32);
        303:passwd_task(`GET_PASSWD(`ID2ADDR(8'h32)));
        304:deposit_task(16'h10);      //2
        305:deposit_task(16'h10);      //2
        306:check_blc_task();          //3
        307:deposit_task(16'h10);      //2
        308:change_pw_task(4'h0);      //4
        309:deposit_task(16'h10);      //2
        310:exit_task;                 //5
        311:login_task(8'h49);
        312:passwd_task(`GET_PASSWD(`ID2ADDR(8'h49)));
        313:check_blc_task();          //3
        314:check_blc_task();          //3
        315:change_pw_task(4'h0);      //4
        316:check_blc_task();          //3
        317:exit_task;                 //5
        318:login_task(8'h66);
        319:passwd_task(`GET_PASSWD(`ID2ADDR(8'h66)));
        320:change_pw_task(4'h0);      //4
        321:change_pw_task(4'h0);      //4
        322:exit_task;                 //5
        // fail blc 2 * 10
        323:login_task(8'h4c);
        324:passwd_task(`GET_PASSWD(`ID2ADDR(8'h4c)));
        325:trnsf_task(8'h67,16'hffff);  //1
        326:trnsf_task(8'hff,16'hffff);  //1
        327:trnsf_task(8'hfe,16'hffff);  //1
        328:trnsf_task(8'hfd,16'hffff);  //1
        329:trnsf_task(8'hfc,16'hffff);  //1
        330:trnsf_task(8'hfb,16'hffff);  //1
        331:trnsf_task(8'hfa,16'hffff);  //1
        332:trnsf_task(8'hf9,16'hffff);  //1
        333:trnsf_task(8'hf8,16'hffff);  //1
        334:trnsf_task(8'hf7,16'hffff);  //1
        335:exit_task;                 //5
        // fail blc 3 * 20
        336:login_task(8'h19);
        337:passwd_task(`GET_PASSWD(`ID2ADDR(8'h19)));
        338:trnsf_task(8'hf6,16'hffff);  //1
        339:trnsf_task(8'hf5,16'hffff);  //1
        340:trnsf_task(8'hf4,16'hffff);  //1
        341:trnsf_task(8'hf3,16'hffff);  //1
        342:trnsf_task(8'hf2,16'hffff);  //1
        343:trnsf_task(8'hf1,16'hffff);  //1
        344:trnsf_task(8'hf0,16'hffff);  //1
        345:trnsf_task(8'hef,16'hffff);  //1
        346:trnsf_task(8'hee,16'hffff);  //1
        347:trnsf_task(8'hed,16'hffff);  //1
        348:trnsf_task(8'hec,16'hffff);  //1
        349:trnsf_task(8'heb,16'hffff);  //1
        350:trnsf_task(8'hea,16'hffff);  //1
        351:trnsf_task(8'he9,16'hffff);  //1
        352:trnsf_task(8'he8,16'hffff);  //1
        353:trnsf_task(8'he7,16'hffff);  //1
        354:trnsf_task(8'he5,16'hffff);  //1
        355:trnsf_task(8'he4,16'hffff);  //1
        356:trnsf_task(8'he3,16'hffff);  //1
        357:trnsf_task(8'he2,16'hffff);  //1
        358:exit_task;                 //5
        // fail blc 4 * 20
        359:login_task(8'h1f);
        360:passwd_task(`GET_PASSWD(`ID2ADDR(8'h1f)));
        361:trnsf_task(8'he0,16'hffff);  //1
        362:trnsf_task(8'hde,16'hffff);  //1
        363:trnsf_task(8'hdd,16'hffff);  //1
        364:trnsf_task(8'hdc,16'hffff);  //1
        365:trnsf_task(8'hdb,16'hffff);  //1
        366:trnsf_task(8'hda,16'hffff);  //1
        367:trnsf_task(8'hd8,16'hffff);  //1
        368:trnsf_task(8'hd7,16'hffff);  //1
        369:trnsf_task(8'hd6,16'hffff);  //1
        370:trnsf_task(8'hd5,16'hffff);  //1
        371:trnsf_task(8'hd4,16'hffff);  //1
        372:trnsf_task(8'hd3,16'hffff);  //1
        373:trnsf_task(8'hd2,16'hffff);  //1
        374:trnsf_task(8'hd1,16'hffff);  //1
        375:trnsf_task(8'hd0,16'hffff);  //1
        376:trnsf_task(8'hcf,16'hffff);  //1
        377:trnsf_task(8'hce,16'hffff);  //1
        378:trnsf_task(8'hcd,16'hffff);  //1
        379:trnsf_task(8'hcc,16'hffff);  //1
        380:trnsf_task(8'hcb,16'hffff);  //1
        381:exit_task;                 //5
        // non exist account
        382:login_task(8'h07);
        383:login_task(8'h11);
        384:login_task(8'h16);
        385:login_task(8'h1a);
        386:login_task(8'h1d);
        387:login_task(8'h2c);
        388:login_task(8'h31);
        389:login_task(8'h33);
        390:login_task(8'h3a);
        391:login_task(8'h47);
        392:login_task(8'h56);
        393:login_task(8'h71);
        394:login_task(8'h81);
        395:login_task(8'h97);
        396:login_task(8'ha6);
        397:login_task(8'hb5);
        398:login_task(8'hbf);
        399:login_task(8'hd9);
        400:login_task(8'hdf);
        401:login_task(8'he1);
        402:login_task(8'he6);
        // fail login
        403:login_task(8'h68);
        405:login_task(8'h69);
        407:login_task(8'h6a);
        409:login_task(8'h6b);
        411:login_task(8'h6c);
        413:login_task(8'h6d);
        415:login_task(8'h6e);
        417:login_task(8'h6f);
        419:login_task(8'h70);
        421:login_task(8'h72);
        423:login_task(8'h73);
        425:login_task(8'h74);
        427:login_task(8'h75);
        429:login_task(8'h76);
        431:login_task(8'h77);
        433:login_task(8'h78);
        435:login_task(8'h79);
        437:login_task(8'h7a);
        439:login_task(8'h7b);
        441:login_task(8'h7c);
        443:login_task(8'h7d);
        445:login_task(8'h7e);
        447:login_task(8'h7f);
        449:login_task(8'h80);
        451:login_task(8'h82);
        453:login_task(8'h83);
        455:login_task(8'h84);
        457:login_task(8'h85);
        459:login_task(8'h86);
        461:login_task(8'h87);
        463:login_task(8'h88);
        465:login_task(8'h89);
        467:login_task(8'h8a);
        469:login_task(8'h8b);
        471:login_task(8'h8c);
        473:login_task(8'h8d);
        475:login_task(8'h8e);
        477:login_task(8'h8f);
        479:login_task(8'h90);
        481:login_task(8'h91);
        483:login_task(8'h92);
        485:login_task(8'h93);
        487:login_task(8'h94);
        489:login_task(8'h95);
        491:login_task(8'h96);
        493:login_task(8'h98);
        495:login_task(8'h99);
        497:login_task(8'h9a);
        499:login_task(8'h9b);
        501:login_task(8'h9c);
        503:login_task(8'h9d);
        505:login_task(8'h9e);
        507:login_task(8'h9f);
        509:login_task(8'ha0);
        511:login_task(8'ha1);
        513:login_task(8'ha2);
        515:login_task(8'ha3);
        517:login_task(8'ha4);
        519:login_task(8'ha5);
        521:login_task(8'ha7);
        523:login_task(8'ha8);
        525:login_task(8'ha9);
        527:login_task(8'haa);
        529:login_task(8'hab);
        531:login_task(8'hac);
        533:login_task(8'had);
        535:login_task(8'hae);
        537:login_task(8'haf);
        539:login_task(8'hb0);
        541:login_task(8'hb1);
        543:login_task(8'hac);
        545:login_task(8'had);
        547:login_task(8'hae);
        549:login_task(8'haf);
        551:login_task(8'hb0);
        553:login_task(8'hb1);
        555:login_task(8'hb2);
        557:login_task(8'hb3);
        559:login_task(8'hb4);
        561:login_task(8'hb6);
        563:login_task(8'hb7);
        565:login_task(8'hb8);
        567:login_task(8'hb9);
        569:login_task(8'hba);
        571:login_task(8'hbb);
        573:login_task(8'hbc);
        575:login_task(8'hbd);
        577:login_task(8'hbe);
        579:login_task(8'hc0);
        581:login_task(8'hc1);
        583:login_task(8'hc2);
        585:login_task(8'hc3);
        587:login_task(8'hc4);
        589:login_task(8'hc5);
        591:login_task(8'hc6);
        593:login_task(8'hc7);
        595:login_task(8'hc8);
        597:login_task(8'hc9);
        599:login_task(8'hca);
        //
        601:login_task(8'h67);
        /*
        601:login_task(8'hcb);
        603:login_task(8'hcc);
        605:login_task(8'hcd);
        607:login_task(8'hce);
        609:login_task(8'hcf);
        611:login_task(8'hd0);
        613:login_task(8'hd1);
        615:login_task(8'hd2);
        617:login_task(8'hd3);
        619:login_task(8'hd4);
        621:login_task(8'hd5);
        623:login_task(8'hd6);
        625:login_task(8'hd7);
        627:login_task(8'hd8);
        629:login_task(8'hda);
        631:login_task(8'hdb);
        633:login_task(8'hdc);
        635:login_task(8'hdd);
        637:login_task(8'hde);
        639:login_task(8'he0);
        641:login_task(8'he2);
        643:login_task(8'he3);
        645:login_task(8'he4);
        647:login_task(8'he5);
        649:login_task(8'he7);
        651:login_task(8'he8);
        653:login_task(8'he9);
        655:login_task(8'hea);
        657:login_task(8'heb);
        659:login_task(8'hec);
        661:login_task(8'hed);
        663:login_task(8'hee);
        665:login_task(8'hef);
        667:login_task(8'hf0);
        669:login_task(8'hf1);
        671:login_task(8'hf2);
        673:login_task(8'hf3);
        675:login_task(8'hf4);
        677:login_task(8'hf5);
        679:login_task(8'hf6);
        681:login_task(8'hf7);
        683:login_task(8'hf8);
        685:login_task(8'hf9);
        687:login_task(8'hfa);
        689:login_task(8'hfb);
        691:login_task(8'hfc);
        693:login_task(8'hfd);
        695:login_task(8'hfe);
        697:login_task(8'hff);
        699:login_task(8'h67);
        */

/*
        1:passwd_task(`GET_PASSWD(`ID2ADDR(8'h00)));
        2:change_pw_task(4'h0);
        3:check_blc_task();
        4:deposit_task(15'h10);
        5:trnsf_task(8'h01,15'h10);
        6:exit_task;
        7:login_task(8'h01);
        8:passwd_task(4'h0);
        9:login_task(8'h01);
        10:passwd_task(`GET_PASSWD(`ID2ADDR(8'h01)));
        11:check_blc_task();
        12:change_pw_task(4'h5);
        13:exit_task;
        14:login_task(8'h01);
        15:passwd_task(4'h5);
*/

        default: passwd_task(4'h0);
    endcase

end endtask

task wait_done; begin
    lat=-1;
    while(inf.out_valid!==1) begin
	lat=lat+1;
    if(lat==1200)begin//lat==max+1
    //if(lat==2000000)begin//lat==max+1
          $display("********************************************************");
          $display ("                           FAIL!                       ");
          $display("*  The execution latency are over 2000000 cycles  at %8t   *",$time);//over max
          $display("********************************************************");
	    repeat(2)@(negedge clk);
	    $finish;
      end
     @(negedge clk);
   end
end endtask

task check_ans; begin
    x=1;
    while(inf.out_valid)
    begin
        if(x>1) begin
            $display("********************************************************");
            $display ("                          FAIL!                        ");
            $display ("              Outvalid is more than 1 cycles           ");
            $display("********************************************************");
            repeat(9) @(negedge clk);
            $finish;
        end
        // check ans
        if((inf.complete!=cpe_ans)||(inf.err_msg!=msg_ans)||(inf.out_balance!=blc_ans)) begin
            $display("********************************************************");
            $display ("                          FAIL!                        ");
            $display ("                    Ans              Your              ");
            $display ("      complete      %h               %h                ",cpe_ans,inf.complete);
            $display ("      err_msg       %h               %h                ",msg_ans,inf.err_msg);
            $display ("      out_balance    %h               %h               ",blc_ans,inf.out_balance);
            $display("********************************************************");
            repeat(9) @(negedge clk);
            $finish;
        end

        @(negedge clk);
        x=x+1;
    end
    $display("\033[0;34mPASS PATTERN NO.%4d,\033[m \033[0;32mexecution cycle : %3d,\033[m \033[0;34m 0x%h \033[m",p ,lat,addr_start+(p<<2));
end endtask

task YOU_PASS_task; begin
    $display ("--------------------------------------------------------------------");
    $display ("                         Congratulations!                           ");
    $display ("                  You have passed all patterns                      ");
    $display ("--------------------------------------------------------------------");
    repeat(2)@(negedge clk);
    $finish;
end endtask









endprogram
