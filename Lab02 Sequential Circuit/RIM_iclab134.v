module RIM(
    //Input Port
    input clk,
    input rst_n,
	input in_valid,
    input  [7:0] maze,

    //Output Port
    output reg out_valid,
    output reg [2:0] out_row,
    output reg [2:0] out_col
    );

//---------------------------------------------------------------------
//   PORT DECLARATION
//---------------------------------------------------------------------
parameter N = 8;

reg [2:0] in_count ;
reg  clean_count ;
reg  [N-1:0] mm [N-1:0]; // mm[row][col], down = row+1 , right = col+1
//wire [N-1:0] WW [N-1:0];
wire flag;

reg [3:0] ans_idx;
wire [3:0] col_right;
wire [3:0] row_down;

parameter s_idle = 3'd0;
parameter s_check = 3'd1;
parameter s_find = 3'd2;
reg [1:0] state_current;
reg [1:0] state_next;

// ******************************************************
// *             read count & clean_count               *
// ******************************************************
always @ ( posedge clk or negedge rst_n ) begin
    if (!rst_n) begin in_count<=0; clean_count<=0;
    end else if (in_valid==1'b1) begin
        in_count <= in_count + 1 ;
        if(in_count==3'd7)
            clean_count <= 1;
        else clean_count<=0;
    end
end
// ******************************************************
// *                read & clean maze                   *
// ******************************************************
always @ ( posedge clk or negedge rst_n ) begin
    if(!rst_n) begin
        //mm[8]<=8'd0;
    end else if(in_valid==1'b1)begin
        //mm[8] <= 8'd0;
        mm[in_count] <= maze;
    end else if(clean_count!=0) begin
        mm[0][6:0] <= mm[0][6:0]&(mm[1][6:0]|mm[0][7:1]);
        mm[1][6:0] <= mm[1][6:0]&(mm[2][6:0]|mm[1][7:1]);
        mm[2][6:0] <= mm[2][6:0]&(mm[3][6:0]|mm[2][7:1]);
        mm[3][6:0] <= mm[3][6:0]&(mm[4][6:0]|mm[3][7:1]);
        mm[4][6:0] <= mm[4][6:0]&(mm[5][6:0]|mm[4][7:1]);
        mm[5][6:0] <= mm[5][6:0]&(mm[6][6:0]|mm[5][7:1]);
        mm[6][6:0] <= mm[6][6:0]&(mm[7][6:0]|mm[6][7:1]);
        mm[7][6:0] <= mm[7][6:0]&(      mm[7][7:1]);
        mm[8] <= 8'd0;
    end
end
// ******************************************************
// *            flag finish clean maze                  *
// ******************************************************
assign flag = ( (0==( mm[0][6:0]&( ~(mm[1][6:0]|mm[0][7:1]) )) )&&
              (0==( mm[1][6:0]&( ~(mm[2][6:0]|mm[1][7:1]) )) )&&
              (0==( mm[2][6:0]&( ~(mm[3][6:0]|mm[2][7:1]) )) )&&
              (0==( mm[3][6:0]&( ~(mm[4][6:0]|mm[3][7:1]) )) )&&
              (0==( mm[4][6:0]&( ~(mm[5][6:0]|mm[4][7:1]) )) )&&
              (0==( mm[5][6:0]&( ~(mm[6][6:0]|mm[5][7:1]) )) )&&
              (0==( mm[6][6:0]&( ~(mm[7][6:0]|mm[6][7:1]) )) )&&
              (0==( mm[7][6:0]&(      ~(mm[7][7:1]) )) )&&
              (clean_count!=0) )? 1 : 0;

// ******************************************************
// *                state_current                       *
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
/*0*/        s_idle://if(in_valid) state_next = s_start;
                    if(flag==1'b1) state_next = s_check;
                    else state_next = s_idle;
/*1*/        s_check: if(ans_idx==4'd13) state_next = s_find; else state_next = s_check;
/*4*/        s_find:if(in_valid) state_next = s_idle;
                    else state_next = s_find;
        default: state_next = state_current;
    endcase
end
// ******************************************************
// *            col_right,  row_down                    *
// ******************************************************
assign col_right = out_col+1;
assign row_down = out_row+1;

always @ ( posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_col<=0;
        out_row<=0;
    end
    else
    case (state_current)
        s_idle: begin   out_col<=0;
                        out_row<=0;
                end
        s_check:if ((mm[row_down][out_col]==1'b1) &&(out_row!=4'd7)) begin
                    out_row<=row_down;
                end else  if (mm[out_row][col_right]==1'b1) begin
                    out_col<=col_right;
                end
        default: ;
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
        s_check:  ans_idx <= ans_idx + 1;
        default:ans_idx<=ans_idx;
    endcase

end
// ******************************************************
// *                    out_valid                       *
// ******************************************************
always @ ( posedge clk or negedge rst_n ) begin
    if (!rst_n) out_valid <= 0;
    else if((state_current==s_check)||(state_next==s_check)) out_valid <= 1;
    else out_valid <= 0;
end

endmodule
