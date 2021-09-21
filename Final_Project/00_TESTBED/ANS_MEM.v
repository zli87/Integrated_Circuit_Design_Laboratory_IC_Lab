module ANS_MEM #(parameter ID_WIDTH=4, ADDR_WIDTH=32, DATA_WIDTH=16);

    parameter DRAM_p_r = "../00_TESTBED/DRAM/data_file.dat";
    reg	[7:0]	DRAM_r	[0:8*1024-1];

initial  $readmemh(DRAM_p_r,DRAM_r);

endmodule
