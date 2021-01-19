module CLK_1_MODULE(// Input signals
			clk_1,
			clk_2,
			invalid,
			rst_n,
			message,
			mode,
			CRC,
			// Output signals
			clk1_0_message,
			clk1_1_message,
			clk1_CRC,
			clk1_mode,
			clk1_control_signal,
			clk1_flag_0,
			clk1_flag_1,
			clk1_flag_2,
			clk1_flag_3,
			clk1_flag_4,
			clk1_flag_5,
			clk1_flag_6,
			clk1_flag_7,
			clk1_flag_8,
			clk1_flag_9
			);
//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input clk_1;
input clk_2;
input rst_n;
input invalid;
input[57:0]message;
input CRC;
input mode;

output reg [57:0] clk1_0_message;
output reg [57:0] clk1_1_message;
output reg clk1_CRC;
output reg clk1_mode;
output reg [9 :0] clk1_control_signal;
output clk1_flag_0;
output clk1_flag_1;
output clk1_flag_2;
output clk1_flag_3;
output clk1_flag_4;
output clk1_flag_5;
output clk1_flag_6;
output clk1_flag_7;
output clk1_flag_8;
output clk1_flag_9;

//---------------------------------------------------------------------
// PARAMETER DECLARATION
//---------------------------------------------------------------------
//wire CRC_w;
//wire mode_w;
//wire [57:0] message_w;
//always @ (posedge clk_1 or negedge rst_n) begin
//	if(!rst_n) clk1_0_message <=0;
//	else if(clk1_flag_0) clk1_0_message <= message;
//end
//assign clk1_0_message = (invalid)? message: 0 ;
//assign CRC_w = (invalid)? CRC : 0 ;
//assign mode_w = (invalid)? mode : 0 ;

always @ (posedge clk_1) begin
	if(invalid) clk1_0_message <= message;
	else clk1_0_message <= clk1_0_message;
end
always @ (posedge clk_1 ) begin
	if(invalid) clk1_CRC <= CRC;
	else clk1_CRC <= clk1_CRC;
end
always @ (posedge clk_1) begin
	if(invalid) clk1_mode <= mode;
	else clk1_mode <= clk1_mode;
end
//---------------------------------------------------------------------
//   TA hint:
//	  Please write a synchroniser using syn_XOR or doubole flop synchronizer design in CLK_1_MODULE to generate a flag signal to inform CLK_2_MODULE that it can read input signal from CLK_1_MODULE.
//	  You don't need to include syn_XOR.v file or synchronizer.v file by yourself, we have already done that in top module CDC.v
//	  example:
//   syn_XOR syn_1(.IN(inflag_clk1),.OUT(clk1_flag_0),.TX_CLK(clk_1),.RX_CLK(clk_2),.RST_N(rst_n));
//---------------------------------------------------------------------

syn_XOR in_valid(.IN(invalid),.OUT(clk1_flag_0),.TX_CLK(clk_1),.RX_CLK(clk_2),.RST_N(rst_n));
//syn_XOR in_mode(.IN(mode_w),.OUT(clk1_mode),.TX_CLK(clk_1),.RX_CLK(clk_2),.RST_N(rst_n));
//syn_XOR in_CRC(.IN(CRC_w),.OUT(clk1_CRC),.TX_CLK(clk_1),.RX_CLK(clk_2),.RST_N(rst_n));

endmodule


module CLK_2_MODULE(// Input signals
			clk_2,
			clk_3,
			rst_n,
			clk1_0_message,
			clk1_1_message,
			clk1_CRC,
			clk1_mode,
			clk1_control_signal,
			clk1_flag_0,
			clk1_flag_1,
			clk1_flag_2,
			clk1_flag_3,
			clk1_flag_4,
			clk1_flag_5,
			clk1_flag_6,
			clk1_flag_7,
			clk1_flag_8,
			clk1_flag_9,

			// Output signals
			clk2_0_out,
			clk2_1_out,
			clk2_CRC,
			clk2_mode,
			clk2_control_signal,
			clk2_flag_0,
			clk2_flag_1,
			clk2_flag_2,
			clk2_flag_3,
			clk2_flag_4,
			clk2_flag_5,
			clk2_flag_6,
			clk2_flag_7,
			clk2_flag_8,
			clk2_flag_9

			);
