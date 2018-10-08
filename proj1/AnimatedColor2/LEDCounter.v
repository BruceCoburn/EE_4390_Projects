// LEDCounter.v
// Just a simple 8-bit synchronous counter
// Main inputs and outputs connect to GRBStateMachine
// Value of output Count keeps track of how many bits have been sent
// This implies a max of 10 LED modules could be used (240 bits)
// For longer LED strips, increase the bit width of the counter

module LEDCounter(Count,IncCounter,clk,reset);
  output  [11:0] Count;
  input   IncCounter;
  input   clk, reset;

  reg [11:0] Count, nCount;

  always @(posedge clk)
    if(reset) Count <= 0;
    else Count <= nCount;

  always @(reset, Count, IncCounter)
    if(reset)
      nCount = 0;
    else if(IncCounter)
      nCount = Count+1;
    else
      nCount = Count;
endmodule
