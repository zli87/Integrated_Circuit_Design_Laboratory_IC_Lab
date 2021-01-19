module CC(
    // input signals
    input clk,
    input rst_n,
    input in_valid_1,
    input in_valid_2,
    input [2:0] in_color,
    input in_stripe,
    input [1:0] in_action,
    input [5:0] in_starting_pos,
    // output signals
    output reg out_valid,
    output reg [6:0] out_score
);
//---------------------------------------------------------------------
//   COUNTER
//---------------------------------------------------------------------
reg [1:0] in_count ;
reg [2:0] irow_count;
reg [2:0] icol_count;
reg [3:0] act_count ;
reg [3:0] ans_idx;
//---------------------------------------------------------------------
//   FSM
//---------------------------------------------------------------------
parameter s_idle = 3'd0;
parameter s_check = 3'd1;
parameter s_action = 3'd2;
parameter s_find = 3'd3;
reg [1:0] state_current;
reg [1:0] state_next;
//---------------------------------------------------------------------
//   ACTION
//---------------------------------------------------------------------
parameter [1:0] act_up = 2'd0;
parameter [1:0] act_down = 2'd1;
parameter [1:0] act_left = 2'd2;
parameter [1:0] act_right = 2'd3;
reg [1:0] action [10-1:0];
reg [2:0] in_a_x [10-1:0];
reg [2:0] in_a_y [10-1:0];
reg [2:0] act_x_add1;
reg [2:0] act_x_minus1;
reg [2:0] act_y_add1;
reg [2:0] act_y_minus1;
reg [2:0] act_x;
reg [2:0] act_y;
//---------------------------------------------------------------------
//   COLOR
//---------------------------------------------------------------------
reg  [2:0] color [6-1:0][6-1:0]; // element color [2:0] 2d array color[row][col], down = row+1 , right = col+1
wire [2:0] cc [6-1:0][6-1:0];
//---------------------------------------------------------------------
//   STRIPE
//---------------------------------------------------------------------
reg [2:0] in_s_x [3:0];
reg [2:0] in_s_y [3:0];
reg [3:0] stripe;
//---------------------------------------------------------------------
//   CLEAN FLAG
//---------------------------------------------------------------------
wire flag[48-1:0]; // for 3 clean
wire [6-1:0] FLAG [6-1:0]; // 6*6 flag after 3 clean
wire [6-1:0] flag_x; // flag for row x's col clean
wire [6-1:0] flag_y; // flag for col y's row clean
reg [6-1:0] fflag [6-1:0];
reg flag_strike0;
reg flag_strike1;
reg flag_strike2;
reg flag_strike3;
//---------------------------------------------------------------------
//   ELSE
//---------------------------------------------------------------------
reg [6:0] fscore;
integer i,j;
wire [2:0] x;
wire [2:0] y;

