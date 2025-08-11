`timescale 1s/1ms;
module usr_test;
  reg [3:0] Pin;
  reg [1:0] mode;
  reg RSin, LSin, reset;
  reg clk = 0;
  wire [3:0] Pout;
  usr U(.Pin(Pin), .RSin(RSin), .LSin(LSin), .Pout(Pout), .modesel(mode), . reset(reset), .clk(clk));
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
      forever
        begin
      		#1 clk = ~clk;
      		$display("Pin: %0000b, RSin: %0b, LSin: %0b, Pout: %0000b", Pin, RSin, LSin, Pout);
        end
    end
  initial
    begin
      reset = 1;
      mode = 2'b00;
      Pin = 4'b0000;
      LSin = 0;
      RSin = 0;
      
      #1 reset = 0;
      mode = 2'b11;
      Pin = 4'b1101;
      
      #2 mode = 2'b01;
      
      #2 mode = 2'b10;
      
      #2 mode = 2'b00;
      
      #2 mode = 2'b11;
      Pin = 4'b1111;
      
      #6 $finish;
    end
endmodule
