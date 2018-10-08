// SimpleSend.v
// top-level module for WS2812B LED strip
// VERY basic design, sends same color to all modules
// Updated to support new WS2812B reset code of > 280 us

module SimpleSend(dataOut,NumLEDs,sw,clk,reset,Ready2Go);
	output	dataOut, Ready2Go;
	input   [15:13] sw;
	input   [3:1]  NumLEDs;
    input	clk, reset;
	
	wire		shipGRB, Done, allDone;
	wire [1:0]	qmode;
	wire		LoadGRBPattern, ShiftPattern, StartCoding, ClrCounter, IncCounter, theBit, bdone;
	wire [7:0]	Count;
	wire [11:0] LEDCount;
	wire        ledClk;

    smoothClockDivide       ledDiv(ledClk, sw,clk);
    LEDCounter              ledC(LEDCount,1'b1, ledClk, reset);
	SSStateMachine	        sssm(shipGRB,Done,ledClk,clk,reset,allDone,Ready2Go);
	GRBStateMachine         grbsm(qmode,Done,LoadGRBPattern,ShiftPattern,StartCoding,ClrCounter,IncCounter,
                                  shipGRB,theBit,bdone,Count,NumLEDs,clk,reset,allDone);
	ShiftRegister           shftr(theBit,12'd0,LoadGRBPattern,ShiftPattern,LEDCount,clk,reset);
	BitCounter	            btcnt(Count,ClrCounter,IncCounter,clk,reset);
	NZRbitGEN	            nzrgn(dataOut,bdone,qmode,StartCoding,clk,reset);
endmodule