//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input clk_2;
input clk_3;
input rst_n;

input [57:0] clk1_0_message;
input [57:0] clk1_1_message;
input clk1_CRC;
input clk1_mode;
input [9  :0] clk1_control_signal;
input clk1_flag_0;
input clk1_flag_1;
input clk1_flag_2;
input clk1_flag_3;
input clk1_flag_4;
input clk1_flag_5;
input clk1_flag_6;
input clk1_flag_7;
input clk1_flag_8;
input clk1_flag_9;


output reg [57:0] clk2_0_out;
output reg [57:0] clk2_1_out;
output reg clk2_CRC;
output reg clk2_mode;
output reg [9  :0] clk2_control_signal;
output clk2_flag_0;
output reg clk2_flag_1;
output clk2_flag_2;
output clk2_flag_3;
output clk2_flag_4;
output clk2_flag_5;
output clk2_flag_6;
output clk2_flag_7;
output clk2_flag_8;
output clk2_flag_9;
//---------------------------------------------------------------------
//   TA hint:
//	  Please write a synchroniser using syn_XOR or doubole flop synchronizer design in CLK_2_MODULE to generate a flag signal to inform CLK_3_MODULE that it can read input signal from CLK_2_MODULE.
//	  You don't need to include syn_XOR.v file or synchronizer.v file by yourself, we have already done that in top module CDC.v
//	  example:
//   syn_XOR syn_2(.IN(inflag_clk2),.OUT(clk2_flag_0),.TX_CLK(clk_2),.RX_CLK(clk_3),.RST_N(rst_n));
//---------------------------------------------------------------------
reg [6-1:0] counter58;
//reg [57:0] message_origin;
//reg [57:0] message;
/*
reg [4:0] b_CRC0;// parity bit for encoder
reg [4:0] b_CRC1;// parity bit for encoder
reg [4:0] bb_CRC0;//syndrone
reg [4:0] bb_CRC1;//syndrone
wire XOR_CRC0;
wire XOR_CRC1;
wire [57:0] codeword0;
wire [57:0] codeword1;
*/
wire finish_flag;
reg shift_flag;

// store mode
always @ ( posedge clk_2 ) begin
	if(clk1_flag_0) clk2_mode <= clk1_mode;
	else clk2_mode <= clk2_mode;
end

// store CRC
always @ ( posedge clk_2 ) begin
	if(clk1_flag_0) clk2_CRC <= clk1_CRC;
	else clk2_CRC <= clk2_CRC;
end

// store messege
//always @ (posedge clk_2 or negedge rst_n) begin
//	if(!rst_n) message_origin <=0;
//	else if(clk1_flag_0) message_origin <= clk1_0_message;
//end

// shift counter 0~57 after invalid
always @ (posedge clk_2 or negedge rst_n) begin
	if(!rst_n) counter58 <=0;
	else if(clk1_flag_0) counter58 <= 6'd1;
	else if(counter58!=0) counter58 <= counter58 + 1;
