
module MC(
	//io
	clk,
	rst_n,
	in_valid,
	in_data,
	size,
	action,
	out_valid,
	out_data
);
//io
input	clk;
input	rst_n;
input	in_valid;
input	[31:0]in_data;
input	[1:0]size;
input	[2:0]action;
output	reg out_valid;
output	reg[31:0]out_data;

reg in_valid2;
reg [3:0] act;
reg [2:0] ss;
reg [31:0] in_data_delay [1:0];
reg [31:0] add_result;
reg [31:0] mult_col [31:0];
reg [31:0] mult_add;

reg [4:0] state;
reg [4:0] state_next;
parameter state_idle = 4'd0;
parameter state_input = 4'd1;
parameter state_output = 4'd15;
parameter state_cleanMA = 4'd2;
parameter state_mirror = 4'd3;
parameter state_transpose = 4'd4;
parameter state_rotate = 4'd5;
parameter state_result = 4'd14;
parameter state_add = 4'd6;
parameter state_input_C = 4'd7;
parameter state_mult_add = 4'd8;
parameter state_mult2reg = 4'd9;
parameter state_trace = 4'd10;
parameter state_trace_out = 4'd11;

parameter act_setup = 3'b100;
parameter act_trace = 3'b000;
parameter act_mirror = 3'b001;
parameter act_transpose = 3'b010;
parameter act_rotate = 3'b011;
parameter act_addition = 3'b101;
parameter act_multiplication = 3'b110;

parameter size_4 = 2'b00;
parameter size_8 = 2'b01;
parameter size_16 = 2'b10;
parameter size_32 = 2'b11;

reg [2:0] stop_counter;
reg [1:0] mult_wait;
reg [2:0] LEN_bit;
reg [5:0] LEN; // 4,8,16,32
wire [9:0] LEN_sq;
reg [9:0] M_A;
reg [9:0] M_A_delay;
reg [31:0] M_D;
reg [31:0] M_Q;
reg M_WEM;

reg [31:0] C_A_delay;
reg [9:0] C_col_mirror;
reg [9:0] C_A;
reg [31:0] C_D;
reg [31:0] C_Q;
reg C_WEM;

reg [5:0] C_row;
reg [5:0] C_col;
reg [6:0] K_K;
reg [5:0] C_row_delay [2:0];
reg [5:0] C_col_delay [2:0];

wire [9:0] M_A_i;
wire [31:0] M_D_i;
wire [31:0] M_Q_o;
wire M_WEN_i;
reg [5:0] M_row;
reg [5:0] M_col;

wire [9:0] C_A_i;
wire [31:0] C_D_i;
wire [31:0] C_Q_o;
wire C_WEN_i;

wire CEN;
wire OEN;

assign CEN = 0;
assign OEN = 0;
assign M_A_i = M_A;
assign M_D_i = M_D;
assign C_A_i = C_A;
assign C_D_i = C_D;
assign M_WEN_i = M_WEM;
assign C_WEN_i = C_WEM;


RA1SH mem_M( .Q(M_Q_o), .CLK(clk), .CEN(CEN), .WEN(M_WEN_i), .A(M_A_i), .D(M_D_i), .OEN(OEN) );
RA1SH mem_C( .Q(C_Q_o), .CLK(clk), .CEN(CEN), .WEN(C_WEN_i), .A(C_A_i), .D(C_D_i), .OEN(OEN) );

assign LEN_sq = LEN*LEN-1;

always @ (posedge clk) begin
	in_valid2 <= in_valid;
end
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) act <=4'b1111;
	else if((in_valid==1)&&(in_valid2==0))
		act <= action;
	else if(in_valid==0)act <= 4'b1111;
end
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) ss <=3'b111;
	else if((in_valid==1)&&(in_valid2==0))
		ss <= size;
	else if(in_valid==0) ss <= 3'b111;
end
// in_data_delay
always @ (posedge clk) begin
	in_data_delay[0]<=in_data;
	in_data_delay[1] <= in_data_delay[0];
end
// add_result
always @ ( * ) begin
	add_result <= in_data_delay[1] + M_Q_o;
end
// LEN
always @ (posedge clk) begin
	if((state==state_idle)&&(state_next==state_input))
		if(act==act_setup)
			case(ss)
				size_4: begin LEN <= 6'd4; LEN_bit<= 3'd2; end
				size_8: begin LEN <= 6'd8; LEN_bit<= 3'd3; end
				size_16: begin LEN <= 6'd16; LEN_bit<=3'd4; end
				size_32: begin LEN <= 6'd32; LEN_bit<=3'd5; end
			endcase
