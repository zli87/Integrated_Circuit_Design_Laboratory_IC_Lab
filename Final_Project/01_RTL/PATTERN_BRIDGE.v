`ifdef RTL
	`define CYCLE_TIME 10.0
`elsif GATE
	`define CYCLE_TIME 10.0
`elsif CHIP
    `define CYCLE_TIME 10.0
`elsif POST
    `define CYCLE_TIME 10.0
`endif

`define GET_DATA(ins_name,addr) {ins_name.DRAM_r[(addr)+1],ins_name.DRAM_r[(addr)]}
`define GET_INST1(addr) {IMEM1.DRAM_r[(addr)+1],IMEM1.DRAM_r[(addr)]}
`define GET_INST2(addr) {IMEM2.DRAM_r[(addr)+1],IMEM2.DRAM_r[(addr)]}
`define R_TYPE 3'b000
`define M_TYPE 3'b001
`define ADDI_TYPE 3'b010
`define SUBI_TYPE 3'b011
`define LOAD_TYPE 3'b100
`define STORE_TYPE 3'b101
`define BEQ_TYPE 3'b110
`define J_TYPE 3'b111

`define ADD_FUNC 3'b000
`define SUB_FUNC 3'b001
`define AND_FUNC 3'b010
`define OR_FUNC 3'b011
`define NAND_FUNC 3'b100
`define NOR_FUNC 3'b101
`define XOR_FUNC 3'b110
`define SLE_FUNC 3'b111