end
/*
// message[57] = input into encoder each clock
always @ (posedge clk_2 or negedge rst_n) begin
	if(!rst_n) message <=0;
	else if(clk1_flag_0) message <= clk1_0_message;
	else message <= {message[56:0],1'b0};
end
*/
/*
//---------------------------------------------------------------------
// mode = 0 , CRC = 1	encoder g(x) = 1 + x^2 + x^5
//---------------------------------------------------------------------
assign XOR_CRC1 = b_CRC1[4]^clk2_0_out[57];
always @ (posedge clk_2 ) begin
	if(clk1_flag_0) b_CRC1<=0;
	else begin
		b_CRC1[0] <= 		   XOR_CRC1;
		b_CRC1[1] <= b_CRC1[0];
		b_CRC1[2] <= b_CRC1[1]^XOR_CRC1;
		b_CRC1[3] <= b_CRC1[2];
		b_CRC1[4] <= b_CRC1[3];
	end
end
assign codeword1 = {clk1_0_message[52:0],b_CRC1};
//---------------------------------------------------------------------
// mode = 0 , CRC = 0	encoder g(x) = 1 + x + x^3 + x^5
//---------------------------------------------------------------------
assign XOR_CRC0 = b_CRC0[4]^clk2_0_out[57];
always @ (posedge clk_2 ) begin
	if(clk1_flag_0) b_CRC0<=0;
	else begin
		b_CRC0[0] <= 		   XOR_CRC0;
		b_CRC0[1] <= b_CRC0[0]^XOR_CRC0;
		b_CRC0[2] <= b_CRC0[1];
		b_CRC0[3] <= b_CRC0[2]^XOR_CRC0;
		b_CRC0[4] <= b_CRC0[3];
	end
end
assign codeword0 = {clk1_0_message[52:0],b_CRC0};
//---------------------------------------------------------------------

// mode = 1 , CRC = 1 sydrone detect
//---------------------------------------------------------------------
always @ (posedge clk_2 ) begin
	if(clk1_flag_0) bb_CRC1 <=0;
	else begin
		bb_CRC1[0] <= bb_CRC1[4]^clk2_0_out[57];
		bb_CRC1[1] <= bb_CRC1[0];
		bb_CRC1[2] <= bb_CRC1[1]^bb_CRC1[4];
		bb_CRC1[3] <= bb_CRC1[2];
		bb_CRC1[4] <= bb_CRC1[3];
	end
end
//---------------------------------------------------------------------
// mode = 1 , CRC = 0 sydrone detect
//---------------------------------------------------------------------
always @ (posedge clk_2 ) begin
	if(clk1_flag_0) bb_CRC0 <=0;
	else begin
		bb_CRC0[0] <= bb_CRC0[4]^clk2_0_out[57];
		bb_CRC0[1] <= bb_CRC0[0]^bb_CRC0[4];
		bb_CRC0[2] <= bb_CRC0[1];
		bb_CRC0[3] <= bb_CRC0[2]^bb_CRC0[4];
		bb_CRC0[4] <= bb_CRC0[3];
	end
end
*/
reg [4:0] parity;
wire [3:0] p;
wire XOR_CRC;

assign XOR_CRC = parity[4]^p[0];
assign p[0] = (clk2_mode)? clk2_0_out[57] : clk2_0_out[52];
assign p[1] = (clk2_CRC)?  0 : XOR_CRC;
assign p[2] = (clk2_CRC)?  XOR_CRC : 0;
assign p[3] = (clk2_CRC)?  0 : XOR_CRC;
/*always @ ( * ) begin
	if(clk2_mode)
		if(clk2_CRC) begin // mode 1 CRC 1
			p[0] <= clk2_0_out[57];
			p[1] <= 0;
			p[2] <= parity[4];
			p[3] <= 0;
			p[4] <= 0;
		end else begin // mode 1 CRC 0
			p[0] <= clk2_0_out[57];
			p[1] <= parity[4];
			p[2] <= 0;
			p[3] <= parity[4];
			p[4] <= 0;
		end
	else
		if(clk2_CRC) begin // mode 0 CRC 1
			p[0] <= clk2_0_out[52];
			p[1] <= 0;
			p[2] <= parity[4]^clk2_0_out[52];
			p[3] <= 0;
			p[4] <= 0;
		end else begin // mode 0 CRC 0
			p[0] <= clk2_0_out[52];
			p[1] <= parity[4]^clk2_0_out[52];
			p[2] <= 0;
			p[3] <= parity[4]^clk2_0_out[52];
			p[4] <= 0;
		end
end*/
always @ (posedge clk_2 ) begin
	 if(clk1_flag_0) parity <=0;
	else begin
		parity[0] <= XOR_CRC;
		parity[1] <= parity[0]^p[1];
		parity[2] <= parity[1]^p[2];
		parity[3] <= parity[2]^p[3];
		parity[4] <= parity[3];
	end
end

