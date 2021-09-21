//===============================================
// module: MLRU 
// fuction: pseudo mbit LRU (mLRU)
// author: Zong-Ru Li
// date: 03/28/2021
// desription: to be done
//===============================================

module MLRU(
    input clk,
    input rst_n,
    input i_valid_1,
    input i_valid_2,
    input [3:0] I_BANK_0,
    input [3:0] I_BANK_1,
    input [3:0] BASE_BANK_0,
    input [3:0] BASE_BANK_1,
    input [3:0] BASE_BANK_2,
    input [3:0] BASE_BANK_3,
    output victim_idx
);
reg [3:0] mbit;
wire [3:0] ADDR_HIT_SRAM;
wire LAST_ONE_HIT;

assign ADDR_HIT_SRAM[0] = (BASE_BANK_0 == I_BANK_0) | (BASE_BANK_0 == I_BANK_1);
assign ADDR_HIT_SRAM[1] = (BASE_BANK_1 == I_BANK_0) | (BASE_BANK_1 == I_BANK_1);
assign ADDR_HIT_SRAM[2] = (BASE_BANK_2 == I_BANK_0) | (BASE_BANK_2 == I_BANK_1);
assign ADDR_HIT_SRAM[3] = (BASE_BANK_3 == I_BANK_0) | (BASE_BANK_3 == I_BANK_1);

assign LAST_ONE_HIT = &( mbit | ADDR_HIT_SRAM );

always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        mbit <= 0;
    end begin if (LAST_ONE_HIT) begin
        mbit <= 0;
    end else begin
        mbit <= mbit | ADDR_HIT_SRAM; 
    end
end

reg [1:0] victim_idx;
always @(*) begin
    case (mbit)
        4'b0xxx: victim_idx <= 2'd0;
        4'b10xx: victim_idx <= 2'd1;
        4'b110x: victim_idx <= 2'd2;
        4'b1110: victim_idx <= 2'd3;
        default: victim_idx <= 2'd0;
    endcase
end

endmodule