`include "../00_TESTBED/MEM_MAP_define.v"
`include "../00_TESTBED/INST_MEM_1.v"
`include "../00_TESTBED/INST_MEM_2.v"
`include "../00_TESTBED/DATA_MEM.v"
`include "../00_TESTBED/ANS_MEM.v"

module PATTERN #(parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=16) (
    //Output Port
    output reg clk,
	output reg rst_n,
	output reg inst_1_i_valid ,
    output reg [13-1:0] inst_1_i_addr ,
    input inst_1_o_valid ,
    input [DATA_WIDTH-1:0] inst_1_o_data ,
	output reg inst_2_i_valid ,
    output reg [13-1:0] inst_2_i_addr ,
    input inst_2_o_valid ,
    input [DATA_WIDTH-1:0] inst_2_o_data ,
  // dual port data controll
    output reg data_1_i_valid ,
    output reg [DATA_WIDTH-1:0] data_1_i_data ,
    output reg [13-1:0] data_1_i_addr ,
    output reg data_1_i_rw ,
    input data_1_o_valid ,
    input [DATA_WIDTH-1:0] data_1_o_data ,
    output reg data_2_i_valid ,
    output reg [DATA_WIDTH-1:0] data_2_i_data ,
    output reg [13-1:0] data_2_i_addr ,
    output reg data_2_i_rw ,
    input data_2_o_valid ,
    input [DATA_WIDTH-1:0] data_2_o_data ,
	output reg data_i_interrupt,
	//===== AXI-4 Instruction Memory #1 =====
	input [ID_WIDTH-1:0] arid_s_inf_inst_1,
	input [ADDR_WIDTH-1:0] araddr_s_inf_inst_1,
	input [7:0] arlen_s_inf_inst_1,
	input [2:0] arsize_s_inf_inst_1,
	input [1:0] arburst_s_inf_inst_1,
	input arvalid_s_inf_inst_1,
	output arready_s_inf_inst_1,

	output [ID_WIDTH-1:0] rid_s_inf_inst_1,
	output [DATA_WIDTH-1:0] rdata_s_inf_inst_1,
	output [1:0] rresp_s_inf_inst_1,
	output rlast_s_inf_inst_1,
	output rvalid_s_inf_inst_1,
	input rready_s_inf_inst_1,

	input [ID_WIDTH-1:0] awid_s_inf_inst_1,
	input [ADDR_WIDTH-1:0] awaddr_s_inf_inst_1,
	input [2:0] awsize_s_inf_inst_1,
	input [1:0] awburst_s_inf_inst_1,
	input [7:0] awlen_s_inf_inst_1,
	input awvalid_s_inf_inst_1,
	output awready_s_inf_inst_1,

	input [DATA_WIDTH-1:0] wdata_s_inf_inst_1,
	input wlast_s_inf_inst_1,
	input wvalid_s_inf_inst_1,
	output wready_s_inf_inst_1,

	output [ID_WIDTH-1:0] bid_s_inf_inst_1,
	output [1:0] bresp_s_inf_inst_1,
	output bvalid_s_inf_inst_1,
	input bready_s_inf_inst_1,
	//===== AXI-4 Instruction Memory #2 =====
	input [ID_WIDTH-1:0] arid_s_inf_inst_2,
	input [ADDR_WIDTH-1:0] araddr_s_inf_inst_2,
	input [7:0] arlen_s_inf_inst_2,
	input [2:0] arsize_s_inf_inst_2,
	input [1:0] arburst_s_inf_inst_2,
	input arvalid_s_inf_inst_2,
	output arready_s_inf_inst_2,

	output [ID_WIDTH-1:0] rid_s_inf_inst_2,
	output [DATA_WIDTH-1:0] rdata_s_inf_inst_2,
	output [1:0] rresp_s_inf_inst_2,
	output rlast_s_inf_inst_2,
	output rvalid_s_inf_inst_2,
	input rready_s_inf_inst_2,

	input [ID_WIDTH-1:0] awid_s_inf_inst_2,
	input [ADDR_WIDTH-1:0] awaddr_s_inf_inst_2,
	input [2:0] awsize_s_inf_inst_2,
	input [1:0] awburst_s_inf_inst_2,
	input [7:0] awlen_s_inf_inst_2,
	input awvalid_s_inf_inst_2,
	output awready_s_inf_inst_2,

	input [DATA_WIDTH-1:0] wdata_s_inf_inst_2,
	input wlast_s_inf_inst_2,
	input wvalid_s_inf_inst_2,
	output wready_s_inf_inst_2,

	output [ID_WIDTH-1:0] bid_s_inf_inst_2,
	output [1:0] bresp_s_inf_inst_2,
	output bvalid_s_inf_inst_2,
	input bready_s_inf_inst_2,
	//===== AXI-4 Data Memory =====
	input [ID_WIDTH-1:0] arid_s_inf_data,
	input [ADDR_WIDTH-1:0] araddr_s_inf_data,
	input [7:0] arlen_s_inf_data,
	input [2:0] arsize_s_inf_data,
	input [1:0] arburst_s_inf_data,
	input arvalid_s_inf_data,
	output arready_s_inf_data,

	output [ID_WIDTH-1:0] rid_s_inf_data,
	output [DATA_WIDTH-1:0] rdata_s_inf_data,
	output [1:0] rresp_s_inf_data,
	output rlast_s_inf_data,
	output rvalid_s_inf_data,
	input rready_s_inf_data,

	input [ID_WIDTH-1:0] awid_s_inf_data,
	input [ADDR_WIDTH-1:0] awaddr_s_inf_data,
	input [2:0] awsize_s_inf_data,
	input [1:0] awburst_s_inf_data,
	input [7:0] awlen_s_inf_data,
	input awvalid_s_inf_data,
	output awready_s_inf_data,

	input [DATA_WIDTH-1:0] wdata_s_inf_data,
	input wlast_s_inf_data,
	input wvalid_s_inf_data,
	output wready_s_inf_data,

	output [ID_WIDTH-1:0] bid_s_inf_data,
	output [1:0] bresp_s_inf_data,
	output bvalid_s_inf_data,
	input bready_s_inf_data );

//---------------------------------------------------------------------
//   PORT DECLARATION
//---------------------------------------------------------------------
//########################################### Instruction Memory #1
INST_MEM_1 IMEM1 (
	.clk(clk),
	.rst_n(rst_n),
	// axi write addr channel
	// src master
	.awid_s_inf(awid_s_inf_inst_1),
	.awaddr_s_inf(awaddr_s_inf_inst_1),
	.awsize_s_inf(awsize_s_inf_inst_1),
	.awburst_s_inf(awburst_s_inf_inst_1),
	.awlen_s_inf(awlen_s_inf_inst_1),
	.awvalid_s_inf(awvalid_s_inf_inst_1),
	// src slave
	.awready_s_inf(awready_s_inf_inst_1),
	// axi write data channel
	// src master
	.wdata_s_inf(wdata_s_inf_inst_1),
	.wlast_s_inf(wlast_s_inf_inst_1),
	.wvalid_s_inf(wvalid_s_inf_inst_1),
	// src slave
	.wready_s_inf(wready_s_inf_inst_1),
	// axi write resp channel
	// src slave
	.bid_s_inf(bid_s_inf_inst_1),
	.bresp_s_inf(bresp_s_inf_inst_1),
	.bvalid_s_inf(bvalid_s_inf_inst_1),
	// src master
	.bready_s_inf(bready_s_inf_inst_1),
	// axi read addr channel
	// src master
	.arid_s_inf(arid_s_inf_inst_1),
	.araddr_s_inf(araddr_s_inf_inst_1),
	.arlen_s_inf(arlen_s_inf_inst_1),
	.arsize_s_inf(arsize_s_inf_inst_1),
	.arburst_s_inf(arburst_s_inf_inst_1),
	.arvalid_s_inf(arvalid_s_inf_inst_1),
	// src slave
	.arready_s_inf(arready_s_inf_inst_1),
	// axi read data channel
	// slave
	.rid_s_inf(rid_s_inf_inst_1),
	.rdata_s_inf(rdata_s_inf_inst_1),
	.rresp_s_inf(rresp_s_inf_inst_1),
	.rlast_s_inf(rlast_s_inf_inst_1),
	.rvalid_s_inf(rvalid_s_inf_inst_1),
	// master
	.rready_s_inf(rready_s_inf_inst_1)
);

//########################################### Instruction Memory #2
INST_MEM_2 IMEM2 (
	.clk(clk),
	.rst_n(rst_n),
	// axi write addr channel
	// src master
	.awid_s_inf(awid_s_inf_inst_2),
	.awaddr_s_inf(awaddr_s_inf_inst_2),
	.awsize_s_inf(awsize_s_inf_inst_2),
	.awburst_s_inf(awburst_s_inf_inst_2),
	.awlen_s_inf(awlen_s_inf_inst_2),
	.awvalid_s_inf(awvalid_s_inf_inst_2),
	// src slave
	.awready_s_inf(awready_s_inf_inst_2),
	// axi write data channel
	// src master
	.wdata_s_inf(wdata_s_inf_inst_2),
	.wlast_s_inf(wlast_s_inf_inst_2),
	.wvalid_s_inf(wvalid_s_inf_inst_2),
	// src slave
	.wready_s_inf(wready_s_inf_inst_2),
	// axi write resp channel
	// src slave
	.bid_s_inf(bid_s_inf_inst_2),
	.bresp_s_inf(bresp_s_inf_inst_2),
	.bvalid_s_inf(bvalid_s_inf_inst_2),
	// src master
	.bready_s_inf(bready_s_inf_inst_2),
	// axi read addr channel
	// src master
	.arid_s_inf(arid_s_inf_inst_2),
	.araddr_s_inf(araddr_s_inf_inst_2),
	.arlen_s_inf(arlen_s_inf_inst_2),
	.arsize_s_inf(arsize_s_inf_inst_2),
	.arburst_s_inf(arburst_s_inf_inst_2),
	.arvalid_s_inf(arvalid_s_inf_inst_2),
	// src slave
	.arready_s_inf(arready_s_inf_inst_2),
	// axi read data channel
	// slave
	.rid_s_inf(rid_s_inf_inst_2),
	.rdata_s_inf(rdata_s_inf_inst_2),
	.rresp_s_inf(rresp_s_inf_inst_2),
	.rlast_s_inf(rlast_s_inf_inst_2),
	.rvalid_s_inf(rvalid_s_inf_inst_2),
	// master
	.rready_s_inf(rready_s_inf_inst_2)
);

//########################################### Data Memory
DATA_MEM DMEM (
	.clk(clk),
	.rst_n(rst_n),
	// axi write addr channel
	// src master
	.awid_s_inf(awid_s_inf_data),
	.awaddr_s_inf(awaddr_s_inf_data),
	.awsize_s_inf(awsize_s_inf_data),
	.awburst_s_inf(awburst_s_inf_data),
	.awlen_s_inf(awlen_s_inf_data),
	.awvalid_s_inf(awvalid_s_inf_data),
	// src slave
	.awready_s_inf(awready_s_inf_data),
	// axi write data channel
	// src master
	.wdata_s_inf(wdata_s_inf_data),
	.wlast_s_inf(wlast_s_inf_data),
	.wvalid_s_inf(wvalid_s_inf_data),
	// src slave
	.wready_s_inf(wready_s_inf_data),
	// axi write resp channel
	// src slave
	.bid_s_inf(bid_s_inf_data),
	.bresp_s_inf(bresp_s_inf_data),
	.bvalid_s_inf(bvalid_s_inf_data),
	// src master
	.bready_s_inf(bready_s_inf_data),
	// axi read addr channel
	// src master
	.arid_s_inf(arid_s_inf_data),
	.araddr_s_inf(araddr_s_inf_data),
	.arlen_s_inf(arlen_s_inf_data),
	.arsize_s_inf(arsize_s_inf_data),
	.arburst_s_inf(arburst_s_inf_data),
	.arvalid_s_inf(arvalid_s_inf_data),
	// src slave
	.arready_s_inf(arready_s_inf_data),
	// axi read data channel
	// slave
	.rid_s_inf(rid_s_inf_data),
	.rdata_s_inf(rdata_s_inf_data),
	.rresp_s_inf(rresp_s_inf_data),
	.rlast_s_inf(rlast_s_inf_data),
	.rvalid_s_inf(rvalid_s_inf_data),
	// master
	.rready_s_inf(rready_s_inf_data)
);

ANS_MEM AMEM();
//ANS_MEM ans_mem2();
//---------------------------------------------------------------------
//   PARAMETER & INTEGER DECLARATION
//---------------------------------------------------------------------
integer i,t,p,SEED=125,PAT_NUM=10000;
integer lat_1,lat_2;
integer wait_stop;
integer finish_1,finish_2;
//---------------------------------------------------------------------
//  TASK VARIABLE
//---------------------------------------------------------------------
reg [13-1:0] data_addr_1_ans;
integer data_1_ans;
reg [13-1:0] data_addr_2_ans;
integer data_2_ans;
reg [13-1:0] PC_ans_1;
integer inst_1_ans;
reg [13-1:0] PC_ans_2;
integer inst_ans_2;
//
reg [13+1-1:0]  i_addr[1:0];
reg [16-1:0] i_data[1:0];
reg [1:0] i_rw;
reg signed [7:0] ADDR_OFFSET;
//---------------------------------------------------------------------
//   WIRE & REGISTER DECLARATION
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//   CLOCK
//---------------------------------------------------------------------
always #(`CYCLE_TIME/2.0) clk = ~clk;
//---------------------------------------------------------------------
//   TEST PATTERN
//---------------------------------------------------------------------
initial begin