// row check
CHECK_3_COLOR check00(.color0(color[0][0]),.color1(color[0][1]),.color2(color[0][2]),.out_score(flag[0]));
CHECK_3_COLOR check01(.color0(color[0][1]),.color1(color[0][2]),.color2(color[0][3]),.out_score(flag[1]));
CHECK_3_COLOR check02(.color0(color[0][2]),.color1(color[0][3]),.color2(color[0][4]),.out_score(flag[2]));
CHECK_3_COLOR check03(.color0(color[0][3]),.color1(color[0][4]),.color2(color[0][5]),.out_score(flag[3]));
CHECK_3_COLOR check04(.color0(color[1][0]),.color1(color[1][1]),.color2(color[1][2]),.out_score(flag[4]));
CHECK_3_COLOR check05(.color0(color[1][1]),.color1(color[1][2]),.color2(color[1][3]),.out_score(flag[5]));
CHECK_3_COLOR check06(.color0(color[1][2]),.color1(color[1][3]),.color2(color[1][4]),.out_score(flag[6]));
CHECK_3_COLOR check07(.color0(color[1][3]),.color1(color[1][4]),.color2(color[1][5]),.out_score(flag[7]));
CHECK_3_COLOR check08(.color0(color[2][0]),.color1(color[2][1]),.color2(color[2][2]),.out_score(flag[8]));
CHECK_3_COLOR check09(.color0(color[2][1]),.color1(color[2][2]),.color2(color[2][3]),.out_score(flag[9]));
CHECK_3_COLOR check10(.color0(color[2][2]),.color1(color[2][3]),.color2(color[2][4]),.out_score(flag[10]));
CHECK_3_COLOR check11(.color0(color[2][3]),.color1(color[2][4]),.color2(color[2][5]),.out_score(flag[11]));
CHECK_3_COLOR check12(.color0(color[3][0]),.color1(color[3][1]),.color2(color[3][2]),.out_score(flag[12]));
CHECK_3_COLOR check13(.color0(color[3][1]),.color1(color[3][2]),.color2(color[3][3]),.out_score(flag[13]));
CHECK_3_COLOR check14(.color0(color[3][2]),.color1(color[3][3]),.color2(color[3][4]),.out_score(flag[14]));
CHECK_3_COLOR check15(.color0(color[3][3]),.color1(color[3][4]),.color2(color[3][5]),.out_score(flag[15]));
CHECK_3_COLOR check16(.color0(color[4][0]),.color1(color[4][1]),.color2(color[4][2]),.out_score(flag[16]));
CHECK_3_COLOR check17(.color0(color[4][1]),.color1(color[4][2]),.color2(color[4][3]),.out_score(flag[17]));
CHECK_3_COLOR check18(.color0(color[4][2]),.color1(color[4][3]),.color2(color[4][4]),.out_score(flag[18]));
CHECK_3_COLOR check19(.color0(color[4][3]),.color1(color[4][4]),.color2(color[4][5]),.out_score(flag[19]));
CHECK_3_COLOR check20(.color0(color[5][0]),.color1(color[5][1]),.color2(color[5][2]),.out_score(flag[20]));
CHECK_3_COLOR check21(.color0(color[5][1]),.color1(color[5][2]),.color2(color[5][3]),.out_score(flag[21]));
CHECK_3_COLOR check22(.color0(color[5][2]),.color1(color[5][3]),.color2(color[5][4]),.out_score(flag[22]));
CHECK_3_COLOR check23(.color0(color[5][3]),.color1(color[5][4]),.color2(color[5][5]),.out_score(flag[23]));
// col check
CHECK_3_COLOR check24(.color0(color[0][0]),.color1(color[1][0]),.color2(color[2][0]),.out_score(flag[24]));
CHECK_3_COLOR check25(.color0(color[1][0]),.color1(color[2][0]),.color2(color[3][0]),.out_score(flag[25]));
CHECK_3_COLOR check26(.color0(color[2][0]),.color1(color[3][0]),.color2(color[4][0]),.out_score(flag[26]));
CHECK_3_COLOR check27(.color0(color[3][0]),.color1(color[4][0]),.color2(color[5][0]),.out_score(flag[27]));
CHECK_3_COLOR check28(.color0(color[0][1]),.color1(color[1][1]),.color2(color[2][1]),.out_score(flag[28]));
CHECK_3_COLOR check29(.color0(color[1][1]),.color1(color[2][1]),.color2(color[3][1]),.out_score(flag[29]));
CHECK_3_COLOR check30(.color0(color[2][1]),.color1(color[3][1]),.color2(color[4][1]),.out_score(flag[30]));
CHECK_3_COLOR check31(.color0(color[3][1]),.color1(color[4][1]),.color2(color[5][1]),.out_score(flag[31]));
CHECK_3_COLOR check32(.color0(color[0][2]),.color1(color[1][2]),.color2(color[2][2]),.out_score(flag[32]));
CHECK_3_COLOR check33(.color0(color[1][2]),.color1(color[2][2]),.color2(color[3][2]),.out_score(flag[33]));
CHECK_3_COLOR check34(.color0(color[2][2]),.color1(color[3][2]),.color2(color[4][2]),.out_score(flag[34]));
CHECK_3_COLOR check35(.color0(color[3][2]),.color1(color[4][2]),.color2(color[5][2]),.out_score(flag[35]));
CHECK_3_COLOR check36(.color0(color[0][3]),.color1(color[1][3]),.color2(color[2][3]),.out_score(flag[36]));
CHECK_3_COLOR check37(.color0(color[1][3]),.color1(color[2][3]),.color2(color[3][3]),.out_score(flag[37]));
CHECK_3_COLOR check38(.color0(color[2][3]),.color1(color[3][3]),.color2(color[4][3]),.out_score(flag[38]));
CHECK_3_COLOR check39(.color0(color[3][3]),.color1(color[4][3]),.color2(color[5][3]),.out_score(flag[39]));
CHECK_3_COLOR check40(.color0(color[0][4]),.color1(color[1][4]),.color2(color[2][4]),.out_score(flag[40]));
CHECK_3_COLOR check41(.color0(color[1][4]),.color1(color[2][4]),.color2(color[3][4]),.out_score(flag[41]));
CHECK_3_COLOR check42(.color0(color[2][4]),.color1(color[3][4]),.color2(color[4][4]),.out_score(flag[42]));
CHECK_3_COLOR check43(.color0(color[3][4]),.color1(color[4][4]),.color2(color[5][4]),.out_score(flag[43]));
CHECK_3_COLOR check44(.color0(color[0][5]),.color1(color[1][5]),.color2(color[2][5]),.out_score(flag[44]));
CHECK_3_COLOR check45(.color0(color[1][5]),.color1(color[2][5]),.color2(color[3][5]),.out_score(flag[45]));
CHECK_3_COLOR check46(.color0(color[2][5]),.color1(color[3][5]),.color2(color[4][5]),.out_score(flag[46]));
CHECK_3_COLOR check47(.color0(color[3][5]),.color1(color[4][5]),.color2(color[5][5]),.out_score(flag[47]));

