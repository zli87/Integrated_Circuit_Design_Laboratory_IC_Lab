`ifdef RTL
	`define CYCLE_TIME 5.0
`elsif GATE
	`define CYCLE_TIME 5.0
`elsif CHIP
    `define CYCLE_TIME 20.0
`elsif POST
    `define CYCLE_TIME 20.0
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
	output reg interrupt_1,
	output reg interrupt_2,
    //Input Port
	input stall_core1,
	input stall_core2,
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

reg [14-1:0] PC [3:0];
reg [16-1:0] REG [3:0][7:0];
ANS_MEM ans_mem[1:0] ();
//---------------------------------------------------------------------
//   PARAMETER & INTEGER DECLARATION
//---------------------------------------------------------------------
integer i,j,t,p,patnumber=1;
integer lat_1,lat_2;
integer inst_1_cnt, inst_2_cnt;
integer pattern_stop;
parameter CPU_STOP_INST_NUM = 1000;
//---------------------------------------------------------------------
//  TASK VARIABLE
//---------------------------------------------------------------------
reg [3-1:0] op;
reg [3-1:0] rs;
reg [3-1:0] rt;
reg [3-1:0] rd;
reg [3-1:0] func;
reg [3-1:0] rl;
reg [7-1:0] imm;
reg [13-1:0] addr;
reg x; // dont care
reg [15:0] inst;
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
for(i=0;i<4;i=i+1)
	PC[i] = 0;
for(i=0;i<4;i=i+1)
	for(j=0;j<8;j=j+1)
		REG[i][j]=0;

rst_n=1'b1;
interrupt_1=1'b0;
interrupt_2=1'b0;
inst_1_cnt=-1;
inst_2_cnt=-1;
lat_1 = 0;
lat_2 = 0;

