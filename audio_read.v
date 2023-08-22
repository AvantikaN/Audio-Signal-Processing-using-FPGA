`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:09:59 04/13/2023 
// Design Name: 
// Module Name:    image_reader_1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module audio_read (
    input clk,
	 input reset,
    input write_en,
    input data_in,
    output reg data_out_1
);

reg [7:0]address;

    //reg mem [0:1023];

		reg mem [0:1999];

    initial begin
	     address=8'b0;
        $readmemh("audiomem01.mem",mem);
    end
always @(posedge clk) begin	 
	 if (reset) begin
            data_out_1 <= 1'b0;
        end 
		  else begin

		   if(write_en) begin

            mem[address] <= data_in;

        end
		  else begin

        //data_out_1 <= mem[address];

		  data_out_1 <= mem[address];
        end
		  end
		  address<=address+1'b1;
		  end

endmodule