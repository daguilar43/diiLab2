	module ZERO(
			  input [2:0] portA,portB,
			  input clk,
			  input START,
			  output reg ZERO,
			  output reg DONE

	);

	reg[2:0] minuendo, sustraendo;

	always@(START) begin
	  if(START) begin
		minuendo=portA;
		sustraendo=portB;
		// sustraendo= ~portB+1;

		 if (minuendo-sustraendo==0) 
			  ZERO=1;
		
		 else 
			  ZERO=0;
		end
        DONE=1;
	end

	endmodule