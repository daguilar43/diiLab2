`timescale 1ns / 1ps
module test;

reg clk, init;
reg [2:0] portA,portB;
reg START;
wire ZERO;
wire DONE;

ZERO uutZ (.portA(portA),.portB(portB),.clk(clk),.START(START),.ZERO(ZERO),.DONE(DONE));

initial begin

    $dumpfile("ZERO_tb.vcd");
    $dumpvars(0,test);

    portA = 4;
    portB = 4;
    clk=0;
    START=0;

    #18 START=1;
    #2000 $finish;

end
always #1 clk = ~clk;
endmodule