module usr(Pin, RSin, LSin, Pout, modesel, reset, clk);
  input [3:0] Pin;
  input [1:0] modesel;
  input RSin, LSin, reset, clk;
  output [3:0] Pout;
  wire [3:0] con;
  
  mux4 m0(.in({Pin[0], LSin, Pout[1], Pout[0]}), .out(con[0]), .s(modesel));
  mux4 m1(.in({Pin[1], Pout[0], Pout[2], Pout[1]}), .out(con[1]), .s(modesel));
  mux4 m2(.in({Pin[2], Pout[1], Pout[3], Pout[2]}), .out(con[2]), .s(modesel));
  mux4 m3(.in({Pin[3], Pout[2], RSin, Pout[3]}), .out(con[3]), .s(modesel));
  
  dff d0(.d(con[0]), .q(Pout[0]), .reset(reset), .clk(clk));
  dff d1(.d(con[1]), .q(Pout[1]), .reset(reset), .clk(clk));
  dff d2(.d(con[2]), .q(Pout[2]), .reset(reset), .clk(clk));
  dff d3(.d(con[3]), .q(Pout[3]), .reset(reset), .clk(clk));
  // Mode 0h = Storage
  // Mode 1h = Right Shift
  // Mode 2h = Left Shift
  // Mode 3h = Parallel Input
endmodule
  

module dff(d, q, qb, reset, clk);
  input d, reset, clk;
  output q, qb;
  reg q;
  assign qb = ~q;
  always @(posedge clk or posedge reset)
    begin
      if (reset)
        q <= 0;
      else
        q <= d;
    end
endmodule

module mux4(in, s, out);
  input [3:0] in;
  input [1:0] s;
  output out;
  assign out = ~s[1]&~s[0]&in[0]|~s[1]&s[0]&in[1]|s[1]&~s[0]&in[2]|s[1]&s[0]&in[3];
endmodule