assign FLAG[0][0] = (flag[24]|flag[0]);
assign FLAG[0][1] = (flag[28]|flag[0]|flag[1]);
assign FLAG[0][2] = (flag[32]|flag[0]|flag[1]|flag[2]);
assign FLAG[0][3] = (flag[36]|flag[1]|flag[2]|flag[3]);
assign FLAG[0][4] = (flag[40]|flag[2]|flag[3]);
assign FLAG[0][5] = (flag[44]|flag[3]);
assign FLAG[1][0] = (flag[24]|flag[25]|flag[4]);
assign FLAG[1][1] = (flag[28]|flag[29]|flag[4]|flag[5]);
assign FLAG[1][2] = (flag[32]|flag[33]|flag[4]|flag[5]|flag[6]);
assign FLAG[1][3] = (flag[36]|flag[37]|flag[5]|flag[6]|flag[7]);
assign FLAG[1][4] = (flag[40]|flag[41]|flag[6]|flag[7]);
assign FLAG[1][5] = (flag[44]|flag[45]|flag[7]);
assign FLAG[2][0] = (flag[24]|flag[25]|flag[26]|flag[8]);
assign FLAG[2][1] = (flag[28]|flag[29]|flag[30]|flag[8]|flag[9]);
assign FLAG[2][2] = (flag[32]|flag[33]|flag[34]|flag[8]|flag[9]|flag[10]);
assign FLAG[2][3] = (flag[36]|flag[37]|flag[38]|flag[9]|flag[10]|flag[11]);
assign FLAG[2][4] = (flag[40]|flag[41]|flag[42]|flag[10]|flag[11]);
assign FLAG[2][5] = (flag[44]|flag[45]|flag[46]|flag[11]);
assign FLAG[3][0] = (flag[25]|flag[26]|flag[27]|flag[12]);
assign FLAG[3][1] = (flag[29]|flag[30]|flag[31]|flag[12]|flag[13]);
assign FLAG[3][2] = (flag[33]|flag[34]|flag[35]|flag[12]|flag[13]|flag[14]);
assign FLAG[3][3] = (flag[37]|flag[38]|flag[39]|flag[13]|flag[14]|flag[15]);
assign FLAG[3][4] = (flag[41]|flag[42]|flag[43]|flag[14]|flag[15]);
assign FLAG[3][5] = (flag[45]|flag[46]|flag[47]|flag[15]);
assign FLAG[4][0] = (flag[26]|flag[27]|flag[16]);
assign FLAG[4][1] = (flag[30]|flag[31]|flag[16]|flag[17]);
assign FLAG[4][2] = (flag[34]|flag[35]|flag[16]|flag[17]|flag[18]);
assign FLAG[4][3] = (flag[38]|flag[39]|flag[17]|flag[18]|flag[19]);
assign FLAG[4][4] = (flag[42]|flag[43]|flag[18]|flag[19]);
assign FLAG[4][5] = (flag[46]|flag[47]|flag[19]);
assign FLAG[5][0] = (flag[27]|flag[20]);
assign FLAG[5][1] = (flag[31]|flag[20]|flag[21]);
assign FLAG[5][2] = (flag[35]|flag[20]|flag[21]|flag[22]);
assign FLAG[5][3] = (flag[39]|flag[21]|flag[22]|flag[23]);
assign FLAG[5][4] = (flag[43]|flag[22]|flag[23]);
assign FLAG[5][5] = (flag[47]|flag[23]);

