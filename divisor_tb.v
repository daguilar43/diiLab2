`timescale 1ns / 1ps
module test;

reg clk, init;
reg [2:0] portA,portB;
reg START;
wire [2:0] DV;
wire done;

divisor uut (.portA(portA),.portB(portB),.clk(clk),.START(START),.DV(DV),.DONE(DOO));

initial begin

    $dumpfile("divisor_tb.vcd");
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
