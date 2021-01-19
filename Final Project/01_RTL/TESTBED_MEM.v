`timescale 1 ns/ 1 ps
`define CYCLE_TIME 10.0
//`define ONE_SRAM_CACHE
`ifdef WRITE_FILE
    `define FILE_OP "w"
`else
    `define FILE_OP "a"
`endif
/*`ifdef FOUR_SRAM_CACHE
    `define FOUR_CACHE
    `define THREE_CACHE
    `define TWO_CACHE
`elsif THREE_SRAM_CACHE
    `define THREE_CACHE
    `define TWO_CACHE
`elsif TWO_SRAM_CACHE
    `define TWO_CACHE
`endif*/
`define RANDOM_INPUT(n) ADDR_OFFSET=$signed($random(SEED) & 8'hfe);\
                        if( $random(SEED) & 1'b1 ) i_addr[n]=i_addr[n]+ ADDR_OFFSET;\
                        else  i_addr[n]=i_addr[n] - ADDR_OFFSET;\
                        i_rw=$random(SEED) & 1'h1;\
                        i_data[n]=$random(SEED) & 16'hffff;
                        //$display("%h,%h",i_addr[n],temp);
`define INIT_INPUT(n,address) i_addr[n]=(address);\
                                i_rw=0;\
                                i_data[n]=0;
`define ADJUST_ADDR if ( i_addr[0] < 0 ) i_addr[0] = 0;\
                  else if ( i_addr[0] > 'h2000 ) i_addr[0] = 'h1ffe;\
                  if ( i_addr[1] < 0 ) i_addr[1] = 0;\
                  else if ( i_addr[1] > 'h2000 ) i_addr[1] = 'h1ffe;
module TESTBD   ();

integer handle1,desc1;

parameter Instruction_NUM = 10000;
parameter Load_Store_ratio = (2/15.0);
parameter CPU_CYCLE = 6;
integer miss,pat,i,j,k,x,SEED=300,PAT_NUM;
reg clk;

`ifdef FOUR_SRAM_CACHE
parameter SRAM_NUM=4;
`elsif FIVE_SRAM_CACHE
parameter SRAM_NUM=5;
`elsif THREE_SRAM_CACHE
parameter SRAM_NUM=3;
`elsif TWO_SRAM_CACHE
parameter SRAM_NUM=2;
`elsif ONE_SRAM_CACHE
parameter SRAM_NUM=1;
`endif
// input signal
reg [7:0] DRAM [8*1024-1:0];
reg [13+1-1:0]  i_addr[1:0];
reg [16-1:0] i_data[1:0];
reg i_rw;
reg signed [7:0] ADDR_OFFSET;
reg [4-1:0] i_bank [1:0];

// compute variable
// SRAM 256W 16B
// CPU 0    CPU 1
// BANK 00  BANK 10
// BANK 01  BANK 11
reg [2:0] cache_temp;
// 4 sram cache
reg [3+1:0] BANK[SRAM_NUM-1:0];  // 4 bank
reg [SRAM_NUM-1:0] ADDR_HIT_BANK[1:0]; //4 * 2 = 8 hit count
reg [2:0] cache [SRAM_NUM-1:0];

real DRAM_miss_penalty=356.0,DRAM_hit_penalty=1;
real total_time,total_area,CPU_excute_time;
real miss_rate;
// always block for 4 sram cache
always@(posedge clk)begin
  for(i=0;i<2;i=i+1)begin // cpu i addr i
    i_bank[i] = i_addr[i][12:9];
    for(j=0;j<SRAM_NUM;j=j+1)begin // sram j
      ADDR_HIT_BANK[i][j] = (BANK[j]==i_bank[i]) ? 1 : 0;
    end
  end
end

always #(`CYCLE_TIME/2.0) clk = ~clk;

initial begin

force clk = 0;
release clk;

init_task;
 @(posedge clk);

for(pat=0;pat<PAT_NUM;pat=pat+1) begin
	`RANDOM_INPUT(0)
	`RANDOM_INPUT(1)
     @(posedge clk);
    // $display("%h,%h,%h,%h",i_bank[0],i_bank[1],i_addr[0],i_addr[1]);
    cache_compute;
end
YOU_PASS_task;
end

task init_task; begin
    handle1=$fopen("SA.log",`FILE_OP);
    desc1=handle1|1;
    $fsdbDumpfile("CPU_MEM.fsdb");
    $fsdbDumpvars(0,"+mda");
    miss = 0;
    PAT_NUM=Instruction_NUM*Load_Store_ratio;
    `INIT_INPUT(0,13'h1000)
    `INIT_INPUT(1,13'h1000)
    //$display("%h,%h",i_addr[0],i_addr[1]);
    for(j=0;j<SRAM_NUM;j=j+1)begin // sram j
        BANK[j] = 5'h10; // initial a out of range bank
        cache[j] = SRAM_NUM-1-j;
    end
    //$display("cache [%d, %d, %d, %d, %d]",cache[0],cache[1],cache[2],cache[3],cache[4]);
end endtask

task cache_compute; begin
    // CPU 0
    cpu_check_hit_task2(0);
    @(posedge clk);
    // CPU 1
    cpu_check_hit_task2(1);
    @(posedge clk);
    // cpu 0 miss
    if(ADDR_HIT_BANK[0]==0)begin
        //$display("cache miss 0");
        miss = miss + 1;
        cache_temp = cache[SRAM_NUM-1];
        for(i=SRAM_NUM-1;i>0;i=i-1)
            cache[i] = cache[i-1];
        cache[0] = cache_temp;
        BANK[cache_temp] = i_bank[0];
        @(posedge clk);
        cpu_check_hit_task2(1);
    end
    @(posedge clk);
    // cpu 1 miss
    if(ADDR_HIT_BANK[1]==0)begin
        //$display("cache miss 1");
        miss = miss + 1;
        cache_temp = cache[SRAM_NUM-1];
        for(i=SRAM_NUM-1;i>0;i=i-1)
            cache[i] = cache[i-1];
        cache[0] = cache_temp;
        BANK[cache_temp] = i_bank[1];
        @(posedge clk);
        cpu_check_hit_task2(0);
    end
    //$display("cache [%1h, %1h, %1h, %1h, %1h], BANK [%1h, %1h, %1h, %1h, %1h]",
    //    BANK[cache[0]],BANK[cache[1]],BANK[cache[2]],BANK[cache[3]],BANK[cache[4]],
    //    BANK[0],BANK[1],BANK[2],BANK[3],BANK[4]
    //);
    @(posedge clk);
`ifndef ONE_SRAM_CACHE
    if(ADDR_HIT_BANK[0]==0 || ADDR_HIT_BANK[1]==0) begin
        $display("Cache does not load data from DRAM!");
        $finish;
    end
`endif
end endtask

task cpu_check_hit_task2(input N); begin
    if(ADDR_HIT_BANK[N]!=0) begin // cpu 0 hit
        for(i=0;i<SRAM_NUM;i=i+1)begin
            if (ADDR_HIT_BANK[N][cache[i]]) begin// hit the second
               cache_temp = cache[i];
               for(j=i;j>0;j=j-1)
                    cache[j] = cache[j-1];
               cache[0] = cache_temp;
           end // end if
        end // end for
    end // end of if(ADDR_HIT_BANK[N]!=0) begin // cpu 0 hit
end endtask
/*
task cpu_check_hit_task(input N); begin
    if(ADDR_HIT_BANK[N]!=0) begin // cpu 0 hit
        if(ADDR_HIT_BANK[N][cache[0]])begin
        end
`ifdef TWO_CACHE
         else if (ADDR_HIT_BANK[N][cache[1]]) begin// hit the second
            cache_temp = cache[1];
            cache[1] = cache[0];
            cache[0] = cache_temp;
        end
`endif
`ifdef THREE_CACHE
         else if(ADDR_HIT_BANK[N][cache[2]])begin
            cache_temp = cache[2];
            cache[2] = cache[1];
            cache[1] = cache[0];
            cache[0] = cache_temp;
        end
`endif
`ifdef FOUR_CACHE
        else if(ADDR_HIT_BANK[N][cache[3]])begin
            cache_temp = cache[3];
            cache[3] = cache[2];
            cache[2] = cache[1];
            cache[1] = cache[0];
            cache[0] = cache_temp;
        end
`endif
    end // end of if(ADDR_HIT_BANK[N]!=0) begin // cpu 0 hit
end endtask
*/
task YOU_PASS_task; begin
    miss_rate = miss/(2.0*PAT_NUM);
    CPU_excute_time = (CPU_CYCLE*Instruction_NUM);
    total_time = (CPU_CYCLE*Instruction_NUM) + Instruction_NUM*Load_Store_ratio*(DRAM_hit_penalty + miss_rate*DRAM_miss_penalty);
    total_area = (SRAM_NUM+2)*76136 + 13000;
    $fdisplay(handle1,"--------------------------------------------------------------------");
    $fdisplay(handle1,"   num of data sram   %d",SRAM_NUM);
    $fdisplay(handle1,"   total miss %d in %d pair Instruction",miss,PAT_NUM);
    $fdisplay(handle1,"   miss rate =            %.4f    ",miss_rate);
    $fdisplay(handle1,"   DRAM delay time :  %10d ",DRAM_miss_penalty);
    $fdisplay(handle1,"   CPU excute time :  %10d ",CPU_excute_time);
    $fdisplay(handle1,"   total time :       %10d ",total_time);
    $fdisplay(handle1,"   SRAM AREA :        %10d ",total_area);
    $fdisplay(handle1,"   total score (time^1.5*area)  %f",((total_time**1.5)/10000.0)*(total_area/10000.0));
    $fdisplay(handle1,"--------------------------------------------------------------------");
    $fclose(handle1);
    repeat(2)@(posedge clk);
    $finish;
end endtask

endmodule
