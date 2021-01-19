module CC(
	input signed [3:0] in_n0,
	input signed [3:0] in_n1,
	input signed [3:0] in_n2,
	input signed [3:0] in_n3,
	input [3:0] opt,
	output reg signed [8:0] out_n
);

//Connection wires
reg signed [3:0] st_n0;
reg signed [3:0] st_n1;
reg signed [3:0] st_n2;
reg signed [3:0] st_n3;

//
reg signed [4:0] rm_n0;
reg signed [4:0] rm_n1;
reg signed [4:0] rm_n2;
reg signed [4:0] rm_n3;

// sort
reg signed [3:0] low1;
reg signed [3:0] low2;
reg signed [3:0] high1;
reg signed [3:0] high2;
reg signed [3:0] middle1;
reg signed [3:0] middle2;
reg signed [3:0] lowest;
reg signed [3:0] mid1;
reg signed [3:0] mid2;
reg signed [3:0] highest;
// mean
reg signed [5:0] mean;
reg signed [5:0] sum;
// eq0 eq1
reg signed [6:0] sft;
reg signed [4:0] sft_tar;
reg signed [4:0] rm_tar;
reg [1:0] sft_cons;
reg signed [9:0] mul;
reg signed [9:0] mul_tar;
reg signed [9:0] add;
reg signed [9:0] add_tar;
reg signed [8:0] div3;


always @ ( * ) begin
	// step 1 : sort or not
	if ( opt[0]==1'b0 ) begin
		// not sort
		st_n0 <= in_n0;
		st_n1 <= in_n1;
		st_n2 <= in_n2;
		st_n3 <= in_n3;
	end
	else begin
		if ( opt[1]==1'b0 ) begin
			// sort acend
			st_n0 <= highest;
			st_n1 <= mid2;
			st_n2 <= mid1;
			st_n3 <= lowest;
		end
		else begin
			// sort decend
			st_n0 <= lowest;
			st_n1 <= mid1;
			st_n2 <= mid2;
			st_n3 <= highest;
		end
	end
end

always @ ( * ) begin
	// step 2 : deduce mean or not
	if ( opt[2]==1'b0 ) begin
		sum <= 6'd0;
		mean <= 6'd0;
		//rm_n0 <= $signed( {{st_n0[3]},st_n0} );
		rm_n1 <= $signed( {{st_n1[3]},st_n1} );
		//rm_n2 <= $signed( {{st_n2[3]},st_n2} );
		rm_n3 <= $signed( {{st_n3[3]},st_n3} );
	end
	else begin
		sum <= st_n0 + st_n1 + st_n2 + st_n3;
		mean <= ( sum[5] == 1'b0 ) ? sum>>2 : -((-sum)>>2);
		//rm_n0 <= ( st_n0 - mean );
		rm_n1 <= ( st_n1 - mean );
		//rm_n2 <= ( st_n2 - mean );
		rm_n3 <= ( st_n3 - mean );
	end
end
always @ ( * ) begin
	if ( opt[3] == 1'b1 ) begin
		rm_tar <= $signed( {{st_n0[3]},st_n0} );
	end else begin
		rm_tar <= $signed( {{st_n2[3]},st_n2} );
	end
	sft_tar <= ( rm_tar - mean );
end

always @ ( * ) begin
	// step 3 : do eq0 or eq1
	if ( opt[3] == 1'b1 ) begin
		sft_cons <= 2'd1;
		//sft_tar <= rm_n0;
		mul_tar <= sft;
		add_tar <= mul;
		out_n <= add;
	end
	else begin
		sft_cons <= 2'd2;
		//sft_tar <= rm_n2;
		mul_tar <= add;
		add_tar <= sft;
		out_n <= div3;
	end
	sft <=  sft_tar <<< sft_cons;
	mul <= mul_tar * rm_n1;
	add <= add_tar + rm_n3;
	div3 <= mul/3;
	//$display("sft = %d sft_tar = %d sft_cons = %d mul = %d mul_tar = %d add = %d add_tar = %d div3 = %d ",sft,sft_tar,sft_cons,mul,mul_tar,add,add_tar,div3);
end

always @ ( in_n0 or in_n1 or in_n2 or in_n3 ) begin
	if ( in_n0 < in_n1 ) begin
		low1 <= in_n0;
		high1 <= in_n1;
	end
	else begin
		low1 <= in_n1;
		high1 <= in_n0;
	end
	if ( in_n2 < in_n3 ) begin
		low2 <= in_n2;
		high2 <= in_n3;
	end
	else  begin
		low2 <= in_n3;
		high2 <= in_n2;
	end
end
always @ ( low1 or high1 or low2 or high2 ) begin
	if ( low1 < low2 ) begin
		lowest <= low1;
		middle1 <= low2;
	end
	else begin
		lowest <= low2;
		middle1 <= low1;
	end
	if ( high1 < high2 ) begin
		highest <= high2;
		middle2 <= high1;
	end
	else  begin
		highest <= high1;
		middle2 <= high2;
	end
end
always @ ( middle1 or middle2 ) begin
	if ( middle1 < middle2 ) begin
		mid1 <= middle1;
		mid2 <= middle2;
	end
	else  begin
		mid1 <= middle2;
		mid2 <= middle1;
	end
end

always @ ( * ) begin
	//$display("st_n0 = %d st_n1 = %d st_n2 = %d st_n3 = %d",st_n0,st_n1,st_n2,st_n3);
end
always @ ( * ) begin
	//$display("rm_n1 = %d rm_n3 = %d rm_tar = %d sft_tar = %d",rm_n1,rm_n3,rm_tar,sft_tar);
end
always @ ( * ) begin
	//$display("mean = %d sum = %d ",mean,sum);
end

endmodule
