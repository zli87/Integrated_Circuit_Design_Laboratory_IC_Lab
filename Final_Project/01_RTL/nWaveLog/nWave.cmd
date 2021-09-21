wvResizeWindow -win $_nWave1 1920 23 1920 1017
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/RAID2/COURSE/iclab/iclab134/ICLAB_FP_2019F/01_RTL/CPU2.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvSetPosition -win $_nWave1 {("G1" 11)}
wvSetPosition -win $_nWave1 {("G1" 11)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/BASE_ADDR\[15:0\]} \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 7 8 9 10 11 )} 
wvSetPosition -win $_nWave1 {("G1" 11)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 11 )} 
wvSelectGroup -win $_nWave1 {G2}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_PATTERN"
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/BASE_ADDR\[15:0\]} \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 2 )} 
wvSetPosition -win $_nWave1 {("G2" 2)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 422095.833333 -snap {("G3" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 36032.571138 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 135894.268293 -snap {("G3" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 266641.026423 -snap {("G3" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectGroup -win $_nWave1 {G3}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvSetPosition -win $_nWave1 {("G3" 1)}
wvSetPosition -win $_nWave1 {("G3" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/ci_1/SRAM_REFRESH} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSetPosition -win $_nWave1 {("G3" 1)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 396358.282520 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvSetPosition -win $_nWave1 {("G3" 3)}
wvSetPosition -win $_nWave1 {("G3" 3)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/ci_1/SRAM_REFRESH} \
{/TESTBED/ci_1/ADDR_OFFSET\[7:0\]} \
{/TESTBED/ci_1/BASE_ADDR_HEAD\[4:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 2 3 )} 
wvSetPosition -win $_nWave1 {("G3" 3)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSetCursor -win $_nWave1 129717.256098 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 3553841.016260 -snap {("G1" 1)}
wvSelectGroup -win $_nWave1 {G3}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvSetPosition -win $_nWave1 {("G3" 5)}
wvSetPosition -win $_nWave1 {("G3" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/ci_1/SRAM_REFRESH} \
{/TESTBED/ci_1/ADDR_OFFSET\[7:0\]} \
{/TESTBED/ci_1/BASE_ADDR_HEAD\[4:0\]} \
{/TESTBED/ci_1/s_c\[2:0\]} \
{/TESTBED/ci_1/s_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 4 5 )} 
wvSetPosition -win $_nWave1 {("G3" 5)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 3562077.032520 -snap {("G3" 4)}
wvSetCursor -win $_nWave1 3582667.073171 -snap {("G3" 4)}
wvSetCursor -win $_nWave1 3545605.000000 -snap {("G3" 4)}
wvSetCursor -win $_nWave1 3529132.967480 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3553841.016260 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 980085.934959 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSetCursor -win $_nWave1 1626613.211382 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1770743.495935 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1482482.926829 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1284818.536585 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1132452.235772 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 975967.926829 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1041856.056911 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1017148.008130 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1008911.991870 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 996557.967480 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3347940.609756 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3541486.991870 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3557959.024390 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3549723.008130 -snap {("G1" 3)}
wvZoom -win $_nWave1 3446772.804878 3689735.284553
wvSetCursor -win $_nWave1 3549488.649944 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 3539612.126380 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 3549817.867396 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 3500106.032124 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3559529.782234 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3569241.697072 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3559858.999686 -snap {("G3" 4)}
wvSetCursor -win $_nWave1 3550640.911026 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3514756.208744 -snap {("G4" 0)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3559975.203946 -snap {("G3" 4)}
wvSetCursor -win $_nWave1 3570180.944962 -snap {("G3" 4)}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetCursor -win $_nWave1 989895.884158 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 999278.581544 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 990389.710336 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 999443.190270 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1009484.322560 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 990225.101610 -snap {("G1" 2)}
wvSelectGroup -win $_nWave1 {G4}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvSetPosition -win $_nWave1 {("G4" 4)}
wvSetPosition -win $_nWave1 {("G4" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/ci_1/SRAM_REFRESH} \
{/TESTBED/ci_1/ADDR_OFFSET\[7:0\]} \
{/TESTBED/ci_1/BASE_ADDR_HEAD\[4:0\]} \
{/TESTBED/ci_1/s_c\[2:0\]} \
{/TESTBED/ci_1/s_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/ci_1/BRG_i_addr\[31:0\]} \
{/TESTBED/ci_1/BRG_i_valid} \
{/TESTBED/ci_1/BRG_o_data\[15:0\]} \
{/TESTBED/ci_1/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 2 3 4 )} 
wvSetPosition -win $_nWave1 {("G4" 4)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 39341.485530 -snap {("G4" 2)}
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetCursor -win $_nWave1 981876.823525 -snap {("G4" 3)}
wvSetCursor -win $_nWave1 989942.651102 -snap {("G4" 3)}
wvSelectGroup -win $_nWave1 {G5}
wvSelectGroup -win $_nWave1 {G5}
wvSelectGroup -win $_nWave1 {G4}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1/bridge_1"
wvSelectGroup -win $_nWave1 {G5}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1/bridge_1"
wvSetPosition -win $_nWave1 {("G5" 25)}
wvSetPosition -win $_nWave1 {("G5" 25)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/ci_1/SRAM_REFRESH} \
{/TESTBED/ci_1/ADDR_OFFSET\[7:0\]} \
{/TESTBED/ci_1/BASE_ADDR_HEAD\[4:0\]} \
{/TESTBED/ci_1/s_c\[2:0\]} \
{/TESTBED/ci_1/s_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/ci_1/BRG_i_addr\[31:0\]} \
{/TESTBED/ci_1/BRG_i_valid} \
{/TESTBED/ci_1/BRG_o_data\[15:0\]} \
{/TESTBED/ci_1/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/ci_1/bridge_1/araddr_M_inf\[31:0\]} \
{/TESTBED/ci_1/bridge_1/arburst_M_inf\[1:0\]} \
{/TESTBED/ci_1/bridge_1/arid_M_inf\[3:0\]} \
{/TESTBED/ci_1/bridge_1/arlen_M_inf\[7:0\]} \
{/TESTBED/ci_1/bridge_1/arready_M_inf} \
{/TESTBED/ci_1/bridge_1/arsize_M_inf\[2:0\]} \
{/TESTBED/ci_1/bridge_1/arvalid_M_inf} \
{/TESTBED/ci_1/bridge_1/bid_m_inf_inst_1\[3:0\]} \
{/TESTBED/ci_1/bridge_1/bready_M_inf} \
{/TESTBED/ci_1/bridge_1/bresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/ci_1/bridge_1/bvalid_M_inf} \
{/TESTBED/ci_1/bridge_1/clk} \
{/TESTBED/ci_1/bridge_1/i_ADDR\[31:0\]} \
{/TESTBED/ci_1/bridge_1/in_valid} \
{/TESTBED/ci_1/bridge_1/o_DATA\[15:0\]} \
{/TESTBED/ci_1/bridge_1/out_valid} \
{/TESTBED/ci_1/bridge_1/rdata_m_inf_inst_1\[15:0\]} \
{/TESTBED/ci_1/bridge_1/rid_m_inf_inst_1\[3:0\]} \
{/TESTBED/ci_1/bridge_1/rlast_M_inf} \
{/TESTBED/ci_1/bridge_1/rready_M_inf} \
{/TESTBED/ci_1/bridge_1/rresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/ci_1/bridge_1/rst_n} \
{/TESTBED/ci_1/bridge_1/rvalid_m_inf_inst_1} \
{/TESTBED/ci_1/bridge_1/state_c\[2:0\]} \
{/TESTBED/ci_1/bridge_1/state_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 23 24 25 )} 
wvSetPosition -win $_nWave1 {("G5" 25)}
wvGetSignalClose -win $_nWave1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 39176.876804 -snap {("G5" 14)}
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 15 )} 
wvSelectSignal -win $_nWave1 {( "G5" 16 )} 
wvSelectSignal -win $_nWave1 {( "G5" 17 )} 
wvSetCursor -win $_nWave1 31604.875405 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 40493.746613 -snap {("G5" 14)}
wvSelectSignal -win $_nWave1 {( "G5" 20 )} 
wvSelectSignal -win $_nWave1 {( "G5" 21 )} 
wvSelectSignal -win $_nWave1 {( "G5" 20 )} 
wvSelectSignal -win $_nWave1 {( "G5" 19 )} 
wvSelectSignal -win $_nWave1 {( "G5" 20 )} 
wvSelectSignal -win $_nWave1 {( "G5" 21 )} 
wvSelectSignal -win $_nWave1 {( "G5" 23 )} 
wvSelectSignal -win $_nWave1 {( "G5" 22 )} 
wvSelectSignal -win $_nWave1 {( "G5" 21 )} 
wvSelectSignal -win $_nWave1 {( "G5" 19 )} 
wvSelectSignal -win $_nWave1 {( "G5" 18 )} 
wvSelectSignal -win $_nWave1 {( "G5" 17 )} 
wvSelectSignal -win $_nWave1 {( "G5" 16 )} 
wvSelectSignal -win $_nWave1 {( "G5" 15 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 12 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 16 )} 
wvSelectSignal -win $_nWave1 {( "G5" 17 )} 
wvSelectSignal -win $_nWave1 {( "G5" 19 )} 
wvSelectSignal -win $_nWave1 {( "G5" 20 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 21 )} 
wvSelectSignal -win $_nWave1 {( "G5" 22 )} 
wvSelectSignal -win $_nWave1 {( "G5" 23 )} 
wvSelectSignal -win $_nWave1 {( "G5" 24 )} 
wvSelectSignal -win $_nWave1 {( "G5" 17 )} 
wvSelectSignal -win $_nWave1 {( "G5" 16 )} 
wvSelectSignal -win $_nWave1 {( "G5" 15 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 11 )} 
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvSetCursor -win $_nWave1 119505.935125 -snap {("G5" 12)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 5 )} 
wvSetCursor -win $_nWave1 69629.491126 -snap {("G5" 7)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3581885.879220 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3550281.003815 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3581885.879220 -snap {("G1" 3)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvZoomIn -win $_nWave1
wvSetCursor -win $_nWave1 3548964.134005 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3558182.222665 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3568717.181133 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3559499.092473 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3546988.829292 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3529869.521781 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 990302.093181 -snap {("G5" 15)}
wvSetCursor -win $_nWave1 996886.442224 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1018614.794065 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1039684.711002 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1058779.323225 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1091042.633534 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1160178.298483 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1220095.874771 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1326103.894358 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1362976.248997 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1391288.949881 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1430136.609233 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1448572.786552 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1455683.883518 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1497823.717391 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1520210.504136 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1543255.725785 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1561033.468201 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1576835.905903 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1598564.257744 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1641362.526521 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 1688111.404724 -snap {("G1" 2)}
wvSetCursor -win $_nWave1 1670333.662309 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 1678893.316065 -snap {("G1" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetRadix -win $_nWave1 -format Hex
wvSetCursor -win $_nWave1 1100787.470117 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1146877.913416 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1170581.569969 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1188359.312385 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1211404.534034 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1233791.320779 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1254861.237716 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1266054.631088 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1291733.592355 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1307536.030057 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 1320046.293238 -snap {("G5" 17)}
wvSetCursor -win $_nWave1 980325.308837 -snap {("G5" 15)}
wvSetCursor -win $_nWave1 927650.516496 -snap {("G5" 8)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectGroup -win $_nWave1 {G6}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 978434.267743 -snap {("G5" 15)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvGetSignalOpen -win $_nWave1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 32921.745213 -snap {("G1" 6)}
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 979751.137551 -snap {("G4" 3)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSetCursor -win $_nWave1 36872.354639 -snap {("G4" 2)}
wvSelectGroup -win $_nWave1 {G3}
wvSetPosition -win $_nWave1 {("G3" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvSetPosition -win $_nWave1 {("G3" 2)}
wvSetPosition -win $_nWave1 {("G3" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/ci_1/ADDR_HEAD\[3:0\]} \
{/TESTBED/ci_1/BASE_ADDR_HEAD\[3:0\]} \
{/TESTBED/ci_1/SRAM_REFRESH} \
{/TESTBED/ci_1/ADDR_OFFSET\[7:0\]} \
{/TESTBED/ci_1/s_c\[2:0\]} \
{/TESTBED/ci_1/s_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/ci_1/BRG_i_addr\[31:0\]} \
{/TESTBED/ci_1/BRG_i_valid} \
{/TESTBED/ci_1/BRG_o_data\[15:0\]} \
{/TESTBED/ci_1/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/ci_1/bridge_1/araddr_M_inf\[31:0\]} \
{/TESTBED/ci_1/bridge_1/arburst_M_inf\[1:0\]} \
{/TESTBED/ci_1/bridge_1/arid_M_inf\[3:0\]} \
{/TESTBED/ci_1/bridge_1/arlen_M_inf\[7:0\]} \
{/TESTBED/ci_1/bridge_1/arready_M_inf} \
{/TESTBED/ci_1/bridge_1/arsize_M_inf\[2:0\]} \
{/TESTBED/ci_1/bridge_1/arvalid_M_inf} \
{/TESTBED/ci_1/bridge_1/bid_m_inf_inst_1\[3:0\]} \
{/TESTBED/ci_1/bridge_1/bready_M_inf} \
{/TESTBED/ci_1/bridge_1/bresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/ci_1/bridge_1/bvalid_M_inf} \
{/TESTBED/ci_1/bridge_1/clk} \
{/TESTBED/ci_1/bridge_1/i_ADDR\[31:0\]} \
{/TESTBED/ci_1/bridge_1/in_valid} \
{/TESTBED/ci_1/bridge_1/o_DATA\[15:0\]} \
{/TESTBED/ci_1/bridge_1/out_valid} \
{/TESTBED/ci_1/bridge_1/rdata_m_inf_inst_1\[15:0\]} \
{/TESTBED/ci_1/bridge_1/rid_m_inf_inst_1\[3:0\]} \
{/TESTBED/ci_1/bridge_1/rlast_M_inf} \
{/TESTBED/ci_1/bridge_1/rready_M_inf} \
{/TESTBED/ci_1/bridge_1/rresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/ci_1/bridge_1/rst_n} \
{/TESTBED/ci_1/bridge_1/rvalid_m_inf_inst_1} \
{/TESTBED/ci_1/bridge_1/state_c\[2:0\]} \
{/TESTBED/ci_1/bridge_1/state_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G3" 1 2 )} 
wvSetPosition -win $_nWave1 {("G3" 2)}
wvGetSignalClose -win $_nWave1
wvZoom -win $_nWave1 15802.437702 154073.767599
wvSetCursor -win $_nWave1 34632.070026 -snap {("G3" 1)}
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 68731.503686 -snap {("G5" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 35317.270576 -snap {("G3" 1)}
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 30071.203859 -snap {("G3" 4)}
wvSetCursor -win $_nWave1 34755.192000 -snap {("G3" 3)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectGroup -win $_nWave1 {G3}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/ci_1"
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvScrollDown -win $_nWave1 9
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G4" 3 )} 
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 44966.286145 -snap {("G5" 12)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 40188.618242 -snap {("G1" 5)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetCursor -win $_nWave1 989932.873782 -snap {("G5" 17)}
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3182581.294348 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3150355.455944 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3095646.474468 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 2954752.111213 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 2918779.082297 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 2688996.568469 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 2656021.291962 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 2643280.844221 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 2627542.644070 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3568694.542787 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3570942.857094 -snap {("G1" 3)}
wvSetCursor -win $_nWave1 3582184.428630 -snap {("G1" 3)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvZoom -win $_nWave1 3527475.447154 3610663.076522
wvSetCursor -win $_nWave1 3569520.143297 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3559657.111360 -snap {("G1" 1)}
wvSetCursor -win $_nWave1 3569971.024757 -snap {("G1" 1)}
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 3579439.535417 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3469424.459180 -snap {("G4" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 1793417.174797 -snap {("G5" 4)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 1473429.878049 -snap {("G5" 2)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvZoom -win $_nWave1 3437818.292683 3726838.414634
wvSetCursor -win $_nWave1 3604259.419822 -snap {("G1" 6)}
wvScrollDown -win $_nWave1 6
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3595252.017647 -snap {("G3" 6)}
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSetCursor -win $_nWave1 3605434.298366 -snap {("G3" 3)}
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3551194.072228 -snap {("G5" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3600281.322295 -snap {("G1" 5)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3580700.013220 -snap {("G1" 3)}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetCursor -win $_nWave1 3599498.069932 -snap {("G4" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSetCursor -win $_nWave1 3605795.340489 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 3610299.041576 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3599725.134675 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3610299.041576 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3630663.603014 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3619306.443751 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 3630663.603014 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 3620089.696114 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3629880.350651 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3619893.883023 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3630271.976833 -snap {("G1" 9)}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 3619502.256841 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3629880.350651 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3636929.621918 -snap {("G5" 9)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvZoom -win $_nWave1 3444476.355014 3699155.792683
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectGroup -win $_nWave1 {G2}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_PATTERN"
wvSetPosition -win $_nWave1 {("G2" 1)}
wvSetPosition -win $_nWave1 {("G2" 1)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/ci_1/SRAM_A\[7:0\]} \
{/TESTBED/ci_1/SRAM_D\[15:0\]} \
{/TESTBED/ci_1/SRAM_Q\[15:0\]} \
{/TESTBED/ci_1/SRAM_WEN} \
{/TESTBED/ci_1/clk} \
{/TESTBED/ci_1/i_addr\[12:0\]} \
{/TESTBED/ci_1/i_valid} \
{/TESTBED/ci_1/o_data\[15:0\]} \
{/TESTBED/ci_1/o_valid} \
{/TESTBED/ci_1/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/u_PATTERN/inst_1_o_data\[15:0\]} \
{/TESTBED/u_PATTERN/PC_ans_1\[12:0\]} \
{/TESTBED/u_PATTERN/inst_1_ans\[31:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/ci_1/ADDR_HEAD\[3:0\]} \
{/TESTBED/ci_1/BASE_ADDR_HEAD\[3:0\]} \
{/TESTBED/ci_1/SRAM_REFRESH} \
{/TESTBED/ci_1/ADDR_OFFSET\[7:0\]} \
{/TESTBED/ci_1/s_c\[2:0\]} \
{/TESTBED/ci_1/s_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/ci_1/BRG_i_addr\[31:0\]} \
{/TESTBED/ci_1/BRG_i_valid} \
{/TESTBED/ci_1/BRG_o_data\[15:0\]} \
{/TESTBED/ci_1/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/ci_1/bridge_1/araddr_M_inf\[31:0\]} \
{/TESTBED/ci_1/bridge_1/arburst_M_inf\[1:0\]} \
{/TESTBED/ci_1/bridge_1/arid_M_inf\[3:0\]} \
{/TESTBED/ci_1/bridge_1/arlen_M_inf\[7:0\]} \
{/TESTBED/ci_1/bridge_1/arready_M_inf} \
{/TESTBED/ci_1/bridge_1/arsize_M_inf\[2:0\]} \
{/TESTBED/ci_1/bridge_1/arvalid_M_inf} \
{/TESTBED/ci_1/bridge_1/bid_m_inf_inst_1\[3:0\]} \
{/TESTBED/ci_1/bridge_1/bready_M_inf} \
{/TESTBED/ci_1/bridge_1/bresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/ci_1/bridge_1/bvalid_M_inf} \
{/TESTBED/ci_1/bridge_1/clk} \
{/TESTBED/ci_1/bridge_1/i_ADDR\[31:0\]} \
{/TESTBED/ci_1/bridge_1/in_valid} \
{/TESTBED/ci_1/bridge_1/o_DATA\[15:0\]} \
{/TESTBED/ci_1/bridge_1/out_valid} \
{/TESTBED/ci_1/bridge_1/rdata_m_inf_inst_1\[15:0\]} \
{/TESTBED/ci_1/bridge_1/rid_m_inf_inst_1\[3:0\]} \
{/TESTBED/ci_1/bridge_1/rlast_M_inf} \
{/TESTBED/ci_1/bridge_1/rready_M_inf} \
{/TESTBED/ci_1/bridge_1/rresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/ci_1/bridge_1/rst_n} \
{/TESTBED/ci_1/bridge_1/rvalid_m_inf_inst_1} \
{/TESTBED/ci_1/bridge_1/state_c\[2:0\]} \
{/TESTBED/ci_1/bridge_1/state_n\[2:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetPosition -win $_nWave1 {("G2" 1)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 3 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetCursor -win $_nWave1 3589760.966475 -snap {("G1" 9)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3589138.983951 -snap {("G1" 9)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3620546.454244 -snap {("G3" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvSetCursor -win $_nWave1 4743953.042232 -snap {("G5" 8)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 7210531.833638 -snap {("G2" 1)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 7168821.999508 -snap {("G4" 4)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 7212272.450078 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 7259269.446281 -snap {("G1" 8)}
wvSelectSignal -win $_nWave1 {( "G2" 3 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 3 )} 
wvSetCursor -win $_nWave1 7258094.521376 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 7230483.786106 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 7240470.647800 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 7251632.434398 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 7229308.861201 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 7168800.228590 -snap {("G4" 4)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoom -win $_nWave1 3406519.241192 4425387.533875
wvSetCursor -win $_nWave1 3557004.477961 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3571500.571556 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3581854.924124 -snap {("G1" 5)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3571500.571556 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 3579784.053611 -snap {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSetCursor -win $_nWave1 3507016.301038 -snap {("G4" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3560168.644220 -snap {("G3" 6)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 3 )} 
wvSetCursor -win $_nWave1 3581052.887192 -snap {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvSetCursor -win $_nWave1 39412.097047 -snap {("G4" 2)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvSetCursor -win $_nWave1 69392.239245 -snap {("G5" 4)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 39748.952577 -snap {("G5" 24)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 71750.227957 -snap {("G5" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 58612.862275 -snap {("G5" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3609651.611811 -snap {("G3" 1)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSetCursor -win $_nWave1 3623125.833024 -snap {("G3" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvSetCursor -win $_nWave1 3609988.467343 -snap {("G4" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3669914.756282 -snap {("G5" 12)}
wvSetCursor -win $_nWave1 3630165.803705 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 3638587.191963 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 3669914.756282 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 3664861.923327 -snap {("G4" 2)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3638036.003171 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3610230.932915 -snap {("G1" 6)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3599286.383984 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 3609935.134295 -snap {("G1" 5)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 3580059.473700 -snap {("G1" 8)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3639810.794889 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3609935.134295 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 3550183.813106 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 3609047.738436 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 3639219.197650 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3630049.440438 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3640106.593509 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3609639.335675 -snap {("G5" 14)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 15 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G4" 2 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSetCursor -win $_nWave1 3637444.405931 -snap {("G5" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3609047.738436 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3559649.368938 -snap {("G1" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3539239.264175 -snap {("G4" 4)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3610526.731534 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 3601061.175702 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 3609639.335675 -snap {("G3" 6)}
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetCursor -win $_nWave1 3557874.577219 -snap {("G3" 6)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3661759.051221 -snap {("G3" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3670041.412574 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 3638982.557501 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3609698.494146 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 3640757.349219 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 3660871.655362 -snap {("G2" 2)}
wvSetCursor -win $_nWave1 3669081.906078 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3659320.551626 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 3669673.503317 -snap {("G1" 7)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3661095.343345 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 3669377.704697 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 3659616.350246 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 3669969.301937 -snap {("G1" 5)}
wvSetCursor -win $_nWave1 3661160.387926 -snap {("G3" 3)}
wvSetCursor -win $_nWave1 3669146.950659 -snap {("G3" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvSetCursor -win $_nWave1 72376.490515 -snap {("G5" 13)}
wvSetCursor -win $_nWave1 93055.487805 -snap {("G5" 7)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3598145.528455 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 3618824.525745 -snap {("G4" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 5366199.796748 -snap {("G5" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 375054.878049 -snap {("G4" 4)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 3673224.932249 -snap {("G3" 2)}
wvZoom -win $_nWave1 3431126.016260 3944542.682927
wvSetCursor -win $_nWave1 3660702.574526 -snap {("G3" 3)}
wvSetCursor -win $_nWave1 3670790.029358 -snap {("G3" 3)}
wvSetCursor -win $_nWave1 3661398.261066 -snap {("G3" 3)}
wvSetCursor -win $_nWave1 3670094.342818 -snap {("G3" 3)}
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 39581.087095 -snap {("G3" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 30245.925045 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 40888.009783 -snap {("G1" 7)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 30619.331527 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 39207.680613 -snap {("G3" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 5 )} 
wvSetCursor -win $_nWave1 28565.595875 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 39207.680613 -snap {("G3" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 30059.221804 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 41074.713024 -snap {("G3" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSelectSignal -win $_nWave1 {( "G3" 3 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvSetCursor -win $_nWave1 30245.925045 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 39767.790336 -snap {("G3" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 3678253.849471 -snap {("G1" 7)}
wvZoom -win $_nWave1 0.000000 140400.837244
wvSetCursor -win $_nWave1 39666.090197 -snap {("G3" 1)}
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvSelectSignal -win $_nWave1 {( "G3" 2 )} 
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvZoomOut -win $_nWave1
wvSetCursor -win $_nWave1 3666849.193325 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 3682068.796278 -snap {("G1" 7)}
wvZoom -win $_nWave1 3467472.394637 3784040.136065
wvSetCursor -win $_nWave1 3669724.007215 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3678732.032378 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3668222.669688 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3679804.416326 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3669295.053636 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3679804.416326 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3670796.391163 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3679375.462747 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 3649564.728481 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 3619752.454728 -snap {("G1" 7)}
wvSetCursor -win $_nWave1 3630047.340629 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 3619966.931518 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3630261.817418 -snap {("G3" 6)}
wvSetCursor -win $_nWave1 3639484.319370 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 3680449.386181 -snap {("G1" 7)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 3686454.736290 -snap {("G5" 5)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 7261101.888504 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 7229144.846856 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 7260029.504556 -snap {("G1" 6)}
wvSetCursor -win $_nWave1 7289841.778308 -snap {("G1" 8)}
wvSetCursor -win $_nWave1 7137134.304124 -snap {("G3" 2)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 3 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 3 )} 
wvSelectSignal -win $_nWave1 {( "G2" 2 )} 
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvCloseFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvTpfCloseForm -win $_nWave1
wvGetSignalClose -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 0)}
wvOpenFile -win $_nWave1 \
           {/home/RAID2/COURSE/iclab/iclab134/ICLAB_FP_2019F/01_RTL/CPU2.fsdb}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSetPosition -win $_nWave1 {("G1" 6)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G1" 6)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 7 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G1" 14)}
wvSetPosition -win $_nWave1 {("G1" 14)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 9 10 11 12 13 14 )} 
wvSetPosition -win $_nWave1 {("G1" 14)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G1" 18)}
wvSetPosition -win $_nWave1 {("G1" 18)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 15 16 17 18 )} 
wvSetPosition -win $_nWave1 {("G1" 18)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G1" 22)}
wvSetPosition -win $_nWave1 {("G1" 22)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
}
wvSelectSignal -win $_nWave1 {( "G1" 19 20 21 22 )} 
wvSetPosition -win $_nWave1 {("G1" 22)}
wvGetSignalClose -win $_nWave1
wvSelectGroup -win $_nWave1 {G2}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G2" 6)}
wvSetPosition -win $_nWave1 {("G2" 6)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 2 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G2" 6)}
wvGetSignalClose -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G2" 10)}
wvSetPosition -win $_nWave1 {("G2" 10)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
}
wvSelectSignal -win $_nWave1 {( "G2" 7 8 9 10 )} 
wvSetPosition -win $_nWave1 {("G2" 10)}
wvGetSignalClose -win $_nWave1
wvSelectGroup -win $_nWave1 {G3}
wvSetPosition -win $_nWave1 {("G3" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G3" 6)}
wvSetPosition -win $_nWave1 {("G3" 6)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G3" 1 2 3 4 5 6 )} 
wvSetPosition -win $_nWave1 {("G3" 6)}
wvGetSignalClose -win $_nWave1
wvZoomAll -win $_nWave1
wvSetCursor -win $_nWave1 386325.000000 -snap {("G2" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectGroup -win $_nWave1 {G4}
wvSelectGroup -win $_nWave1 {G4}
wvSelectGroup -win $_nWave1 {G1}
wvSetPosition -win $_nWave1 {("G1" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_PATTERN"
wvSetPosition -win $_nWave1 {("G1" 4)}
wvSetPosition -win $_nWave1 {("G1" 4)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G1" 1 2 3 4 )} 
wvSetPosition -win $_nWave1 {("G1" 4)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvSelectSignal -win $_nWave1 {( "G1" 3 )} 
wvSelectSignal -win $_nWave1 {( "G1" 2 )} 
wvSelectSignal -win $_nWave1 {( "G1" 1 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectGroup -win $_nWave1 {G2}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/u_PATTERN"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G2" 2)}
wvSetPosition -win $_nWave1 {("G2" 2)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/s_c\[3:0\]} \
{/TESTBED/cd/s_n\[3:0\]} \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
}
wvSelectSignal -win $_nWave1 {( "G2" 1 2 )} 
wvSetPosition -win $_nWave1 {("G2" 2)}
wvGetSignalClose -win $_nWave1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 219859.756098 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 229056.504065 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 238828.048780 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 248024.796748 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 257508.943089 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 266993.089431 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 278201.626016 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 289984.959350 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 219859.756098 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 212387.398374 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 240839.837398 -snap {("G2" 7)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvSetCursor -win $_nWave1 2837716.802168 -snap {("G3" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 860224.390244 -snap {("G3" 5)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1482113.414634 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 1489873.170732 -snap {("G3" 5)}
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSelectSignal -win $_nWave1 {( "G2" 5 )} 
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSelectSignal -win $_nWave1 {( "G2" 5 )} 
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSelectSignal -win $_nWave1 {( "G2" 5 )} 
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSelectSignal -win $_nWave1 {( "G2" 5 )} 
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSelectSignal -win $_nWave1 {( "G2" 5 )} 
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSelectSignal -win $_nWave1 {( "G2" 5 )} 
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 78706.097561 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 209513.414634 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 219490.243902 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 232792.682927 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 213947.560976 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 217273.170732 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 207296.341463 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 221707.317073 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 206187.804878 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 77597.560976 -snap {("G3" 1)}
wvSetCursor -win $_nWave1 217273.170732 -snap {("G3" 5)}
wvSelectGroup -win $_nWave1 {G4}
wvSetPosition -win $_nWave1 {("G4" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd/bridge"
wvSetPosition -win $_nWave1 {("G4" 38)}
wvSetPosition -win $_nWave1 {("G4" 38)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/s_c\[3:0\]} \
{/TESTBED/cd/s_n\[3:0\]} \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G4" \
{/TESTBED/cd/bridge/araddr_M_inf\[31:0\]} \
{/TESTBED/cd/bridge/arburst_M_inf\[1:0\]} \
{/TESTBED/cd/bridge/arid_M_inf\[3:0\]} \
{/TESTBED/cd/bridge/arlen_M_inf\[7:0\]} \
{/TESTBED/cd/bridge/arready_M_inf} \
{/TESTBED/cd/bridge/arsize_M_inf\[2:0\]} \
{/TESTBED/cd/bridge/arvalid_M_inf} \
{/TESTBED/cd/bridge/awaddr_M_inf\[31:0\]} \
{/TESTBED/cd/bridge/awburst_M_inf\[1:0\]} \
{/TESTBED/cd/bridge/awid_M_inf\[3:0\]} \
{/TESTBED/cd/bridge/awlen_M_inf\[7:0\]} \
{/TESTBED/cd/bridge/awready_M_inf} \
{/TESTBED/cd/bridge/awsize_M_inf\[2:0\]} \
{/TESTBED/cd/bridge/awvalid_M_inf} \
{/TESTBED/cd/bridge/bid_m_inf_inst_1\[3:0\]} \
{/TESTBED/cd/bridge/bready_M_inf} \
{/TESTBED/cd/bridge/bresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/cd/bridge/bvalid_M_inf} \
{/TESTBED/cd/bridge/clk} \
{/TESTBED/cd/bridge/i_ADDR\[31:0\]} \
{/TESTBED/cd/bridge/i_DATA\[15:0\]} \
{/TESTBED/cd/bridge/i_rw} \
{/TESTBED/cd/bridge/in_valid} \
{/TESTBED/cd/bridge/o_DATA\[15:0\]} \
{/TESTBED/cd/bridge/out_valid} \
{/TESTBED/cd/bridge/rdata_m_inf_inst_1\[15:0\]} \
{/TESTBED/cd/bridge/rid_m_inf_inst_1\[3:0\]} \
{/TESTBED/cd/bridge/rlast_M_inf} \
{/TESTBED/cd/bridge/rready_M_inf} \
{/TESTBED/cd/bridge/rresp_m_inf_inst_1\[1:0\]} \
{/TESTBED/cd/bridge/rst_n} \
{/TESTBED/cd/bridge/rvalid_m_inf_inst_1} \
{/TESTBED/cd/bridge/state_c\[2:0\]} \
{/TESTBED/cd/bridge/state_n\[2:0\]} \
{/TESTBED/cd/bridge/wdata_M_inf\[15:0\]} \
{/TESTBED/cd/bridge/wlast_M_inf} \
{/TESTBED/cd/bridge/wready_m_inf_inst_1} \
{/TESTBED/cd/bridge/wvalid_M_inf} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
}
wvSelectSignal -win $_nWave1 {( "G4" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 \
           18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 )} \
           
wvSetPosition -win $_nWave1 {("G4" 38)}
wvGetSignalClose -win $_nWave1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvSelectSignal -win $_nWave1 {( "G4" 7 )} 
wvSelectSignal -win $_nWave1 {( "G4" 6 )} 
wvSelectSignal -win $_nWave1 {( "G4" 5 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G4" 1 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 4
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 109745.121951 -snap {("G4" 33)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 78706.097561 -snap {("G4" 33)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 90900.000000 -snap {("G4" 2)}
wvSetCursor -win $_nWave1 110853.658537 -snap {("G4" 5)}
wvSetCursor -win $_nWave1 208404.878049 -snap {("G4" 24)}
wvSetCursor -win $_nWave1 219490.243902 -snap {("G4" 24)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 576439.024390 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 638517.073171 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 624106.097561 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 610803.658537 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 569787.804878 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 575330.487805 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 568679.268293 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 556485.365854 -snap {("G3" 5)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 441197.560976 -snap {("G1" 25)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G2" 1 )} 
wvSetCursor -win $_nWave1 1498741.463415 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1507609.756098 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1523129.268293 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1530889.024390 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1546408.536585 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1502067.073171 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1507609.756098 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1522020.731707 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1510935.365854 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1519803.658537 -snap {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G3" 1 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSetCursor -win $_nWave1 1512043.902439 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1522020.731707 -snap {("G2" 1)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 18 )} 
wvSelectSignal -win $_nWave1 {( "G1" 17 )} 
wvSetCursor -win $_nWave1 216164.634146 -snap {("G2" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 40187.872629 -snap {("G1" 26)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 18 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 30128.929539 -snap {("G1" 24)}
wvSetCursor -win $_nWave1 40235.772358 -snap {("G1" 25)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvSetCursor -win $_nWave1 1530765.853659 -snap {("G1" 10)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 18 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvZoomAll -win $_nWave1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 212880.081301 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 1492247.628726 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 1688431.233062 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 2976147.018970 -snap {("G3" 5)}
wvSetCursor -win $_nWave1 1590339.430894 -snap {("G4" 5)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1531901.761518 -snap {("G1" 10)}
wvSetCursor -win $_nWave1 1511031.165312 -snap {("G1" 9)}
wvSetCursor -win $_nWave1 1538162.940379 -snap {("G1" 9)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3009539.972900 -snap {("G1" 17)}
wvSetCursor -win $_nWave1 1533988.821138 -snap {("G1" 9)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 39654.132791 -snap {("G1" 23)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 7
wvSelectGroup -win $_nWave1 {G4}
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G3" 6)}
wvScrollDown -win $_nWave1 0
wvSelectGroup -win $_nWave1 {G5}
wvSetPosition -win $_nWave1 {("G5" 0)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G5" 5)}
wvSetPosition -win $_nWave1 {("G5" 5)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/s_c\[3:0\]} \
{/TESTBED/cd/s_n\[3:0\]} \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/cd/SRAM_A\[1:0\]} \
{/TESTBED/cd/SRAM_DIRTY\[1:0\]} \
{/TESTBED/cd/SRAM_D\[1:0\]} \
{/TESTBED/cd/SRAM_Q\[1:0\]} \
{/TESTBED/cd/SRAM_WEN\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G5" 1 2 3 4 5 )} 
wvSetPosition -win $_nWave1 {("G5" 5)}
wvGetSignalClose -win $_nWave1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSetPosition -win $_nWave1 {("G5" 4)}
wvExpandBus -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSetPosition -win $_nWave1 {("G5" 4)}
wvCollapseBus -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 4)}
wvSetPosition -win $_nWave1 {("G5" 5)}
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvSetPosition -win $_nWave1 {("G5" 1)}
wvExpandBus -win $_nWave1 {("G5" 1)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvScrollDown -win $_nWave1 2
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSelectSignal -win $_nWave1 {( "G5" 5 )} 
wvSelectSignal -win $_nWave1 {( "G5" 7 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 3019975.271003 -snap {("G2" 6)}
wvSelectSignal -win $_nWave1 {( "G2" 7 )} 
wvSelectSignal -win $_nWave1 {( "G2" 8 )} 
wvSetCursor -win $_nWave1 1529814.701897 -snap {("G2" 7)}
wvSelectSignal -win $_nWave1 {( "G2" 9 )} 
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSelectSignal -win $_nWave1 {( "G2" 9 )} 
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSetPosition -win $_nWave1 {("G2" 10)}
wvExpandBus -win $_nWave1 {("G2" 10)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSetCursor -win $_nWave1 2087.059621 -snap {("G2" 12)}
wvSetCursor -win $_nWave1 10435.298103 -snap {("G2" 12)}
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSelectSignal -win $_nWave1 {( "G2" 11 )} 
wvSetPosition -win $_nWave1 {("G2" 11)}
wvExpandBus -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSelectSignal -win $_nWave1 {( "G2" 11 )} 
wvSetPosition -win $_nWave1 {("G2" 11)}
wvCollapseBus -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G2" 11)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSelectSignal -win $_nWave1 {( "G2" 9 )} 
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSetCursor -win $_nWave1 8348.238482 -snap {("G2" 10)}
wvSetCursor -win $_nWave1 14609.417344 -snap {("G2" 10)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSetCursor -win $_nWave1 12522.357724 -snap {("G2" 10)}
wvSetPosition -win $_nWave1 {("G2" 10)}
wvExpandBus -win $_nWave1 {("G2" 10)}
wvSetPosition -win $_nWave1 {("G6" 0)}
wvSetCursor -win $_nWave1 10435.298103 -snap {("G2" 12)}
wvSetCursor -win $_nWave1 33392.953930 -snap {("G2" 8)}
wvSetCursor -win $_nWave1 12522.357724 -snap {("G2" 9)}
wvSetCursor -win $_nWave1 35480.013550 -snap {("G2" 14)}
wvSetCursor -win $_nWave1 200357.723577 -snap {("G2" 2)}
wvSetCursor -win $_nWave1 66785.907859 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 50089.430894 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 62611.788618 -snap {("G2" 1)}
wvSelectSignal -win $_nWave1 {( "G2" 4 )} 
wvSelectSignal -win $_nWave1 {( "G2" 7 )} 
wvScrollDown -win $_nWave1 2
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 6
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSelectGroup -win $_nWave1 {G2}
wvSetPosition -win $_nWave1 {("G2" 0)}
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSetPosition -win $_nWave1 {("G2" 14)}
wvGetSignalOpen -win $_nWave1
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G2" 15)}
wvSetPosition -win $_nWave1 {("G2" 15)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/s_c\[3:0\]} \
{/TESTBED/cd/s_n\[3:0\]} \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1\]\[3:0\]} \
{/TESTBED/cd/BASE_BLOCK\[0\]\[3:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
{/TESTBED/cd/SRAM_NUM\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/cd/SRAM_A\[1:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[3:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[3:0\]} \
{/TESTBED/cd/SRAM_DIRTY\[1:0\]} \
{/TESTBED/cd/SRAM_D\[1:0\]} \
{/TESTBED/cd/SRAM_Q\[1:0\]} \
{/TESTBED/cd/SRAM_WEN\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G2" 15 )} 
wvSetPosition -win $_nWave1 {("G2" 15)}
wvGetSignalClose -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 15 )} 
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 10 )} 
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSetCursor -win $_nWave1 139832.994580 -snap {("G2" 14)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 9 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 57548.102981 -snap {("G2" 15)}
wvSetCursor -win $_nWave1 69454.607046 -snap {("G2" 14)}
wvSetCursor -win $_nWave1 9922.086721 -snap {("G2" 10)}
wvSetCursor -win $_nWave1 71439.024390 -snap {("G2" 10)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G2" 17)}
wvSetPosition -win $_nWave1 {("G2" 17)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/i_addr_1\[12:0\]} \
{/TESTBED/cd/i_data_1\[15:0\]} \
{/TESTBED/cd/i_rw_1} \
{/TESTBED/cd/i_valid_1} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
{/TESTBED/cd/i_addr_2\[12:0\]} \
{/TESTBED/cd/i_data_2\[15:0\]} \
{/TESTBED/cd/i_rw_2} \
{/TESTBED/cd/i_valid_2} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/I_ADDR_0\[12:0\]} \
{/TESTBED/cd/I_DATA_0\[15:0\]} \
{/TESTBED/cd/I_RW_0} \
{/TESTBED/cd/I_VALID_0} \
{/TESTBED/cd/I_ADDR_1\[12:0\]} \
{/TESTBED/cd/I_DATA_1\[15:0\]} \
{/TESTBED/cd/I_RW_1} \
{/TESTBED/cd/I_VALID_1} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/s_c\[3:0\]} \
{/TESTBED/cd/s_n\[3:0\]} \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1\]\[3:0\]} \
{/TESTBED/cd/BASE_BLOCK\[0\]\[3:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
{/TESTBED/cd/SRAM_NUM\[1:0\]} \
{/TESTBED/cd/CP_CNT\[7:0\]} \
{/TESTBED/cd/CP_NUM\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/cd/SRAM_A\[1:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[3:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[3:0\]} \
{/TESTBED/cd/SRAM_DIRTY\[1:0\]} \
{/TESTBED/cd/SRAM_D\[1:0\]} \
{/TESTBED/cd/SRAM_Q\[1:0\]} \
{/TESTBED/cd/SRAM_WEN\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G2" 16 17 )} 
wvSetPosition -win $_nWave1 {("G2" 17)}
wvGetSignalClose -win $_nWave1
wvSetCursor -win $_nWave1 61516.937669 -snap {("G2" 17)}
wvSelectSignal -win $_nWave1 {( "G2" 17 )} 
wvSelectSignal -win $_nWave1 {( "G2" 16 )} 
wvSelectGroup -win $_nWave1 {G3}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G2" 16 )} 
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 5 )} 
wvSelectSignal -win $_nWave1 {( "G5" 6 )} 
wvSelectSignal -win $_nWave1 {( "G5" 5 )} 
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSelectSignal -win $_nWave1 {( "G5" 1 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSetCursor -win $_nWave1 226223.577236 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 263927.506775 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 472291.327913 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 633029.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 740187.669377 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 936644.986450 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1105320.460705 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1270027.100271 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1355357.046070 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1502203.929539 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1514110.433604 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1498235.094851 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1514110.433604 -snap {("G5" 3)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 7 )} 
wvSetPosition -win $_nWave1 {("G5" 7)}
wvExpandBus -win $_nWave1 {("G5" 7)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 7 )} 
wvSetPosition -win $_nWave1 {("G5" 7)}
wvCollapseBus -win $_nWave1 {("G5" 7)}
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSelectSignal -win $_nWave1 {( "G5" 7 )} 
wvSetRadix -win $_nWave1 -format Bin
wvSelectSignal -win $_nWave1 {( "G5" 6 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSelectSignal -win $_nWave1 {( "G2" 15 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSelectSignal -win $_nWave1 {( "G2" 13 )} 
wvSelectSignal -win $_nWave1 {( "G2" 14 )} 
wvSetCursor -win $_nWave1 39688.346883 -snap {("G2" 14)}
wvSetCursor -win $_nWave1 65485.772358 -snap {("G2" 14)}
wvSetCursor -win $_nWave1 33735.094851 -snap {("G2" 14)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G1" 26 )} 
wvSelectSignal -win $_nWave1 {( "G1" 19 20 21 22 23 24 25 26 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSelectSignal -win $_nWave1 {( "G1" 18 )} 
wvSelectSignal -win $_nWave1 {( "G1" 17 )} 
wvSelectSignal -win $_nWave1 {( "G1" 15 16 17 )} 
wvSelectSignal -win $_nWave1 {( "G1" 16 )} 
wvSelectSignal -win $_nWave1 {( "G1" 13 14 15 16 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 7 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 6 7 8 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G5" 7)}
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 8 )} 
wvGoToGroup -win $_nWave1 "G1"
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSetPosition -win $_nWave1 {("G1" 6)}
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 10 )} 
wvCut -win $_nWave1
wvSetPosition -win $_nWave1 {("G1" 6)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G1" 8)}
wvSetPosition -win $_nWave1 {("G1" 8)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/s_c\[3:0\]} \
{/TESTBED/cd/s_n\[3:0\]} \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1\]\[3:0\]} \
{/TESTBED/cd/BASE_BLOCK\[0\]\[3:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
{/TESTBED/cd/SRAM_NUM\[1:0\]} \
{/TESTBED/cd/CP_CNT\[7:0\]} \
{/TESTBED/cd/CP_NUM\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/cd/SRAM_A\[1:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[3:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[3:0\]} \
{/TESTBED/cd/SRAM_DIRTY\[1:0\]} \
{/TESTBED/cd/SRAM_D\[1:0\]} \
{/TESTBED/cd/SRAM_Q\[1:0\]} \
{/TESTBED/cd/SRAM_WEN\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G1" 7 8 )} 
wvSetPosition -win $_nWave1 {("G1" 8)}
wvGetSignalClose -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 9 )} 
wvSelectSignal -win $_nWave1 {( "G1" 10 )} 
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSelectSignal -win $_nWave1 {( "G1" 7 )} 
wvSelectSignal -win $_nWave1 {( "G1" 6 )} 
wvSelectSignal -win $_nWave1 {( "G1" 5 )} 
wvSelectSignal -win $_nWave1 {( "G1" 4 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectGroup -win $_nWave1 {G2}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 2 )} 
wvSetPosition -win $_nWave1 {("G5" 2)}
wvExpandBus -win $_nWave1 {("G5" 2)}
wvScrollDown -win $_nWave1 3
wvSelectSignal -win $_nWave1 {( "G5" 7 )} 
wvSetPosition -win $_nWave1 {("G5" 7)}
wvExpandBus -win $_nWave1 {("G5" 7)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 12 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 1549829.945799 -snap {("G5" 7)}
wvSetCursor -win $_nWave1 1565705.284553 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1571658.536585 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1559752.032520 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1575627.371274 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1563720.867209 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1571658.536585 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1557767.615176 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1575627.371274 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 1549829.945799 -snap {("G2" 16)}
wvSetCursor -win $_nWave1 1539907.859079 -snap {("G2" 10)}
wvSetCursor -win $_nWave1 1567689.701897 -snap {("G2" 16)}
wvSetCursor -win $_nWave1 1589518.292683 -snap {("G2" 16)}
wvSetCursor -win $_nWave1 1680801.490515 -snap {("G2" 16)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1543876.693767 -snap {("G5" 1)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1801850.948509 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1998308.265583 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 2200718.834688 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 2825810.298103 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 2831763.550136 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2831763.550136 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2825810.298103 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2821841.463415 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2831763.550136 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2821841.463415 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2835732.384824 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2833747.967480 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2821841.463415 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2833747.967480 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2821841.463415 -snap {("G5" 14)}
wvSetCursor -win $_nWave1 2833747.967480 -snap {("G5" 14)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1639128.726287 -snap {("G5" 11)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSetCursor -win $_nWave1 1555783.197832 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1541892.276423 -snap {("G5" 7)}
wvSetCursor -win $_nWave1 1561736.449864 -snap {("G5" 7)}
wvSetCursor -win $_nWave1 2843670.054201 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2827794.715447 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2837716.802168 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2827794.715447 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2815888.211382 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2827794.715447 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 2805966.124661 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 2817872.628726 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2841685.636856 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2837716.802168 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2825810.298103 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2813903.794038 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2825810.298103 -snap {("G5" 7)}
wvSetCursor -win $_nWave1 2831763.550136 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2823825.880759 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2817872.628726 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2831763.550136 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2821841.463415 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2827794.715447 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2815888.211382 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2827794.715447 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2813903.794038 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2831763.550136 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2825810.298103 -snap {("G5" 3)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1508157.181572 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1516094.850949 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1533954.607046 -snap {("G2" 1)}
wvSetCursor -win $_nWave1 1539907.859079 -snap {("G2" 1)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 2831763.550136 -snap {("G5" 14)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSelectSignal -win $_nWave1 {( "G2" 3 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 15 )} 
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G3" 5 )} 
wvSelectSignal -win $_nWave1 {( "G3" 4 )} 
wvSelectSignal -win $_nWave1 {( "G3" 5 )} 
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G1" 8 )} 
wvSetCursor -win $_nWave1 2863514.227642 -snap {("G1" 7)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 2821841.463415 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2837716.802168 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2829779.132791 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2819857.046070 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2827794.715447 -snap {("G5" 3)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSetCursor -win $_nWave1 1543876.693767 -snap {("G2" 1)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvSetCursor -win $_nWave1 1524032.520325 -snap {("G2" 2)}
wvSetCursor -win $_nWave1 1533954.607046 -snap {("G2" 2)}
wvSetCursor -win $_nWave1 1545861.111111 -snap {("G2" 1)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1555783.197832 -snap {("G5" 2)}
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSetCursor -win $_nWave1 2835732.384824 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2827794.715447 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 2815888.211382 -snap {("G5" 3)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSetCursor -win $_nWave1 1559752.032520 -snap {("G5" 14)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvZoom -win $_nWave1 1414889.566396 1920915.989160
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSetPosition -win $_nWave1 {("G5" 14)}
wvExpandBus -win $_nWave1 {("G5" 14)}
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvScrollDown -win $_nWave1 2
wvSelectSignal -win $_nWave1 {( "G5" 16 )} 
wvExpandBus -win $_nWave1 {("G5" 16)}
wvSelectSignal -win $_nWave1 {( "G5" 13 )} 
wvSetPosition -win $_nWave1 {("G5" 13)}
wvExpandBus -win $_nWave1 {("G5" 13)}
wvSetPosition -win $_nWave1 {("G5" 22)}
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSelectSignal -win $_nWave1 {( "G5" 15 )} 
wvSelectSignal -win $_nWave1 {( "G5" 14 )} 
wvSetPosition -win $_nWave1 {("G5" 14)}
wvExpandBus -win $_nWave1 {("G5" 14)}
wvSetPosition -win $_nWave1 {("G5" 26)}
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 2827966.342234 -snap {("G5" 27)}
wvSelectSignal -win $_nWave1 {( "G5" 21 )} 
wvSetCursor -win $_nWave1 1560602.440545 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 1571230.366768 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 1561630.949534 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 1568830.512459 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 1565059.312832 -snap {("G5" 25)}
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSelectSignal -win $_nWave1 {( "G5" 4 )} 
wvSelectSignal -win $_nWave1 {( "G5" 3 )} 
wvSetCursor -win $_nWave1 1569859.021449 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1559231.095225 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1569516.185119 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1560602.440545 -snap {("G5" 10)}
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 1551345.859640 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1559916.767885 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1548946.005332 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1558545.422566 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1560602.440545 -snap {("G5" 25)}
wvSelectSignal -win $_nWave1 {( "G5" 10 )} 
wvSetCursor -win $_nWave1 1558888.258896 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1568830.512459 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1559231.095225 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1569859.021449 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1559916.767885 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1551003.023310 -snap {("G5" 1)}
wvSetCursor -win $_nWave1 1559916.767885 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1570887.530438 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1580144.111342 -snap {("G5" 2)}
wvSetCursor -win $_nWave1 1569516.185119 -snap {("G5" 2)}
wvSetCursor -win $_nWave1 1579801.275013 -snap {("G5" 2)}
wvSetCursor -win $_nWave1 1589743.528576 -snap {("G5" 2)}
wvSetCursor -win $_nWave1 1599685.782140 -snap {("G5" 2)}
wvSetCursor -win $_nWave1 1610656.544693 -snap {("G5" 2)}
wvSetCursor -win $_nWave1 1620598.798257 -snap {("G5" 2)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSelectSignal -win $_nWave1 {( "G2" 8 )} 
wvSetPosition -win $_nWave1 {("G2" 8)}
wvGetSignalOpen -win $_nWave1
wvGetSignalSetScope -win $_nWave1 "/TESTBED/cd"
wvSetPosition -win $_nWave1 {("G2" 9)}
wvSetPosition -win $_nWave1 {("G2" 9)}
wvAddSignal -win $_nWave1 -clear
wvAddSignal -win $_nWave1 -group {"G1" \
{/TESTBED/u_PATTERN/data_1_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_2_ans\[31:0\]} \
{/TESTBED/u_PATTERN/data_addr_1_ans\[12:0\]} \
{/TESTBED/u_PATTERN/data_addr_2_ans\[12:0\]} \
{/TESTBED/cd/o_data_1\[15:0\]} \
{/TESTBED/cd/o_valid_1} \
{/TESTBED/cd/o_data_2\[15:0\]} \
{/TESTBED/cd/o_valid_2} \
{/TESTBED/cd/clk} \
{/TESTBED/cd/rst_n} \
}
wvAddSignal -win $_nWave1 -group {"G2" \
{/TESTBED/cd/s_c\[3:0\]} \
{/TESTBED/cd/s_n\[3:0\]} \
{/TESTBED/cd/JOB_ADDR\[12:0\]} \
{/TESTBED/cd/JOB_BLOCK\[4:0\]} \
{/TESTBED/cd/JOB_DATA\[15:0\]} \
{/TESTBED/cd/JOB_LIST\[1:0\]} \
{/TESTBED/cd/JOB_PORT} \
{/TESTBED/cd/JOB_RW} \
{/TESTBED/cd/JOB_OFFSET\[6:0\]} \
{/TESTBED/cd/ADDR_HIT_SRAM\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1:0\]} \
{/TESTBED/cd/BASE_BLOCK\[1\]\[3:0\]} \
{/TESTBED/cd/BASE_BLOCK\[0\]\[3:0\]} \
{/TESTBED/cd/BLOCK_MAX\[2:0\]} \
{/TESTBED/cd/BLOCK_MINUS\[3:0\]} \
{/TESTBED/cd/SRAM_NUM\[1:0\]} \
{/TESTBED/cd/CP_CNT\[7:0\]} \
{/TESTBED/cd/CP_NUM\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G3" \
{/TESTBED/cd/BRG_i_addr\[31:0\]} \
{/TESTBED/cd/BRG_i_data\[15:0\]} \
{/TESTBED/cd/BRG_i_rw} \
{/TESTBED/cd/BRG_i_valid} \
{/TESTBED/cd/BRG_o_data\[15:0\]} \
{/TESTBED/cd/BRG_o_valid} \
}
wvAddSignal -win $_nWave1 -group {"G5" \
{/TESTBED/cd/SRAM_A\[1:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[3:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[3\]\[6:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[2\]\[6:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[1\]\[6:0\]} \
{/TESTBED/cd/SRAM_A\[1\]\[0\]\[6:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[3:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[3\]\[6:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[2\]\[6:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[1\]\[6:0\]} \
{/TESTBED/cd/SRAM_A\[0\]\[0\]\[6:0\]} \
{/TESTBED/cd/SRAM_DIRTY\[1:0\]} \
{/TESTBED/cd/SRAM_D\[1:0\]} \
{/TESTBED/cd/SRAM_D\[1\]\[3:0\]} \
{/TESTBED/cd/SRAM_D\[1\]\[3\]\[15:0\]} \
{/TESTBED/cd/SRAM_D\[1\]\[2\]\[15:0\]} \
{/TESTBED/cd/SRAM_D\[1\]\[1\]\[15:0\]} \
{/TESTBED/cd/SRAM_D\[1\]\[0\]\[15:0\]} \
{/TESTBED/cd/SRAM_D\[0\]\[3:0\]} \
{/TESTBED/cd/SRAM_Q\[1:0\]} \
{/TESTBED/cd/SRAM_Q\[1\]\[3:0\]} \
{/TESTBED/cd/SRAM_Q\[0\]\[3:0\]} \
{/TESTBED/cd/SRAM_Q\[0\]\[3\]\[15:0\]} \
{/TESTBED/cd/SRAM_Q\[0\]\[2\]\[15:0\]} \
{/TESTBED/cd/SRAM_Q\[0\]\[1\]\[15:0\]} \
{/TESTBED/cd/SRAM_Q\[0\]\[0\]\[15:0\]} \
{/TESTBED/cd/SRAM_WEN\[1:0\]} \
}
wvAddSignal -win $_nWave1 -group {"G6" \
}
wvSelectSignal -win $_nWave1 {( "G2" 9 )} 
wvSetPosition -win $_nWave1 {("G2" 9)}
wvGetSignalClose -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvSelectSignal -win $_nWave1 {( "G2" 9 )} 
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvSetCursor -win $_nWave1 1907895.642619 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1919353.066510 -snap {("G5" 15)}
wvSetCursor -win $_nWave1 1910439.321935 -snap {("G5" 15)}
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollUp -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvSetCursor -win $_nWave1 570301.298088 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 580586.387982 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 572015.479737 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 569958.461758 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1909685.918320 -snap {("G5" 15)}
wvSetCursor -win $_nWave1 1557859.749907 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1569859.021450 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1558888.258897 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1569173.348790 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1558888.258897 -snap {("G5" 3)}
wvSetCursor -win $_nWave1 1548603.169003 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1558888.258897 -snap {("G5" 10)}
wvSetCursor -win $_nWave1 1560602.440545 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 1570544.694109 -snap {("G5" 22)}
wvSetCursor -win $_nWave1 1561288.113205 -snap {("G5" 22)}
wvSetCursor -win $_nWave1 1560259.604216 -snap {("G5" 25)}
wvSetCursor -win $_nWave1 1569859.021450 -snap {("G5" 15)}
wvSetCursor -win $_nWave1 1559231.095226 -snap {("G5" 10)}
wvDisplayGridCount -win $_nWave1 -off
wvGetSignalClose -win $_nWave1
wvReloadFile -win $_nWave1
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvScrollDown -win $_nWave1 0
wvZoomAll -win $_nWave1
wvSetCursor -win $_nWave1 2905248.577236 -snap {("G3" 4)}
wvCloseFile -win $_nWave1
wvDisplayGridCount -win $_nWave1 -off
wvTpfCloseForm -win $_nWave1
wvGetSignalClose -win $_nWave1