end

// M_WEN
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) M_WEM<=1;
	else
		case(state_next)
			state_idle:  M_WEM <= 1;
			state_input: M_WEM <=0;
			state_mirror: M_WEM <= 1;
			state_transpose: M_WEM <= 1;
			state_rotate : M_WEM <= 1;
			state_result: if((state==state_result)) M_WEM <= 0; else M_WEM <= 1;
			state_cleanMA: M_WEM <=1;
			state_mult_add:M_WEM <=1;
			state_mult2reg:M_WEM <=0;
		endcase
end
// M_D
always @ (posedge clk) begin
	case(state_next)
		state_input:M_D <= in_data_delay[0];
		state_result:M_D <= C_Q_o;
		state_mult2reg:M_D<= mult_col[C_col];
		default: M_D <= 0;
	endcase
end
// M_A
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) M_A <=0;
	else
		case(state_next)
			state_idle: if(state==state_idle)M_A<=0;
			state_input: if(state==state_input) M_A <= M_A + 1; else M_A<=0;
			state_mirror: if(state==state_mirror) M_A <= M_A + 1; else M_A<=0;
			state_transpose: if(state==state_transpose) M_A <= M_A + 1; else M_A<=0;
			state_rotate: if(state==state_rotate) M_A <= M_A + 1; else M_A<=0;
			state_add:  M_A <= M_A + 1;
			state_result: if(state==state_result) M_A <= C_A_delay; else M_A<=0;
			state_cleanMA: M_A <= 0;
			state_output: M_A <= M_A + 1;
			state_mult_add: M_A <= K_K + C_col*LEN;
			state_mult2reg: M_A <= K_K + C_col*LEN;
			state_trace: M_A <=(C_col+1)*(LEN+1);
			default: M_A <= 0;
		endcase
end
//M_A delay
always @ (posedge clk) begin
	M_A_delay <= M_A;
end
// M_row M_col
always @ (posedge clk) begin
	M_row <= M_A >> LEN_bit;
	M_col <= M_A & (LEN-1);
end
// C_row
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) C_col <=0;
	else
	case(state_next)
		state_mult_add: if(C_col==(LEN-1)) C_col<=0; else C_col <= C_col + 1;
		state_mult2reg: if((C_col==(LEN-1))) C_col<=0; else C_col <= C_col + 1;
		state_trace: if((C_col==(LEN-1))) C_col<=0; else C_col <= C_col + 1;
		default: C_col <=0;
	endcase
end
// C_col
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) C_row <=0;
	else
	if(state_next==state_mult_add)
		if(C_col==(LEN-1))
			if(C_row==(LEN-1)) C_row <= 0;
			else C_row <= C_row +1;
	else if(state_next==state_idle)
		C_row <= 0;
end
// K_K
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) K_K <=0;
	else
	if((C_col==(LEN-1))&&state==state_mult2reg)
		K_K <= K_K + 1;
	else if(state_next==state_idle)
		K_K <= 0;
end
// C_WEN
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) C_WEM<=1;
	else
		case(state_next)
			state_idle: C_WEM <= 1;
			state_input: C_WEM <=1;
			state_input_C:C_WEM <=0;
			state_mirror:C_WEM <= 0;
			state_transpose:C_WEM <= 0;
			state_rotate:C_WEM <=0;
			state_add:C_WEM <= 0;
			state_result:C_WEM <= 1;
			state_cleanMA: C_WEM <=1;
			state_mult_add: C_WEM <=1;
			state_mult2reg: C_WEM <=1;
		endcase
end
// C_A_mirror
always @ ( * ) begin
	C_col_mirror <= LEN - 1 - M_col;
end
always @ (posedge clk) begin
	if(state==state_result) C_A_delay <= C_A;
	else C_A_delay <=0;
end
//C_A
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) C_A <= 0;
	else
		case(state_next)
			state_idle: C_A <=0;
			state_input_C: if(state==state_input_C) C_A <= C_A + 1; else C_A<=0;
			state_mirror: if(state==state_mirror) C_A <= M_row*LEN + C_col_mirror; else C_A <= 0;
			state_transpose: if(state==state_transpose) C_A <= M_col*LEN + M_row; else C_A <= 0;
			state_rotate: if(state==state_rotate) C_A <= C_col_mirror*LEN + M_row; else C_A <= 0;
			state_add:if(state==state_add) C_A <= M_A_delay; else C_A <= 0;
			state_result: if(state==state_result) C_A <= C_A + 1; else C_A <=0;
			state_mult_add: C_A <= C_row*LEN + C_col;
			state_mult2reg: if(state==state_mult2reg) C_A <= 0; else C_A <= C_row*LEN + C_col;
			default: C_A <=0;
		endcase