assign cc[0][0] = (FLAG[0][0])? 3'd7:color[0][0];
assign cc[0][1] = (FLAG[0][1])? 3'd7:color[0][1];
assign cc[0][2] = (FLAG[0][2])? 3'd7:color[0][2];
assign cc[0][3] = (FLAG[0][3])? 3'd7:color[0][3];
assign cc[0][4] = (FLAG[0][4])? 3'd7:color[0][4];
assign cc[0][5] = (FLAG[0][5])? 3'd7:color[0][5];
assign cc[1][0] = (FLAG[1][0])? 3'd7:color[1][0];
assign cc[1][1] = (FLAG[1][1])? 3'd7:color[1][1];
assign cc[1][2] = (FLAG[1][2])? 3'd7:color[1][2];
assign cc[1][3] = (FLAG[1][3])? 3'd7:color[1][3];
assign cc[1][4] = (FLAG[1][4])? 3'd7:color[1][4];
assign cc[1][5] = (FLAG[1][5])? 3'd7:color[1][5];
assign cc[2][0] = (FLAG[2][0])? 3'd7:color[2][0];
assign cc[2][1] = (FLAG[2][1])? 3'd7:color[2][1];
assign cc[2][2] = (FLAG[2][2])? 3'd7:color[2][2];
assign cc[2][3] = (FLAG[2][3])? 3'd7:color[2][3];
assign cc[2][4] = (FLAG[2][4])? 3'd7:color[2][4];
assign cc[2][5] = (FLAG[2][5])? 3'd7:color[2][5];
assign cc[3][0] = (FLAG[3][0])? 3'd7:color[3][0];
assign cc[3][1] = (FLAG[3][1])? 3'd7:color[3][1];
assign cc[3][2] = (FLAG[3][2])? 3'd7:color[3][2];
assign cc[3][3] = (FLAG[3][3])? 3'd7:color[3][3];
assign cc[3][4] = (FLAG[3][4])? 3'd7:color[3][4];
assign cc[3][5] = (FLAG[3][5])? 3'd7:color[3][5];
assign cc[4][0] = (FLAG[4][0])? 3'd7:color[4][0];
assign cc[4][1] = (FLAG[4][1])? 3'd7:color[4][1];
assign cc[4][2] = (FLAG[4][2])? 3'd7:color[4][2];
assign cc[4][3] = (FLAG[4][3])? 3'd7:color[4][3];
assign cc[4][4] = (FLAG[4][4])? 3'd7:color[4][4];
assign cc[4][5] = (FLAG[4][5])? 3'd7:color[4][5];
assign cc[5][0] = (FLAG[5][0])? 3'd7:color[5][0];
assign cc[5][1] = (FLAG[5][1])? 3'd7:color[5][1];
assign cc[5][2] = (FLAG[5][2])? 3'd7:color[5][2];
assign cc[5][3] = (FLAG[5][3])? 3'd7:color[5][3];
assign cc[5][4] = (FLAG[5][4])? 3'd7:color[5][4];
assign cc[5][5] = (FLAG[5][5])? 3'd7:color[5][5];

