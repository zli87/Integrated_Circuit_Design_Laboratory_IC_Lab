/*****************************************************************************/
// MODULE:  Customized Invalid Outvalid to AXI4-Lite Bridge
// FILE NAME: bridge.sv
// VERSION:   1.0
// DATE:      December 1, 2019
// AUTHOR:    Li-Wei Liu (Will Liu)
// CODE TYPE: RTL or Behavioral Level
// DESCRIPTION:
//        This rtl code is used as course material for ICLAB Course 2019 Fall
//        System Verilog Course Series @ Formal Verification
// Copyright 2019      OASIS LAB, ED317A @ NCTU
// ALL RIGHT RESERVED.
//
//MODIFICATION HISTORY:
// Date Description:
//
/******************************************************************************/



module bridge(input clk, INF.bridge_inf inf);

AXI_STAGE c_state,n_state;

always_ff@(posedge clk or negedge inf.rst_n)begin
	if(!inf.rst_n)
		c_state <= AXI_IDLE;
        else
		c_state <= n_state;
end

always_comb begin
    case(c_state)
    AXI_IDLE: begin
                  if(inf.C_in_valid)begin
                      n_state =  (inf.C_r_wb == 1'b1)? AXI_AR : AXI_AW;
                  end
                  else begin
                      n_state =  c_state;
                  end
              end
    AXI_AW  : n_state = (inf.AW_VALID & inf.AW_READY) ? AXI_W    : c_state;
    AXI_W   : n_state = (inf.W_VALID & inf.W_READY  ) ? AXI_B    : c_state;
    AXI_B   : n_state = (inf.B_VALID & inf.B_READY  ) ? AXI_IDLE : c_state;
    AXI_AR  : n_state = (inf.AR_VALID & inf.AR_READY) ? AXI_R    : c_state;
    AXI_R   : n_state = (inf.R_VALID & inf.R_READY  ) ? AXI_IDLE : c_state;
    default : n_state = c_state;
    endcase
end

always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.C_out_valid <= 'b0;
	end
	else begin
            if(n_state == AXI_IDLE && c_state != AXI_IDLE)
		inf.C_out_valid <= 'b1;
            else
		inf.C_out_valid <= 'b0;
	end
end

always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.C_data_r <= 'b0;
	end
	else begin
            case(c_state)
            AXI_R: if(inf.R_VALID & inf.R_READY )
			inf.C_data_r <= inf.R_DATA;
                   else
			inf.C_data_r <= inf.C_data_r;
            AXI_W: if(inf.B_VALID & inf.B_READY )
			inf.C_data_r <= {30'b0, inf.B_RESP};
                   else
			inf.C_data_r <= inf.C_data_r;
            default:
			inf.C_data_r <= inf.C_data_r;
            endcase
	end
end

///////////////////////////////////////////////////////////////       AR

always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.AR_VALID <= 'b0;
	end
	else begin
		//if(inf.AR_READY)       inf.AR_VALID <=  1'b1;
		//else                   inf.AR_VALID <=  1'b0;
		if(inf.AR_READY)         inf.AR_VALID <=  1'b0;
		else if(n_state==AXI_AR) inf.AR_VALID <=  1'b1;
	end
end

always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.AR_ADDR <= 'b0;
	end
	else begin
		if(n_state == AXI_AR && c_state != AXI_AR) inf.AR_ADDR <= {1'b1, 6'b0, inf.C_addr, 2'b0};
		else                                       inf.AR_ADDR <= inf.AR_ADDR ;
	end
end

///////////////////////////////////////////////////////////////       R       ////////
always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.R_READY <= 'b0;
	end
	else begin
	    if( inf.R_VALID )      inf.R_READY <= 'b1;
	    else                   inf.R_READY <= 'b0;
	end
end


///////////////////////////////////////////////////////////////       AW       //////////////
always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.AW_VALID <= 'b0;
	end
	else begin
	    //if(inf.AW_READY )     inf.AW_VALID <=  1'b1;
			//else                  inf.AW_VALID <=  1'b0;
		if(inf.AW_READY)                 inf.AW_VALID <=  1'b0;
		else if(n_state == AXI_AW && c_state == AXI_IDLE)     inf.AW_VALID <=  1'b1;
	end
end

always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.AW_ADDR <= 'b0;
	end
	else begin
		if(n_state == AXI_AW && c_state == AXI_IDLE) inf.AW_ADDR <= {7'b1000000, inf.C_addr, 2'b0};
	    //if(n_state == AXI_AW && c_state == AXI_IDLE) inf.AW_ADDR <= {7'h40, inf.C_addr, 2'b0};
	    else                                         inf.AW_ADDR <= inf.AW_ADDR ;
	end
end

///////////////////////////////////////////////////////////////       W       /////////////
always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.W_DATA  <= 'b0;
	end
	else begin
	    //if(n_state == AXI_AW)  inf.W_DATA  <= inf.C_data_w;
		if(n_state == AXI_AW && c_state == AXI_IDLE )  inf.W_DATA  <= inf.C_data_w;
	    else                    inf.W_DATA  <= inf.W_DATA  ;
	end
end

always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.W_VALID <= 'b0;
	end
	else begin
	    if(n_state == AXI_W) inf.W_VALID <= 1'b1;
	    else                 inf.W_VALID <= 1'b0;
	end
end

///////////////////////////////////////////////////////////////       B       //////////
always_ff@(posedge clk or negedge inf.rst_n) begin
	if(!inf.rst_n)begin
		inf.B_READY <= 'b0;
	end
	else begin
            if(n_state == AXI_B) inf.B_READY <= 1'b1;
	    else                 inf.B_READY <= 1'b0;
	end
end

endmodule