always @ (posedge clk_2 ) begin
	 if(  finish_flag ) begin
		/*
		if(clk2_mode) begin
			if(clk2_CRC)
			//clk2_0_out <= {{53{1'b0}},bb_CRC0};
			//clk2_1_out <= {{53{1'b0}},bb_CRC1};
			clk2_0_out <= {{53{1'b0}},parity};
			else clk2_0_out <= {{53{1'b0}},parity};
		end else begin
			if(clk2_CRC)
			//clk2_0_out <= {clk2_0_out[52:0],b_CRC0};
			//clk2_1_out <= {clk2_1_out[52:0],b_CRC1};
			clk2_0_out <= {clk2_0_out[52:0],parity};
			else clk2_0_out <= {clk2_0_out[52:0],parity};
		end
		*/
		if(clk2_mode) clk2_0_out <= {{53{1'b0}},(parity==clk1_0_message[4:0])};
		else clk2_0_out <= {clk1_0_message[52:0],parity};
	end else if(clk1_flag_0) begin
		clk2_0_out <= clk1_0_message;
		//clk2_1_out <= clk1_0_message;
	end else if(shift_flag) clk2_0_out <= {clk2_0_out[56:0],1'b0};
end

always @ (posedge clk_2) begin
	if(finish_flag) shift_flag <= 0;
	else if(clk1_flag_0) shift_flag <= 1;
end
// mode 1 => sydrone detect
// mode 0 => encoder
//assign finish_flag = (clk2_mode)? (counter58==6'd59) : (counter58==6'd54);
assign finish_flag = (counter58==6'd54);
syn_XOR syn_2(.IN(finish_flag),.OUT(clk2_flag_0),.TX_CLK(clk_2),.RX_CLK(clk_3),.RST_N(rst_n));
//syn_XOR syn_3(.IN(clk1_CRC),.OUT(clk2_CRC),.TX_CLK(clk_2),.RX_CLK(clk_3),.RST_N(rst_n));
//syn_XOR syn_4(.IN(clk1_mode),.OUT(clk2_mode),.TX_CLK(clk_2),.RX_CLK(clk_3),.RST_N(rst_n));

/*always @ (posedge clk_2) begin
	if(counter58[53]) begin
		if(!mode) begin
			$display("%b",b_CRC0);
			$display("%b",b_CRC1);
		end
	end
	if(counter58[58])begin
		if(mode) begin
			$display("%b",bb_CRC0);
			$display("%b",bb_CRC1);
		end
	end
end*/
endmodule


module CLK_3_MODULE(// Input signals
			clk_3,
			rst_n,
			clk2_0_out,
			clk2_1_out,
			clk2_CRC,
			clk2_mode,
			clk2_control_signal,
			clk2_flag_0,
			clk2_flag_1,
			clk2_flag_2,
			clk2_flag_3,
			clk2_flag_4,
			clk2_flag_5,
			clk2_flag_6,
			clk2_flag_7,
			clk2_flag_8,
			clk2_flag_9,

			// Output signals
			outvalid,
			out

			);
//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input clk_3;
input rst_n;

input [57:0] clk2_0_out;
input [57:0] clk2_1_out;
input clk2_CRC;
input clk2_mode;
input [9  :0] clk2_control_signal;
input clk2_flag_0;
input clk2_flag_1;
input clk2_flag_2;
input clk2_flag_3;
input clk2_flag_4;
input clk2_flag_5;
input clk2_flag_6;
input clk2_flag_7;
input clk2_flag_8;
input clk2_flag_9;

output reg outvalid;
output reg [57:0]out;

//---------------------------------------------------------------------
// PARAMETER DECLARATION
//---------------------------------------------------------------------
always @ (posedge clk_3 or negedge rst_n) begin
	if(!rst_n) begin
		outvalid<=0;
		out <=0;
	end else if(clk2_flag_0) begin
		outvalid<=1;
		if(clk2_mode) begin
			//if(clk2_CRC)
			//	if(clk2_1_out[0]|clk2_1_out[1]|clk2_1_out[2]|clk2_1_out[3]|clk2_1_out[4])
			//		out <= {58{1'b1}};
			//	else
			//		out <= 0;
			//else
				//if(clk2_0_out[0]|clk2_0_out[1]|clk2_0_out[2]|clk2_0_out[3]|clk2_0_out[4])
				if(clk2_0_out[0])
					out <= 0;
				else
					out <= {58{1'b1}};
		end else begin
			//if(clk2_CRC)
			//	out <= clk2_1_out;
			//else
				out <= clk2_0_out;
		end
	end else begin
		outvalid<=0;
		out <=0;
	end
end


endmodule