end
// C_D
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) C_D <= 0;
	else
		case(state_next)
			state_input_C: C_D <= in_data_delay[0];
			state_mirror:C_D <= M_Q_o;
			state_transpose:C_D <= M_Q_o;
			state_rotate:C_D <= M_Q_o;
			state_add: C_D <= in_data_delay[1] + M_Q_o;
			default: C_D <= 0;
		endcase
end
// FSM
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n)	state <= state_idle;
	else state <= state_next;
end
always @ ( * ) begin
	if(!rst_n) state_next= 0;
	else
		case(state)
			0: case(act)
			  				act_setup: state_next=state_input;
							act_trace: state_next=state_trace;
							act_rotate:state_next= state_rotate;
							act_transpose:state_next= state_transpose;
							act_mirror: state_next= state_mirror;
							act_addition: state_next= state_add;
							act_multiplication: state_next= state_input_C;
							default:state_next= 0;
						endcase
			state_trace: if(M_A_delay==(LEN_sq)) state_next=state_trace_out;  else state_next = state_trace;
			state_input: if(M_A==(LEN_sq)) state_next= state_cleanMA;  else state_next= state_input;
			state_input_C:if(C_A==(LEN_sq)) state_next= state_mult_add; else state_next= state_input_C;
			state_mult_add:if(mult_wait==1) state_next=state_mult2reg; else state_next= state_mult_add;
			state_mult2reg:  if(C_col_delay[0]==(LEN-1))
								if(K_K==(LEN)) state_next=state_cleanMA;
								else state_next = state_mult_add;
							else state_next = state_mult2reg;
			state_mirror: if(stop_counter==2) state_next= state_result;  else state_next= state_mirror;
			state_transpose: if(stop_counter==2) state_next = state_result;  else state_next= state_transpose;
			state_rotate:if(stop_counter==2) state_next = state_result;  else state_next=  state_rotate;
			state_add: if(stop_counter==2) state_next = state_result;  else state_next=  state_add;
			state_result: if(M_A==(LEN_sq)) state_next= state_idle;  else state_next=  state_result;
			state_cleanMA: state_next= state_output;
			state_output: if(stop_counter==1) state_next=state_idle;  else state_next=  state_output;
			state_trace_out: state_next = 0;
			default: state_next=0;
		endcase
end
//stop counter
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) stop_counter <=0;
	else if(M_A==LEN_sq) stop_counter <=1;
	else if(stop_counter!=0) stop_counter <= stop_counter +1;
end
// mult_wait
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) mult_wait <=0;
	else if(C_col==(LEN-1)&&(C_row==(LEN-1))) mult_wait <=1;
	else if(mult_wait!=0) mult_wait <= mult_wait +1;
end
// C_Q M_Q
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) C_Q <=0;
	else C_Q <= C_Q_o;
end
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) M_Q <=0;
	else M_Q <= M_Q_o;
end
// mult_add
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) mult_add<=0;
	else if((state==state_mult_add)||(state==state_mult2reg))
		if ((C_col==2))
			mult_add <= 0;
		else
			mult_add <= mult_add + (M_Q*C_Q);
	else if(state==state_trace)
		if(M_col!=0)
			mult_add <= mult_add + M_Q;
	else mult_add <=0;
end
// C_row_delay
always @ (posedge clk) begin
	C_row_delay[0] <= C_row;
	C_row_delay[1] <= C_row_delay[0];
	C_row_delay[2] <= C_row_delay[1];
end
// C_col_delay
always @ (posedge clk) begin
	C_col_delay[0] <= C_col;
	C_col_delay[1] <= C_col_delay[0];
	C_col_delay[2] <= C_col_delay[1];
end
// mult_col
always @ (posedge clk) begin
	if(C_col_delay[2]==(LEN-1))
		mult_col[C_row_delay[2]] <= mult_add + (M_Q*C_Q);
end
// output
always @ (posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		out_valid <=0;
		out_data <=0;
	end else case(state)
				state_output: begin out_valid<=1; out_data<= M_Q_o; end
				state_result: if((stop_counter>4)||(stop_counter==0)) begin out_valid<=1; out_data<= M_D; end
				state_trace_out: begin out_valid<=1; out_data<= mult_add + M_Q; end
				default: begin out_valid <=0; out_data <=0; end
			endcase
end

endmodule