always @ ( * ) begin
    for(i=0;i<6;i=i+1)
        for(j=0;j<6;j=j+1) begin
            if((i==in_s_x[0])&&(stripe[0]==0)&&flag_strike0)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else if((j==in_s_y[0])&&(stripe[0]==1)&&flag_strike0)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else if((i==in_s_x[1])&&(stripe[1]==0)&&flag_strike1)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else if((j==in_s_y[1])&&(stripe[1]==1)&&flag_strike1)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else if((i==in_s_x[2])&&(stripe[2]==0)&&flag_strike2)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else if((j==in_s_y[2])&&(stripe[2]==1)&&flag_strike2)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else if((i==in_s_x[3])&&(stripe[3]==0)&&flag_strike3)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else if((j==in_s_y[3])&&(stripe[3]==1)&&flag_strike3)
                fflag[i][j] <= (cc[i][j]!=7)? 1 : 0;
            else fflag[i][j] <= 0;
        end
end
always @ ( * ) begin
    flag_strike0 = FLAG[in_s_x[0]][in_s_y[0]];
    flag_strike1 = FLAG[in_s_x[1]][in_s_y[1]];
    flag_strike2 = FLAG[in_s_x[2]][in_s_y[2]];
    flag_strike3 = FLAG[in_s_x[3]][in_s_y[3]];
