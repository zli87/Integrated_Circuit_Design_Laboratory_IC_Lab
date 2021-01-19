//############################################################################
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//   (C) Copyright Laboratory System Integration and Silicon Implementation
//   All Right Reserved
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   2018 ICLAB fall Course
//   Lab03	    : Candy Crush
//   Author         : Yi Syuan Chen
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//
//   File Name   : PATTERN.v
//   Module Name : PATTERN
//   Release version : v1.0
//
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//############################################################################

`ifdef RTL
	`timescale 1ns/10ps
	`include "CC.v"
	`define CYCLE_TIME 10.0
`endif
`ifdef GATE
	`timescale 1ns/1ps
	`include "CC_SYN.v"
	`define CYCLE_TIME 10.0
`endif

module PATTERN(
  // Output signals
  output reg clk,
  output reg rst_n,
  output reg in_valid_1,
  output reg in_valid_2,
  output reg[2:0] in_color,
  output reg in_stripe,
  output reg[1:0] in_action,
  output reg[5:0] in_starting_pos,
  // input signals
  input out_valid,
  input [6:0] out_score
);

// Input signals
// Output signals
//output reg           clk, rst_n, in_valid;
//output reg   [7:0]   maze;
//input         out_valid;
//input [2:0]   out_row, out_col;
real CYCLE=`CYCLE_TIME;
integer SEED=125,x,lat,t,p,i;
integer pat_delay;
parameter patnumber=8;

//reg,parameter
integer in,in2,in3,in4, ans;
integer  f_color,f_stripe,f_start_pos,f_action,  f_ans;
integer nothing, ans_out_score;
initial clk = 0;
always #(CYCLE/2.0) clk = ~clk;

initial begin
  f_color  = $fopen("../00_TESTBED/color_iclab134.txt", "r");
  f_stripe  = $fopen("../00_TESTBED/stripe_iclab134.txt", "r");
  f_start_pos  = $fopen("../00_TESTBED/start_pos_iclab134.txt", "r");
  f_action  = $fopen("../00_TESTBED/action_iclab134.txt", "r");
  f_ans = $fopen("../00_TESTBED/ans_iclab134.txt", "r");
  rst_n=1'b0;
  in_valid_1=1'b0;
  in_valid_2=1'b0;
  //in=x
  //maze='bx;
  in_action = 'bx;
  in_color = 'bx;
  in_starting_pos = 'bx;

  force clk = 0;
  reset_signal_task;
  for (p=0; p<patnumber; p=p+1)
	begin
		input_task;
		compute_ans;
        wait_out_valid;
        check_ans;
    end
  YOU_PASS_task;

end

task reset_signal_task; begin
    #CYCLE; rst_n = 0;
    #CYCLE; rst_n = 1;
    if(out_valid!==1'b0||out_score!==0) begin//out!==0
        $display("************************************************************");
		$display("*                   SPEC 3 IS FAIL                         *");
        $display("*  Output signal should be 0 after initial RESET  at %8t   *",$time);
        $display("************************************************************");
        repeat(2) #CYCLE;
        $finish;
    end
	#CYCLE; release clk;
end endtask

task input_task; begin
	//t= $random(SEED) %3'd3+1;
	t = 2;
	repeat(t) @(negedge clk);
	in_valid_1=1'b1;
	in_stripe=1'b1;
	//in=?
	// **********************************************************
	// *	in_starting_pos
	// **********************************************************
	for(i=0; i<4; i=i+1) begin
		//in =$fscanf(f_in,"%8b",ma);
		//in = $random(SEED)%'d6;
		//in2 = $random(SEED)%'d6;
		//in3 = $random(SEED)%'d6;
		nothing = $fscanf(f_start_pos,"%d %d",in,in2);
		nothing = $fscanf(f_color,"%d",in3);
		nothing = $fscanf(f_stripe,"%d",in4);
		in_starting_pos={in[2:0],in2[2:0]}; // x [5:3] , y [2:0]
		in_color={in3[2:0]};
		in_stripe={in4[0]};
		@(negedge clk);
	end
	in_stripe = 'bx;
	in_starting_pos = 'bx;
	// **********************************************************
	// *	in_color
	// **********************************************************
	for(i=0; i<32; i=i+1) begin
		//in =$fscanf(f_in,"%8b",ma);
		nothing = $fscanf(f_color,"%d ",in3);
		in_color={in3[2:0]}; // x [5:3] , y [2:0]
		@(negedge clk);
	end
	in_valid_1=1'b0;
	in_color = 'bx;
	// delay 2 cycle
	for(i=0;i<2;i=i+1) @(negedge clk);
	// **********************************************************
	// *	in_action & in_starting_pos
	// **********************************************************
	in_valid_2=1'b1;
	for(i=0; i<10; i=i+1) begin
		//in =$fscanf(f_in,"%8b",ma);
		nothing = $fscanf(f_action,"%d",in3);
		nothing = $fscanf(f_start_pos,"%d %d",in,in2);
		in_action={in3[1:0]};
		in_starting_pos={in[2:0],in2[2:0]}; // x [5:3] , y [2:0]
		@(negedge clk);
	end
	in_valid_2=1'b0;
	in_action = 'bx;
	in_starting_pos = 'bx;
	//in=x
	//maze='bx;
end endtask

task compute_ans; begin
//cmp
	//for(i=0;i<15;i=i+1) begin
	nothing = $fscanf(f_ans,"%d",ans_out_score);
	//end
	//ans_out_score = 7'd4;
end endtask


task wait_out_valid; begin
    lat=-1;
    while(out_valid!==1) begin
	lat=lat+1;
      if(lat==500)begin//lat==max+1
          $display("********************************************************");
		  $display("*                   SPEC 5 IS FAIL                         *");
          $display("*  The execution latency are over 500 cycles  at %8t   *",$time);//over max
          $display("********************************************************");
	    repeat(2)@(negedge clk);
	    $finish;
      end
     @(negedge clk);
   end
end endtask

task check_ans; begin
	x=1;
	while(out_valid)
	begin
		if(x>1)//x>max
			begin
				$display ("--------------------------------------------------------------------------------------------------------------------------------------------");
				$display ("                                                               SPEC 4 IS FAIL                                                               ");
				$display ("                                                           Outvalid is more than 1 cycles                                                  ");//than max
				$display ("--------------------------------------------------------------------------------------------------------------------------------------------");
				repeat(9) @(negedge clk);
				$finish;
			end

		if(ans_out_score!==out_score)//check ans
				begin
					$display ("------------------------------------------------------------------------------------------------------------------------------------------");
					$display ("                                                                 SPEC 6 IS FAIL                                                           ");
					$display ("                                                                 Ans:          ( %1d)                                                   ",ans_out_score);//show ans
					$display ("                                                                 Your output : ( %d) at %8t                                ",out_score,$time);//show output
					$display ("------------------------------------------------------------------------------------------------------------------------------------------");
					repeat(9) @(negedge clk);
					$finish;
				end
		@(negedge clk);
		x=x+1;
	end
	/*
    if(x<16) begin//x<max+1
    $display ("---------------------------------------------------");
    $display ("                    FAIL!                          ");
    $display ("          Outvalid is less than 15 cycles.         ");//than max
    $display ("---------------------------------------------------");
    repeat(2) @(negedge clk);
    $finish;
    end
	*/
	$display("\033[0;34mPASS PATTERN NO.%4d,\033[m \033[0;32mexecution cycle : %3d\033[m",p ,lat);
	@(negedge clk);

end endtask

task YOU_PASS_task; begin
    $display ("--------------------------------------------------------------------");
    $display ("                         Congratulations!                           ");
    $display ("                  You have passed all patterns!                     ");
    $display ("--------------------------------------------------------------------");
    repeat(2)@(negedge clk);
    $finish;
end endtask

always @ (negedge clk) begin
	if ((out_valid==0 )&& (out_score!=0)) begin
		$display("************************************************************");
		$display("*                   SPEC 7 IS FAIL                         *");
		$display("*  Output signal should be 0 after out_valid pull pulled down at %8t   *",$time);
		$display("************************************************************");
		repeat(9) @(negedge clk);
		$finish;
	end
end

endmodule
