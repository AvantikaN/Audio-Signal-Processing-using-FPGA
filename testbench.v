`timescale 1ns / 1ps

module testbench;
reg clk;
reg new_clk
reg [2:0] sel;
wire [8:0] yr,yi;
dit_fft_8 dit_fft_8_test(.clk(clk),.sel(sel),.yr(yr),.yi(yi),.new_clk(new_clk);
parameter clkper = 10;
initial
   begin
    clk = 1;
	 new_clk =1;
   end
always
   begin
      #(clkper/2) clk = ~clk;
   end
initial
   begin
   sel = 3'b000;
   #10
   sel = 3'b001;
   #10
   sel = 3'b010;
   #10
   sel = 3'b011;
   #10
   sel = 3'b100;
   #10
   sel = 3'b101;
   #10
   sel = 3'b110;
   #10
   sel = 3'b111;
   end
endmodule