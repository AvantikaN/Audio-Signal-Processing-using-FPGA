`timescale 1 ns/1 ns
module dit_fft_8(clk_in,sel,yr,yi,ne_clk,led);
input clk_in;
input [2:0] sel;
output reg [8:0] yr,yi;
output reg ne_clk;
output reg [7:0] led;
//Slow CLK
reg [25:0] count;
always@(posedge clk_in)begin
count=count+1'b1;
if(count==50000000)begin
ne_clk=~ne_clk;
count=0;
end
end
wire [8:0] y0r,y1r,y2r,y3r,y4r,y5r,y6r,y7r,y0i,y1i,y2i,y3i,y4i,y5i,y6i,y7i;
wire [8:0] x20r,x20i,x21r,x21i,x22r,x22i,x23r,x23i,x24r,x24i,x25r,x25i,x26r,x26i,x27r,x27i;
wire [8:0] x10r,x10i,x11r,x11i,x12r,x12i,x13r,x13i,x14r,x14i,x15r,x15i,x16r,x16i,x17r,x17i;
wire [8:0] x0,x1,x2,x3,x4,x5,x6,x7;

parameter w0r=9'b1;
parameter w0i=9'b0;
parameter w1r=9'b010110101;//0.707=0.10110101
parameter w1i=9'b101001011;//-0.707=1.01001011
parameter w2r=9'b0;
parameter w2i=9'b111111111;//-1
parameter w3r=9'b101001011;//-0.707=1.01001011
parameter w3i=9'b101001011;//-0.707=1.01001011


//feed input
assign x0=9'b1;//1
assign x1=9'b0;//2
assign x2=9'b1;//4
assign x3=9'b0;//8
assign x4=9'b1;//16
assign x5=9'b0;//32
assign x6=9'b1;//64
assign x7=9'b0;//128

/*genvar i;
generate 
for (i=0;i<8;i=i+1)
begin: Top
image_reader_1 dut1(.clk(clk),.data_out_1[i](x[i]));
end
endgenerate
*/
//stage1
bfly2_4 s11(x0,x4,w0r,w0i,x10r,x10i,x11r,x11i);
bfly2_4 s12(x2,x6,w0r,w0i,x12r,x12i,x13r,x13i);
bfly2_4 s13(x1,x5,w0r,w0i,x14r,x14i,x15r,x15i);
bfly2_4 s14(x3,x7,w0r,w0i,x16r,x16i,x17r,x17i);
//stage2
bfly2_4 s21(x10r,x12r,w0r,w0i,x20r,x20i,x22r,x22i);
bfly2_4 s22(x11r,x13r,w2r,w2i,x21r,x21i,x23r,x23i);
bfly2_4 s23(x14r,x16r,w0r,w0i,x24r,x24i,x26r,x26i);
bfly2_4 s24(x15r,x17r,w2r,w2i,x25r,x25i,x27r,x27i);
//stage3
bfly2_4 s31(x20r,x24r,w0r,w0i,y0r,y0i,y4r,y4i);
bfly4_4 s32(x21r,x21i,x25r,x25i,w1r,w1i,y1r,y1i,y5r,y5i);
bfly2_4 s33(x22r,x26r,w2r,w2i,y2r,y2i,y6r,y6i);
bfly4_4 s34(x23r,x23i,x27r,x27i,w3r,w3i,y3r,y3i,y7r,y7i);
/*always @* begin
    case(switch)
        switch[0]: sel = 3'b000; // DP switch at position 0, assign 0 to sel
        switch[1]: sel = 3'b001; // DP switch at position 1, assign 1 to sel
        switch[2]: sel = 3'b010; // DP switch at position 2, assign 2 to sel
        switch[3]: sel = 3'b011; // DP switch at position 3, assign 3 to sel
        switch[4]: sel = 3'b100; // DP switch at position 4, assign 4 to sel
        switch[5]: sel = 3'b101; // DP switch at position 5, assign 5 to sel
        switch[6]: sel = 3'b110; // DP switch at position 6, assign 6 to sel
        switch[7]: sel = 3'b111; // DP switch at position 7, assign 7 to sel
        default: sel = 3'b000; // Default case, assign 0 to sel
    endcase
end*/
always@(posedge clk_in)
     case(sel)
   0:begin yr=y0r; yi=y0i;end
   1:begin yr=y1r; yi=y1i;end
   2:begin yr=y2r; yi=y2i;end
   3:begin yr=y3r; yi=y3i;end
   4:begin yr=y4r; yi=y4i;end
   5:begin yr=y5r; yi=y5i;end
   6:begin yr=y6r; yi=y6i;end
   7:begin yr=y7r; yi=y7i;end

  endcase


/*always@(posedge ne_clk)
begin
if (y0r)begin
led[0] <= (y0r == 4);
end
else if (y1r)begin
led[1] <= (y1r == 0);
end
else if (y2r)begin
led[2] <= (y2r == 0);
end
else if (y3r)begin
led[3] <= (y3r == 0);
end
else if (y4r)begin
led[4] <= (y4r == 4);
end
else if (y5r)begin
led[5] <= (y5r == 0);
end
else if (y6r)begin
led[6] <= (y6r == 0);
end
else if (y7r)begin
led[7] <= (y7r == 0);
end*/

endmodule
