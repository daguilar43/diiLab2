`timescale 1ns / 1ps
`include "multiplicadorEjemplo.v"

module testM;

    reg[2:0] portA=4;
    reg[2:0] portB=3;
    reg init=0;
    reg clk=0;
    reg rst=0;
    wire done;
    wire [5:0] out;

    multiplicador UUT(.pp(out),.done(done),.MD(portA),.MR(portB),.init(init_mult),.clk(clk));

    initial begin


        $dumpfile("mult_tb.vcd");
        $dumpvars(0,testM);
        #5 rst=1;
        #10 rst=0;
        #10 init=1;
        #200 $finish;
    end

    always #1 clk = ~clk;
endmodule