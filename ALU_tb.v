`timescale 1ns / 1ps

module test;

    reg[2:0] portA;
    reg[2:0] portB;
    reg[1:0] opcode;
    reg clk;
    reg rst;
    wire [5:0] out;

    ALU uut (.out(out),.portA(portA),.portB(portB),.opcode(opcode),.clk(clk),.rst(rst));

    initial begin
        portA=4;
        portB=3;
        opcode=0;
        clk=0;
        rst=1;

        $dumpfile("ALU_tb.vcd");
        $dumpvars(0,test);

        #10 opcode=1;
        #50 rst=0;
        #200 $finish;
    end

    always #1 clk = ~clk;
endmodule