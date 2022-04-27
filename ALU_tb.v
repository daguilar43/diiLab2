`timescale 1ns / 1ps
//`include "ALU.v"
module testALU;

    reg[2:0] portA;
    reg[2:0] portB;
    reg[1:0] opcode;
    reg clk;
    reg rst;
    wire [15:0] out;

    ALU uut (.out(out),.portA(portA),.portB(portB),.opcode(opcode),.clk(clk),.rst(rst));

    initial begin
        portA=6;
        portB=6;
        opcode=1;
        clk=0;
        rst=1;

        $dumpfile("ALU_tb.vcd");
        $dumpvars(0,testALU);

        #200 opcode=2;
        #50 rst=0;
        #2000 $finish;
    end

    always #1 clk = ~clk;
endmodule