force clk = 0;
reset_signal_task;
// compute first CPU reg ans
CPU_compute(2'd0,0,`GET_INST1(PC[0]));
CPU_compute(2'd1,0,`GET_INST2(PC[1]));
CPU_compute(2'd2,1,`GET_INST1(PC[2]));
CPU_compute(2'd3,1,`GET_INST2(PC[3]));

pattern_stop = 0;
while(!pattern_stop) begin
  	wait_out_valid;
	@(negedge clk);
	compute_next_ans;
end
check_MEM_task;
YOU_PASS_task;
end

task reset_signal_task; begin
    #`CYCLE_TIME; rst_n = 0;
    #`CYCLE_TIME; rst_n = 1;

    if(stall_core1!==1'b1||stall_core2!==1) begin//out!==0
        $display("************************************************************");
        $display("*  Output signal should be 0 after initial RESET  at %8t   *",$time);
        $display("************************************************************");
        repeat(2) #`CYCLE_TIME;
        $finish;
    end
	#`CYCLE_TIME; release clk;
end endtask

task wait_out_valid; begin
	while(stall_core1!==0 && stall_core2!==0) begin
		lat_1=lat_1+1;
		lat_2=lat_2+1;
		if(lat_1>=1500  )begin//lat==max+1
	   		$display("********************************************************");
	   		$display("*  The execution latency (%4d,%4d) are over 1500 cycles  at %8t *",lat_1,lat_2,$time);//over max
	   		$display("********************************************************");
			repeat(2)@(negedge clk);
			$finish;
		end
	    @(negedge clk);
	end
    if( stall_core1==0 ) begin
	 	lat_1=-1;
		inst_1_cnt = inst_1_cnt + 1;
	end
	if( stall_core2==0 ) begin
		lat_2=-1;
		inst_2_cnt = inst_2_cnt + 1;
	end
	if( (inst_1_cnt == CPU_STOP_INST_NUM) ) interrupt_1 = 1'b1;
	if( (inst_2_cnt == CPU_STOP_INST_NUM) ) interrupt_2 = 1'b1;
	if( (inst_1_cnt == CPU_STOP_INST_NUM) && (inst_2_cnt == CPU_STOP_INST_NUM) ) pattern_stop = 1;
end endtask

 task compute_next_ans; begin
		if( inst_1_cnt < CPU_STOP_INST_NUM )begin
			$display("PC:%h",PC[0]);
			$display("instruction:%16b",`GET_INST1(PC[0]));
			CPU_compute(2'd0,0,`GET_INST1(PC[0]));
			CPU_compute(2'd1,0,`GET_INST2(PC[1]));
		end
		if( inst_2_cnt < CPU_STOP_INST_NUM ) begin
			$display("PC:%h",PC[3]);
			$display("instruction:%16b",`GET_INST1(PC[3]));
			CPU_compute(2'd2,1,`GET_INST1(PC[2]));
			CPU_compute(2'd3,1,`GET_INST2(PC[3]));
		end
end endtask


reg [12:0]addr_t0,addr_t1;
task CPU_compute(input [1:0] N,input N_MEM,input [15:0] inst); begin
	{op,rs,rt,rd,func} = inst[15:1];
	rl = inst[3:1];
	imm = inst[6:0];
	addr = inst[12:0];
	if(N==0) $display("rs %h rt %h rd %h func %h rl %h imm %h addr %h ",rs,rt,rd,func,rl,imm,addr);
	case( op )
		`R_TYPE:	begin
						 case(func)
						 `ADD_FUNC : REG[N][rd] = $signed(REG[N][rs]) + $signed(REG[N][rt]);
						 `SUB_FUNC :	REG[N][rd] = $signed(REG[N][rs]) - $signed(REG[N][rt]);
						 `AND_FUNC :	REG[N][rd] = REG[N][rs] & REG[N][rt];
						 `OR_FUNC :	REG[N][rd] = REG[N][rs] | REG[N][rt];
						 `NAND_FUNC :REG[N][rd] = ~(REG[N][rs] & REG[N][rt]);
						 `NOR_FUNC :	REG[N][rd] = ~(REG[N][rs] | REG[N][rt]);
						 `XOR_FUNC :	REG[N][rd] = REG[N][rs] ^ REG[N][rt];
						 `SLE_FUNC :	if ($signed(REG[N][rs]) < $signed(REG[N][rt])) REG[N][rd]=1; else REG[N][rd]=0;
						endcase
					end
		`M_TYPE:	begin 	{REG[N][rd],REG[N][rl]} = $signed(REG[N][rs]) * $signed(REG[N][rt]); end
		`ADDI_TYPE:	begin 	REG[N][rt] = $signed(REG[N][rs]) + $signed(imm); end
		`SUBI_TYPE:	begin 	REG[N][rt] = $signed(REG[N][rs]) - $signed(imm); end
		`LOAD_TYPE:	begin 	if (N==0 || N==1 ) 	REG[N][rt] = `GET_DATA(ans_mem[0],$signed(REG[N][rs]) + $signed(imm));
		 					else 				REG[N][rt] = `GET_DATA(ans_mem[1],$signed(REG[N][rs]) + $signed(imm));	end

		`STORE_TYPE:begin 	if (N==0 || N==1 )	`GET_DATA(ans_mem[0],$signed(REG[N][rs]) + $signed(imm)) = REG[N][rt];
							else				`GET_DATA(ans_mem[1],$signed(REG[N][rs]) + $signed(imm)) = REG[N][rt];
							end
	endcase
	case( op )
		`BEQ_TYPE:	begin 	if( REG[N][rs]== REG[N][rt] ) PC[N] = $signed(PC[N]) + $signed(1) + $signed(imm);else PC[N] = PC[N] + 2; end
		`J_TYPE:	PC[N] = inst[12:0];
		default:	PC[N] = PC[N] + 2;
	endcase
end endtask

task check_MEM_task; begin
	repeat(1500)@(negedge clk);
	for(i=0;i<32'h2000;i=i+2)begin
		if(`GET_DATA(DMEM,i) != `GET_DATA(ans_mem[0],i))begin
			$display ("--------------------------------------------------------------------");
			$display ("                         Error in Data Memory !     ");
			$display ("                           Adress = %d    ",i);
			$display ("                           YOURS      ANS    ");
			$display ("                  data       %d         %d     ",`GET_DATA(DMEM,i-4),`GET_DATA(ans_mem[0],i-4));
			$display ("                  data       %d         %d     ",`GET_DATA(DMEM,i-2),`GET_DATA(ans_mem[0],i-2));
			$display ("             *    data       %d         %d     ",`GET_DATA(DMEM,i),`GET_DATA(ans_mem[0],i));
			$display ("                  data       %d         %d     ",`GET_DATA(DMEM,i+2),`GET_DATA(ans_mem[0],i+2));
			$display ("                  data       %d         %d     ",`GET_DATA(DMEM,i+4),`GET_DATA(ans_mem[0],i+4));
			$display ("                  data       %d         %d     ",`GET_DATA(DMEM,i+6),`GET_DATA(ans_mem[0],i+6));
			$display ("--------------------------------------------------------------------");
			repeat(9)@(negedge clk);
			$finish;
		end
	end
end endtask

task YOU_PASS_task; begin
    $display ("--------------------------------------------------------------------");
    $display ("                         Congratulations!                           ");
    $display ("                  You have passed all patterns!                     ");
    $display ("--------------------------------------------------------------------");
    repeat(2)@(negedge clk);
    $finish;
end endtask

endmodule
