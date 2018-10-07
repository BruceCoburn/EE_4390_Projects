// EE 4490: Homework Set 04
// Problem 1: ClockDivide module
// Bruce Coburn

module ClockDivide(secTick, clk);
	output     	 	secTick;
	input			clk;
	reg 	[26:0] 	ClockTick;
	reg             nextTick;
	
	parameter DIVISOR = 27'd100000000;	// Will take our 100MHz on-board clock
										// and will divide it to make a 1Hz 
										// "new clock"
	
	always@(posedge clk)
	begin
	   ClockTick <= ClockTick + 27'd1;
	   
	   if(ClockTick > DIVISOR/2) nextTick <= 1'b0;
	   else if(ClockTick <= DIVISOR/2) nextTick <=1'b1;
	   
	   if(ClockTick >= (DIVISOR-1))
	       ClockTick <= 27'd0;
    end
	
	assign secTick = nextTick;
		
endmodule
		