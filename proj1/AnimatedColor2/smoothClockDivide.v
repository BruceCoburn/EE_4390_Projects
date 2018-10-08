// EE 4490: Homework Set 04
// Problem 1: ClockDivide module
// Bruce Coburn

module smoothClockDivide(secTick, sw, clk);
	output     	 	secTick;
	input			clk;
	input   [15:13] sw;
	reg 	[24:0] 	ClockTick;
	reg             nextTick;
	
//parameter DIVISOR = 21'd0;	// Will take our 100MHz on-board clock
										// and will divide it to make a 1Hz 
										// "new clock"
	
	always@(posedge clk)
	begin
	   ClockTick <= ClockTick + 1;
	   
	   if(ClockTick > {sw[15],sw[14],sw[13],1'b1,21'd0}/2) nextTick <= 1'b0;
	   else if(ClockTick <= {sw[15],sw[14],sw[13],1'b1,21'd0}/2) nextTick <=1'b1;
	   
	   if(ClockTick >= ({sw[15],sw[14],sw[13],1'b1,21'd0}-1))
	       ClockTick <= 25'd0;
    end
	
	assign secTick = nextTick;
		
endmodule