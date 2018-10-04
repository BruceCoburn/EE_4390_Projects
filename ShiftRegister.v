// ShiftRegister.v
// determines the 24-bit control word for an LED module
// shifts it out one bit at a time
// keeps sending the same 24 bits, so same color to all modules

module ShiftRegister(CurrentBit,sw,LoadRegister,RotateRegisterLeft,clk,reset);
  output CurrentBit;
  input  [15:4] sw;
  input  LoadRegister, RotateRegisterLeft;
  input  clk, reset;

  parameter DEFAULTREG=24'h0F0F0F;  // white, half brightness

  reg [23:0]  TheReg, nTheReg;  // 24 bits for GRB control

  always @(posedge clk)
    if(reset) TheReg <= DEFAULTREG;
    else  TheReg <= nTheReg;
      
    // switches set the upper 4 bits of the GRB control bytes
  always @(TheReg, LoadRegister, RotateRegisterLeft, sw)
    if(LoadRegister)
      nTheReg = {sw[15:12],4'b0000,sw[11:8],4'b0000,sw[7:4],4'b0000};
    else if(RotateRegisterLeft)
      nTheReg = {TheReg[22:0],TheReg[23]};
    else
      nTheReg = TheReg;

  assign  CurrentBit = TheReg[23];
endmodule
