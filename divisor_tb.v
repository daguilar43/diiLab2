`timescale 1ns / 1ps
`include "divisor.v"

module test;

reg clk, init;
reg [2:0] portA,portB;
wire [2:0] D,M;
wire done;

divisor uut (.portA(portA),.portB(portB),.clk(clk),.init(init),.D(D),.M(M),.done(done));

initial begin

    $dumpfile("divisor_tb.vcd");
    $dumpvars(0,test);

    portA = 7;
    portB = 2;
    clk=0;
    init=0;

    #5 init=1;
    #200 $finish;

end
always #1 clk = ~clk;
endmodule