end
// ******************************************************
// *                SCORE                               *
// ******************************************************
always @ ( negedge rst_n or posedge clk ) begin
    if(!rst_n) fscore = 0;
    else if(state_current==s_check) begin
        for(i=0;i<48;i=i+1)
            fscore = fscore + flag[i];
        for(i=0;i<6;i=i+1)
            for(j=0;j<6;j=j+1)
                fscore = fscore + fflag[i][j];
    end else if(in_count==1'd1) fscore = 0;
end

// ******************************************************
// *                input counter                       *
// ******************************************************
always @ ( posedge clk or negedge rst_n ) begin
    if (!rst_n) begin in_count<=0; irow_count <= 0; icol_count <= 0;
    end else if (in_valid_1==1'b1) begin
        //in_count <= in_count + 1 ;
        if(icol_count==5) icol_count <= 0;
        else icol_count <= icol_count + 1;
        if(icol_count==5) irow_count <= irow_count + 1;
        if((irow_count==5)&&(icol_count==5)) begin irow_count<=0; in_count <= 1; end
    end else begin
        if(in_count!=0) in_count <= in_count +1;
    end
end
always @ (posedge clk or negedge rst_n ) begin
    if(!rst_n) act_count<= 0;
    else if(in_valid_2) act_count <= act_count + 1;
    else act_count <=0;
end
// ******************************************************
// *                read action & pos                   *
// ******************************************************
assign {x,y} = in_starting_pos;
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    end else if(in_valid_2==1'b1) begin
        action[act_count] <= in_action;
        in_a_x[act_count] <= in_starting_pos[5:3];
        in_a_y[act_count] <= in_starting_pos[2:0];
    end
end
// ******************************************************
// *                read stripe & pos                   *
// ******************************************************
always @ ( posedge clk or negedge rst_n ) begin
    if(!rst_n) begin
    end else if((in_valid_1==1'b1)&&(irow_count==0)&&(icol_count<'d4)) begin
        in_s_x[icol_count] <= in_starting_pos[5:3];
        in_s_y[icol_count] <= in_starting_pos[2:0];
        stripe[icol_count] <= in_stripe;
    end else if(state_current==s_action) begin
        if (action[ans_idx]==act_up) begin
                 if({act_x,act_y}=={in_s_x[0],in_s_y[0]}) in_s_x[0]<= act_x_minus1;
            else if({act_x,act_y}=={in_s_x[1],in_s_y[1]}) in_s_x[1]<= act_x_minus1;
            else if({act_x,act_y}=={in_s_x[2],in_s_y[2]}) in_s_x[2]<= act_x_minus1;
            else if({act_x,act_y}=={in_s_x[3],in_s_y[3]}) in_s_x[3]<= act_x_minus1;
                 if({act_x_minus1,act_y}=={in_s_x[0],in_s_y[0]}) in_s_x[0]<= act_x;
            else if({act_x_minus1,act_y}=={in_s_x[1],in_s_y[1]}) in_s_x[1]<= act_x;
            else if({act_x_minus1,act_y}=={in_s_x[2],in_s_y[2]}) in_s_x[2]<= act_x;
            else if({act_x_minus1,act_y}=={in_s_x[3],in_s_y[3]}) in_s_x[3]<= act_x;

        end else if (action[ans_idx]==act_down) begin
                 if({act_x,act_y}=={in_s_x[0],in_s_y[0]}) in_s_x[0]<= act_x_add1;
            else if({act_x,act_y}=={in_s_x[1],in_s_y[1]}) in_s_x[1]<= act_x_add1;
            else if({act_x,act_y}=={in_s_x[2],in_s_y[2]}) in_s_x[2]<= act_x_add1;
            else if({act_x,act_y}=={in_s_x[3],in_s_y[3]}) in_s_x[3]<= act_x_add1;
                 if({act_x_add1,act_y}=={in_s_x[0],in_s_y[0]}) in_s_x[0]<= act_x;
            else if({act_x_add1,act_y}=={in_s_x[1],in_s_y[1]}) in_s_x[1]<= act_x;
            else if({act_x_add1,act_y}=={in_s_x[2],in_s_y[2]}) in_s_x[2]<= act_x;
            else if({act_x_add1,act_y}=={in_s_x[3],in_s_y[3]}) in_s_x[3]<= act_x;

        end else if (action[ans_idx]==act_left) begin
                 if({act_x,act_y}=={in_s_x[0],in_s_y[0]}) in_s_y[0]<= act_y_minus1;
            else if({act_x,act_y}=={in_s_x[1],in_s_y[1]}) in_s_y[1]<= act_y_minus1;
            else if({act_x,act_y}=={in_s_x[2],in_s_y[2]}) in_s_y[2]<= act_y_minus1;
            else if({act_x,act_y}=={in_s_x[3],in_s_y[3]}) in_s_y[3]<= act_y_minus1;
                 if({act_x,act_y_minus1}=={in_s_x[0],in_s_y[0]}) in_s_y[0]<= act_y;
            else if({act_x,act_y_minus1}=={in_s_x[1],in_s_y[1]}) in_s_y[1]<= act_y;
            else if({act_x,act_y_minus1}=={in_s_x[2],in_s_y[2]}) in_s_y[2]<= act_y;
            else if({act_x,act_y_minus1}=={in_s_x[3],in_s_y[3]}) in_s_y[3]<= act_y;

        end else if (action[ans_idx]==act_right) begin
                 if({act_x,act_y}=={in_s_x[0],in_s_y[0]}) in_s_y[0]<= act_y_add1;
            else if({act_x,act_y}=={in_s_x[1],in_s_y[1]}) in_s_y[1]<= act_y_add1;
            else if({act_x,act_y}=={in_s_x[2],in_s_y[2]}) in_s_y[2]<= act_y_add1;
            else if({act_x,act_y}=={in_s_x[3],in_s_y[3]}) in_s_y[3]<= act_y_add1;
                 if({act_x,act_y_add1}=={in_s_x[0],in_s_y[0]}) in_s_y[0]<= act_y;
            else if({act_x,act_y_add1}=={in_s_x[1],in_s_y[1]}) in_s_y[1]<= act_y;
            else if({act_x,act_y_add1}=={in_s_x[2],in_s_y[2]}) in_s_y[2]<= act_y;
            else if({act_x,act_y_add1}=={in_s_x[3],in_s_y[3]}) in_s_y[3]<= act_y;

        end
    end
end
// ******************************************************
// *                read & clean map                    *
// ******************************************************
always @ ( posedge clk or negedge rst_n ) begin
    if(!rst_n) begin
        //color[8]<=8'd0;
    end else if(in_valid_1==1'b1)begin
        //color[8] <= 8'd0;
        color[irow_count][icol_count] <= in_color;
    end else if(state_current==s_check) begin
        for(i=0;i<6;i=i+1)
            for(j=0;j<6;j=j+1)
                color[i][j] <= (FLAG[i][j]|fflag[i][j])? 3'd7:color[i][j];
    end else if(state_current==s_action) begin
        if (action[ans_idx]==act_up) begin
            color[act_x_minus1][act_y] <= color[act_x][act_y];
            color[act_x][act_y] <= color[act_x_minus1][act_y];
            //if((color[act_x_minus1][act_y]==3'd7)||(color[act_x][act_y]==3'd7)) $display("[Error] move empty candy!");
        end else if (action[ans_idx]==act_down) begin
            color[act_x_add1][act_y] <= color[act_x][act_y];
            color[act_x][act_y] <= color[act_x_add1][act_y];
            //if((color[act_x_add1][act_y]==3'd7)||(color[act_x][act_y]==3'd7)) $display("[Error] move empty candy!");
        end else if (action[ans_idx]==act_left) begin
            color[act_x][act_y_minus1] <= color[act_x][act_y];
            color[act_x][act_y] <= color[act_x][act_y_minus1];
            //if((color[act_x][act_y_minus1]==3'd7)||(color[act_x][act_y]==3'd7)) $display("[Error] move empty candy!");
        end else if (action[ans_idx]==act_right) begin
            color[act_x][act_y_add1] <= color[act_x][act_y];
            color[act_x][act_y] <= color[act_x][act_y_add1];
            //if((color[act_x][act_y_add1]==3'd7)||(color[act_x][act_y]==3'd7)) $display("[Error] move empty candy!");
        end
    end
end
always @ ( * ) begin
    act_x_add1 <= in_a_x[ans_idx]+1;
    act_x_minus1 <=  in_a_x[ans_idx]-1;
    act_y_add1 <= in_a_y[ans_idx]+1;
    act_y_minus1 <=  in_a_y[ans_idx]-1;
    act_x <= in_a_x[ans_idx];
    act_y <= in_a_y[ans_idx];
end
// ******************************************************
// *                PRINT                               *
// ******************************************************
/*always @ (negedge clk) begin
    if(in_valid_2==1 || ans_idx!=0) begin

        for(i=0;i<6;i=i+1)
            $display(" %d %d %d %d %d %d  %d %d %d %d %d %d  %d %d %d %d %d %d",
                            color[i][0],color[i][1],color[i][2],color[i][3],color[i][4],color[i][5],
                            FLAG[i][0],FLAG[i][1],FLAG[i][2],FLAG[i][3],FLAG[i][4],FLAG[i][5],
                            fflag[i][0],fflag[i][1],fflag[i][2],fflag[i][3],fflag[i][4],fflag[i][5]
                    );
        case(state_current)
            s_idle : $display("idle ans_id =%d score = %d",ans_idx,fscore);
            s_check : $display("check ans_id =%d score = %d",ans_idx,fscore);
            s_action : $display("action ans_id =%d score = %d",ans_idx,fscore);
            default :;
        endcase
    end
end*/
// ******************************************************
// *                FSM STATE                           *
// ******************************************************
always @(posedge clk or negedge rst_n ) begin
    if(!rst_n) state_current <= s_idle;
    else state_current <= state_next;
end
// ******************************************************
// *                    FSM                             *
// ******************************************************
always @ ( * ) begin
    if(!rst_n) state_next = 0;
    else
    case (state_current)
/*0*/        s_idle:
                    if(in_count=='d2) state_next = s_check;
                    else state_next = s_idle;
/*1*/        s_check: if(ans_idx==4'd10) state_next = s_find; else state_next = s_action;
/*2*/        s_action: state_next = s_check;
/*3*/        s_find: state_next = s_idle;
        default: state_next = state_current;
    endcase
end
// ******************************************************
// *                    ans_idx                         *
// ******************************************************
always @ ( posedge clk or negedge rst_n ) begin
    if(!rst_n) ans_idx <=0;
    else
    case(state_current)
        s_idle: ans_idx <=0;
        s_action:  ans_idx <= ans_idx + 1;
        s_find: ans_idx<=0;
        default:ans_idx<=ans_idx;
    endcase
end
// ******************************************************
// *                    out_valid                       *
// ******************************************************
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin out_valid <= 0; out_score <= 0;
    end else if(state_current==s_find) begin
        out_score <= fscore;//7'd4;
        out_valid <=1;
    end else begin
        out_score <= 0;
        out_valid <= 0;
    end
end

endmodule

module CHECK_3_COLOR(
        input [2:0] color0,
        input [2:0] color1,
        input [2:0] color2,
        output out_score
);
assign out_score = ((color0==color1)&&(color1==color2))?(color0!=3'd7)?1:0:0;
endmodule
