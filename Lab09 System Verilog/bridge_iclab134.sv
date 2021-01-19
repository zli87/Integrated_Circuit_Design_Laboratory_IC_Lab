module bridge(input clk, INF.bridge_inf inf);

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.C_out_valid = 0;
    else if(inf.B_VALID | inf.R_VALID )  inf.C_out_valid = 1;
    else inf.C_out_valid = 0;
end

always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.C_data_r <=0;
    else if(inf.R_VALID) inf.C_data_r <= inf.R_DATA;
    else inf.C_data_r <=0;
end
/*
output AR_READY,
output R_VALID,
output R_DATA,
output AW_READY,
output W_READY,
output B_VALID,
output B_RESP,
// read
input AR_VALID,
input AR_ADDR,
input R_READY,
// write
input AW_VALID,
input AW_ADDR,
input W_VALID,
input W_DATA,
input B_READY
*/
//--------------------------------------------------
// read
//--------------------------------------------------
// AR_VALID
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.AR_VALID = 0;
    else if(inf.C_in_valid && (inf.C_r_wb)) inf.AR_VALID = 1;
    else if(inf.AR_READY) inf.AR_VALID = 0;
end
// AR_ADDR
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.AR_ADDR = 0;
    else if(inf.C_in_valid && (inf.C_r_wb)) begin
        inf.AR_ADDR = { 22'h40 , 10'd0 | (inf.C_addr<<2) };
        //$strobe("read addr %h",inf.AR_ADDR);
    end
    else if(inf.AR_READY) inf.AR_ADDR = 0;
end
// R_READY
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.R_READY = 0;
    else if(inf.C_in_valid && (inf.C_r_wb)) inf.R_READY = 1;
    else if(inf.R_VALID) inf.R_READY = 0;
end

//--------------------------------------------------
// write
//--------------------------------------------------
// AW_VALID
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.AW_VALID = 0;
    else if(inf.C_in_valid && (!inf.C_r_wb)) inf.AW_VALID = 1;
    else if(inf.AW_READY) inf.AW_VALID = 0;
end
// AW_ADDR
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.AW_ADDR = 0;
    else if(inf.C_in_valid && (!inf.C_r_wb)) begin
        inf.AW_ADDR = {  22'h40 , 10'd0 | (inf.C_addr<<2) };
        //$strobe("write addr %h",inf.AW_ADDR);
    end
    else if(inf.AW_READY) inf.AW_ADDR = 0;
end
// W_VALID
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.W_VALID = 0;
    else if(inf.C_in_valid && (!inf.C_r_wb)) inf.W_VALID = 1;
    else if( inf.W_READY ) inf.W_VALID = 0;
end
// W_DATA
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.W_DATA = 0;
    else if(inf.C_in_valid && (!inf.C_r_wb)) inf.W_DATA = inf.C_data_w;
    else if( inf.W_READY ) inf.W_DATA = 0;
end
// B_READY
always_ff @ (posedge clk or negedge inf.rst_n) begin
    if(!inf.rst_n) inf.B_READY = 0;
    else if(inf.C_in_valid && (!inf.C_r_wb)) inf.B_READY = 1;
    else if( inf.B_VALID ) inf.B_READY = 0;
end

endmodule