rst_n=1'b1;
lat_1 = 0;
lat_2 = 0;

inst_1_i_valid = 0;
inst_1_i_addr = 0;
inst_2_i_valid = 0;
inst_2_i_addr = 0;
data_1_i_valid = 0;
data_1_i_data = 0;
data_1_i_addr = 0;
data_1_i_rw = 0;
data_2_i_valid = 0;
data_2_i_data = 0;
data_2_i_addr = 0;
data_2_i_rw = 0;
data_i_interrupt = 0;
INIT_INPUT(0,13'h1000);
INIT_INPUT(1,13'h1000);

force clk = 0;
reset_signal_task;
@(posedge clk);

for(p=0;p<PAT_NUM;p=p+1) begin
		// check inst
		//inst_input_task;
	  	//wait_out_valid;
		//check_MEM_task;
		// check data
		data_input_task;
		wait_out_valid_and_check;
	  	@(posedge clk);
end
YOU_PASS_task;
end

task reset_signal_task; begin
    #`CYCLE_TIME; rst_n = 0;
    #`CYCLE_TIME; rst_n = 1;

    if(inst_1_o_valid!==1'b0||inst_2_o_valid!==0||data_1_o_valid!==0||data_2_o_valid!==0) begin//out!==0
        $display("************************************************************");
        $display("*  Output signal should be 0 after initial RESET  at %8t   *",$time);
        $display("************************************************************");
        repeat(2) #`CYCLE_TIME;
        $finish;
    end
	#`CYCLE_TIME; release clk;
end endtask

/*task inst_input_task; begin
	// test inst controller
	inst_1_i_valid = 1;
	case(p)
		0:inst_1_i_addr = 13'h344;
		1:inst_1_i_addr = 13'h346;
		2:inst_1_i_addr = 13'h792;
		3:inst_1_i_addr = 13'h798;
	endcase
	PC_ans_1 = inst_1_i_addr;
	inst_1_ans = `GET_DATA(IMEM1,inst_1_i_addr);
	@(posedge clk);
	inst_1_i_valid = 0;
 	inst_1_i_addr = 0;
end endtask*/

task RANDOM_INPUT(input n); begin
	ADDR_OFFSET=$signed($random(SEED) & 8'hfe);
	if($random(SEED)&1'b1)i_addr[n]=i_addr[n]+ADDR_OFFSET;
	else i_addr[n]=i_addr[n]-ADDR_OFFSET;
	i_rw[n]=$random(SEED) & 1'h1;
	i_data[n]=$random(SEED) & 16'hffff;
end endtask

task INIT_INPUT(input n,input [12:0] address); begin
	i_addr[n]=(address);
	i_rw[n]=0;
	i_data[n]=0;
end endtask

task ADJUST_ADDR; begin
	if ( i_addr[0] < 0 ) i_addr[0] = 0;
    else if ( i_addr[0] > 14'h2000 ) i_addr[0] = 14'h1ffe;
    if ( i_addr[1] < 0 ) i_addr[1] = 0;
    else if ( i_addr[1] > 14'h2000 ) i_addr[1] = 14'h1ffe;
end endtask

task set_1_data(input [12:0] addr,input rw,input [15:0] data); begin
	data_1_i_data = data;
	data_1_i_addr = addr;
	data_1_i_rw = rw;

	data_addr_1_ans = data_1_i_addr;
	if(rw) data_1_ans = `GET_DATA(AMEM,data_1_i_addr);
	else  begin
		data_1_ans = 0;
		`GET_DATA(AMEM,data_1_i_addr) = data;
	end
end endtask

task set_2_data(input [12:0] addr,input rw,input [15:0] data); begin
	data_2_i_data = data;
	data_2_i_addr = addr;
	data_2_i_rw = rw;

	data_addr_2_ans = data_2_i_addr;
	if(rw) data_2_ans = `GET_DATA(AMEM,data_2_i_addr);
	else  begin
		data_2_ans = 0;
		`GET_DATA(AMEM,data_2_i_addr) = data;
	end
end endtask

task data_input_task; begin
	data_1_i_valid = 1;
	data_2_i_valid = 1;
	RANDOM_INPUT(0);
	RANDOM_INPUT(1);
	ADJUST_ADDR;
	$display("%h,%h",i_addr[0][12:9],i_addr[1][12:9]);
	set_1_data(i_addr[0],i_rw[0],i_data[0]);
	set_2_data(i_addr[1],i_rw[1],i_data[1]);
	//case(p)
	//	0: begin set_1_data(13'h344,0,16'h4567); set_2_data(13'h346,1,0); end
	//	1: begin set_1_data(13'h792,0,16'h4321); set_2_data(13'ha68,0,16'h1234); end
	//	2: begin set_1_data(13'hfe2,0,16'habcd); set_2_data(13'ha66,1,0); end
	//	3: begin set_1_data(13'hed2,0,16'h8888); set_2_data(13'hc84,1,0); end
	//	4: begin set_1_data(13'h344,1,0); set_2_data(13'hc82,1,0); end
	//endcase
	@(posedge clk);
	data_1_i_valid = 0;
	data_1_i_data = 0;
	data_1_i_addr = 0;
	data_1_i_rw = 0;
	data_2_i_valid = 0;
	data_2_i_data = 0;
	data_2_i_addr = 0;
	data_2_i_rw = 0;
end endtask

task wait_out_valid; begin
	$display("start to wait");
	while(data_1_o_valid==0&&data_2_o_valid==0) begin
	//while(inst_1_o_data==0&&inst_1_o_data==0) begin
		lat_1=lat_1+1;
		lat_2=lat_2+1;
		if(lat_1>=1500 || lat_2>=1500)begin//lat==max+1
	   		$display("********************************************************");
	   		$display("*  The execution latency (%4d,%4d) are over 1500 cycles  at %8t *",lat_1,lat_2,$time);//over max
	   		$display("********************************************************");
			repeat(2)@(posedge clk);
			$finish;
		end
	    @(posedge clk);
	end
	//if(inst_1_o_data) lat_1 = -1;
	//if(inst_1_o_data) lat_2 = -1;
	if(data_1_o_valid) lat_1 = -1;
	if(data_2_o_valid) lat_2 = -1;
end endtask

task wait_out_valid_and_check; begin
	//$display("start to wait");
	finish_1 = 0;
	finish_2 = 0;
	wait_stop = 0;
	while( ((finish_1==0) || (finish_2==0)) && (wait_stop < 3) ) begin
		while((data_1_o_valid==0)&&(data_2_o_valid==0)) begin
		//while(inst_1_o_data==0&&inst_1_o_data==0) begin
			lat_1=lat_1+1;
			lat_2=lat_2+1;
			if(lat_1>=1500 || lat_2>=1500)begin//lat==max+1
		   		$display("********************************************************");
		   		$display("*  The execution latency (%4d,%4d) are over 1500 cycles  at %8t *",lat_1,lat_2,$time);//over max
		   		$display("********************************************************");
				repeat(2)@(posedge clk);
				$finish;
			end
		    @(posedge clk);
		end
		if(data_1_o_valid) begin
			lat_1 = -1;
			finish_1 = 1;
			if( data_1_ans != data_1_o_data  )begin
				$display ("--------------------------------------------------------------------");
				$display ("                         Error in Data Memory !     ");
				$display ("                           Adress = %h    ",data_addr_1_ans);
				$display ("                           ANS      YOURS    ");
				$display ("                read out  data       %h         %h     ",`GET_DATA(AMEM,data_addr_1_ans-2),`GET_DATA(DMEM,data_addr_1_ans-2));
				$display ("                read out  data       %h         %h     ",data_1_ans,data_1_o_data);
				$display ("                read out  data       %h         %h     ",`GET_DATA(AMEM,data_addr_1_ans+2),`GET_DATA(DMEM,data_addr_1_ans+2));
				$display ("--------------------------------------------------------------------");
				repeat(9)@(posedge clk);
				$finish;
			end
			//$display("data_1 finish");
		end // end if data_1_o_valid
		if(data_2_o_valid) begin
			lat_2 = -1;
			finish_2 = 1;
			if( data_2_ans != data_2_o_data )begin
				$display ("--------------------------------------------------------------------");
				$display ("                         Error in Data Memory !     ");
				$display ("                           Adress = %h    ",data_addr_2_ans);
				$display ("                           ANS      YOURS    ");
				$display ("                read out  data       %h         %h     ",`GET_DATA(AMEM,data_addr_2_ans-2),`GET_DATA(DMEM,data_addr_2_ans-2));
				$display ("                read out  data       %h         %h     ",data_2_ans,data_2_o_data);
				$display ("                read out  data       %h         %h     ",`GET_DATA(AMEM,data_addr_2_ans+2),`GET_DATA(DMEM,data_addr_2_ans+2));
				$display ("--------------------------------------------------------------------");
				repeat(9)@(posedge clk);
				$finish;
			end
			//$display("data_2 finish");
		end // end if data_2_o_valid
		wait_stop = wait_stop + 1;
		@(posedge clk);
	end // end while
end endtask

task check_MEM_task; begin
		if( inst_1_ans != inst_1_o_data)begin
			$display ("--------------------------------------------------------------------");
			$display ("                         Error in Data Memory !     ");
			$display ("                           Adress = %h    ",PC_ans_1);
			$display ("                           ANS      YOURS    ");
			$display ("                  data       %h         %h     ",inst_1_ans,inst_1_o_data);
			$display ("--------------------------------------------------------------------");
			repeat(9)@(posedge clk);
			$finish;
		end
		@(posedge clk);
end endtask

task YOU_PASS_task; begin

	@(posedge clk);
	data_i_interrupt = 1;
	@(posedge clk);
	data_i_interrupt = 0;
	repeat(1500)@(posedge clk);
	for(i=0;i<32'h2000;i=i+2)begin
		if(`GET_DATA(DMEM,i) != `GET_DATA(AMEM,i))begin
			$display ("--------------------------------------------------------------------");
			$display ("               Error in Data Memory ! No write back ! ");
			$display ("                           Adress = %h    ",i);
			$display ("                           ANS      YOURS    ");
			$display ("                  data       %h         %h     ",`GET_DATA(AMEM,i),`GET_DATA(DMEM,i));
			$display ("--------------------------------------------------------------------");
			repeat(9)@(negedge clk);
			$finish;
		end
	end

    $display ("--------------------------------------------------------------------");
    $display ("                         Congratulations!                           ");
    $display ("                  You have passed all patterns!                     ");
    $display ("--------------------------------------------------------------------");
    repeat(20)@(posedge clk);
    $finish;
end endtask

endmodule
