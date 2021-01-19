module CONV2D
#( parameter M = 4,  N = 3,  WIDTH1 = 8,  WIDTH2 = 3)
(
    input [(M*M*WIDTH1)-1:0] IMAGE,
    input [(N*N*WIDTH2)-1:0] KERNEL,

    output reg [M*M*(WIDTH1+WIDTH2+N*N-1)-1:0] RESULT
);
parameter ZP = (N-1)/2;
parameter M_1 = M + N-1;
integer k,h;
genvar ii,jj;

wire [M_1*M_1*WIDTH1-1:0] img;
//reg [M*M*(WIDTH1+WIDTH2+N*N-1)-1:0] out;

generate
    for(ii=0;ii<M_1;ii=ii+1) begin : loop_1
        for(jj=0;jj<M_1;jj=jj+1) begin : loop_2
            if((ii>=ZP) && (ii<(M+ZP)) && (jj>=ZP) && (jj<(M+ZP)) )
                assign img[(ii*M_1+jj)*WIDTH1+:WIDTH1] = IMAGE[((ii-ZP)*M+(jj-ZP))*WIDTH1+:WIDTH1];
            else
                assign img[(ii*M_1+jj)*WIDTH1+:WIDTH1] = 0;
        end
    end
endgenerate

generate
    for(ii=0;ii<M;ii=ii+1) begin : loop_44
        for(jj=0;jj<M;jj=jj+1) begin : loop_55
            always @ ( img or KERNEL ) begin
                for(k=0;k<N;k=k+1) begin
                    for(h=0;h<N;h=h+1) begin
                        if((k==0) &&(h==0))
                            RESULT[(WIDTH1+WIDTH2+N*N-1)*(ii*M+jj)+:WIDTH1+WIDTH2+N*N-1] = img[WIDTH1*((ii+k)*M_1+jj+h)+:WIDTH1] * KERNEL[WIDTH2*(k*N+h)+:WIDTH2] ;
                        else
                            RESULT[(WIDTH1+WIDTH2+N*N-1)*(ii*M+jj)+:WIDTH1+WIDTH2+N*N-1] = RESULT[(WIDTH1+WIDTH2+N*N-1)*(ii*M+jj)+:WIDTH1+WIDTH2+N*N-1] + img[WIDTH1*((ii+k)*M_1+jj+h)+:WIDTH1] * KERNEL[WIDTH2*(k*N+h)+:WIDTH2];
                    end
                end
            end
        end
    end
endgenerate

endmodule
